#!/bin/bash
#------------------------------------------------------------
# cleanup_office.sh
# 一键查找并删除 macOS 上 Microsoft 365/Office & AutoUpdate 残留
# 执行前请先阅读脚本，确认要删除的内容是否符合预期
#------------------------------------------------------------

# 获取当前登录用户名（假设使用当前用户身份运行）
CURRENT_USER=$(whoami)
USER_HOME="/Users/$CURRENT_USER"

# 提醒用户风险
echo "======================================================="
echo "  此脚本将扫描并列出可能的 Office / Microsoft 残留文件"
echo "  并询问你是否确定要删除它们。删除后无法恢复！"
echo " Write by kukkori.@2024"
echo "======================================================="
read -p "是否继续扫描并删除？(y/n): " ANSWER
if [[ "$ANSWER" != "y" ]]; then
  echo "操作已取消。"
  exit 0
fi

#--------------------------------------------------------------------------
# 函数：kill_processes
# 结束相关进程，避免因文件正在使用而无法删除
#--------------------------------------------------------------------------
kill_processes() {
  echo
  echo ">>> 尝试结束可能存在的进程 (Word, Excel, Outlook, Teams, AutoUpdate 等)..."
  local procs=("Microsoft" "Teams" "OneDrive" "Outlook" "Word" "Excel" "PowerPoint" "OneNote" "AutoUpdate")
  for proc in "${procs[@]}"; do
    pkill -f "$proc" &>/dev/null
  done
  sleep 1
}

#--------------------------------------------------------------------------
# 函数：collect_items
# 收集要删除的路径（文件或文件夹），保存在全局数组 TO_DELETE 中
#--------------------------------------------------------------------------
TO_DELETE=()  # 全局数组，用来收集所有待删除的项目

collect_items() {
  echo
  echo ">>> 开始收集可能的残留项目列表..."

  #--- 1. 应用程序路径（部分为固定路径） ---
  declare -a apps=(
    "/Applications/Microsoft Word.app"
    "/Applications/Microsoft Excel.app"
    "/Applications/Microsoft PowerPoint.app"
    "/Applications/Microsoft Outlook.app"
    "/Applications/Microsoft OneNote.app"
    "/Applications/Microsoft Teams.app"
    "/Applications/Microsoft OneDrive.app"
    "/Applications/Microsoft AutoUpdate.app"
  )

  for app_path in "${apps[@]}"; do
    if [ -e "$app_path" ]; then
      TO_DELETE+=("$app_path")
    fi
  done

  #--- 2. 用户级残留，主要位于 ~/Library 下 ---
  # 2.1 ~/Library/Containers: com.microsoft*
  if [ -d "$USER_HOME/Library/Containers" ]; then
    while IFS= read -r -d '' item; do
      TO_DELETE+=("$item")
    done < <(find "$USER_HOME/Library/Containers" -iname "com.microsoft*" -print0 2>/dev/null)
  fi

  # 2.2 ~/Library/Group Containers: UBF8T346G9.*, com.microsoft*
  if [ -d "$USER_HOME/Library/Group Containers" ]; then
    while IFS= read -r -d '' item; do
      TO_DELETE+=("$item")
    done < <(find "$USER_HOME/Library/Group Containers" \( -iname "UBF8T346G9.*" -o -iname "com.microsoft*" \) -print0 2>/dev/null)
  fi

  # 2.3 ~/Library/Application Scripts: com.microsoft*
  if [ -d "$USER_HOME/Library/Application Scripts" ]; then
    while IFS= read -r -d '' item; do
      TO_DELETE+=("$item")
    done < <(find "$USER_HOME/Library/Application Scripts" -iname "com.microsoft*" -print0 2>/dev/null)
  fi

  # 2.4 ~/Library/Preferences: com.microsoft*.plist
  if [ -d "$USER_HOME/Library/Preferences" ]; then
    while IFS= read -r -d '' item; do
      TO_DELETE+=("$item")
    done < <(find "$USER_HOME/Library/Preferences" -iname "com.microsoft*.plist" -print0 2>/dev/null)
  fi

  # 2.5 ~/Library/Saved Application State: com.microsoft*.savedState
  if [ -d "$USER_HOME/Library/Saved Application State" ]; then
    while IFS= read -r -d '' item; do
      TO_DELETE+=("$item")
    done < <(find "$USER_HOME/Library/Saved Application State" -iname "com.microsoft*.savedState" -print0 2>/dev/null)
  fi

  # 2.6 ~/Library/Caches: com.microsoft*
  if [ -d "$USER_HOME/Library/Caches" ]; then
    while IFS= read -r -d '' item; do
      TO_DELETE+=("$item")
    done < <(find "$USER_HOME/Library/Caches" -iname "com.microsoft*" -print0 2>/dev/null)
  fi

  # 2.7 ~/Library/Application Support: Microsoft/Teams/OneDrive...
  if [ -d "$USER_HOME/Library/Application Support" ]; then
    while IFS= read -r -d '' item; do
      TO_DELETE+=("$item")
    done < <(find "$USER_HOME/Library/Application Support" \( -iname "Microsoft" -o -iname "Teams" -o -iname "OneDrive" \) -print0 2>/dev/null)
  fi

  #--- 3. 系统级 /Library ---
  # 3.1 /Library/LaunchAgents & LaunchDaemons: com.microsoft*.plist
  local sys_launch_agents="/Library/LaunchAgents"
  local sys_launch_daemons="/Library/LaunchDaemons"
  if [ -d "$sys_launch_agents" ]; then
    while IFS= read -r -d '' item; do
      TO_DELETE+=("$item")
    done < <(sudo find "$sys_launch_agents" -iname "com.microsoft*.plist" -print0 2>/dev/null)
  fi
  if [ -d "$sys_launch_daemons" ]; then
    while IFS= read -r -d '' item; do
      TO_DELETE+=("$item")
    done < <(sudo find "$sys_launch_daemons" -iname "com.microsoft*.plist" -print0 2>/dev/null)
  fi

  # 3.2 /Library/Application Support
  local sys_app_support="/Library/Application Support"
  if [ -d "$sys_app_support" ]; then
    while IFS= read -r -d '' item; do
      TO_DELETE+=("$item")
    done < <(sudo find "$sys_app_support" \( -iname "Microsoft" -o -iname "MAU" -o -iname "AutoUpdate" -o -iname "Teams" -o -iname "OneDrive" \) -print0 2>/dev/null)
  fi

  # 3.3 /Library/Preferences: com.microsoft*.plist
  local sys_pref="/Library/Preferences"
  if [ -d "$sys_pref" ]; then
    while IFS= read -r -d '' item; do
      TO_DELETE+=("$item")
    done < <(sudo find "$sys_pref" -iname "com.microsoft*.plist" -print0 2>/dev/null)
  fi
}

