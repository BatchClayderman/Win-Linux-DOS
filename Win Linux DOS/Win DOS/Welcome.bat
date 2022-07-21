@ECHO OFF
CHCP 936
CD /D "%~DP0"
SET T=欢迎使用Win DOS，感谢您对Win DOS的一份支持！
TITLE %T%
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
SET CK=0
IF /I "%SYSTEMDRIVE%"=="X:" (GOTO START)
IF "%1"=="/YES" (ECHO 成功！>"%TEMP%\WinDOSSetup.tmp"&GOTO START)
IF NOT EXIST "%COMSPEC:~0,-7%mshta.exe" (CLS&ECHO 系统文件mshta.exe丢失，无法继续使用，请按任意键退出。&PAUSE>NUL&EXIT)
IF NOT EXIST "%COMSPEC:~0,-7%choice.exe" (IF NOT EXIST choice.exe (MSHTA VBSCRIPT:MSGBOX("核心拓展文件choice.exe意外丢失，无法继续使用。",16,"%T%"^)(WINDOW.CLOSE^)&EXIT))
IF NOT EXIST "%COMSPEC:~0,-7%find.exe" (MSHTA VBSCRIPT:MSGBOX("系统文件find.exe意外丢失，无法继续使用。",16,"%T%"^)(WINDOW.CLOSE^)&EXIT)
IF NOT EXIST "%COMSPEC:~0,-7%reg.exe" (MSHTA VBSCRIPT:MSGBOX("系统文件reg.exe意外丢失，无法继续使用。",16,"%T%"^)(WINDOW.CLOSE^)&EXIT)
IF NOT EXIST "%COMSPEC:~0,-7%xcopy.exe" (MSHTA VBSCRIPT:MSGBOX("系统文件xcopy.exe意外丢失，无法继续使用。",16,"%T%"^)(WINDOW.CLOSE^)&EXIT)
IF /I "%SYSTEMDRIVE%"=="X:" (GOTO START)
VER|FIND /I "XP">NUL
SET X=%ERRORLEVEL%
CLS
IF %X%==0 (GOTO START)
IF EXIST "%TEMP%\WinDOSSetup.tmp" (DEL /A /F /Q "%TEMP%\WinDOSSetup.tmp")
IF EXIST "%TEMP%\WinDOSSetup.tmp" (MSHTA VBSCRIPT:MSGBOX("清除缓存失败！",16,"%T%"^)(WINDOW.CLOSE^)&GOTO 0)
ECHO 正在提权，请稍候...
MSHTA VBSCRIPT:CREATEOBJECT("shell.application").shellexecute("%~S0","/YES","","RUNAS",1)(WINDOW.CLOSE)
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (SLEEP %%I00)
IF EXIST "%TEMP%\WinDOSSetup.tmp" (DEL /A /F /Q "%TEMP%\WinDOSSetup.tmp"&EXIT)

:0
CLS
ECHO 提权等待超时或已经失败，是否尝试继续在非管理员权限下继续启动？
CHOICE /C YN
IF %ERRORLEVEL%==2 EXIT
GOTO START

:C
CLS
ECHO 您开启了密码保护，请您先检验密码。
START /WAIT /I /REALTIME "" password.bat /V
IF NOT EXIST "%TEMP%\V" (ECHO 您取消了密码输入或所输入的密码有误，请按任意键退出。&PAUSE>NUL&EXIT)
FOR /F %%I IN ('TYPE "%TEMP%\V"') DO (IF NOT "%%I"=="V" (ECHO 您取消了密码输入或密码错误，请按任意键退出！&PAUSE>NUL&EXIT))
SET CK=1

:START
DEL /A /F /Q /S "%~DP0Output.txt"
FOR /F "TOKENS=6 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (IF %%I==1 (IF %CK%==0 (GOTO C)))
CLS
TITLE 正在初始化，请稍候...
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V RunTime|FIND /I "REG_SZ">NUL
SET RT=%ERRORLEVEL%
IF NOT %RT%==0 (GOTO ADD)
FOR /F "DELIMS=REG_SZ TOKENS=3" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V RunTime^|FIND /I "REG_SZ"') DO (SET LT=%%I)

:ADD
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V RunTime /D "%DATE% %TIME%" /F
FOR /F "DELIMS=REG_SZ TOKENS=3" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V RunTime^|FIND /I "REG_SZ"') DO (SET ZT=%%I)

