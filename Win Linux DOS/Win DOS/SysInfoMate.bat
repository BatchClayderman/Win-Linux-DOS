@ECHO OFF
SET SYSINFOERR=0
IF /I "%1"=="/CLEAR" (GOTO CLEAR)
IF /I "%1"=="/LAUNCH" (GOTO CHECK)
IF /I "%1"=="/OLD" (GOTO OLD)
IF /I "%1"=="/P" (GOTO MAIN)
IF /I "%1"=="/PATH" (GOTO PATH)
IF /I "%1"=="/X" (GOTO X)
IF /I "%1"=="/?" (GOTO HELP)
IF /I "%1"=="" (GOTO HELP)
SET SYSINFOERR=1
GOTO HELP

:CHECK
IF /I NOT EXIST "%COMSPEC:~0,-7%SYSINFORMATION.TXT" (GOTO LAUNCH)
ECHO ԭ�洢�ļ��Ѵ��ڣ��Ƿ񸲸ǣ�Y/N����
SET /P Y=
IF /I "%Y:~0,1%"=="Y" (SET Y=&GOTO CLEAR) ELSE (ECHO ��ʾ������ɾ��ԭ�洢�ļ����ԡ�&SET Y=&EXIT /B)

:CLEAR
IF /I NOT EXIST "%COMSPEC:~0,-7%SYSINFORMATION.TXT" (ECHO ��ʾ��û�д洢��Ϣ��&EXIT /B)
CACLS "%COMSPEC:~0,-7%SYSINFORMATION.TXT" /E /G SYSTEM:F>NUL
CACLS "%COMSPEC:~0,-7%SYSINFORMATION.TXT" /E /G ADMINISTRATORS:F>NUL
CACLS "%COMSPEC:~0,-7%SYSINFORMATION.TXT" /E /G %USERNAME%:F>NUL
CACLS "%COMSPEC:~0,-7%SYSINFORMATION.TXT" /E /G USERS:F>NUL
CACLS "%COMSPEC:~0,-7%SYSINFORMATION.TXT" /E /G EVERYONE:F>NUL
DEL /A /F /Q "%COMSPEC:~0,-7%SYSINFORMATION.TXT">NUL
IF /I EXIST "%COMSPEC:~0,-7%SYSINFORMATION.TXT" (ECHO �����޷�ɾ��ԭ�洢��Ϣ��&EXIT /B)
IF /I "%1"=="/LAUNCH" (GOTO LAUNCH) ELSE (ECHO �ɹ�������洢��Ϣ�ɹ���)
SET SYSINFOERR=
EXIT /B

:HELP
IF %SYSINFOERR%==1 (ECHO ��ʾ����Ч������)
ECHO ��;����ȡϵͳ�洢��Ϣ��
ECHO.
ECHO [�÷�]SYSINFOMATE [Option]
ECHO 	CLEAR   ���ԭ�д洢�ļ�
ECHO 	LAUNCH  �����µĴ洢�ļ�
ECHO 	OLD     ��ԭ�д洢�ļ�
ECHO 	P       ���ڵ�ǰ�����г�
ECHO 	PATH    ָ���ļ��洢��Ϣ
ECHO 	X       ��SYSINFOMATEдΪϵͳ����
ECHO 	?       ��ʾ����������ʾ����Ϣ��
ECHO û�в���������ʾ�˰������档
ECHO ���磺1��SYSINFOMATE /LAUNCH��
ECHO       2��SYSINFOMATE /PATH "C:\Documents and Settings\sys.txt"��
ECHO ˵����1������/PATH�������⣬�������ȡ��һ��������
ECHO       2�����еĴ洢�ļ�λ��ϵͳ��Ŀ¼�£���Ϊ�浵ֻ����ϵͳ�����ļ���
ECHO       3����/PATH��������ָ�����ļ�ԭ�����ݲ��ᱻɾ����
ECHO ���飺1�����С�SYSINFOMATE /OLD��ǰ��ʹ��mode����ҳ��������
ECHO       2�����С�SYSINFOMATE /LAUNCH��������XCOPY��ATTRIB���ߡ�
ECHO ���棺1���������뺬�г��ı����ݵĲ�����
ECHO       2��SYSINFOMATE�޷���ָ֤���ļ��洢��Ϣ�Ƿ�ɹ���
ECHO       3����·���к��пո���������ʹ��Ӣ��˫���š�
SET SYSINFOERR=
EXIT /B

