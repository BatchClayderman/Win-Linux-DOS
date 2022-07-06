@ECHO OFF
SET SYSINFOERR=0
IF /I "%1"=="/CLEAR" (GOTO CLEAR)
IF /I "%1"=="/LAUNCH" (GOTO CHECK)
IF /I "%1"=="/OLD" (GOTO OLD)
IF /I "%1"=="/P" (GOTO MAIN)
IF /I "%1"=="/PATH" (GOTO PATH)
IF /I "%1"=="/X" (GOTO X)
IF /I "%1"=="/?" (GOTO HELP)
IF /I "%1"=="" (GOTO HELP)
SET SYSINFOERR=1
GOTO HELP

:CHECK
IF /I NOT EXIST "%COMSPEC:~0,-7%SYSINFORMATION.TXT" (GOTO LAUNCH)
ECHO 原存储文件已存在，是否覆盖（Y/N）？
SET /P Y=
IF /I "%Y:~0,1%"=="Y" (SET Y=&GOTO CLEAR) ELSE (ECHO 提示：请先删除原存储文件再试。&SET Y=&EXIT /B)

:CLEAR
IF /I NOT EXIST "%COMSPEC:~0,-7%SYSINFORMATION.TXT" (ECHO 提示：没有存储信息。&EXIT /B)
CACLS "%COMSPEC:~0,-7%SYSINFORMATION.TXT" /E /G SYSTEM:F>NUL
CACLS "%COMSPEC:~0,-7%SYSINFORMATION.TXT" /E /G ADMINISTRATORS:F>NUL
CACLS "%COMSPEC:~0,-7%SYSINFORMATION.TXT" /E /G %USERNAME%:F>NUL
CACLS "%COMSPEC:~0,-7%SYSINFORMATION.TXT" /E /G USERS:F>NUL
CACLS "%COMSPEC:~0,-7%SYSINFORMATION.TXT" /E /G EVERYONE:F>NUL
DEL /A /F /Q "%COMSPEC:~0,-7%SYSINFORMATION.TXT">NUL
IF /I EXIST "%COMSPEC:~0,-7%SYSINFORMATION.TXT" (ECHO 错误：无法删除原存储信息。&EXIT /B)
IF /I "%1"=="/LAUNCH" (GOTO LAUNCH) ELSE (ECHO 成功：清除存储信息成功。)
SET SYSINFOERR=
EXIT /B

:HELP
IF %SYSINFOERR%==1 (ECHO 提示：无效参数。)
ECHO 用途：获取系统存储信息。
ECHO.
ECHO [用法]SYSINFOMATE [Option]
ECHO 	CLEAR   清除原有存储文件
ECHO 	LAUNCH  创建新的存储文件
ECHO 	OLD     打开原有存储文件
ECHO 	P       仅在当前窗口列出
ECHO 	PATH    指定文件存储信息
ECHO 	X       将SYSINFOMATE写为系统程序
ECHO 	?       显示帮助（即显示此消息）
ECHO 没有参数，将显示此帮助界面。
ECHO 例如：1．SYSINFOMATE /LAUNCH；
ECHO       2．SYSINFOMATE /PATH "C:\Documents and Settings\sys.txt"。
ECHO 说明：1．除“/PATH”参数外，程序仅读取第一个参数；
ECHO       2．所有的存储文件位于系统根目录下，均为存档只读的系统隐藏文件；
ECHO       3．“/PATH”参数所指定的文件原有内容不会被删除。
ECHO 建议：1．运行“SYSINFOMATE /OLD”前请使用mode调整页面行数；
ECHO       2．运行“SYSINFOMATE /LAUNCH”后运行XCOPY和ATTRIB工具。
ECHO 警告：1．切勿输入含有超文本内容的参数；
ECHO       2．SYSINFOMATE无法验证指定文件存储信息是否成功；
ECHO       3．若路径中含有空格，切勿忘记使用英文双引号。
SET SYSINFOERR=
EXIT /B

:LAUNCH
IF /I EXIST "%COMSPEC:~0,-7%SYSINFORMATION.TXT" (DEL /A /F /Q "%COMSPEC:~0,-7%SYSINFORMATION.TXT"^>NUL)
IF /I EXIST "%COMSPEC:~0,-7%SYSINFORMATION.TXT" (GOTO CLEAR)
ECHO 所有系统信息如下：>>"%COMSPEC:~0,-7%SysInformation.txt"
SYSTEMINFO>>"%COMSPEC:~0,-7%SysInformation.txt"
ECHO.>>"%COMSPEC:~0,-7%SysInformation.txt"
ECHO 所有系统变量如下：>>"%COMSPEC:~0,-7%SysInformation.txt"
SET>>"%COMSPEC:~0,-7%SysInformation.txt"
ECHO.>>"%COMSPEC:~0,-7%SysInformation.txt"
ECHO 网络信息如下：>>"%COMSPEC:~0,-7%SysInformation.txt"
IPCONFIG>>"%COMSPEC:~0,-7%SysInformation.txt"
ECHO.>>"%COMSPEC:~0,-7%SysInformation.txt"
ECHO 设备信息如下：>>"%COMSPEC:~0,-7%SysInformation.txt"
MODE>>"%COMSPEC:~0,-7%SysInformation.txt"
ECHO.>>"%COMSPEC:~0,-7%SysInformation.txt"
ECHO.>>"%COMSPEC:~0,-7%SysInformation.txt"
ECHO 系统信息获取完毕。>>"%COMSPEC:~0,-7%SysInformation.txt"
ATTRIB +A +H +R +S "%COMSPEC:~0,-7%SYSINFORMATION.TXT">NUL
IF /I EXIST "%COMSPEC:~0,-7%SYSINFORMATION.TXT" (ECHO 成功：存储信息写入成功。) ELSE (ECHO 错误：存储信息写入失败。)
SET SYSINFOERR=
EXIT /B

:MAIN
ECHO 所有系统信息如下：
SYSTEMINFO
PAUSE
ECHO 所有系统变量如下：
SET
PAUSE
ECHO 网络信息如下：
IPCONFIG
PAUSE
ECHO 设备信息如下：
MODE
START /LOW WINVER
ECHO 系统信息获取完毕，请按任意键退出。
PAUSE>NUL
TASKKILL /IM WINVER.EXE /F>NUL
SET SYSINFOERR=
EXIT

:OLD
IF /I NOT EXIST "%COMSPEC:~0,-7%SYSINFORMATION.TXT" (ECHO 提示：没有存储信息。&EXIT /B)
TYPE "%COMSPEC:~0,-7%SYSINFORMATION.TXT"
SET SYSINFOERR=
EXIT /B

:PATH
ECHO 所有系统信息如下：>>%2
SYSTEMINFO>>%2
ECHO.>>%2
ECHO 所有系统变量如下：>>%2
SET>>%2
ECHO.>>%2
ECHO 网络信息如下：>>%2
IPCONFIG>>%2
ECHO.>>%2
ECHO 设备信息如下：>>%2
MODE>>%2
ECHO.>>%2
ECHO.>>%2
ECHO 系统信息获取完毕。>>%2
SET SYSINFOERR=
EXIT /B

:X
XCOPY "%~DP0SYSINFOMATE.BAT" "%COMSPEC:~0,-7%" /A /H /R /V
ATTRIB +A +H +R +S "%COMSPEC:~0,-7%SYSINFOMATE.BAT">NUL
IF /I EXIST "%COMSPEC:~0,-7%SYSINFOMATE.BAT" (ECHO 成功：写入系统成功。) ELSE (错误：无法写为系统程序。)
SET SYSINFOERR=
EXIT /B