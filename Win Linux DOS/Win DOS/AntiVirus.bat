@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE 反病毒软件专业工具
SET ERR=0
IF %PROCESSOR_ARCHITECTURE:~-1%==6 (SET W=32&GOTO MAIN)
IF %PROCESSOR_ARCHITECTURE:~-1%==4 (SET W=64&GOTO MAIN)
IF %PROCESSOR_ARCHITECTURE:~-1%==2 (SET W=32&SET ERR=1&GOTO MAIN)
GOTO A

:A
CLS
ECHO Win DOS无法获取您的操作系统位数，请手动选择。
CHOICE /C 036 /M "退出程序请选择0，32位系统请选择3，64位系统请选择6。"
IF %ERRORLEVEL%==1 EXIT
IF %ERRORLEVEL%==2 (SET W=32)
IF %ERRORLEVEL%==3 (SET W=64)
GOTO MAIN

:MAIN
CLS
ECHO 反病毒软件专业工具-Windows %W%
IF %ERR%==1 (ECHO 您的系统可能发生了参变，建议启动参变检测仪。)
ECHO.
ECHO 可供的选择如下：
ECHO   0=退出
ECHO   1=Everything（文件查找神器）
ECHO   2=360系统急救箱
ECHO   3=PC Hunter Standard（Windows XP下建议搭载systemrun）
ECHO   4=微点主动防御软件（推荐32位操作系统使用）
ECHO   5=DiskGenius
ECHO 版权声明：以上专业工具由其它公司提供，不属于Win DOS，不得用于商业用途。
ECHO 风险说明：数字越大，操作技术越高，如果您不是专业人员，请勿随意操作。
ECHO 请选择一项以继续：
CHOICE /C 123450
CLS
IF %ERRORLEVEL%==6 EXIT
GOTO %ERRORLEVEL%

:1
ECHO Everything
ECHO 要下载Everything，请直接通过网络搜索引擎搜索获取。
ECHO 如有需要，请联系本脚本开发人员中的通讯作者，按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:2
ECHO 360系统急救箱
IF %W%==64 (ECHO 您的系统为64位系统，急救箱无法启动隐藏进程保护，是否继续？) ELSE (ECHO 即将下载360系统急救箱，是否继续？)
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO MAIN)
FOR /F "TOKENS=1 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (%%I "" "https://www.360.cn/jijiuxiang/")
GOTO MAIN

:3
ECHO PC Hunter Standard
ECHO PC Hunter Standard目前已经更新至V1.6版本，最新版在微信群发布。
ECHO 如有需要，请联系本脚本开发人员中的通讯作者，按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:4
ECHO 正在检查管道通道，请稍候...
TASKKILL /IM MP* /F /T
WMIC PROCESS GET NAME|FIND /I "MPSVC2.EXE">NUL
CLS
IF %ERRORLEVEL%==0 (CLS&ECHO 主动防御处于活跃状态，系统安全，请按任意键返回主面板。&PAUSE>NUL&GOTO MAIN)
SC START MPSVCSERVICE
WMIC PROCESS GET NAME|FIND /I "MPSVC2.EXE">NUL
IF %ERRORLEVEL%==0 (MSHTA VBSCRIPT:MSGBOX("您已安装微点主动防御软件，但主动防御并非处于活跃状态，建议重新启动系统，点击“确定”返回主面板。",64,"反病毒专业工具"^)(WINDOW.CLOSE^)&GOTO MAIN)
CLS
ECHO 微点主动防御软件-先进的第三代反病毒软件（国家“863”重点科技项目)
ECHO 推荐理由：驱动级的反病毒机制，曾担任2008年北京奥运会网络安全总工程师。
ECHO 即将访问主动防御官网，是否继续？
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO MAIN)
FOR /F "TOKENS=1 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (%%I "" "https://www.depthsec.com.cn/index.php?m=&c=Product&a=personal")
GOTO MAIN

:5
ECHO DiskGenius
ECHO 即将访问DiskGenius官网，是否继续？
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO MAIN)
FOR /F "TOKENS=1 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (%%I "" "https://www.diskgenius.cn/")
GOTO MAIN