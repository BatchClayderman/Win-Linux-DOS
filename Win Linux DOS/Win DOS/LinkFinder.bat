@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE ��ݷ�ʽ׷����
IF NOT EXIST "%COMSPEC:~0,-7%findstr.exe" (ECHO ����ȱ��ϵͳ�ļ�findstr.exe���޷��������밴������˳���&PAUSE>NUL&EXIT)
IF NOT EXIST "%COMSPEC:~0,-7%find.exe" (ECHO ����ȱ��ϵͳ�ļ�find.exe���޷��������밴������˳���&PAUSE>NUL&EXIT)
GOTO MAIN

:MAIN
CLS
ECHO ���롰0���س����˳�������·���пո�����·�����˼���Ӣ��˫���š�
ECHO �����·������ݷ�ʽ·���򽫿�ݷ�ʽ��ק���ˣ�
SET /P F=
IF %F%==0 EXIT
IF /I NOT EXIST %F% (GOTO C)
FOR %%I IN (%F%) DO (IF /I NOT "%%~XI"==".LNK" (GOTO E))
FOR /F "DELIMS=" %%I IN ('FIND ":" %F%^|FINDSTR /R "^[A-Z]:[\\]"') DO (SET P="%%I")
ECHO ��ݷ�ʽ%F%ָ���Ŀ��Ϊ%P%��
IF /I NOT EXIST %P% (GOTO D)
ECHO �Ƿ����Ŀ�ꣿ
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO MAIN)
FOR /F "TOKENS=1 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (START /REALTIME "" EXPLORER /E,/SELECT,%P%)
GOTO MAIN

:C
MSHTA VBSCRIPT:MSGBOX("���������·���ļ������ڣ����������롣",16,"��ݷ�ʽ׷����")(WINDOW.CLOSE)
GOTO MAIN

:D
ECHO Ŀ�겻���ڣ��Ƿ�ɾ����ݷ�ʽ��
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO F)
GOTO MAIN

:E
MSHTA VBSCRIPT:MSGBOX("���������·���ļ�������Ч�Ŀ�ݷ�ʽ�����������롣",16,"��ݷ�ʽ׷����")(WINDOW.CLOSE)
GOTO MAIN

:F
DEL /A /F /Q %F%
IF /I EXIST %F% (ECHO ɾ����ݷ�ʽʧ�ܣ�����ǿ��ɾ�����뵽Win DOS�����ѡ��D����) ELSE (ECHO ��ݷ�ʽ�ѱ��ɹ�ɾ����)
PAUSE
GOTO MAIN