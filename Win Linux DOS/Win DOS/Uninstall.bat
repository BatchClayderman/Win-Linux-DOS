@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE Win DOSж�س���
SET C=%SYSTEMDRIVE%
CLS
IF NOT EXIST "%COMSPEC:~0,-7%mshta.exe" (ECHO ��������ϵͳ��ʧ�ļ�mshta.exe��������Ϣ���޷���ȷ���ݣ���ж��������&PAUSE)
IF NOT "%1"=="/Verify" (START /LOW MSHTA VBSCRIPT:MSGBOX("Win DOS��һ�������������������"^&vbcrlf^&"���ɳ������ڳ���ж��Win DOS����ж�ز����ѱ���ֹ��"^&vbcrlf^&"����ⲻ�����������������ܿ�������Ϊ���ļ�������м�������"^&vbcrlf^&"�������Ҫж��Win DOS�������������ѡ��1����Ȼ��ж�ء�"^&vbcrlf^&"���������Ĳ��㣬���½⣡",16,"Win DOSж�س���"^)(WINDOW.CLOSE^)&EXIT)
FOR /F "TOKENS=6 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (IF %%I==0 (GOTO 1))
CLS
ECHO ���������뱣���������ȼ������롣
START /WAIT /I /REALTIME "" PASSWORD.BAT /V
IF EXIST "%TEMP%\V" (FOR /F %%I IN ('TYPE "%TEMP%\V"') DO (IF "%%I"=="V" (GOTO 1)))
ECHO ��ȡ�����������������������������밴�������������塣
PAUSE>NUL
START /REALTIME /I "" WELCOME.BAT
EXIT

:1
CLS
ECHO ���ǳ�ŵ��һ��أ�����DOS�������ļ���ע����Լ�$MFT�е��ļ���¼֮�⣬
ECHO ���ǲ��������ĵ����������κ��߹��ĺۼ��������ж�أ�
IF NOT EXIST "%COMSPEC:~0,-7%mshta.exe" (ECHO ��������ϵͳ��ʧ�ļ�mshta.exe��������Ϣ���޷���ȷ���ݣ���ж��������)
ECHO �Ƿ�������Win DOS��д��ϵͳ���ļ���ע���
CHOICE /C YNC /M "Y=������N=ɾ����C=�˳�ж�س���"
IF %ERRORLEVEL%==3 EXIT
SET UI=%ERRORLEVEL%
FOR /F "TOKENS=4 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE Win DOSж�س���-����ж��Win DOS�����Ժ�...
CLS
ECHO ���ڷ�ע�������������Ҫ�����ӣ����Ժ�...
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /F>NUL
CLS
IF %UI%==1 (GOTO 2)
ECHO ����ȡ��Win DOS����״̬�����Ժ�...
DEL "%COMSPEC:~0,-7%systemrun.bat" /A /F /Q
DEL "%COMSPEC:~0,-7%SysInfoMate.bat" /A /F /Q
DEL "%COMSPEC:~0,-7%SetFile.bat" /A /F /Q
REG DELETE HKCR\*\shell\secret /F
REG DELETE HKCR\*\shell\set /F
REG DELETE HKCR\*\shell\show /F
REG DELETE HKCR\Folder\shell\secret /F
REG DELETE HKCR\Folder\shell\set /F
REG DELETE HKCR\Folder\shell\show /F
REG DELETE HKCR\*\shell\cmd /F
REG DELETE HKCR\*\shell\runas /F

:2
ECHO ���������ݷ�ʽ��������Ҫ�����ӣ����Ժ�...
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"|FIND ":">NUL
IF NOT %ERRORLEVEL%==0 (SET DESKTOP=%C%&GOTO 3)
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"') DO (SET DESK=%%I)
SET DESK=%DESK:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"') DO (SET TOP=%%I)
SET DESKTOP=%DESK%:%TOP%

:3
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON PROGRAMS"|FIND ":">NUL
IF NOT %ERRORLEVEL%==0 (SET MENU=%C%&GOTO 4)
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON PROGRAMS"') DO (SET ME=%%I)
SET ME=%ME:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON PROGRAMS"') DO (SET NU=%%I)
SET MENU=%ME%:%NU%
GOTO 4

