@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
TITLE Win DOS设置程序
IF /I "%1"=="/R" (GOTO RECOVER)
SET CK=0
SET SETALL=0
SET CHANGE=0
SET ALL1=启动设置
SET ALL2=基础程序颜色设置
SET ALL3=风险警报颜色设置
SET ALL4=自动化面板颜色设置
SET ALL5=暂停时间设置
SET ALL6=密码保护设置
CLS
IF EXIST "%COMSPEC:~0,-7%mshta.exe" (MSHTA VBSCRIPT:MSGBOX("若Win DOS程序崩溃或闪退，请重置Win DOS设置。",64,"Win DOS设置程序"^)(WINDOW.CLOSE^)) ELSE (ECHO 若Win DOS程序崩溃或闪退，请重置Win DOS设置。)
GOTO CLEAR1

:CLEAR1
SET ERR=0
CLS
ECHO 正在加载设置文件，请稍候...
FOR /F "TOKENS=1 DELIMS=," %%I IN ('TYPE config.ini') DO (SET X1=%%I)
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE config.ini') DO (SET X2=%%I)
FOR /F "TOKENS=3 DELIMS=," %%I IN ('TYPE config.ini') DO (SET X3=%%I)
FOR /F "TOKENS=4 DELIMS=," %%I IN ('TYPE config.ini') DO (SET X4=%%I)
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE config.ini') DO (SET X5=%%I)
FOR /F "TOKENS=6 DELIMS=," %%I IN ('TYPE config.ini') DO (SET X6=%%I)
FOR /F "TOKENS=7 DELIMS=," %%I IN ('TYPE config.ini') DO (SET X7=%%I)
IF "%X1%"=="START /REALTIME" (SET Y1=1．以实时优先级常规面板中断运行&GOTO CLEAR2)
IF "%X1%"=="START /HIGH" (SET Y1=1．以高优先级常规面板中断运行&GOTO CLEAR2)
IF "%X1%"=="START /ABOVENORMAL" (SET Y1=1．以高于标准优先级常规面板中断运行&GOTO CLEAR2)
IF "%X1%"=="START /NORMAL" (SET Y1=1．以标准优先级常规面板中断运行&GOTO CLEAR2)
IF "%X1%"=="START /BELOWNORMAL" (SET Y1=1．以低于标准优先级常规面板中断运行&GOTO CLEAR2)
IF "%X1%"=="START /LOW" (SET Y1=1．以低优先级常规面板中断运行&GOTO CLEAR2)
IF "%X1%"=="START /MAX /REALTIME" (SET Y1=1．以实时优先级最大化面板中断运行&GOTO CLEAR2)
IF "%X1%"=="START /MAX /HIGH" (SET Y1=1．以高优先级最大化面板中断运行&GOTO CLEAR2)
IF "%X1%"=="START /MAX /ABOVENORMAL" (SET Y1=1．以高于标准优先级最大化面板中断运行&GOTO CLEAR2)
IF "%X1%"=="START /MAX /NORMAL" (SET Y1=1．以标准优先级最大化面板中断运行&GOTO CLEAR2)
IF "%X1%"=="START /MAX /BELOWNORMAL" (SET Y1=1．以低于标准优先级最大化面板中断运行&GOTO CLEAR2)
IF "%X1%"=="START /MAX /LOW" (SET Y1=1．以低优先级最大化面板中断运行&GOTO CLEAR2)
IF "%X1%"=="START /MIN /REALTIME" (SET Y1=1．以实时优先级最小化面板中断运行&GOTO CLEAR2)
IF "%X1%"=="START /MIN /HIGH" (SET Y1=1．以高优先级最小化面板中断运行&GOTO CLEAR2)
IF "%X1%"=="START /MIN /ABOVENORMAL" (SET Y1=1．以高于标准优先级最小化面板中断运行&GOTO CLEAR2)
IF "%X1%"=="START /MIN /NORMAL" (SET Y1=1．以标准优先级最小化面板中断运行&GOTO CLEAR2)
IF "%X1%"=="START /MIN /BELOWNORMAL" (SET Y1=1．以低于标准优先级最小化面板中断运行&GOTO CLEAR2)
IF "%X1%"=="START /MIN /LOW" (SET Y1=1．以低优先级最小化面板中断运行&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /REALTIME" (SET Y1=1．以实时优先级常规面板等待运行&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /HIGH" (SET Y1=1．以高优先级常规面板等待运行&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /ABOVENORMAL" (SET Y1=1．以高于标准优先级常规面板等待运行&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /NORMAL" (SET Y1=1．以标准优先级常规面板等待运行&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /BELOWNORMAL" (SET Y1=1．以低于标准优先级常规面板等待运行&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /LOW" (SET Y1=1．以低优先级常规面板等待运行&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MAX /REALTIME" (SET Y1=1．以实时优先级最大化面板等待运行&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MAX /HIGH" (SET Y1=1．以高优先级最大化面板等待运行&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MAX /ABOVENORMAL" (SET Y1=1．以高于标准优先级最大化面板等待运行&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MAX /NORMAL" (SET Y1=1．以标准优先级最大化面板等待运行&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MAX /BELOWNORMAL" (SET Y1=1．以低于标准优先级最大化面板等待运行&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MAX /LOW" (SET Y1=1．以低优先级最大化面板等待运行&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MIN /REALTIME" (SET Y1=1．以实时优先级最小化面板等待运行&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MIN /HIGH" (SET Y1=1．以高优先级最小化面板等待运行&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MIN /ABOVENORMAL" (SET Y1=1．以高于标准优先级最小化面板等待运行&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MIN /NORMAL" (SET Y1=1．以标准优先级最小化面板等待运行&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MIN /BELOWNORMAL" (SET Y1=1．以低于标准优先级最小化面板等待运行&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MIN /LOW" (SET Y1=1．以低优先级最小化面板等待运行&GOTO CLEAR2)
SET ERR=1
GOTO CLEAR6

:CLEAR2
IF %X2:~0,1%==%X2:~1,1% (GOTO CLEAR6)
IF %X2:~0,1%==0 (SET T1=黑色)
IF %X2:~0,1%==1 (SET T1=蓝色)
IF %X2:~0,1%==2 (SET T1=绿色)
IF %X2:~0,1%==3 (SET T1=湖蓝色)
IF %X2:~0,1%==4 (SET T1=红色)
IF %X2:~0,1%==5 (SET T1=紫色)
IF %X2:~0,1%==6 (SET T1=黄色)
IF %X2:~0,1%==7 (SET T1=白色)
IF %X2:~0,1%==8 (SET T1=灰色)
IF %X2:~0,1%==9 (SET T1=淡蓝色)
IF %X2:~0,1%==A (SET T1=淡绿色)
IF %X2:~0,1%==B (SET T1=淡浅绿色)
IF %X2:~0,1%==C (SET T1=淡红色)
IF %X2:~0,1%==D (SET T1=淡紫色)
IF %X2:~0,1%==E (SET T1=淡黄色)
IF %X2:~0,1%==F (SET T1=亮白色)
IF %X2:~1,1%==0 (SET T2=黑色)
IF %X2:~1,1%==1 (SET T2=蓝色)
IF %X2:~1,1%==2 (SET T2=绿色)
IF %X2:~1,1%==3 (SET T2=湖蓝色)
IF %X2:~1,1%==4 (SET T2=红色)
IF %X2:~1,1%==5 (SET T2=紫色)
IF %X2:~1,1%==6 (SET T2=黄色)
IF %X2:~1,1%==7 (SET T2=白色)
IF %X2:~1,1%==8 (SET T2=灰色)
IF %X2:~1,1%==9 (SET T2=淡蓝色)
IF %X2:~1,1%==A (SET T2=淡绿色)
IF %X2:~1,1%==B (SET T2=淡浅绿色)
IF %X2:~1,1%==C (SET T2=淡红色)
IF %X2:~1,1%==D (SET T2=淡紫色)
IF %X2:~1,1%==E (SET T2=淡黄色)
IF %X2:~1,1%==F (SET T2=亮白色)
SET Y2=2．基础程序颜色：在%T1%上产生%T2%，即背景为%T1%，文字为%T2%
GOTO CLEAR3

:CLEAR3
IF %X3:~0,1%==%X3:~1,1% (GOTO CLEAR6)
IF %X3:~0,1%==0 (SET T1=黑色)
IF %X3:~0,1%==1 (SET T1=蓝色)
IF %X3:~0,1%==2 (SET T1=绿色)
IF %X3:~0,1%==3 (SET T1=湖蓝色)
IF %X3:~0,1%==4 (SET T1=红色)
IF %X3:~0,1%==5 (SET T1=紫色)
IF %X3:~0,1%==6 (SET T1=黄色)
IF %X3:~0,1%==7 (SET T1=白色)
IF %X3:~0,1%==8 (SET T1=灰色)
IF %X3:~0,1%==9 (SET T1=淡蓝色)
IF %X3:~0,1%==A (SET T1=淡绿色)
IF %X3:~0,1%==B (SET T1=淡浅绿色)
IF %X3:~0,1%==C (SET T1=淡红色)
IF %X3:~0,1%==D (SET T1=淡紫色)
IF %X3:~0,1%==E (SET T1=淡黄色)
IF %X3:~0,1%==F (SET T1=亮白色)
IF %X3:~1,1%==0 (SET T2=黑色)
IF %X3:~1,1%==1 (SET T2=蓝色)
IF %X3:~1,1%==2 (SET T2=绿色)
IF %X3:~1,1%==3 (SET T2=湖蓝色)
IF %X3:~1,1%==4 (SET T2=红色)
IF %X3:~1,1%==5 (SET T2=紫色)
IF %X3:~1,1%==6 (SET T2=黄色)
IF %X3:~1,1%==7 (SET T2=白色)
IF %X3:~1,1%==8 (SET T2=灰色)
IF %X3:~1,1%==9 (SET T2=淡蓝色)
IF %X3:~1,1%==A (SET T2=淡绿色)
IF %X3:~1,1%==B (SET T2=淡浅绿色)
IF %X3:~1,1%==C (SET T2=淡红色)
IF %X3:~1,1%==D (SET T2=淡紫色)
IF %X3:~1,1%==E (SET T2=淡黄色)
IF %X3:~1,1%==F (SET T2=亮白色)
SET Y3=3．风险警报颜色：在%T1%上产生%T2%，即背景为%T1%，文字为%T2%
GOTO CLEAR4

:CLEAR4
IF %X4:~0,1%==%X4:~1,1% (GOTO CLEAR6)
IF %X4:~0,1%==0 (SET T1=黑色)
IF %X4:~0,1%==1 (SET T1=蓝色)
IF %X4:~0,1%==2 (SET T1=绿色)
IF %X4:~0,1%==3 (SET T1=湖蓝色)
IF %X4:~0,1%==4 (SET T1=红色)
IF %X4:~0,1%==5 (SET T1=紫色)
IF %X4:~0,1%==6 (SET T1=黄色)
IF %X4:~0,1%==7 (SET T1=白色)
IF %X4:~0,1%==8 (SET T1=灰色)
IF %X4:~0,1%==9 (SET T1=淡蓝色)
IF %X4:~0,1%==A (SET T1=淡绿色)
IF %X4:~0,1%==B (SET T1=淡浅绿色)
IF %X4:~0,1%==C (SET T1=淡红色)
IF %X4:~0,1%==D (SET T1=淡紫色)
IF %X4:~0,1%==E (SET T1=淡黄色)
IF %X4:~0,1%==F (SET T1=亮白色)
IF %X4:~1,1%==0 (SET T2=黑色)
IF %X4:~1,1%==1 (SET T2=蓝色)
IF %X4:~1,1%==2 (SET T2=绿色)
IF %X4:~1,1%==3 (SET T2=湖蓝色)
IF %X4:~1,1%==4 (SET T2=红色)
IF %X4:~1,1%==5 (SET T2=紫色)
IF %X4:~1,1%==6 (SET T2=黄色)
IF %X4:~1,1%==7 (SET T2=白色)
IF %X4:~1,1%==8 (SET T2=灰色)
IF %X4:~1,1%==9 (SET T2=淡蓝色)
IF %X4:~1,1%==A (SET T2=淡绿色)
IF %X4:~1,1%==B (SET T2=淡浅绿色)
IF %X4:~1,1%==C (SET T2=淡红色)
IF %X4:~1,1%==D (SET T2=淡紫色)
IF %X4:~1,1%==E (SET T2=淡黄色)
IF %X4:~1,1%==F (SET T2=亮白色)
SET Y4=4．自动化面板颜色：在%T1%上产生%T2%，即背景为%T1%，文字为%T2%
GOTO CLEAR5

:CLEAR5
IF NOT "%X5:~1,1%"=="" (GOTO CLEAR6)
IF "%X5%"=="0" (GOTO CLEAR6)
IF NOT "%X6:~1,1%"=="" (GOTO CLEAR6)
SET Y5=5．暂停时长为%X5%秒
IF %X6%==1 (SET Y6=6．密码保护已打开) ELSE (SET Y6=6．密码保护已关闭)
GOTO CLEAR7

:CLEAR6
SET ERR=1
ECHO Win DOS设置被恶意更改，是否重置？
CHOICE /C YN /T 10 /D Y /M "10秒无动作后将会自动重置。"
IF %ERRORLEVEL%==1 (GOTO RECOVER)
SET S1=START /REALTIME
SET S2=0E
SET S3=CF
SET S4=0A
SET S5=5
SET CHANGE=1
GOTO CLEAR8

:CLEAR7
IF /I %X2%==%X3% (GOTO CLEAR6)
IF /I %X2%==%X4% (GOTO CLEAR6)
IF /I %X3%==%X4% (GOTO CLEAR6)
IF /I "%1"=="/V" (GOTO V)
COLOR %X2%
IF %CHANGE%==0 (
	SET S1=%X1%
	SET S2=%X2%
	SET S3=%X3%
	SET S4=%X4%
	SET S5=%X5%
	SET S6=%X6%
	SET S7=%X7%
	SET CHANGE=1
)
IF NOT "%S1%"=="%X1%" (SET SETALL=1)
IF NOT %S2%==%X2% (SET SETALL=2)
IF NOT %S3%==%X3% (SET SETALL=3)
IF NOT %S4%==%X4% (SET SETALL=4)
IF NOT %S5%==%X5% (SET SETALL=5)
IF NOT %S6%==%X6% (SET SETALL=6)
IF "%S1%,%S2%,%S3%,%S4%,%S5%,%S6%,%S7%"=="%X1%,%X2%,%X3%,%X4%,%X5%,%X6%,%X7%" (SET SETALL=0)
CLS
ECHO Win DOS设置程序主面板
ECHO.
ECHO 当前已保存的设置信息如下：
ECHO     %Y1%；
ECHO     %Y2%；
ECHO     %Y3%；
ECHO     %Y4%；
ECHO     %Y5%；
ECHO     %Y6%。
FOR /F "TOKENS=6 DELIMS=," %%I IN ('TYPE config.ini') DO (IF %%I==1 (IF %CK%==0 (GOTO C)))
GOTO MAIN

:CLEAR8
CLS
ECHO Win DOS设置程序主面板
ECHO.
ECHO 错误：设置信息不可用。
GOTO MAIN

:MAIN
ECHO.
ECHO 可供执行的选项：
ECHO     0=退出Win DOS设置程序
ECHO     1=启动设置
ECHO     2=基础程序颜色设置
ECHO     3=风险警报颜色设置
ECHO     4=自动化面板颜色设置
ECHO     5=暂停时间设置
ECHO     6=密码保护设置
ECHO     7=查看设置代码
ECHO     8=保存设置
IF NOT %SETALL%==0 (ECHO （设置发生变更，请保存设置！）)
ECHO     9=重置设置
ECHO 请选择一项以继续：
CHOICE /C 1234567890
IF %ERRORLEVEL%==1 (GOTO SET11)
IF %ERRORLEVEL%==2 (GOTO SET21)
IF %ERRORLEVEL%==3 (GOTO SET31)
IF %ERRORLEVEL%==4 (GOTO SET41)
IF %ERRORLEVEL%==5 (GOTO SET5)
IF %ERRORLEVEL%==6 (GOTO SET61)
IF %ERRORLEVEL%==7 (GOTO SET7)
IF %ERRORLEVEL%==8 (GOTO SET8)
IF %ERRORLEVEL%==9 (GOTO SET10)
IF %ERRORLEVEL%==10 (GOTO SET0)

:SET0
IF %SETALL%==0 (START /REALTIME /I "" WELCOME.BAT&EXIT)
CALL SET YALL=%%ALL%SETALL%%%
CLS
ECHO 已确认，您至少变更了%YALL%且尚未保存。
ECHO 设置已变更，您确定放弃设置并退出程序吗？
CHOICE /C YN
IF /I %ERRORLEVEL%==2 (GOTO A)
START /REALTIME /I "" WELCOME.BAT
EXIT

:SET11
CLS
IF %ERR%==0 (ECHO 当前状态：%Y1%。) ELSE (ECHO 错误：设置信息不可用。)
ECHO.
ECHO 启动设置-优先级设置面板
ECHO   0=返回主面板
ECHO   1=实时（默认值）
ECHO   2=高
ECHO   3=高于标准
ECHO   4=标准
ECHO   5=低于标准
ECHO   6=低
ECHO 请选择一种运行优先级：
CHOICE /C 1234560
IF %ERRORLEVEL%==1 (SET S1=/REALTIME)
IF %ERRORLEVEL%==2 (SET S1=/HIGH)
IF %ERRORLEVEL%==3 (SET S1=/ABOVENORMAL)
IF %ERRORLEVEL%==4 (SET S1=/NORMAL)
IF %ERRORLEVEL%==5 (SET S1=/BELOWNORMAL)
IF %ERRORLEVEL%==6 (SET S1=/LOW)
IF %ERRORLEVEL%==7 (GOTO A)
GOTO SET12

:SET12
CLS
IF %ERR%==0 (ECHO 当前状态：%Y1%。) ELSE (ECHO 错误：设置信息不可用。)
ECHO.
ECHO 启动设置-运行面板设置面板
ECHO   0=返回优先级设置面板
ECHO   1=最大化面板
ECHO   2=常规面板（默认值）
ECHO   3=最小化面板
ECHO 请选择一种运行面板：
CHOICE /C 1230
IF %ERRORLEVEL%==1 (SET S1=/MAX %S1%)
IF %ERRORLEVEL%==3 (SET S1=/MIN %S1%)
IF %ERRORLEVEL%==4 (GOTO SET11)
GOTO SET13

:SET13
CLS
IF %ERR%==0 (ECHO 当前状态：%Y1%。) ELSE (ECHO 错误：设置信息不可用。)
ECHO.
ECHO 启动设置-等待链设置面板
ECHO   0=返回运行面板设置
ECHO   1=启用等待链
ECHO   2=停用等待链（默认值）
ECHO 请选择一项以继续：
CHOICE /C 120
IF %ERRORLEVEL%==1 (SET S1=/WAIT %S1%)
IF %ERRORLEVEL%==3 (GOTO SET12)
GOTO SET14

:SET14
SET S1=START %S1%
CLS
ECHO 启动设置缓存完毕！
PAUSE
GOTO A

:SET21
IF %ERR%==0 (FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE config.ini') DO (COLOR %%I))
CLS
ECHO 基础程序颜色设置面板
IF %ERR%==0 (ECHO 当前状态：%Y2%。) ELSE (ECHO 错误：设置信息不可用。)
ECHO.
ECHO 颜色代号如下：
ECHO   0=黑色       8=灰色
ECHO   1=蓝色       9=淡蓝色
ECHO   2=绿色       A=淡绿色
ECHO   3=湖蓝色     B=淡浅绿色
ECHO   4=红色       C=淡红色
ECHO   5=紫色       D=淡紫色
ECHO   6=黄色       E=淡黄色
ECHO   7=白色       F=亮白色
ECHO 请选择背景颜色，输入“Q”返回主面板。
CHOICE /C 1234567890ABCDEFQ
IF %ERRORLEVEL%==17 (GOTO A)
IF %ERRORLEVEL%==10 (SET S2=0&GOTO SET22)
IF %ERRORLEVEL%==11 (SET S2=A&GOTO SET22)
IF %ERRORLEVEL%==12 (SET S2=B&GOTO SET22)
IF %ERRORLEVEL%==13 (SET S2=C&GOTO SET22)
IF %ERRORLEVEL%==14 (SET S2=D&GOTO SET22)
IF %ERRORLEVEL%==15 (SET S2=E&GOTO SET22)
IF %ERRORLEVEL%==16 (SET S2=F&GOTO SET22)
SET S2=%ERRORLEVEL%
GOTO SET22

:SET22
ECHO 请选择文字颜色，输入“Q”重设背景颜色。
CHOICE /C 1234567890ABCDEFQ
IF %ERRORLEVEL%==17 (SET S2=%X2%&GOTO SET21)
IF %ERRORLEVEL%==10 (SET T2=0&GOTO SET23)
IF %ERRORLEVEL%==11 (SET T2=A&GOTO SET23)
IF %ERRORLEVEL%==12 (SET T2=B&GOTO SET23)
IF %ERRORLEVEL%==13 (SET T2=C&GOTO SET23)
IF %ERRORLEVEL%==14 (SET T2=D&GOTO SET23)
IF %ERRORLEVEL%==15 (SET T2=E&GOTO SET23)
IF %ERRORLEVEL%==16 (SET T2=F&GOTO SET23)
SET T2=%ERRORLEVEL%
GOTO SET23

:SET23
IF %S2%==%T2% (SET S2=%X2%&SET GO=2&GOTO SET9)
SET S2=%S2%%T2%
COLOR %S2%
CLS
ECHO 您所选择的颜色如当前屏幕颜色所示，是否确认？
CHOICE /C YN
IF %ERRORLEVEL%==2 (SET S2=%X2%&GOTO SET21)
CLS
ECHO 基础面板颜色设置缓存完毕！
PAUSE
GOTO A

:SET31
IF %ERR%==0 (FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE config.ini') DO (COLOR %%I))
CLS
ECHO 风险警报颜色设置面板
IF %ERR%==0 (ECHO 当前状态：%Y3%。) ELSE (ECHO 错误：设置信息不可用。)
ECHO.
ECHO 颜色代号如下：
ECHO   0=黑色       8=灰色
ECHO   1=蓝色       9=淡蓝色
ECHO   2=绿色       A=淡绿色
ECHO   3=湖蓝色     B=淡浅绿色
ECHO   4=红色       C=淡红色
ECHO   5=紫色       D=淡紫色
ECHO   6=黄色       E=淡黄色
ECHO   7=白色       F=亮白色
ECHO 请选择背景颜色，输入“Q”返回主面板。
CHOICE /C 1234567890ABCDEFQ
IF %ERRORLEVEL%==17 (GOTO A)
IF %ERRORLEVEL%==10 (SET S3=0&GOTO SET32)
IF %ERRORLEVEL%==11 (SET S3=A&GOTO SET32)
IF %ERRORLEVEL%==12 (SET S3=B&GOTO SET32)
IF %ERRORLEVEL%==13 (SET S3=C&GOTO SET32)
IF %ERRORLEVEL%==14 (SET S3=D&GOTO SET32)
IF %ERRORLEVEL%==15 (SET S3=E&GOTO SET32)
IF %ERRORLEVEL%==16 (SET S3=F&GOTO SET32)
SET S3=%ERRORLEVEL%
GOTO SET32

:SET32
ECHO 请选择文字颜色，输入“Q”重设背景颜色。
CHOICE /C 1234567890ABCDEFQ
IF %ERRORLEVEL%==17 (SET S3=%X2%&GOTO SET31)
IF %ERRORLEVEL%==10 (SET T3=0&GOTO SET33)
IF %ERRORLEVEL%==11 (SET T3=A&GOTO SET33)
IF %ERRORLEVEL%==12 (SET T3=B&GOTO SET33)
IF %ERRORLEVEL%==13 (SET T3=C&GOTO SET33)
IF %ERRORLEVEL%==14 (SET T3=D&GOTO SET33)
IF %ERRORLEVEL%==15 (SET T3=E&GOTO SET33)
IF %ERRORLEVEL%==16 (SET T3=F&GOTO SET33)
SET T3=%ERRORLEVEL%
GOTO SET33

:SET33
IF %S3%==%T3% (SET S3=%X2%&SET GO=3&GOTO SET9)
SET S3=%S3%%T3%
COLOR %S3%
CLS
ECHO 您所选择的颜色如当前屏幕颜色所示，是否确认？
CHOICE /C YN
IF %ERRORLEVEL%==2 (SET S3=%X2%&GOTO SET31)
CLS
ECHO 风险警报颜色设置缓存完毕！
PAUSE
GOTO A

:SET41
IF %ERR%==0 (FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE config.ini') DO (COLOR %%I))
CLS
ECHO 自动化面板颜色设置面板
IF %ERR%==0 (ECHO 当前状态：%Y4%。) ELSE (ECHO 错误：设置信息不可用。)
ECHO.
ECHO 颜色代号如下：
ECHO   0=黑色       8=灰色
ECHO   1=蓝色       9=淡蓝色
ECHO   2=绿色       A=淡绿色
ECHO   3=湖蓝色     B=淡浅绿色
ECHO   4=红色       C=淡红色
ECHO   5=紫色       D=淡紫色
ECHO   6=黄色       E=淡黄色
ECHO   7=白色       F=亮白色
ECHO 请选择背景颜色，输入“Q”返回主面板。
CHOICE /C 1234567890ABCDEFQ
IF %ERRORLEVEL%==17 (GOTO A)
IF %ERRORLEVEL%==10 (SET S4=0&GOTO SET42)
IF %ERRORLEVEL%==11 (SET S4=A&GOTO SET42)
IF %ERRORLEVEL%==12 (SET S4=B&GOTO SET42)
IF %ERRORLEVEL%==13 (SET S4=C&GOTO SET42)
IF %ERRORLEVEL%==14 (SET S4=D&GOTO SET42)
IF %ERRORLEVEL%==15 (SET S4=E&GOTO SET42)
IF %ERRORLEVEL%==16 (SET S4=F&GOTO SET42)
SET S4=%ERRORLEVEL%
GOTO SET42

:SET42
ECHO 请选择文字颜色，输入“Q”重设背景颜色。
CHOICE /C 1234567890ABCDEFQ
IF %ERRORLEVEL%==17 (SET S4=%X2%&GOTO SET41)
IF %ERRORLEVEL%==10 (SET T4=0&GOTO SET43)
IF %ERRORLEVEL%==11 (SET T4=A&GOTO SET43)
IF %ERRORLEVEL%==12 (SET T4=B&GOTO SET43)
IF %ERRORLEVEL%==13 (SET T4=C&GOTO SET43)
IF %ERRORLEVEL%==14 (SET T4=D&GOTO SET43)
IF %ERRORLEVEL%==15 (SET T4=E&GOTO SET43)
IF %ERRORLEVEL%==16 (SET T4=F&GOTO SET43)
SET T4=%ERRORLEVEL%
GOTO SET43

:SET43
IF %S4%==%T4% (SET S4=%X2%&SET GO=2&GOTO SET9)
SET S4=%S4%%T4%
COLOR %S4%
CLS
ECHO 您所选择的颜色如当前屏幕颜色所示，是否确认？
CHOICE /C YN
IF %ERRORLEVEL%==2 (SET S4=%X2%&GOTO SET41)
CLS
ECHO 自动化面板颜色设置缓存完毕！
PAUSE
GOTO A

:SET5
CLS
ECHO 暂停时间设置面板
IF %ERR%==0 (ECHO 当前状态：%Y5%。) ELSE (ECHO 错误：设置信息不可用。)
ECHO.
ECHO 0=返回主面板，1-9为有效数字。
ECHO 请选择一个有效数字：
CHOICE /C 1234567890
IF %ERRORLEVEL%==10 (GOTO A)
SET S5=%ERRORLEVEL%
IF NOT EXIST SLEEP.EXE (IF EXIST DEBUG.EXE (GOTO SET52) ELSE (GOTO SET53))

:SET51
ECHO 暂停时间设置缓存完毕！
GOTO A

:SET52
ECHO 丢失sleep.exe，正在尝试修复，请稍候...
IF NOT EXIST DEBUG.EXE (GOTO 53)
IF NOT %PROCESSOR_ARCHITECTURE:~-2%==64 (GOTO 53)
ECHO q | debug>nul
ECHO Bj@jzh`0X-`/PPPPPPa(DE(DM(DO(Dh(Ls(Lu(LX(LeZRR]EEEUYRX2Dx=>sleep.com
ECHO 0DxFP,0Xx.t0P,=XtGsB4o@$?PIyU WwX0GwUY Wv;ovBX2Gv0ExGIuht6>>sleep.com
ECHO T}{z~~@GwkBG@OEKcUt`~}@MqqBsy?seHB~_Phxr?@zAB`LrPEyoDt@Cj?>>sleep.com
ECHO pky_jN@QEKpEt@ij?jySjN@REKpEt@jj?jyGjN@SEKkjtlGuNw?p@pjirz>>sleep.com
ECHO LFvAURQ?OYLTQ@@?~QCoOL~RDU@?aU?@{QOq?@}IKuNWpe~FpeQFwH?Vkk>>sleep.com
ECHO _GSqoCvH{OjeOSeIQRmA@KnEFB?p??mcjNne~B?M??QhetLBgBPHexh@e=>>sleep.com
ECHO EsOgwTLbLK?sFU`?LDOD@@K@xO?SUudA?_FKJ@N?KD@?UA??O}HCQOQ??R>>sleep.com
ECHO _OQOL?CLA?CEU?_FU?UAQ?UBD?LOC?ORO?UOL?UOD?OOI?UgL?LOR@YUO?>>sleep.com
ECHO dsmSQswDOR[BQAQ?LUA?_L_oUNUScLOOuLOODUO?UOE@OwH?UOQ?DJTSDM>>sleep.com
ECHO QTqrK@kcmSULkPcLOOuLOOFUO?hwDTqOsTdbnTQrrDsdFTlnBTm`lThKcT>>sleep.com
ECHO @dmTkRQSoddTT~?K?OCOQp?o??Gds?wOw?PGAtaCHQvNntQv_w?A?it\EH>>sleep.com
ECHO {zpQpKGk?Jbs?FqokOH{T?jPvP@IQBDFAN?OHROL?Kj??pd~aN?OHROd?G>>sleep.com
ECHO Q??PGT~B??OC~?ipO?T?~U?p~cUo0x>>sleep.com
sleep.com>sleep.exe
IF EXIST sleep.exe (DEL /A /F /Q sleep.com)

:SET53
ECHO 警告：丢失sleep.exe且无法修复，请重新安装Win DOS！
ECHO 请按任意键返回主面板。
PAUSE>NUL
GOTO A

:SET6
CLS
ECHO 代号输入有误，请重新输入，按任意键返回上一级面板。
PAUSE>NUL
IF %GO%==MAIN (GOTO A)
GOTO %GO%

:SET61
CLS
ECHO 密码保护设置面板
IF %ERR%==0 (ECHO 当前状态：%Y6%。) ELSE (ECHO 错误：设置信息不可用。)
ECHO 密码保护时机：启动主面板、查看或更改设置以及卸载本程序。
ECHO.
ECHO 您是否要启用密码？
CHOICE /C CYN /M "Y=启用，N=停用，C=取消"
IF %ERRORLEVEL%==1 (GOTO A)
GOTO SET6%ERRORLEVEL%

:SET62
CLS
IF %X6%==0 (GOTO SET65)
ECHO 您是否需要修改密码？修改密码将自动保存设置，请牢记您的密码。
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO SET64)
GOTO A

:SET63
IF %X6%==1 (GOTO SET66) ELSE (SET S6=0&GOTO A)

:SET64
CLS
ECHO 请先在弹出窗口中输入原密码。
START /WAIT /REALTIME /I "" password.bat /V
IF NOT EXIST "%TEMP%\V" (GOTO A)
FOR /F %%I IN ('TYPE "%TEMP%\V"') DO (IF NOT "%%I"=="V" (GOTO A))
DEL "%TEMP%\V" /A /F /Q
IF EXIST "%TEMP%\V" (SET GO=SET65&GOTO E)

:SET65
SET S6=1
CLS
SETLOCAL ENABLEDELAYEDEXPANSION
IF %X6%==0 (
	ECHO 您是否需要修改密码？修改密码将自动保存设置，请牢记您的密码。
	CHOICE /C YN
	IF !ERRORLEVEL!==2 (GOTO A)
)
ENDLOCAL
CLS
DEL "%TEMP%\password.vbs" /A /F /Q
DEL "%TEMP%\password.txt" /A /F /Q
IF EXIST "%TEMP%\password.vbs" (GOTO SET67)
IF EXIST "%TEMP%\password.txt" (GOTO SET67)
ECHO a=inputbox("此密码支持数字．英文大小写．中文以及部分特殊符号。请定义新的密码，直接回车或取消输入将使用原密码：","Win DOS密码录入程序") >"%TEMP%\password.vbs"
ECHO If Len(a)^>0 Then>>"%TEMP%\password.vbs"
ECHO Dim fso, File>>"%TEMP%\password.vbs"
ECHO Set fso=CreateObject("Scripting.FileSystemObject")>>"%TEMP%\password.vbs"
ECHO Set File=fso.CreateTextFile("%TEMP%\password.txt", True)>>"%TEMP%\password.vbs"
ECHO File.WriteLine(a)>>"%TEMP%\password.vbs"
ECHO File.Close>>"%TEMP%\password.vbs"
ECHO End If>>"%TEMP%\password.vbs"
IF EXIST "%TEMP%\password.vbs" (GOTO SET68) ELSE (GOTO SET67)

:SET66
CLS
ECHO 请输入原密码。
START /WAIT /REALTIME /I "" password.bat /V
IF NOT EXIST "%TEMP%\V" (GOTO A)
FOR /F %%I IN ('TYPE "%TEMP%\V"') DO (IF NOT "%%I"=="V" (GOTO A))
SET S6=0
DEL "%TEMP%\V" /A /F /Q
IF EXIST "%TEMP%\V" (SET GO=A&GOTO E)
CLS
GOTO A

:SET67
CLS
ECHO 发生错误，无法定义新密码。是否重试？
ECHO 如果您打开了密码检验窗口，请将其关闭再试。
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO SET65)
GOTO A

:SET68
CLS
ECHO 请在弹出窗口中定义新密码。
START /REALTIME /WAIT /I "" "%TEMP%\password.vbs"
IF NOT EXIST "%TEMP%\password.txt" (GOTO A)
FIND "," "%TEMP%\password.txt"
IF %ERRORLEVEL%==0 (ECHO 您输入的密码中含有不允许的字符——“,”，请按任意键重新定义新密码。&PAUSE>NUL&GOTO SET68)
TYPE "%TEMP%\password.txt"|FINDSTR /C:"""
IF %ERRORLEVEL%==0 (ECHO 您输入的密码中含有不允许的字符——“^"”，请按任意键重新定义新密码。&PAUSE>NUL&GOTO SET68)
FIND ">" "%TEMP%\password.txt"
IF %ERRORLEVEL%==0 (ECHO 您输入的密码中含有不允许的字符——“^>”，请按任意键重新定义新密码。&PAUSE>NUL&GOTO SET68)
FIND "<" "%TEMP%\password.txt"
IF %ERRORLEVEL%==0 (ECHO 您输入的密码中含有不允许的字符——“^<”，请按任意键重新定义新密码。&PAUSE>NUL&GOTO SET68)
FOR /F %%I IN ('TYPE "%TEMP%\password.txt"') DO (SET S7=%%I)
CLS
ECHO 请确认您的新密码：
ECHO %S7%
PAUSE
GOTO SET8

:SET7
CLS
ECHO 代码查看面板
ECHO.
ECHO 源代码：
ECHO %X1%,^%X2%,^%X3%,^%X4%,^%X5%,^%X6%
ECHO 已缓存的代码：
ECHO %S1%,^%S2%,^%S3%,^%S4%,^%S5%,^%S6%
ECHO 输出完毕！
ECHO.
IF %SETALL%==0 (
	ECHO 设置未变更，
	PAUSE
	GOTO A
)
ECHO 设置已变更，是否保存变更？
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO SET8)
GOTO A

:SET8
CLS
IF /I %S2%==%S3% (IF %S2%==%S4% (SET CS=三种运行面板颜色均&GOTO SET8S) ELSE (SET CS=基础程序颜色和风险警报颜色&GOTO SET8S))
IF /I %S2%==%S4% (SET CS=基础程序颜色和自动化面板颜色&GOTO SET8S)
IF /I %S3%==%S4% (SET CS=风险警报颜色和自动化面板颜色&GOTO SET8S)
SET ERR=0
ECHO 正在尝试保存设置，请稍候...
CACLS config.ini /E /G SYSTEM:F>NUL
CACLS config.ini /E /G ADMINISTRATORS:F>NUL
CACLS config.ini /E /G %USERNAME%:F>NUL
CACLS config.ini /E /G USERS:F>NUL
CACLS config.ini /E /G EVERYONE:F>NUL
DEL /A /F /Q config.ini>NUL
IF /I EXIST config.ini (CLS&ECHO 删除原设置失败，请确保您没有运行多个设置程序。&SET ERR=1)
ECHO.%S1%,^%S2%,^%S3%,^%S4%,^%S5%,^%S6%,^%S7%>config.ini
ATTRIB +A +H +R +S config.ini
IF /I NOT EXIST config.ini (ECHO 保存设置失败，请确保第三代检测软件没有禁止创建文件。&SET ERR=1)
IF ERR==1 (GOTO SET8E)
SET SETALL=0
SET CHANGE=0
CLS
ECHO 保存设置成功！
PAUSE
GOTO CLEAR1

:SET8E
ECHO 过程出现错误，是否重试？
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO SET7)
GOTO CLEAR1

:SET8S
ECHO 您设置的%CS%相同，请按任意键重新设置。
PAUSE>NUL
GOTO A

:SET9
CLS
ECHO 所选文字颜色和背景颜色相同，请重新选择，按任意键返回上一级面板。
PAUSE>NUL
GOTO SET%GO%1

:SET10
CLS
ECHO 确认重置设置？
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO RECOVER)

:A
IF %ERR%==0 (GOTO CLEAR7) ELSE (GOTO CLEAR8)

:C
CLS
ECHO 您打开了密码保护，请输入原密码。
START /WAIT /REALTIME /I "" password.bat /V
IF NOT EXIST "%TEMP%\V" (ECHO 您取消了密码输入或密码错误，请按任意键退出！&PAUSE>NUL&EXIT)
FOR /F %%I IN ('TYPE "%TEMP%\V"') DO (IF NOT "%%I"=="V" (ECHO 您取消了密码输入或密码错误，请按任意键退出！&PAUSE>NUL&EXIT))
SET CK=1
DEL "%TEMP%\V" /A /F /Q
IF NOT EXIST "%TEMP%\V" (GOTO CLEAR7)
SET GO=CLEAR7

:E
CLS
ECHO 无法删除缓存文件，可能会引发错误的密码检验。是否重试？
CHOICE /C RG /M "R=重试；G=忽略错误，继续运行。"
IF %ERRORLEVEL%==2 (GOTO %GO%)
DEL /A /F /Q "%TEMP%\V"
IF EXIST "%TEMP%\V" (GOTO E)
GOTO %GO%

:RECOVER
CD /D "%~DP0"
CLS
START /WAIT /REALTIME /I "%~S0" /V
IF NOT EXIST "%TEMP%\V" (GOTO R)
CLS
ECHO 请输入原密码。
START /WAIT /REALTIME /I "" password.bat /V
IF NOT EXIST "%TEMP%\V" (ECHO 您取消了密码输入或密码错误，无法重置设置，请按任意键退出！&PAUSE>NUL&EXIT)
FOR /F %%I IN ('TYPE "%TEMP%\V"') DO (IF NOT "%%I"=="V" (ECHO 您取消了密码输入或密码错误，无法重置设置，请按任意键退出！&PAUSE>NUL&EXIT))
DEL "%TEMP%\V" /A /F /Q
IF EXIST "%TEMP%\V" (SET GO=R&GOTO E)

:R
CLS
ECHO 正在重置设置，请稍候...
CACLS config.ini /E /G SYSTEM:F
CACLS config.ini /E /G ADMINISTRATORS:F
CACLS config.ini /E /G %USERNAME%:F
CACLS config.ini /E /G USERS:F
CACLS config.ini /E /G EVERYONE:F
DEL /A /F /Q config.ini
IF /I EXIST config.ini (CLS&ECHO 删除原设置失败，请确保您没有运行多个设置程序。&SET ERR=1)
ECHO START /REALTIME,^0E,CF,^0A,^5,^0,12345678>config.ini
ATTRIB +A +H +R +S config.ini
IF /I NOT EXIST config.ini (ECHO 保存设置失败，请确保第三代检测软件没有禁止创建文件。&SET ERR=1)
IF ERR==1 (GOTO SERR)
SET SETALL=0
SET CHANGE=0
CLS
ECHO 温馨提示：重置设置后若要启用密码，则初始密码为12345678。
ECHO 重置设置成功结束，若重置后程序依旧提示“设置被恶意更改”，建议您运行参变检测仪。
PAUSE
IF /I "%1"=="/R" EXIT
GOTO CLEAR1

:SERR
ECHO 重置设置过程中发生严重错误，是否重试？
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO RECOVER)
IF /I "%1"=="/R" EXIT
GOTO CLEAR1

:V
DEL /A /F /Q "%TEMP%\V"
IF EXIST "%TEMP%\V" (SET GO=W&GOTO E)

:W
ECHO V>"%TEMP%\V"
EXIT