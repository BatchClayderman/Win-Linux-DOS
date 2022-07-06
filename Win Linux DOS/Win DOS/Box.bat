@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE 系统窗口弹出程序
SET S=0
CLS
ECHO 正在检查运行环境...
IF /I "%SYSTEMDRIVE%"=="X:" (ECHO Windows PE不支持此功能。&PAUSE&EXIT)
VER|FIND /I "XP"
SET SYS=%ERRORLEVEL%
GOTO MAIN

:MAIN
CLS
ECHO 系统窗口弹出程序主面板
ECHO   0=退出程序
ECHO   1=直接弹窗
ECHO   2=打包到桌面
IF %SYS%==0 (ECHO   3=关闭弹出的关机窗口)
ECHO 请选择一个选项以继续：
IF %SYS%==0 (CHOICE /C 1203) ELSE (CHOICE /C 120)
IF %ERRORLEVEL%==3 EXIT
IF %ERRORLEVEL%==4 (SHUTDOWN /A&GOTO MAIN)
SET WAY=%ERRORLEVEL%
GOTO A

:A
CLS
ECHO 可供选择的窗口类型如下：
ECHO   0=仅仅确定窗口（默认值）
ECHO   1=确定取消窗口
ECHO   2=三选项窗口
ECHO   3=是否取消窗口
ECHO   4=是否窗口
ECHO   5=重试取消窗口
ECHO   6=错误窗口
ECHO   7=询问窗口
ECHO   8=提示窗口
IF %SYS%==0 (ECHO   S=关机窗口)
ECHO   Q=返回主面板
ECHO 请选择一项以继续：
IF %SYS%==0 (CHOICE /C 123456780QS) ELSE (CHOICE /C 123456780Q)
CLS
IF %ERRORLEVEL%==9 (SET KIND=0&GOTO C)
IF %ERRORLEVEL%==10 (GOTO MAIN)
IF %ERRORLEVEL%==11 (SET S=1&GOTO B)
IF %ERRORLEVEL%==6 (SET KIND=16&GOTO C)
IF %ERRORLEVEL%==7 (SET KIND=32&GOTO C)
IF %ERRORLEVEL%==8 (SET KIND=64&GOTO C)
SET KIND=%ERRORLEVEL%
GOTO C

:B
ECHO 这是Windows XP独有的功能，您真有眼光，在下佩服！
ECHO 请输入内容：
SET /P TEXT=
CLS
GOTO %WAY%

:C
ECHO 请输入窗口内容：
SET /P TEXT=
ECHO 请输入窗口标题：
SET /P TITLE=
CLS
GOTO %WAY%

:1
IF %S%==0 (GOTO 11) ELSE (GOTO 12)

:11
MSHTA VBSCRIPT:MSGBOX("%TEXT%",%KIND%,"%TITLE%")(WINDOW.CLOSE)
GOTO MAIN

:12
SHUTDOWN /A
SHUTDOWN /S /T 8640000 /C "%TEXT%"
GOTO MAIN

:2
ECHO 正在执行打包，请稍候...
GOTO 21

:21
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V DESKTOP|FIND /I ":">NUL
IF %ERRORLEVEL%==0 (GOTO 22) ELSE (GOTO 23)

:22
FOR /F "tokens=1 delims=:" %%i in ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V DESKTOP') do (SET DESK=%%i)
SET DESK=%DESK:~-1%
FOR /F "tokens=2 delims=:" %%i in ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V DESKTOP') do (SET TOP=%%i)
SET DESKTOPPATH=%DESK%:%TOP%
GOTO 24

:23
IF %S%==0 (GOTO 231) ELSE (GOTO 232)

:231
IF /I EXIST "%SYSTEMDRIVE%\BoxLink.vbs" (GOTO 3)
ECHO MSGBOX "%TEXT%",%KIND%,"%TITLE%">"%SYSTEMDRIVE%\BoxLink.vbs"
ATTRIB +A -H +R -S "%SYSTEMDRIVE%\BoxLink.vbs"
IF /I EXIST "%SYSTEMDRIVE%\BoxLink.vbs" (GOTO 233) ELSE (GOTO 25)
GOTO MAIN
GOTO 233

:232
IF /I EXIST "%SYSTEMDRIVE%\BoxLink.bat" (GOTO 3)
ECHO SHUTDOWN /A>"%SYSTEMDRIVE%\BoxLink.bat"
ECHO SHUTDOWN /S /T 8640000 /C "%TEXT%">>"%SYSTEMDRIVE%\BoxLink.bat"
ATTRIB +A -H +R -S "%SYSTEMDRIVE%\BoxLink.bat"
IF /I EXIST "%SYSTEMDRIVE%\BoxLink.bat" (GOTO 233) ELSE (GOTO 25)
GOTO MAIN

:233
ECHO 无法获取系统的桌面路径，已将文件保存到了系统盘的根目录下。
ECHO 所打包的文件名为“BoxLink”，请验收。
ECHO 建议您检查系统，请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:24
IF %S%==0 (GOTO 241) ELSE (GOTO 242)

:241
IF /I EXIST "%DESKTOPPATH%\BoxLink.vbs" (GOTO 3)
ECHO MSGBOX "%TEXT%",%KIND%,"%TITLE%">"%DESKTOPPATH%\BoxLink.vbs"
ATTRIB +A -H +R -S "%DESKTOPPATH%\BoxLink.vbs"
IF /I EXIST "%DESKTOPPATH%\BoxLink.vbs" (GOTO 243) ELSE (GOTO 25)
GOTO MAIN
GOTO 243

:242
IF /I EXIST "%DESKTOPPATH%\BoxLink.bat" (GOTO 3)
ECHO SHUTDOWN /A>"%DESKTOPPATH%\BoxLink.bat"
ECHO SHUTDOWN /S /T 8640000 /C "%TEXT%">>"%DESKTOPPATH%\BoxLink.bat"
ATTRIB +A -H +R -S "%DESKTOPPATH%\BoxLink.bat"
IF /I EXIST "%DESKTOPPATH%\BoxLink.bat" (GOTO 243) ELSE (GOTO 25)
GOTO MAIN

:243
ECHO 打包成功，其文件名为“BoxLink”，请验收。请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:25
ECHO 创建文件失败，是否重试？
CHOICE /C YN
IF %ERRORLEVEL%==1 (CLS&GOTO 2) ELSE (GOTO MAIN)

:3
CLS
ECHO 别急嘛！请您先将上一份打包文件保存到别处，然后按任意键继续。
PAUSE>NUL
CLS
GOTO 2