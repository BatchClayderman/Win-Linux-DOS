@ECHO OFF
CHCP 936
CD /D "%~DP0"
SET T=��ӭʹ��Win DOS����л����Win DOS��һ��֧�֣�
TITLE %T%
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
SET CK=0
IF /I "%SYSTEMDRIVE%"=="X:" (GOTO START)
IF "%1"=="/YES" (ECHO �ɹ���>"%TEMP%\WinDOSSetup.tmp"&GOTO START)
IF NOT EXIST "%COMSPEC:~0,-7%mshta.exe" (CLS&ECHO ϵͳ�ļ�mshta.exe��ʧ���޷�����ʹ�ã��밴������˳���&PAUSE>NUL&EXIT)
IF NOT EXIST "%COMSPEC:~0,-7%choice.exe" (IF NOT EXIST choice.exe (MSHTA VBSCRIPT:MSGBOX("������չ�ļ�choice.exe���ⶪʧ���޷�����ʹ�á�",16,"%T%"^)(WINDOW.CLOSE^)&EXIT))
IF NOT EXIST "%COMSPEC:~0,-7%find.exe" (MSHTA VBSCRIPT:MSGBOX("ϵͳ�ļ�find.exe���ⶪʧ���޷�����ʹ�á�",16,"%T%"^)(WINDOW.CLOSE^)&EXIT)
IF NOT EXIST "%COMSPEC:~0,-7%reg.exe" (MSHTA VBSCRIPT:MSGBOX("ϵͳ�ļ�reg.exe���ⶪʧ���޷�����ʹ�á�",16,"%T%"^)(WINDOW.CLOSE^)&EXIT)
IF NOT EXIST "%COMSPEC:~0,-7%xcopy.exe" (MSHTA VBSCRIPT:MSGBOX("ϵͳ�ļ�xcopy.exe���ⶪʧ���޷�����ʹ�á�",16,"%T%"^)(WINDOW.CLOSE^)&EXIT)
IF /I "%SYSTEMDRIVE%"=="X:" (GOTO START)
VER|FIND /I "XP">NUL
SET X=%ERRORLEVEL%
CLS
IF %X%==0 (GOTO START)
IF EXIST "%TEMP%\WinDOSSetup.tmp" (DEL /A /F /Q "%TEMP%\WinDOSSetup.tmp")
IF EXIST "%TEMP%\WinDOSSetup.tmp" (MSHTA VBSCRIPT:MSGBOX("�������ʧ�ܣ�",16,"%T%"^)(WINDOW.CLOSE^)&GOTO 0)
ECHO ������Ȩ�����Ժ�...
MSHTA VBSCRIPT:CREATEOBJECT("shell.application").shellexecute("%~S0","/YES","","RUNAS",1)(WINDOW.CLOSE)
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (SLEEP %%I00)
IF EXIST "%TEMP%\WinDOSSetup.tmp" (DEL /A /F /Q "%TEMP%\WinDOSSetup.tmp"&EXIT)

:0
CLS
ECHO ��Ȩ�ȴ���ʱ���Ѿ�ʧ�ܣ��Ƿ��Լ����ڷǹ���ԱȨ���¼���������
CHOICE /C YN
IF %ERRORLEVEL%==2 EXIT
GOTO START

:C
CLS
ECHO �����������뱣���������ȼ������롣
START /WAIT /I /REALTIME "" password.bat /V
IF NOT EXIST "%TEMP%\V" (ECHO ��ȡ�����������������������������밴������˳���&PAUSE>NUL&EXIT)
FOR /F %%I IN ('TYPE "%TEMP%\V"') DO (IF NOT "%%I"=="V" (ECHO ��ȡ���������������������밴������˳���&PAUSE>NUL&EXIT))
SET CK=1

