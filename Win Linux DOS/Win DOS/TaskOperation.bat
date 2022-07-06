@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
SET B=0
SET L=0
SET O=结束进程
SET TREE=
COLOR E
SET T=
SET W=0
SET Z=
CLS
GOTO TASK

:TASK
TITLE %Z%%TREE%%O%
IF NOT %L%==0 (TITLE %Z%%TREE%%O%-已锁定)
IF NOT %L%==0 (GOTO L)
SET Z=
IF %B%==0 (IF %W%==0 (TASKKILL /IM WMIC.EXE /F /T))
CLS
IF %W%==0 TASKLIST
IF %B%==1 (CLS&GOTO WMIC)
IF %B%==2 (SET B=4&TASKLIST)
IF %B%==3 CLS
IF %B%==4 (CLS&SET B=0)
ECHO 以下为可供执行的操作：
ECHO   0=退出程序
ECHO   1=刷新进程列表（详细信息模式下不生效）
IF %W%==0 (ECHO   2=查看进程详细信息（仅此一次）)
IF %W%==1 (ECHO   2=查看进程简略信息（仅此一次）)
IF %W%==0 (ECHO   3=查看进程详细信息（直到本程序退出）)
IF %W%==1 (ECHO   3=查看进程简略信息（直到本程序退出）)
IF "%T%"=="/T" (ECHO   4=停用进程树操作) ELSE (ECHO   4=启用进程树操作)
ECHO   5=通过映像名称%TREE%%O%
ECHO   6=通过进程标识符%TREE%%O%
IF %O%==关闭窗口 (ECHO   7=结束进程(当前：仅作关闭窗口处理）) ELSE (ECHO   7=仅作关闭窗口处理（当前：结束进程）)
ECHO   8=使用古结束法
ECHO   9=锁定关闭或结束方式
ECHO 请选择一项操作：
CHOICE /C 1234567890
IF %ERRORLEVEL%==10 EXIT
IF %ERRORLEVEL%==1 (GOTO TASK)
IF %ERRORLEVEL%==2 (IF %W%==0 (SET B=1)&IF %W%==1 (SET B=2))
IF %ERRORLEVEL%==3 (IF %W%==1 (SET W=0&SET B=0&TASKKILL /IM WMIC.EXE /F /T&GOTO TASK) ELSE (SET W=1&GOTO WMIC))
IF %ERRORLEVEL%==4 (IF "%T%"=="/T" (SET TREE=&SET T=) ELSE (SET TREE=按进程树&SET T=/T)&GOTO TASK)
IF %ERRORLEVEL%==5 (SET Z=通过映像名称&GOTO I)
IF %ERRORLEVEL%==6 (SET Z=通过PID&GOTO P)
IF %ERRORLEVEL%==7 (IF %O%==关闭窗口 (SET O=结束进程) ELSE (SET O=关闭窗口))
IF %ERRORLEVEL%==2 (TASKLIST&PAUSE&GOTO TASK)
IF %ERRORLEVEL%==7 (GOTO TASK)
GOTO %ERRORLEVEL%

:8
TITLE 古结束法
ECHO 注意：如果进程名为纯数字，所输数字将被识别为PID。
ECHO 请输入去exe进程名（*通配符可用）或PID：
SET /P P=
TSKILL "%P%"
PAUSE
TSKILL WMIC
GOTO TASK

:9
ECHO 请在5-8中输入操作选项：
CHOICE /C 5678
SET /A L=%ERRORLEVEL%+4
GOTO TASK

:I
TITLE %Z%%TREE%%O%
IF NOT %L%==0 (TITLE %Z%%TREE%%O%-已锁定)
ECHO 请输入进程映像名称（*通配符可用）：
SET /P IMN=
SET IMN="%IMN%"
IF %O%==关闭窗口 (TASKKILL /IM %IMN% %T%&GOTO TASK)
TASKKILL /IM %IMN% /F %T%
WMIC PROCESS GET NAME|FIND /I %IMN%
IF %ERRORLEVEL%==0 (SET NT=1&GOTO NT)
GOTO TASK

:L
CLS
IF %W%==0 TASKLIST
IF "%L%"=="5" (GOTO I)
IF "%L%"=="6" (GOTO P)
IF "%L%"=="7" (SET O=关闭窗口&GOTO TASK)
IF "%L%"=="8" (GOTO 8)
IF "%L%"=="9" (GOTO 9)
GOTO TASK


:P
TITLE %Z%%TREE%%O%
IF NOT %L%==0 (TITLE %Z%%TREE%%O%-已锁定)
ECHO 请输入进程PID：
SET /P PID=
IF %O%==关闭窗口 (TASKKILL /IM %PID% %T%&GOTO TASK)
TASKKILL /IM %PID% /F %T%
WMIC PROCESS GET PROCESSID|FIND "%PID%"
IF %ERRORLEVEL%==0 (SET NT=2&GOTO NT)
GOTO TASK

:NT
ECHO 上述进程结束失败，是否需要强制结束？
ECHO （专业人员请注意，该结束方式未涉及NT级或驱动级，结束能级较弱。）
ECHO （如有需要，请到反病毒专业工具中下载PC Hunter Standard。）
CHOICE /C YN
IF %ERRORLEVEL%==1 (IF %NT%==2 (ntsd -c q -p %PID%) ELSE (ntsd -c q -pn %IMN%))
IF %B%==0 (IF %W%==0 (TASKKILL /IM WMIC.EXE /F /T))
GOTO TASK

:WMIC
TASKKILL /IM WMIC.EXE /F /T
CLS
START "请在下方输入process并回车。如需刷新，请再次输入process并回车。" WMIC
MSHTA VBSCRIPT:MSGBOX("请在弹出窗口中输入process并回车。如需刷新，请再次输入process并回车。",0,"结束进程")(WINDOW.CLOSE)
IF %B%==1 (SET B=4)
IF %B%==2 (SET B=3)
GOTO TASK