:LAUNCH
IF /I EXIST "%COMSPEC:~0,-7%SYSINFORMATION.TXT" (DEL /A /F /Q "%COMSPEC:~0,-7%SYSINFORMATION.TXT"^>NUL)
IF /I EXIST "%COMSPEC:~0,-7%SYSINFORMATION.TXT" (GOTO CLEAR)
ECHO ����ϵͳ��Ϣ���£�>>"%COMSPEC:~0,-7%SysInformation.txt"
SYSTEMINFO>>"%COMSPEC:~0,-7%SysInformation.txt"
ECHO.>>"%COMSPEC:~0,-7%SysInformation.txt"
ECHO ����ϵͳ�������£�>>"%COMSPEC:~0,-7%SysInformation.txt"
SET>>"%COMSPEC:~0,-7%SysInformation.txt"
ECHO.>>"%COMSPEC:~0,-7%SysInformation.txt"
ECHO ������Ϣ���£�>>"%COMSPEC:~0,-7%SysInformation.txt"
IPCONFIG>>"%COMSPEC:~0,-7%SysInformation.txt"
ECHO.>>"%COMSPEC:~0,-7%SysInformation.txt"
ECHO �豸��Ϣ���£�>>"%COMSPEC:~0,-7%SysInformation.txt"
MODE>>"%COMSPEC:~0,-7%SysInformation.txt"
ECHO.>>"%COMSPEC:~0,-7%SysInformation.txt"
ECHO.>>"%COMSPEC:~0,-7%SysInformation.txt"
ECHO ϵͳ��Ϣ��ȡ��ϡ�>>"%COMSPEC:~0,-7%SysInformation.txt"
ATTRIB +A +H +R +S "%COMSPEC:~0,-7%SYSINFORMATION.TXT">NUL
IF /I EXIST "%COMSPEC:~0,-7%SYSINFORMATION.TXT" (ECHO �ɹ����洢��Ϣд��ɹ���) ELSE (ECHO ���󣺴洢��Ϣд��ʧ�ܡ�)
SET SYSINFOERR=
EXIT /B

:MAIN
ECHO ����ϵͳ��Ϣ���£�
SYSTEMINFO
PAUSE
ECHO ����ϵͳ�������£�
SET
PAUSE
ECHO ������Ϣ���£�
IPCONFIG
PAUSE
ECHO �豸��Ϣ���£�
MODE
START /LOW WINVER
ECHO ϵͳ��Ϣ��ȡ��ϣ��밴������˳���
PAUSE>NUL
TASKKILL /IM WINVER.EXE /F>NUL
SET SYSINFOERR=
EXIT

:OLD
IF /I NOT EXIST "%COMSPEC:~0,-7%SYSINFORMATION.TXT" (ECHO ��ʾ��û�д洢��Ϣ��&EXIT /B)
TYPE "%COMSPEC:~0,-7%SYSINFORMATION.TXT"
SET SYSINFOERR=
EXIT /B

:PATH
ECHO ����ϵͳ��Ϣ���£�>>%2
SYSTEMINFO>>%2
ECHO.>>%2
ECHO ����ϵͳ�������£�>>%2
SET>>%2
ECHO.>>%2
ECHO ������Ϣ���£�>>%2
IPCONFIG>>%2
ECHO.>>%2
ECHO �豸��Ϣ���£�>>%2
MODE>>%2
ECHO.>>%2
ECHO.>>%2
ECHO ϵͳ��Ϣ��ȡ��ϡ�>>%2
SET SYSINFOERR=
EXIT /B

:X
XCOPY "%~DP0SYSINFOMATE.BAT" "%COMSPEC:~0,-7%" /A /H /R /V
ATTRIB +A +H +R +S "%COMSPEC:~0,-7%SYSINFOMATE.BAT">NUL
IF /I EXIST "%COMSPEC:~0,-7%SYSINFOMATE.BAT" (ECHO �ɹ���д��ϵͳ�ɹ���) ELSE (�����޷�дΪϵͳ����)
SET SYSINFOERR=
EXIT /B