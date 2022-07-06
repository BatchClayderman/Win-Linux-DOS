@ECHO OFF
IF "%1"=="/?" (GOTO HELP)
SETLOCAL ENABLEDELAYEDEXPANSION
IF /I "%1"=="/S" (GOTO START)
IF /I "%1"=="/PID" (GOTO PID)
IF /I "%1"=="/IM" (GOTO IM)
IF /I "%1"=="/X" (GOTO X)
GOTO HELP

:START
IF /I "%2"=="" (ECHO 错误：命令行参数太少。&EXIT /B)
IF /I NOT EXIST %2 (ECHO 失败：系统找不到指定文件。&SET ERRORLEVEL=1&EXIT /B)
SET P=CMD /K START %~2
WMIC PATH Win32_Service WHERE NAME='System start' delete>nul 2>nul
FOR /F "usebackq skip=5 tokens=2 delims==;" %%i in (
	`"WMIC PATH Win32_Service call create Name="System start" DisplayName="System start" PathName="!P!" ErrorControl="0" DesktopInteract="-1"^&
	WMIC PATH Win32_Service WHERE "NAME='System start'" call startservice"`
) do (
	SET /A N=N+1
	IF !N!==1 (IF NOT "%%i"==" 0" (ECHO 失败：服务安装失败。&SET ERRORLEVEL=1&EXIT /B))
	IF !N!==3 (
		IF "%%i"==" 7" (
			ECHO 成功：操作成功结束。
			SET ERRORLEVEL=0
			FOR /F "usebackq skip=1 delims= " %%i in (`"WMIC PATH Win32_Service where name='System start' delete"`) do (IF NOT "%%i"=="范例删除成功。" (ECHO 错误：删除服务失败。))
		) ELSE (ECHO 失败：执行操作失败。&SET ERRORLEVEL=1)
	)
)
EXIT /B

:PID
IF "%3"=="" (SET Priority=256)
IF "%3"=="0" (SET Priority=64)
IF "%3"=="1" (SET Priority=16384)
IF "%3"=="2" (SET Priority=32)
IF "%3"=="3" (SET Priority=32768)
IF "%3"=="4" (SET Priority=128)
IF "%3"=="5" (SET Priority=256)
IF "%3" GTR "5" (
	ECHO 错误：无效的命令行参数 - “%3”。
	IF /I "%~DP0"=="%COMSPEC:~0,-7" (ECHO 有关用法，请键入“systemrun /?”。) ELSE (ECHO 有关用法，请将systemrun所在目录设为起始目录后键入“systemrun /?”。)
	EXIT /B
)
FOR /F %%i in ('WMIC PROCESS GET PROCESSID') do (
	IF "%%i"=="%2" (
	FOR /F "usebackq skip=5 tokens=3 delims= " %%i in (
	`"WMIC PROCESS WHERE PROCESSID='%2' call SETpriority %Priority%"`
) do (
		IF "%%i"=="0;" (ECHO 成功：操作成功结束。&SET ERRORLEVEL=0) ELSE (ECHO 失败：执行操作失败。&SET ERRORLEVEL=1)
		)
	EXIT /B
	)
)
ECHO 失败：系统找不到PID为%2的进程。
SET ERRORLEVEL=1
EXIT /B

:IM
IF "%3"=="" (SET Priority=256)
IF "%3"=="0" (SET Priority=64)
IF "%3"=="1" (SET Priority=16384)
IF "%3"=="2" (SET Priority=32)
IF "%3"=="3" (SET Priority=32768)
IF "%3"=="4" (SET Priority=128)
IF "%3"=="5" (SET Priority=256)
IF "%3" GTR "5" (
	ECHO 错误：无效的命令行参数 - “%3”。
	IF /I "%~DP0"=="%COMSPEC:~0,-7" (ECHO 有关用法，请键入“SYSTEMRUN /?”。) ELSE (ECHO 有关用法，请键入“"%~DP0SYSTEMRUN" /?”。)
	EXIT /B
)
FOR /F %%i in ('WMIC PROCESS GET NAME') do (
	IF "%%i"=="%2" (
	FOR /F "usebackq skip=5 tokens=3 delims= " %%i in (
	`"WMIC PROCESS WHERE NAME='%2' call SETpriority %Priority%"`
) do (
		IF "%%i"=="0;" (ECHO 成功：操作成功结束。&SET ERRORLEVEL=0) ELSE (ECHO 失败：执行操作失败。&SET ERRORLEVEL=1)
		)
	EXIT /B
	)
)
ECHO 失败：没有找到进程“%2”或进程“%2”不唯一。&SET ERRORLEVEL=1)
EXIT /B

:X
IF /I EXIST "%COMSPEC:~0,-7%systemrun.bat" (ECHO 失败：系统目录下存在同名文件。&SET ERRORLEVEL=1&EXIT /B)
XCOPY "%~DP0systemrun.bat" "%COMSPEC:~0,-7%" /H /R /V /Y
IF /I EXIST "%COMSPEC:~0,-7%systemrun.bat" (ECHO 成功：操作成功结束。&SET ERRORLEVEL=0) ELSE (ECHO 失败：执行操作失败。&SET ERRORLEVEL=1&EXIT /B)
ATTRIB +A +H +R +S "%COMSPEC:~0,-7%systemrun.bat"
EXIT /B

:HELP
ECHO 以系统权限运行指定程序或更改进程优先级。
ECHO.
ECHO 用法：systemrun [/s [ImagePath]] [/pid [ProcessID] [/im [ImageName] [0/1/2/3/4/5]] [/?]
ECHO 没有参数		显示此消息（与/?相同）
ECHO /s	   start	以系统权限运行指定程序
ECHO /pid  processid	通过PID更改进程优先级
ECHO /im   imagename	通过进程名称更改优先级
ECHO /x    通用参数	将systemrun写为系统程序
ECHO 优先级代号如下：
ECHO 	5 实时
ECHO 	4 高
ECHO 	3 高于标准
ECHO 	2 标准（默认值）
ECHO 	1 低于标准
ECHO 	0 低
ECHO 注意：1．当出现多个参数时，systemrun只读取第一个参数及其对应的参数对象；
ECHO       2．当使用“/im”参数时，通配符不可用，若进程不唯一，操作将会失败；
ECHO       3．systemrun会自动启用延缓环境变量扩展名，详情请运行“ SET /?” 。
ECHO 格式：systemrun /s [ImagePath]
ECHO       systemrun /pid [PID] [0/1/2/3/4/5]
ECHO       systemrun /im [ImageName] [0/1/2/3/4/5/]
ECHO 例如：systemrun /s "C:\Windows\system32\cmd.exe"
ECHO       systemrun /pid 4 5
ECHO       systemrun /im notepad.exe 3
ECHO 返回错误信息代码：除“/?”参数和错误外，若成功则返回0，若失败则返回1。
EXIT /B