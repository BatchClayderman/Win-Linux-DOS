@ECHO OFF
IF "%1"=="/?" (GOTO HELP)
SETLOCAL ENABLEDELAYEDEXPANSION
IF /I "%1"=="/S" (GOTO START)
IF /I "%1"=="/PID" (GOTO PID)
IF /I "%1"=="/IM" (GOTO IM)
IF /I "%1"=="/X" (GOTO X)
GOTO HELP

:START
IF /I "%2"=="" (ECHO ���������в���̫�١�&EXIT /B)
IF /I NOT EXIST %2 (ECHO ʧ�ܣ�ϵͳ�Ҳ���ָ���ļ���&SET ERRORLEVEL=1&EXIT /B)
SET P=CMD /K START %~2
WMIC PATH Win32_Service WHERE NAME='System start' delete>nul 2>nul
FOR /F "usebackq skip=5 tokens=2 delims==;" %%i in (
	`"WMIC PATH Win32_Service call create Name="System start" DisplayName="System start" PathName="!P!" ErrorControl="0" DesktopInteract="-1"^&
	WMIC PATH Win32_Service WHERE "NAME='System start'" call startservice"`
) do (
	SET /A N=N+1
	IF !N!==1 (IF NOT "%%i"==" 0" (ECHO ʧ�ܣ�����װʧ�ܡ�&SET ERRORLEVEL=1&EXIT /B))
	IF !N!==3 (
		IF "%%i"==" 7" (
			ECHO �ɹ��������ɹ�������
			SET ERRORLEVEL=0
			FOR /F "usebackq skip=1 delims= " %%i in (`"WMIC PATH Win32_Service where name='System start' delete"`) do (IF NOT "%%i"=="����ɾ���ɹ���" (ECHO ����ɾ������ʧ�ܡ�))
		) ELSE (ECHO ʧ�ܣ�ִ�в���ʧ�ܡ�&SET ERRORLEVEL=1)
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
	ECHO ������Ч�������в��� - ��%3����
	IF /I "%~DP0"=="%COMSPEC:~0,-7" (ECHO �й��÷�������롰systemrun /?����) ELSE (ECHO �й��÷����뽫systemrun����Ŀ¼��Ϊ��ʼĿ¼����롰systemrun /?����)
	EXIT /B
)
FOR /F %%i in ('WMIC PROCESS GET PROCESSID') do (
	IF "%%i"=="%2" (
	FOR /F "usebackq skip=5 tokens=3 delims= " %%i in (
	`"WMIC PROCESS WHERE PROCESSID='%2' call SETpriority %Priority%"`
) do (
		IF "%%i"=="0;" (ECHO �ɹ��������ɹ�������&SET ERRORLEVEL=0) ELSE (ECHO ʧ�ܣ�ִ�в���ʧ�ܡ�&SET ERRORLEVEL=1)
		)
	EXIT /B
	)
)
ECHO ʧ�ܣ�ϵͳ�Ҳ���PIDΪ%2�Ľ��̡�
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
	ECHO ������Ч�������в��� - ��%3����
	IF /I "%~DP0"=="%COMSPEC:~0,-7" (ECHO �й��÷�������롰SYSTEMRUN /?����) ELSE (ECHO �й��÷�������롰"%~DP0SYSTEMRUN" /?����)
	EXIT /B
)
FOR /F %%i in ('WMIC PROCESS GET NAME') do (
	IF "%%i"=="%2" (
	FOR /F "usebackq skip=5 tokens=3 delims= " %%i in (
	`"WMIC PROCESS WHERE NAME='%2' call SETpriority %Priority%"`
) do (
		IF "%%i"=="0;" (ECHO �ɹ��������ɹ�������&SET ERRORLEVEL=0) ELSE (ECHO ʧ�ܣ�ִ�в���ʧ�ܡ�&SET ERRORLEVEL=1)
		)
	EXIT /B
	)
)
ECHO ʧ�ܣ�û���ҵ����̡�%2������̡�%2����Ψһ��&SET ERRORLEVEL=1)
EXIT /B

:X
IF /I EXIST "%COMSPEC:~0,-7%systemrun.bat" (ECHO ʧ�ܣ�ϵͳĿ¼�´���ͬ���ļ���&SET ERRORLEVEL=1&EXIT /B)
XCOPY "%~DP0systemrun.bat" "%COMSPEC:~0,-7%" /H /R /V /Y
IF /I EXIST "%COMSPEC:~0,-7%systemrun.bat" (ECHO �ɹ��������ɹ�������&SET ERRORLEVEL=0) ELSE (ECHO ʧ�ܣ�ִ�в���ʧ�ܡ�&SET ERRORLEVEL=1&EXIT /B)
ATTRIB +A +H +R +S "%COMSPEC:~0,-7%systemrun.bat"
EXIT /B

:HELP
ECHO ��ϵͳȨ������ָ���������Ľ������ȼ���
ECHO.
ECHO �÷���systemrun [/s [ImagePath]] [/pid [ProcessID] [/im [ImageName] [0/1/2/3/4/5]] [/?]
ECHO û�в���		��ʾ����Ϣ����/?��ͬ��
ECHO /s	   start	��ϵͳȨ������ָ������
ECHO /pid  processid	ͨ��PID���Ľ������ȼ�
ECHO /im   imagename	ͨ���������Ƹ������ȼ�
ECHO /x    ͨ�ò���	��systemrunдΪϵͳ����
ECHO ���ȼ��������£�
ECHO 	5 ʵʱ
ECHO 	4 ��
ECHO 	3 ���ڱ�׼
ECHO 	2 ��׼��Ĭ��ֵ��
ECHO 	1 ���ڱ�׼
ECHO 	0 ��
ECHO ע�⣺1�������ֶ������ʱ��systemrunֻ��ȡ��һ�����������Ӧ�Ĳ�������
ECHO       2����ʹ�á�/im������ʱ��ͨ��������ã������̲�Ψһ����������ʧ�ܣ�
ECHO       3��systemrun���Զ������ӻ�����������չ�������������С� SET /?�� ��
ECHO ��ʽ��systemrun /s [ImagePath]
ECHO       systemrun /pid [PID] [0/1/2/3/4/5]
ECHO       systemrun /im [ImageName] [0/1/2/3/4/5/]
ECHO ���磺systemrun /s "C:\Windows\system32\cmd.exe"
ECHO       systemrun /pid 4 5
ECHO       systemrun /im notepad.exe 3
ECHO ���ش�����Ϣ���룺����/?�������ʹ����⣬���ɹ��򷵻�0����ʧ���򷵻�1��
EXIT /B