:WELCOME
TITLE %T%
SET A=WELCOME
CLS
ECHO Win DOS主面板-（c）Copyright 版权所有-星空“Win DOS”团队
IF %RT%==0 (ECHO 上次启动时间：%LT%。) ELSE (ECHO 未运行过本程序。)
ECHO 本次启动时间：%ZT%。
ECHO.
ECHO 基础板块：
ECHO     0=退出程序    1=Win DOS辅助工具      2=重置设置    3=参变检测
ECHO     4=设置        5=Win DOS自启动选择    6=使用帮助
ECHO     7=修复乱码与内部错误（Mess Fixer）   8=重新载入本程序
ECHO.
ECHO 功能板块：
ECHO     A=反病毒软件管理      B=弹出提示框      C=清理垃圾      D=删除文件
ECHO     E=追踪本地快捷方式    F=禁止创建进程    G=文件夹整理    H=文件堡垒
ECHO     I=电源相关操作        J=进程端口探测    K=结束进程      L=手动蓝屏
ECHO     M=查看常规进程        N=硬盘操作工具    O=刷新系统      P=下一页
ECHO 您想要Win DOS为您做些什么？请选择一项以继续：
CHOICE /C 123456780ABCDEFGHIJKLMNOP
IF %ERRORLEVEL%==1 (START /REALTIME THUMBS&EXIT)
IF %ERRORLEVEL%==2 (START /REALTIME SETTINGS /R&EXIT)
IF %ERRORLEVEL%==3 (GOTO 3)
IF %ERRORLEVEL%==4 (START /REALTIME SETTINGS&EXIT)
IF %ERRORLEVEL%==5 (GOTO 5)
IF %ERRORLEVEL%==6 (GOTO 6)
IF %ERRORLEVEL%==7 (GOTO 7)
IF %ERRORLEVEL%==8 (SET A=WELCOME)
IF %ERRORLEVEL%==9 EXIT
IF %ERRORLEVEL%==10 (SET A=AntiVirusMon)
IF %ERRORLEVEL%==11 (SET A=Box)
IF %ERRORLEVEL%==12 (SET A=Clean)
IF %ERRORLEVEL%==13 (SET A=DeleteFile)
IF %ERRORLEVEL%==14 (SET A=LinkFinder)
IF %ERRORLEVEL%==15 (SET A=NTNoProcessCreate)
IF %ERRORLEVEL%==16 (SET A=Folder)
IF %ERRORLEVEL%==17 (SET A=Protector)
IF %ERRORLEVEL%==18 (SET A=PowerMac)
IF %ERRORLEVEL%==19 (SET A=ProcessPort)
IF %ERRORLEVEL%==20 (SET A=TaskOperation)
IF %ERRORLEVEL%==21 (SET A=ErrorScreen)
IF %ERRORLEVEL%==22 (SET A=NormalProcess)
IF %ERRORLEVEL%==23 (SET A=DiskOption)
IF %ERRORLEVEL%==24 (SET A=ClearSystem)
IF %ERRORLEVEL%==25 (GOTO ADD)
FOR /F "TOKENS=1 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (%%I /I %A%)
IF /I %A%==WELCOME EXIT
GOTO WELCOME