:START
DEL /A /F /Q /S "%~DP0Output.txt"
FOR /F "TOKENS=6 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (IF %%I==1 (IF %CK%==0 (GOTO C)))
CLS
TITLE ���ڳ�ʼ�������Ժ�...
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
ECHO Win DOS�����-��c��Copyright ��Ȩ����-�ǿա�Win DOS���Ŷ�
IF %RT%==0 (ECHO �ϴ�����ʱ�䣺%LT%��) ELSE (ECHO δ���й�������)
ECHO ��������ʱ�䣺%ZT%��
ECHO.
ECHO ������飺
ECHO     0=�˳�����    1=Win DOS��������      2=��������    3=�α���
ECHO     4=����        5=Win DOS������ѡ��    6=ʹ�ð���
ECHO     7=�޸��������ڲ�����Mess Fixer��   8=�������뱾����
ECHO.
ECHO ���ܰ�飺
ECHO     A=�������������      B=������ʾ��      C=��������      D=ɾ���ļ�
ECHO     E=׷�ٱ��ؿ�ݷ�ʽ    F=��ֹ��������    G=�ļ�������    H=�ļ�����
ECHO     I=��Դ��ز���        J=���̶˿�̽��    K=��������      L=�ֶ�����
ECHO     M=�鿴�������        N=Ӳ�̲�������    O=ˢ��ϵͳ      P=��һҳ
ECHO ����ҪWin DOSΪ����Щʲô����ѡ��һ���Լ�����
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
ECHO Win DOS�����-��c��Copyright ��Ȩ����-�ǿչ�˾Win DOS�Ŷ�
IF %RT%==0 (ECHO �ϴ�����ʱ�䣺%LT%��) ELSE (ECHO δ���й�������)
ECHO ��������ʱ�䣺%ZT%��
ECHO.
ECHO ������飺
ECHO     0=�˳�����    1=Win DOS��������      2=��������    3=�α���
ECHO     4=����        5=Win DOS������ѡ��    6=ʹ�ð���
ECHO     7=�޸��������ڲ�����Mess Fixer��   8=�������뱾����
ECHO.
ECHO ���ܰ�飺
ECHO     A=�޸�ʱ������    B=��ӿ���������   C=�ļ�����        D=���ϵͳ�ؼ��ļ�
ECHO     E=�����Ż�        F=�ı�������     G=�鿴ϵͳ��Ϣ    H=����Ŀ¼·����̽
ECHO     I=�๦�ܼ�����    J=�����ٶȼ��     K=������ʾ��      L=������Ϸ
ECHO     M=�����ļ���λ��                     N=�๦���޸�����
ECHO     O=�����Դ���벢�򿪳���Ŀ¼         P=������һҳ
ECHO ����ҪWin DOSΪ����Щʲô����ѡ��һ���Լ�����
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
TITLE ����׼�����α䣬���̲��ɳ��ء�
CLS
ECHO ���壺�α䣬�������仯��ָ���Ǽ����ȫ�ֻ�ֲ��ַ��������滻�򱻶���ٳֵ�����WPS��Ҳ�����Ƶļ�⹤�ߡ�
ECHO ˵�����α��������ڼ������ϵͳ�Ƿ���ڲα䣬���������α����ں˼��α䣬��Ѱ�Ҹ�Ϊ�߼��Ĳα������лл��
ECHO ʹ�÷�����1���α������ڿ�ʼ�ᵯ��һ����ɫ���ڣ���δ��������˵�����̴���ʧ�ܣ�
ECHO           2����ʼ����һϵ�еĴ��󴰿ڣ�ÿ�����ڰ���5����ͬ���ַ�������ϵͳ�α䣻
ECHO           3��������ÿһ�����ڶ��Ǵ�����ʾ�򣬰����д�����ʾ��������ϵͳ�α䣻
ECHO           4����ϸ�����������ʾ���������ʣ�����ϵWin DOS�Ŀ�����Ա��
ECHO           5�����ʹ�ù�������������������ˣ�˵������ϵͳ�����زα䣡
ECHO һ��أ�����������ᷢ���α䡣��ϵͳ���ڲα䣬Ҳ��������������������Ҳ���ڲα䡣
PAUSE
CACLS EXPANSIONTEMP.TXT /E /G SYSTEM:F
CACLS EXPANSIONTEMP.TXT /E /G ADMINISTRATORS:F
CACLS EXPANSIONTEMP.TXT /E /G %USERNAME%:F
CACLS EXPANSIONTEMP.TXT /E /G USERS:F
CACLS EXPANSIONTEMP.TXT /E /G EVERYONE:F
DEL /A /F /Q EXPANSIONTEMP.TXT
IF /I EXIST C:\EXPANSIONTEMP.TXT (ECHO ���ش��󣺻����޷�ɾ����Դ�����ѱ�¶��&PAUSE&EXIT)
START /REALTIME "�α�����" EXPANSIONVERIFY
EXIT

:5
CLS
ECHO �Ƿ���������
CHOICE /C YNC /M "Y=��������N=ȡ����������C=��������塣"
CLS
IF %ERRORLEVEL%==3 (GOTO WELCOME)
GOTO 5%ERRORLEVEL%

:51
TITLE ���ڴ���������������ɱ�������ֹ�����أ�����С�
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V "Win DOS" /D "%~S0" /F
PAUSE
GOTO WELCOME

