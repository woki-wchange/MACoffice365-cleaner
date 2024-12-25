# MACoffice365-cleaner

本项目提供了一个用于清理 macOS 上 Microsoft Office / Microsoft 365 及其相关残留文件的脚本。

[Chinese][English]
---

## 简体中文

### 简介

`cleanup_office.sh` 是一个用于 **macOS** 的脚本，可以帮助你**彻底查找并删除** Microsoft 365/Office 以及 Microsoft AutoUpdate 的残留文件、目录和配置。  
该脚本适用于想要从系统中干净卸载 Office/Teams/OneDrive 等相关组件的场景。

> **警告**：脚本内部使用了 `rm -rf` 命令，一旦执行删除，**无法恢复**。请**务必**在执行前备份重要数据，并先行审阅脚本内容。

### 功能

1. **结束相关进程**  
   自动结束可能在运行的 Office、Teams、OneDrive、Microsoft AutoUpdate 等进程，避免文件被占用而无法删除。  

2. **收集残留文件**  
   通过 `find` 命令在系统与用户目录（`~/Library`、`/Library` 等）中搜集常见残留路径并展示给用户。  

3. **删除前确认**  
   在实际删除前，脚本会列出所有目标文件或文件夹，用户可以选择是否确认删除，避免误删。  

4. **覆盖面广**  
   - `/Applications` 中的各 Office 应用（Word, Excel, Outlook, OneNote, Teams 等）  
   - `~/Library` 下的 Containers、Caches、Preferences、Group Containers 等目录  
   - `/Library` 下的 LaunchAgents、LaunchDaemons 以及 Application Support 等系统级位置  

### 使用方法

1. **下载脚本**  
   将脚本文件（`cleanup_office.sh`）克隆或下载到本地，例如放置于 `~/Downloads`。

2. **赋予可执行权限**（若脚本尚无执行权限）  

   `chmod +x cleanup_office.sh`

3.	运行脚本

   `./cleanup_office.sh`


4.	查看执行过程
	•	脚本会首先提示你是否进行扫描并删除；
	•	扫描完成后，会再次询问是否删除所列出的残留文件；
	•	若确认，将执行删除操作并打印已删除的文件/目录列表。
5.	重启系统（推荐）
执行完毕后，最好重启一下电脑，然后可在 Finder 中搜索 Microsoft、Office、Outlook 等，检查是否还有遗留文件。

注意事项
	•	谨慎操作：删除操作不可恢复；请事先确认要清理的文件都是不再需要的。
	•	管理员权限：部分系统级目录（/Library）需要管理员权限。运行脚本时，可能需要输入 sudo 密码。
	•	钥匙串(Keychain)：如果需要删除 Office/Outlook 的密码或激活信息，需要手动在「钥匙串访问」里搜索 Microsoft、Office、Outlook 并删除对应条目。脚本无法自动处理钥匙串内容。
	•	定制：如果你的 Office/Teams/OneDrive 安装路径或名称与默认不同，可自行编辑脚本相关目录或关键字。
	•	测试环境：建议先在测试环境或虚拟机中试运行该脚本，确保你了解脚本的行为。

常见问题
	1.	运行后找不到任何文件删除？
说明系统中可能已无 Microsoft 相关残留，或之前已被手动/其他工具清理干净。脚本只会删除存在的目标。
	2.	脚本执行后依然有部分残留？
可能位于自定义路径或脚本中未包含的目录。可手动搜索/删除。
	3.	脚本执行过程中出现 No such file or directory 报错？
文件/目录已不存在，可忽略此提示，脚本会继续执行。
	4.	如何再安装 Office？
如果需要再次安装，建议从 Microsoft 官网 或 Mac App Store 获取最新版本。

English Version

Introduction

cleanup_office.sh is a macOS script to thoroughly search and remove any leftover files, directories, and configurations from Microsoft 365/Office as well as Microsoft AutoUpdate.
This script is particularly useful when you want a completely clean uninstallation of Office, Teams, OneDrive, etc.

	Warning: The script uses rm -rf to remove files, which is irreversible. Make sure to backup your data and review the script before executing it.

Features
	1.	Terminate related processes
Automatically kills processes like Office, Teams, OneDrive, and Microsoft AutoUpdate to avoid locked files.
	2.	Collect leftover files
Uses find to search common directories (e.g. ~/Library and /Library) for leftover files and prompts you before removal.
	3.	Confirmation before deletion
The script will list all detected items and ask for confirmation, preventing accidental deletions.
	4.	Wide coverage
	•	/Applications (Word, Excel, Outlook, OneNote, Teams, etc.)
	•	~/Library (Containers, Caches, Preferences, Group Containers, etc.)
	•	/Library (LaunchAgents, LaunchDaemons, Application Support, etc.)

Usage
	1.	Download the script
Clone or download cleanup_office.sh to your local machine (e.g., ~/Downloads).
	2.	Make it executable (if it isn’t already)

   `chmod +x cleanup_office.sh`


3.	Run the script

   `./cleanup_office.sh`

4.	Follow the prompts
	•	The script will first ask if you want to scan and remove leftovers;
	•	After scanning, it will list all detected items and ask for confirmation;
	•	If confirmed, it will remove those files and print the removed paths.
5.	Reboot (recommended)
After finishing, we recommend you reboot the system and then use Finder to search for Microsoft, Office, or Outlook to ensure no leftovers remain.

Notes
	•	Use with caution: Deletion is permanent. Double-check the listed items before confirming.
	•	Administrator privileges: Some directories in /Library require admin privileges, so you may be prompted for sudo.
	•	Keychain: If you need to remove Office/Outlook credentials, you must do so manually in “Keychain Access” by searching Microsoft, Office, or Outlook.
	•	Customization: If Office/Teams/OneDrive was installed in a custom path or has different names, edit the script accordingly.
	•	Test environment first: Always recommended to try the script in a non-critical or test environment to be absolutely sure of its effects.

##FAQ
	1.	No files found to remove?
Likely your system is already clean of Microsoft leftovers, or they were removed previously.
	2.	Leftovers remain after running?
They may reside in custom or unexpected locations. Please remove them manually.
	3.	No such file or directory errors?
It means the file/folder was not found. These errors can be safely ignored.
	4.	How to reinstall Office?
Download the latest version directly from the Microsoft website or the Mac App Store.

Author: Kukkori

欢迎提交 Issues 或 Pull Requests 来改进脚本的兼容性与覆盖范围。
Feel free to open Issues or submit Pull Requests to improve the script.
