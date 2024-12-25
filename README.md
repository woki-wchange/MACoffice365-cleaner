Cleanup Office for macOS

简体中文 | English

简体中文

简介

cleanup_office.sh 是一个用于 macOS 的脚本，可以帮助你彻底查找并删除 Microsoft 365/Office 以及 Microsoft AutoUpdate 的残留文件、目录和配置。
该脚本适用于想要从系统中干净卸载 Office/Teams/OneDrive 等相关组件的场景。

	警告： 脚本内部使用了 rm -rf 命令，一旦执行删除，无法恢复。请务必在执行前备份重要数据，并先行审阅脚本内容。

功能
	1.	结束相关进程：自动结束可能在运行的 Office/Teams/OneDrive/Microsoft AutoUpdate 等进程，避免文件被占用而无法删除。
	2.	收集残留文件：通过 find 命令搜集系统和用户目录下的常见残留路径并列表展示。
	3.	删除前确认：在实际删除之前，会先列出所有目标文件，询问用户是否执行删除操作，避免误删。
	4.	覆盖面广：清理路径包括：
	•	/Applications 中的各 Office 应用（Word、Excel、Outlook 等）
	•	~/Library 下的 Containers、Caches、Preferences 等目录
	•	/Library 下的 LaunchAgents、LaunchDaemons 以及 Application Support 等系统级位置

使用方法
	1.	下载脚本
将脚本文件（cleanup_office.sh）克隆或下载到你的本地机器，例如放置于 ~/Downloads。
	2.	赋予可执行权限（若脚本尚无执行权限）

chmod +x cleanup_office.sh


	3.	运行脚本

./cleanup_office.sh

或者

bash cleanup_office.sh


	4.	查看执行过程
	•	脚本会首先提示你是否进行扫描并删除；
	•	接着列出扫描结果，并再次询问是否确认删除；
	•	若确认，将执行删除操作并打印已删除的文件/目录列表。
	5.	重启系统（推荐）
完成后，建议重启一次，然后在「访达(Finder)」中搜索 Microsoft 或 Office 关键字，确认是否还有遗留文件。

注意事项
	•	谨慎操作：删除操作不可恢复；请事先确认要清理的文件都是不再需要的。
	•	管理员权限：部分系统级目录（/Library）需要管理员权限，运行脚本时可能会提示输入 sudo 密码。
	•	钥匙串( Keychain )：若需要删除 Office/Outlook 的密码或激活信息，需要手动在「钥匙串访问」里搜索并删除 Microsoft / Office / Outlook 等条目。脚本无法自动处理钥匙串内容。
	•	定制：如果你的 Office 安装位置、应用名称或残留路径与默认不同，可自行编辑脚本中的目录或关键字。
	•	测试优先：建议先在测试环境或虚拟机中试运行脚本，避免在生产环境意外删除重要文件。

常见问题
	1.	运行后找不到任何文件删除？
说明系统中可能已无 Microsoft 相关残留，或已经通过其他方式删除干净。脚本只会删除确实存在的目标文件/目录。
	2.	脚本执行后依然有部分残留？
可能是脚本未涵盖的自定义文件或其他路径。请在「访达」或终端中手动搜索并删除。
	3.	脚本执行过程中出现 No such file or directory 报错？
代表该路径不存在，可忽略。脚本会继续运行下一个目标。
	4.	如何再安装 Office？
如需重新安装，建议从 Microsoft 官网 或 Mac App Store 下载最新版本。

English

Introduction

cleanup_office.sh is a macOS script designed to thoroughly detect and remove any leftover files, directories, or configurations related to Microsoft 365/Office and Microsoft AutoUpdate.
This script is helpful if you want to completely uninstall Office, Teams, OneDrive, etc., leaving no residual files on your system.

	Warning: The script uses rm -rf, which permanently removes files and directories. Please backup important data and review the script before running it.

Features
	1.	Terminate related processes: Automatically kills running Office/Teams/OneDrive/Microsoft AutoUpdate processes to prevent file lock issues.
	2.	Collect leftover files: Uses find to gather commonly known leftover directories and files in both user and system libraries.
	3.	Confirmation prompt: Lists all items to be deleted before actually removing them, so you can confirm or cancel.
	4.	Wide coverage: Cleans up files in:
	•	/Applications (Word, Excel, Outlook, etc.)
	•	~/Library (Containers, Caches, Preferences, etc.)
	•	/Library (LaunchAgents, LaunchDaemons, Application Support, etc.)

Usage
	1.	Download the script
Clone or download the cleanup_office.sh script to your local machine, for example in ~/Downloads.
	2.	Grant execution permission (if needed)

chmod +x cleanup_office.sh


	3.	Run the script

./cleanup_office.sh

or

bash cleanup_office.sh


	4.	Follow the prompts
	•	The script will ask if you want to proceed with scanning and removal.
	•	It will then list all found items and prompt for confirmation before actual deletion.
	•	If confirmed, the script will remove those files and print their paths.
	5.	Reboot (recommended)
After the script finishes, it’s a good idea to reboot your Mac and search for Microsoft or Office in Finder to ensure no unwanted leftovers remain.

Notes
	•	Use with caution: Deletion is irreversible. Make sure you genuinely want to remove these files.
	•	Administrator privileges: Some directories under /Library require elevated privileges. You may be prompted for your sudo password during script execution.
	•	Keychain: If you need to remove Office/Outlook credentials, you must manually delete them from the “Keychain Access” app by searching for Microsoft, Office, or Outlook.
	•	Customization: If your Office apps are installed in custom locations or have different names, feel free to edit the script accordingly.
	•	Test first: We recommend testing the script on a non-critical environment or a VM before applying it to your main system.

FAQ
	1.	No files found after the scan?
That likely means there are no more Microsoft-related leftovers, or they were already removed by other means. The script only deletes existing targets.
	2.	Some leftovers remain?
They might be located in non-standard or custom directories. You can manually search for them in Finder or via the terminal.
	3.	No such file or directory error messages?
This indicates that the path no longer exists. You can safely ignore these messages; the script will continue running.
	4.	How to reinstall Office?
If you plan to reinstall Office later, download the latest official version from the Microsoft website or the Mac App Store.

License

This script is released under the MIT License. You are free to use, modify, and distribute it, provided you include the original license.

Author: Your Name
Repository: GitHub URL here

欢迎提交 Issues 或 Pull Requests 来改进脚本的兼容性和覆盖范围。
Feel free to open Issues or submit Pull Requests to improve the script.

	Disclaimer: The author is not responsible for any data loss or damage caused by running this script. By executing this script, you acknowledge that you understand the risk of permanently deleting files from your system.
