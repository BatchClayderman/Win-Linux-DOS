@ECHO OFF
CHCP 936
CD /D "%~DP0"
TITLE Win DOS����������
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
FOR /F "TOKENS=6 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (IF %%I==0 (CLS&ECHO δ�������뱣�����밴������˳���&PAUSE>NUL&EXIT))
FOR /F "DELIMS=" %%I IN ('TYPE "%~S0"') DO (SET PATH=%%I)
IF /I NOT "%~DPNX0"=="%PATH:~2%" (CLS&ECHO ���󣺲���ԭ�ļ����밴������˳���&PAUSE>NUL&EXIT)

:CREATE
DEL "%TEMP%\password.vbs" /A /F /Q
IF EXIST "%TEMP%\password.vbs" (GOTO E)
ECHO a=inputbox("���������루ֱ�ӻس����˳����򣩣�","Win DOS����������") >"%TEMP%\password.vbs"
ECHO If Len(a)^>0 Then>>"%TEMP%\password.vbs"
ECHO Dim fso, File>>"%TEMP%\password.vbs"
ECHO Set fso=CreateObject("Scripting.FileSystemObject")>>"%TEMP%\password.vbs"
ECHO Set File=fso.CreateTextFile("%TEMP%\password.txt", True)>>"%TEMP%\password.vbs"
ECHO File.WriteLine(a)>>"%TEMP%\password.vbs"
ECHO File.Close>>"%TEMP%\password.vbs"
ECHO End If>>"%TEMP%\password.vbs"
IF NOT EXIST "%TEMP%\password.vbs" (GOTO G)

:PASS
DEL "%TEMP%\password.txt" /A /F /Q
DEL "%TEMP%\rp.txt" /A /F /Q
DEL "%TEMP%\V" /A /F /Q
IF EXIST "%TEMP%\password.txt" (GOTO E)
IF EXIST "%TEMP%\rp.txt" (GOTO E)
IF EXIST "%TEMP%\V" (GOTO E)
CLS
START /REALTIME /WAIT "" "%TEMP%\password.vbs"
IF NOT EXIST "%TEMP%\password.txt" (DEL /A /F /Q "%TEMP%\password.vbs"&EXIT)
FOR /F "TOKENS=7 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (ECHO ^%%I>"%TEMP%\rp.txt")
"%COMSPEC:~0,-7%FC.EXE" /U "%TEMP%\password.txt" "%TEMP%\rp.txt"
IF %ERRORLEVEL%==0 (GOTO 0)
DEL "%TEMP%\rp.txt" /A /F /Q
IF EXIST "%TEMP%\rp.txt" (GOTO F)
DEL "%TEMP%\password.txt" /A /F /Q
IF EXIST "%TEMP%\password.txt" (GOTO E)
CLS
ECHO ��������밴��R�����ԣ�����C��ȡ����
CHOICE /C RC
IF %ERRORLEVEL%==1 (GOTO PASS)
DEL "%TEMP%\password.vbs" /A /F /Q
EXIT

:0
CLS
IF /I "%1"=="/V" (ECHO V>"%TEMP%\V"&EXIT)
ECHO ������ȷ����������Win DOS����塣
START /I /REALTIME "" WELCOME.BAT
EXIT

:E
CLS
ECHO �����ļ�ɾ��ʧ�ܣ����ܻ�Ӱ������У�飬�Ƿ����ԣ�
ECHO �밴��R�����ԣ�����E���˳�������
CHOICE /C RE
IF %ERRORLEVEL%==2 EXIT
DEL "%TEMP%\password.vbs" /A /F /Q
DEL "%TEMP%\password.txt" /A /F /Q
DEL "%TEMP%\rp.txt" /A /F /Q
IF EXIST "%TEMP%\password.vbs" (GOTO E)
IF EXIST "%TEMP%\password.txt" (GOTO E)
IF EXIST "%TEMP%\rp.txt" (GOTO E)
GOTO PASS

:F
CLS
ECHO ԭ���������й©������������
ECHO ����ϵ�ǿչ�˾Win DOS�Ŷӽ��н�����
ECHO ::ERROR>>"%~S0"
EXIT

:G
CLS
ECHO ����Win DOS����������ʧ�ܣ��Ƿ����ԣ�
ECHO �밴��R�����ԣ�����E���˳�������
CHOICE /C RE
IF %ERRORLEVEL%==2 EXIT
GOTO CREATE
::D:\Program Files\Win DOS\password.bat
