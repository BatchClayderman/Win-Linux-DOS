@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE 实时查看进程信息
SET A=1
SET C=0
SET D=%SYSTEMDRIVE%
SET T=简略
CLS
IF /I "%SYSTEMDRIVE%"=="X:" (ECHO Windows PE下此功能无意义。&PAUSE&EXIT)
ECHO 是否查看详细信息？
CHOICE /C YN
IF /I %ERRORLEVEL%==1 (
	START /REALTIME "请在下方输入process并回车。如果需要刷新，请再次输入process并回车。" WMIC
	MSHTA VBSCRIPT:MSGBOX("请在弹出窗口中输入process并回车。如果需要刷新，请再次输入process并回车。",0,"实时查看普通进程详细信息"^)(WINDOW.CLOSE^)
	EXIT
)
ECHO 是否自动刷新？
CHOICE /C YN
IF %ERRORLEVEL%==2 (SET A=0)
ECHO 是否生成报告到%D:~0,-1%盘？
CHOICE /C YN
IF %ERRORLEVEL%==1 (SET C=1)
CLS
GOTO M

:B
MSHTA VBSCRIPT:MSGBOX("创建文件失败，点击“确定”重试！",0,"实时查看普通进程%T%信息-生成报告时出现错误")(WINDOW.CLOSE)
IF %C%==0 (GOTO T) ELSE (GOTO C)

:C
CACLS %D%\Normalprocess.txt /E /G SYSTEM:F
CACLS %D%\Normalprocess.txt /E /G ADMINISTRATORS:F
CACLS %D%\Normalprocess.txt /E /G %USERNAME%:F
CACLS %D%\Normalprocess.txt /E /G USERS:F
CACLS %D%\Normalprocess.txt /E /G EVERYONE:F
DEL /A /F /Q %D%\Normalprocess.txt
IF /I EXIST %D%\Normalprocess.txt (GOTO E)
IF %C%==1 (DATE /T>%D%\Normalprocess.txt)
ATTRIB +A +H +S -R %D%\Normalprocess.txt
IF %C%==1 (IF /I EXIST %D%\Normalprocess.txt (GOTO T) ELSE (GOTO B))
IF %C%==0 (GOTO T)

:D
CLS
MSHTA VBSCRIPT:MSGBOX("本程序将实时更新普通进程%T%信息，请按窗口标题提示执行操作。",0,"实时查看普通进程%T%信息")(WINDOW.CLOSE)
GOTO C

:E
MSHTA VBSCRIPT:MSGBOX("删除原报告时出现错误，点击“确定”重试！",0,"实时查看普通进程%T%信息")(WINDOW.CLOSE)
CACLS %D%\Normalprocess.txt /E /G SYSTEM:F
CACLS %D%\Normalprocess.txt /E /G ADMINISTRATORS:F
CACLS %D%\Normalprocess.txt /E /G %USERNAME%:F
CACLS %D%\Normalprocess.txt /E /G USERS:F
CACLS %D%\Normalprocess.txt /E /G EVERYONE:F
DEL /A /F /Q %D%\Normalprocess.txt
IF /I "%Y%"=="Y" (IF /I EXIST %D%\Normalprocess.txt (GOTO E) ELSE (GOTO C))

:M
ECHO 请选择一个内容模式以继续：
ECHO   0=退出程序
ECHO   1=查看会话和内存
ECHO   2=查看服务
ECHO   3=查看模块
ECHO   4=查看会话任务和任务信息
ECHO 无论您选择哪一种模式，显示的信息都会包含映像名称和进程标识符信息，请选择一项以继续：
CHOICE /C 12340
IF %ERRORLEVEL%==1 (SET O=)
IF %ERRORLEVEL%==2 (SET O= /SVC&SET T=服务)
IF %ERRORLEVEL%==3 (SET O= /M&SET T=模块)
IF %ERRORLEVEL%==4 (SET O= /V&SET T=任务)
IF %ERRORLEVEL%==5 EXIT
GOTO D

:T
IF %A%==1 (TITLE 实时查看普通进程%T%信息：如果需要暂停请按下Ctrl+C，如果需要停止请关闭窗口。) ELSE (TITLE 实时查看普通进程%T%信息：请按任意键刷新，如果需要停止请关闭窗口。)
CLS
TASKLIST%O%
IF %C%==1 (ECHO.>>%D%\Normalprocess.txt)
IF %C%==1 (ECHO.>>%D%\Normalprocess.txt)
IF %C%==1 (TIME /T>>%D%\Normalprocess.txt)
IF %C%==1 (TASKLIST%O%>>%D%\Normalprocess.txt)
IF %A%==0 PAUSE
GOTO T