:52
TITLE ����ȡ�������������Ժ�...
CLS
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V "Win DOS" /F
PAUSE
GOTO WELCOME

:6
CLS
ECHO 1������ѡ��ʱ������򿪴�д��������[Y,N]?����ʾȷ����ȡ����������������ʾ��
ECHO 2��רҵ��Ա��ע�⣬��ʾ�����ı�ʱ�������ñ����������⣬�������볬�ı��ַ���
ECHO 3��һ��·����ʽ�� "C:\Documents and Settings\1.txt" �����޿ո�ɲ���Ӣ��˫���ţ�
ECHO 4���������룬����Win DOS������Welcome��ѡ��7�������޸�������֮���Գ������룬
ECHO    ����ΪϵͳĬ�ϴ���ҳ��ֵ��Ϊ936����Ҳ�����Ҽ�����cmd���ڱ������հ״���
ECHO    ѡ��Ĭ��ֵ���ڵ����ĶԻ���ѡ�ѡ��н�Ĭ�ϴ���ҳ����Ϊ936��
ECHO    What a mess? Please choose the number "7".
ECHO 5��������������ˣ������������ã����������ѡ��2����Ҫ��ж��Win DOS��
ECHO    �����������ѡ��1��������ʹ���������ж�أ��ڴˣ����ǳ�ŵ��һ��أ�
ECHO    ����DOS�������ļ���ע����Լ�$MFT�е��ļ���¼֮�⣬
ECHO    ���ǲ��������ĵ����������κ��߹��ĺۼ��������ж�أ�
ECHO.
ECHO �밴�������������壬�������ʡ�������ڲ���������ϱ�������ϵWin DOS������Ա��
ECHO ��ϵ��ʽ��΢�ţ�DazzlingUniverse��QQ��1306561600�����䣺1306561600@qq.com��
ECHO ����ʹ�ù����и��������˲��㣬�����½⡣��л��������Win Linux DOS�������֧�֣�
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
ECHO ���������ļ����ԣ�������Ҫ�Ƚϳ���ʱ�䣬���Ժ�
ATTRIB +A +H +R +S "%~DP0*" /D /S
ATTRIB +A +H +R +S "%CD%" /D /S
MSHTA VBSCRIPT MSGBOX("ִ���޸���ϣ�������д����������޸�������ȷ�����ļ�����ĵ������������û�н�ֹ�������̡���ֹ�����̻߳��ֹ�޸�ע���",64,"Win DOS")(WINDOW.CLOSE)
WELCOME

:8
DEL /A /F /Q /S "%~DP0Output.txt"
CLS
ECHO ������������Ժ�...
ATTRIB +A +H +R +S "%~DP0*"
FOR /F %%I IN ('DIR /A /B "%~DP0*.bat"') DO (ECHO %%I&ECHO.&TYPE "%~DP0%%I"&ECHO.&ECHO ========================================================================================================================================================================================================)>>"%~DP0Output.txt"
FOR /F %%I IN ('DIR /A /B "%~DP0*.reg"') DO (ECHO %%I&ECHO.&TYPE "%~DP0%%I"&ECHO.&ECHO ========================================================================================================================================================================================================)>>"%~DP0Output.txt"
FOR /F %%I IN ('DIR /A /B "%~DP0*.ini"') DO (ECHO %%I&ECHO.&TYPE "%~DP0%%I"&ECHO.&ECHO ========================================================================================================================================================================================================)>>"%~DP0Output.txt"
FOR /F %%I IN ('DIR /A /B "%~DP0*.inf"') DO (ECHO %%I&ECHO.&TYPE "%~DP0%%I"&ECHO.&ECHO ========================================================================================================================================================================================================)>>"%~DP0Output.txt"
IF NOT EXIST Output.txt (GOTO 9)
ECHO.>>"%~DP0Output.txt"
ECHO.>>"%~DP0Output.txt"
ECHO ���Դ����ֻ��ѧϰ����ʹ�ã�����������ҵ��;��>>"%~DP0Output.txt"
ATTRIB +A -H +R +S "%~DP0Output.txt"
CLS
ECHO ����ɹ�������
EXPLORER /E,/SELECT,"%~DP0Output.txt"
START /WAIT NOTEPAD "%~DP0Output.txt"
DEL /A /F /Q /S "%~DP0Output.txt"
GOTO WELCOME

:9
CLS
ECHO ���ʧ�ܣ��Ƿ����ԣ�
CHOICE /C YN /M "ѡ��Y�����ԣ�ѡ��N�����������档"
IF %ERRORLEVEL%==1 (GOTO 8)
GOTO WELCOME