:4
DEL /A /F /Q "%DESKTOP%\����Win DOS�����.bat"
RD /Q /S "%MENU%\Win DOS%"
DEL /A /F /Q "%DESKTOP%\��קɾ��.bat"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V {645FF040-5081-101B-9F08-00AA002F954E} /D 0 /F
CLS
ECHO ������������ļ���������Ҫ�����ӣ����Ժ�...
DEL /A /F /Q %C%\Normalprocess.txt
DEL /A /F /Q %C%\PID.txt
DEL /A /F /Q "%C%\����Win DOS�����.bat"
DEL /A /F /Q %C%\Speedup1.reg
DEL /A /F /Q %C%\Speedup2.reg
DEL /A /F /Q %C%\Speedup.reg
DEL /A /F /Q %C%\WmiSys.txt
DEL /A /F /Q "%COMSPEC:~0,-7%AntiVirus.txt"
DEL /A /F /Q "%COMSPEC:~0,-7%PathFinder.txt"
DEL /A /F /Q "%TEMP%\WinDOSSetup.tmp"
DEL "%TEMP%\rp.txt" /A /F /Q
DEL "%TEMP%\password.txt" /A /F /Q
DEL "%TEMP%\password.vbs" /A /F /Q
DEL "%TEMP%\V" /A /F /Q
FOR /F "SKIP=1" %%I IN ('WMIC LOGICALDISK GET CAPTION') DO (DEL /A /F /Q %%I\Vir*.*)
IF /I NOT EXIST "%TEMP%\Uninstall.bat" (GOTO 6)

:5
DEL /A /F /Q "%TEMP%\Uninstall.bat"
IF EXIST "%TEMP%\Uninstall.bat" (MSHTA VBSCRIPT:MSGBOX("�ؼ��������ʧ�ܣ���������������������������ֹ�����أ������ȷ�������ԡ�",16,"Win DOSж�س���"^)(WINDOW.CLOSE^)&GOTO 5)

:6
CLS
ECHO ���ڴ����ѿ�ж�س��򣬿�����Ҫ�����ӣ����Ժ�...
SET T=%~DP0
SET T="%T:~0,-1%"
ECHO @ECHO OFF>"%TEMP%\Uninstall.bat"
FOR /F "TOKENS=4 DELIMS=," %%I IN ('TYPE CONFIG.INI') do (ECHO COLOR %%I>>"%TEMP%\Uninstall.bat")
ECHO CD /D "%%~DP0">>"%TEMP%\Uninstall.bat"
ECHO TITLE Win DOS�ѿ�ж�س���>>"%TEMP%\Uninstall.bat"
ECHO CLS>>"%TEMP%\Uninstall.bat"
ECHO ECHO �����ѿ�ж��Win DOS��������Ҫ�����ӣ����Ժ�...>>"%TEMP%\Uninstall.bat"
ECHO DEL /A /F /Q /S "%~DP0*">>"%TEMP%\Uninstall.bat"
ECHO RD /Q /S %T%>>"%TEMP%\Uninstall.bat"
ECHO IF EXIST %T% (MSHTA VBSCRIPT:MSGBOX("�ѿ�ж��ʧ�ܣ�ж�ز����������������������ֹ�����ء�",16,"Win DOS�ѿ�ж�س���"^^^)(WINDOW.CLOSE^^^))>>"%TEMP%\Uninstall.bat"
ECHO IF EXIST %T% EXIT>>"%TEMP%\Uninstall.bat"
ECHO START /LOW MSHTA VBSCRIPT:MSGBOX("ж�سɹ��������ڴˣ������ٴθ�л����Win DOS�Ĵ���֧�֣�ף�����彡���������³ɡ��������⣡�ٻᣡ",64,"Win DOSж�س���")(WINDOW.CLOSE)>>"%TEMP%\Uninstall.bat"
ECHO DEL /A /F /Q "%TEMP%\Uninstall.bat"^&EXIT>>"%TEMP%\Uninstall.bat"
ATTRIB +A +H +R +S "%TEMP%\Uninstall.bat"
IF NOT EXIST "%TEMP%\Uninstall.bat" (MSHTA VBSCRIPT:MSGBOX("ж��ʧ�ܣ�ж�ز����������������������ֹ�����أ�",16,"Win DOSж�س���"^)(WINDOW.CLOSE^))
"%TEMP%\Uninstall.bat"
EXIT