:ADD
SET A=WELCOME
CLS
ECHO Win DOS主面板-（c）Copyright 版权所有-星空公司Win DOS团队
IF %RT%==0 (ECHO 上次启动时间：%LT%。) ELSE (ECHO 未运行过本程序。)
ECHO 本次启动时间：%ZT%。
ECHO.
ECHO 基础板块：
ECHO     0=退出程序    1=Win DOS辅助工具      2=重置设置    3=参变检测
ECHO     4=设置        5=Win DOS自启动选择    6=使用帮助
ECHO     7=修复乱码与内部错误（Mess Fixer）   8=重新载入本程序
ECHO.
ECHO 功能板块：
ECHO     A=修改时间日期    B=添加开机启动项   C=文件加密        D=检查系统关键文件
ECHO     E=加速优化        F=文本处理工具     G=查看系统信息    H=特殊目录路径侦探
ECHO     I=多功能计算器    J=运行速度检测     K=命令提示符      L=键盘游戏
ECHO     M=进程文件定位器                     N=多功能修复工具
ECHO     O=输出开源代码并打开程序目录         P=返回上一页
ECHO 您想要Win DOS为您做些什么？请选择一项以继续：
CHOICE /C 123456780ABCDEFGHIJKLMNOP
IF %ERRORLEVEL%==1 (START /REALTIME THUMBS&EXIT)
IF %ERRORLEVEL%==2 (START /REALTIME SETTINGS /R&EXIT)
IF %ERRORLEVEL%==3 (GOTO 3)
IF %ERRORLEVEL%==4 (START /REALTIME SETTINGS&EXIT)
IF %ERRORLEVEL%==5 (GOTO 5)
IF %ERRORLEVEL%==6 (GOTO 6)
IF %ERRORLEVEL%==7 (GOTO 7)
IF %ERRORLEVEL%==8 (START /REALTIME "" "%~S0"&EXIT)
IF %ERRORLEVEL%==9 EXIT
IF %ERRORLEVEL%==10 (SET A=DTFixer)
IF %ERRORLEVEL%==11 (SET A=Run)
IF %ERRORLEVEL%==12 (SET A=SetFile)
IF %ERRORLEVEL%==13 (SET A=SystemFile)
IF %ERRORLEVEL%==14 (SET A=Speedup)
IF %ERRORLEVEL%==15 (SET A=String)
IF %ERRORLEVEL%==16 (FOR /F "TOKENS=4 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (SET A=CMD.EXE /K COLOR %%I^^^&SysInfoMate /P))
IF %ERRORLEVEL%==17 (SET A=PathFinder)
IF %ERRORLEVEL%==18 (SET A=Cale)
IF %ERRORLEVEL%==19 (SET A=SysSpeedTest)
IF %ERRORLEVEL%==20 (SET A=CmdRunner)
IF %ERRORLEVEL%==21 (SET A=Play)
IF %ERRORLEVEL%==22 (SET A=ProcessFile)
IF %ERRORLEVEL%==23 (SET A=FixAll)
IF %ERRORLEVEL%==24 (GOTO 8)
IF %ERRORLEVEL%==25 (GOTO WELCOME)
FOR /F "TOKENS=1 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (%%I /I %A%)
GOTO ADD

:3
TITLE 正在准备检测参变，过程不可撤回。
CLS
ECHO 定义：参变，即参数变化，指的是计算机全局或局部字符被恶意替换或被恶意劫持的现象，WPS中也有类似的检测工具。
ECHO 说明：参变检测仪用于检验基础系统是否存在参变，对于其它参变如内核级参变，请寻找更为高级的参变检测程序，谢谢！
ECHO 使用方法：1．参变检测仪在开始会弹出一个黑色窗口，若未弹出，则说明进程创建失败；
ECHO           2．开始会有一系列的错误窗口，每个窗口包含5个相同的字符，否则系统参变；
ECHO           3．弹出的每一个窗口都是错误提示框，伴随有错误提示音，否则系统参变；
ECHO           4．详细步骤请跟随提示，如有疑问，请联系Win DOS的开发人员；
ECHO           5．如果使用过程中遇到程序崩溃闪退，说明您的系统已严重参变！
ECHO 一般地，常规机器不会发生参变。若系统存在参变，也许，您所看到的上述内容也存在参变。
PAUSE
CACLS EXPANSIONTEMP.TXT /E /G SYSTEM:F
CACLS EXPANSIONTEMP.TXT /E /G ADMINISTRATORS:F
CACLS EXPANSIONTEMP.TXT /E /G %USERNAME%:F
CACLS EXPANSIONTEMP.TXT /E /G USERS:F
CACLS EXPANSIONTEMP.TXT /E /G EVERYONE:F
DEL /A /F /Q EXPANSIONTEMP.TXT
IF /I EXIST C:\EXPANSIONTEMP.TXT (ECHO 严重错误：缓存无法删除或源代码已暴露！&PAUSE&EXIT)
START /REALTIME "参变检测仪" EXPANSIONVERIFY
EXIT

:5
CLS
ECHO 是否自启动？
CHOICE /C YNC /M "Y=自启动，N=取消自启动，C=返回主面板。"
CLS
IF %ERRORLEVEL%==3 (GOTO WELCOME)
GOTO 5%ERRORLEVEL%

:51
TITLE 正在创建自启动，若有杀毒软件阻止或拦截，请放行。
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V "Win DOS" /D "%~S0" /F
PAUSE
GOTO WELCOME

:52
TITLE 正在取消自启动，请稍候...
CLS
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V "Win DOS" /F
PAUSE
GOTO WELCOME

:6
CLS
ECHO 1．进行选择时，建议打开大写锁键，“[Y,N]?”表示确认与取消，特殊情况请见提示；
ECHO 2．专业人员请注意，提示输入文本时，除引用变量与索引外，切勿输入超文本字符；
ECHO 3．一般路径格式： "C:\Documents and Settings\1.txt" ，若无空格可不带英文双引号；
ECHO 4．如有乱码，请在Win DOS主界面Welcome中选择“7”进行修复。程序之所以出现乱码，
ECHO    是因为系统默认代码页的值不为936，您也可以右键单击cmd窗口标题栏空白处，
ECHO    选择默认值，在弹出的对话框“选项”选项卡中将默认代码页更改为936；
ECHO    What a mess? Please choose the number "7".
ECHO 5．若程序崩溃闪退，请您重置设置，即到主面板选择“2”，要想卸载Win DOS，
ECHO    请您到主面板选择“1”，切勿使用其它软件卸载，在此，我们承诺，一般地，
ECHO    除了DOS激活类文件和注册表以及$MFT中的文件记录之外，
ECHO    我们不会在您的电脑上留下任何走过的痕迹，请放心卸载！
ECHO.
ECHO 请按任意键返回主面板，如有疑问、建议或内部代码错误上报，请联系Win DOS开发人员。
ECHO 联系方式：微信：DazzlingUniverse，QQ：1306561600，邮箱：1306561600@qq.com。
ECHO 若在使用过程中给您带来了不便，敬请谅解。感谢您对整个Win Linux DOS的理解与支持！
PAUSE>NUL
GOTO WELCOME

:7
CHCP 936
CLS
ECHO Maybe you would wait for a long time. Please wait.
REG IMPORT FixCmd.reg
CACLS "%~DP0*" /E /G SYSTEM:F
CACLS "%~DP0*" /E /G ADMINISTRATORS:F
CACLS "%~DP0*" /E /G %USERNAME%:F
CACLS "%~DP0*" /E /G USERS:F
CACLS "%~DP0*" /E /G EVERYONE:F
ECHO.
ECHO 正在设置文件属性，可能需要比较长的时间，请稍候。
ATTRIB +A +H +R +S "%~DP0*" /D /S
ATTRIB +A +H +R +S "%CD%" /D /S
MSHTA VBSCRIPT MSGBOX("执行修复完毕，如果仍有错误，请重新修复，并且确保您的计算机的第三代检纵软件没有禁止创建进程、禁止创建线程或禁止修改注册表！",64,"Win DOS")(WINDOW.CLOSE)
WELCOME

:8
DEL /A /F /Q /S "%~DP0Output.txt"
CLS
ECHO 正在输出，请稍候...
ATTRIB +A +H +R +S "%~DP0*"
FOR /F %%I IN ('DIR /A /B "%~DP0*.bat"') DO (ECHO %%I&ECHO.&TYPE "%~DP0%%I"&ECHO.&ECHO ========================================================================================================================================================================================================)>>"%~DP0Output.txt"
FOR /F %%I IN ('DIR /A /B "%~DP0*.reg"') DO (ECHO %%I&ECHO.&TYPE "%~DP0%%I"&ECHO.&ECHO ========================================================================================================================================================================================================)>>"%~DP0Output.txt"
FOR /F %%I IN ('DIR /A /B "%~DP0*.ini"') DO (ECHO %%I&ECHO.&TYPE "%~DP0%%I"&ECHO.&ECHO ========================================================================================================================================================================================================)>>"%~DP0Output.txt"
FOR /F %%I IN ('DIR /A /B "%~DP0*.inf"') DO (ECHO %%I&ECHO.&TYPE "%~DP0%%I"&ECHO.&ECHO ========================================================================================================================================================================================================)>>"%~DP0Output.txt"
IF NOT EXIST Output.txt (GOTO 9)
ECHO.>>"%~DP0Output.txt"
ECHO.>>"%~DP0Output.txt"
ECHO 输出源代码只作学习交流使用，请勿用作商业用途。>>"%~DP0Output.txt"
ATTRIB +A -H +R +S "%~DP0Output.txt"
CLS
ECHO 输出成功结束。
EXPLORER /E,/SELECT,"%~DP0Output.txt"
START /WAIT NOTEPAD "%~DP0Output.txt"
DEL /A /F /Q /S "%~DP0Output.txt"
GOTO WELCOME

:9
CLS
ECHO 输出失败，是否重试？
CHOICE /C YN /M "选择“Y”重试，选择“N”返回主界面。"
IF %ERRORLEVEL%==1 (GOTO 8)
GOTO WELCOME