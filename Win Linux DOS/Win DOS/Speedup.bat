@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=4 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (SET PT=%%I)
SETLOCAL ENABLEDELAYEDEXPANSION
TITLE �����Ż�
CLS
IF /I "%SYSTEMDRIVE%"=="X:" (ECHO ��ʹ��Windows PEר���Ż������Ż���&PAUSE&EXIT)
TITLE �����Ż�-һ���������ý���
SET E=0
ECHO ��������һ���������ý��̣��������Ҫ����%PT%����ѡ��N����
CHOICE /C YN /T %PT% /D Y
IF %ERRORLEVEL%==2 EXIT
TASKKILL /IM CONIME.EXE /IM CTFMON.EXE /IM SAVEDUMP.EXE /IM SGTOOL.EXE /IM SOGOUCLOUD.EXE /IM TECENTDL.EXE /IM TSSERVICE.EXE /IM TXPLATFORM.EXE /IM WMIPRVSE.EXE /IM WUAUCLT.EXE /F /T
TASKKILL /IM CONIME.EXE /IM CTFMON.EXE /IM SAVEDUMP.EXE /IM SGTOOL.EXE /IM SOGOUCLOUD.EXE /IM TECENTDL.EXE /IM TSSERVICE.EXE /IM TXPLATFORM.EXE /IM WMIPRVSE.EXE /IM WUAUCLT.EXE /F /T
WMIC PROCESS GET NAME|FIND /I "SPOOLSV.EXE"
IF %ERRORLEVEL%==0 (
	ECHO ��⵽��ӡ�������������У��Ƿ�ִ�н�����
	CHOICE /C YN /T %PT% /D Y /M "��%PT%��󽫻��Զ�������"
	IF /I !ERRORLEVEL!==1 (TASKKILL /IM SPOOLSV.EXE /F /T&SC CONFIG Spooler START= DEMAND )
)
CLS
VER|FIND /I "XP">NUL
IF %ERRORLEVEL%==1 (ECHO �����Ż���ɣ�������%PT%����Զ��˳���&SLEEP %PT%&EXIT)
TITLE �����Ż�-�ر�IDEͨ�����
ECHO �����ر�IDEͨ����⣬�������Ҫ����%PT%����ѡ��N����
CHOICE /C YN /T %PT% /D Y
IF %ERRORLEVEL%==2 EXIT
SET HKEY1=HKLM\SYSTEM\CurrentControlSet\Enum\PCIIDE\IDEChannel
SET HKEY2=HKLM\SYSTEM\CurrentControlSet\Control\Class
FOR /F "USEBACKQ TOKENS=*" %%I IN ('REG QUERY %HKEY1%^|FIND /I "IDEChannel\"') DO (CALL :CHECK %%I)
GOTO CHECK

:CHECK
FOR /F "USEBACKQ TOKENS=3*" %%I IN ('REG QUERY %1^|FIND/I "driver"') DO (SET "SUBKEY=%%I")
FOR /F "USEBACKQ TOKENS=3,4*" %%I IN ('REG QUERY "%HKEY2%\%SUBKEY%" /V DriverDesc^|FIND /I "driverdesc"') DO (SET DriverDesc=%%I %%J ͨ��)
REG QUERY "%HKEY2%\%SUBKEY%" /V MasterDeviceType|FIND /I "0x1">NUL
IF %ERRORLEVEL%==1 (GOTO ChgMaster)
GOTO CheckSlave

:ChgMaster
REG ADD "%hkey2%\%subkey%" /V UserMasterDeviceType /T REG_DWORD /D 3 /F
ECHO ��%DriverDesc%�����豸0��ⷽʽ����Ϊ�ޡ�
GOTO CheckSlave

:CheckSlave
REG QUERY "%HKEY2%\%SUBKEY%" /V SlaveDeviceType|FIND "0x1">NUL
if %ERRORLEVEL%==1 (GOTO ChgSlave)
GOTO EOF

:ChgSlave
REG ADD "%HKEY2%\%SUBKEY%" /V UserSlaveDeviceType /T REG_DWORD /D 3 /F
ECHO ��%DriverDesc%�����豸1��ⷽʽ����Ϊ�ޡ�
GOTO EOF