#--------------------------------------------------------------------------
# 函数：confirm_and_delete
# 列出收集到的项目，让用户确认，若确认则删除
#--------------------------------------------------------------------------
confirm_and_delete() {
  # 如果没有收集到任何可删除的项目，直接退出
  if [ ${#TO_DELETE[@]} -eq 0 ]; then
    echo
    echo "未发现可删除的 Microsoft 相关残留文件或目录。"
    return
  fi

  echo
  echo ">>> 以下是即将被删除的文件/目录列表："
  echo "-------------------------------------------------------"
  for item in "${TO_DELETE[@]}"; do
    echo "$item"
  done
  echo "-------------------------------------------------------"
  echo "总共将删除 ${#TO_DELETE[@]} 项。"
  
  # 二次确认
  read -p "是否确认删除以上所有项目？(y/n): " DEL_ANSWER
  if [[ "$DEL_ANSWER" == "y" ]]; then
    echo
    echo ">>> 开始删除..."
    for item in "${TO_DELETE[@]}"; do
      if [ -e "$item" ]; then
        # -e 检查文件或目录是否存在，不存在则跳过
        sudo rm -rf "$item" 2>/dev/null
        echo "已删除: $item"
      fi
    done
    echo
    echo ">>> 删除完成。"
    echo ">>> 建议重启电脑后再检查是否还有残留。"
  else
    echo
    echo "已取消删除操作。"
  fi
}

#--------------------------------------------------------------------------
# 主执行流程
#--------------------------------------------------------------------------
kill_processes     # 先结束相关进程
collect_items      # 搜集可能删除的路径
confirm_and_delete # 列出并确认删除
echo
echo "脚本执行结束。"
echo "如需彻底清理 Keychain 中的微软登录信息，请打开 钥匙串访问 手动删除。"