:EOF
TITLE �����Ż�-���üƻ�����
CLS
ECHO �������üƻ������������Ҫ����%PT%����ѡ��N����
CHOICE /C YN /T %PT% /D Y
IF %ERRORLEVEL%==2 EXIT
AT /DELETE /YES
DEL /A /F /Q "%SYSTEMROOT%\TASKS\*"
TITLE �����Ż�-�������������Ŀ
CLS
ECHO ˵����1��������ע����ᱸ����%SYSTEMDRIVE:~0,-1%�̵ĸ�Ŀ¼�£�
ECHO          ˫��SpeedUp.reg���ɻ�ԭ�����������������ʱ���Ὣ�������
ECHO       2���Ż���һ�����գ������о�����Ĭ��ֵΪ��ȡ������
ECHO �����������������Ŀ�������Ҫ����%PT%����ѡ��Y����
CHOICE /C YN /T %PT% /D N
IF %ERRORLEVEL%==2 EXIT
SC DELETE QQRepairFixSVC
SC DELETE TxQBService
IF /I EXIST %SYSTEMDRIVE%\SpeedUp1.reg (
	CACLS %SYSTEMDRIVE%\SpeedUp1.reg /E /G SYSTEM:F
	CACLS %SYSTEMDRIVE%\SpeedUp1.reg /E /G ADMINISTRATORS:F
	CACLS %SYSTEMDRIVE%\SpeedUp1.reg /E /G %USERNAME%:F
	CACLS %SYSTEMDRIVE%\SpeedUp1.reg /E /G USERS:F
	CACLS %SYSTEMDRIVE%\SpeedUp1.reg /E /G EVERYONE:F
	DEL /A /F /Q %SYSTEMDRIVE%\SpeedUp1.reg
)
IF /I EXIST %SYSTEMDRIVE%\SpeedUp2.reg (
	CACLS %SYSTEMDRIVE%\SpeedUp2.reg /E /G SYSTEM:F
	CACLS %SYSTEMDRIVE%\SpeedUp2.reg /E /G ADMINISTRATORS:F
	CACLS %SYSTEMDRIVE%\SpeedUp2.reg /E /G %USERNAME%:F
	CACLS %SYSTEMDRIVE%\SpeedUp2.reg /E /G USERS:F
	CACLS %SYSTEMDRIVE%\SpeedUp2.reg /E /G EVERYONE:F
	DEL /A /F /Q %SYSTEMDRIVE%\SpeedUp2.reg
)
IF /I EXIST %SYSTEMDRIVE%\SpeedUp.reg (
	CACLS %SYSTEMDRIVE%\SpeedUp.reg /E /G SYSTEM:F
	CACLS %SYSTEMDRIVE%\SpeedUp.reg /E /G ADMINISTRATORS:F
	CACLS %SYSTEMDRIVE%\SpeedUp.reg /E /G %USERNAME%:F
	CACLS %SYSTEMDRIVE%\SpeedUp.reg /E /G USERS:F
	CACLS %SYSTEMDRIVE%\SpeedUp.reg /E /G EVERYONE:F
	DEL /A /F /Q %SYSTEMDRIVE%\SpeedUp.reg
)
IF /I EXIST %SYSTEMDRIVE%\SpeedUp1.reg (MSHTA "VBSCRIPT:MSGBOX("�޷�ɾ��ԭ��ʱ�����ļ�1��",16,"�����Ż�-�Ż�����������Ŀʱ��������"^)(WINDOW.CLOSE^)"&SET E=1)
IF /I EXIST %SYSTEMDRIVE%\SpeedUp2.reg (MSHTA "VBSCRIPT:MSGBOX("�޷�ɾ��ԭ��ʱ�����ļ�2��",16,"�����Ż�-�Ż�����������Ŀʱ��������"^)(WINDOW.CLOSE^)"&SET E=1)
IF /I EXIST %SYSTEMDRIVE%\SpeedUp.reg (MSHTA "VBSCRIPT:MSGBOX("�޷�ɾ��ԭ�����ļ���",16,"�����Ż�-�Ż�����������Ŀʱ��������"^)(WINDOW.CLOSE^)"&SET E=1)
REG EXPORT HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run %SYSTEMDRIVE%\SpeedUp1.reg
REG EXPORT HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run %SYSTEMDRIVE%\SpeedUp2.reg
TYPE %SYSTEMDRIVE%\SpeedUp1.reg>>%SYSTEMDRIVE%\SpeedUp.reg
TYPE %SYSTEMROOT%\2.reg>>%SYSTEMDRIVE%\SpeedUp.reg
DEL /A /F /Q %SYSTEMDRIVE%\SpeedUp1.reg
DEL /A /F /Q %SYSTEMDRIVE%\SpeedUp2.reg
IF /I EXIST %SYSTEMDRIVE%\SpeedUp1.reg (MSHTA "VBSCRIPT:MSGBOX("�޷�ɾ����ʱ�����ļ�1��",16,"�����Ż�-�Ż�����������Ŀʱ��������"^)(WINDOW.CLOSE^)"&SET E=1)
IF /I EXIST %SYSTEMDRIVE%\SpeedUp2.reg (MSHTA "VBSCRIPT:MSGBOX("�޷�ɾ����ʱ�����ļ�2��",16,"�����Ż�-�Ż�����������Ŀʱ��������"^)(WINDOW.CLOSE^)"&SET E=1)
IF /I NOT EXIST %SYSTEMDRIVE%\SpeedUp.reg (MSHTA "VBSCRIPT:MSGBOX("�޷����������ļ���",16,"�����Ż�-�Ż�����������Ŀʱ��������"^)(WINDOW.CLOSE^)"&SET E=1)
ATTRIB +A +H +R +S %SYSTEMDRIVE%\SpeedUp.reg
IF %E%==1 (ECHO ���ݹ��̷������󣬱��ݿ���û�гɹ����Ƿ������)
IF %E%==1 (CHOICE /C YN)
IF %E%==1 (IF %ERRORLEVEL%==2 EXIT)
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /VA /F
REG DELETE HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run /VA /F
REG ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run /V ctfmon.exe /D %SYSTEMROOT%\system32\ctfmon.exe
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg" /F
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\IMJPMIG8.1"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\IMJPMIG8.1" /V command /D ""%SYSTEMDRIVE%\WINDOWS\IME\imjp8_1\IMJPMIG.EXE" /Spoil /RemAdvDef /Migration32"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\IMJPMIG8.1" /V hkey /D HKLM
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\IMJPMIG8.1" /V inimapping /D 0
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\IMJPMIG8.1" /V item /D IMJPMIG
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\IMJPMIG8.1" /V key /D SOFTWARE\Microsoft\Windows\CurrentVersion\Run
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002A"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002A" /V command /D "%SYSTEMDRIVE%\WINDOWS\system32\IME\TINTLGNT\TINTSETP.EXE /IMEName"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002A" /V hkey /D HKLM
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002A" /V inimapping /D 0
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002A" /V item /D TINTSETP
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002A" /V key /D SOFTWARE\Microsoft\Windows\CurrentVersion\Run
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002ASync"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002ASync" /V command /D ""%SYSTEMDRIVE%\WINDOWS\IME\imjp8_1\IMJPMIG.EXE" /Spoil /RemAdvDef /Migration32"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002ASync" /V hkey /D HKLM
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002ASync" /V inimapping /D 0
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002ASync" /V item /D TINTSETP
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002ASync" /V key /D SOFTWARE\Microsoft\Windows\CurrentVersion\Run
DEL /A /F /Q "%SYSTEMDRIVE%\Documents and Settings\All Users\����ʼ���˵�\����\����\*"
DEL /A /F /Q "%SYSTEMDRIVE%\Documents and Settings\Default User\����ʼ���˵�\����\����\*"
DEL /A /F /Q "%USERPROFILE%\����ʼ���˵�\����\����\*"
TASKKILL /IM WMIPRVSE.EXE /F /T
TITLE �����Ż�-���
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (ECHO �����Ż���ɣ�������%%I����Զ��˳���&SLEEP %%I)
ENDLOCAL
EXIT