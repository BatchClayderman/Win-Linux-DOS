@ECHO OFF
CHCP 936
CD /D "%~DP0"
TITLE ������Ϸ
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
SETLOCAL ENABLEDELAYEDEXPANSION
CLS
IF /I NOT EXIST "%~DP0choice.exe" (IF /I NOT EXIST "%COMSPEC:~0,-7%choice.exe" (GOTO ERROR))
SET C=ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789
SET "A=                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        "
SET T=0
SET J=0
CLS
ECHO Ϊ����ϵͳ����Ӧ�����ȴ򿪴�д������
ECHO.
ECHO ��Ϸ�淨��ѡ��ʱ����Ѹ�ٰ�����Ļ�ϳ��ֵ���ĸ�����¡�0�������䡣
PAUSE
GOTO MAIN

:MAIN
CLS
ECHO ����ԽС���Ѷ�Խ����ѡ���Ѷ�ʱ�䣨��λ���룩��
CHOICE /C 123456789
SET T=%ERRORLEVEL%
TITLE ������Ϸ-�Ѷ�ʱ�䣺%T%
SET J=0
GOTO BEGIN

:BEGIN
SET /A Z=%RANDOM%%%35
SET /A K=%RANDOM%%%1000
SET Z=!C:~%Z%,1!
SET K=!A:~%K%!
SET L=%K%%Z%
CLS
ECHO �÷֣�%J%�֡�
ECHO %L%
CHOICE /C ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 /CS /T %T% /D 0 /N>NUL
SET P=%ERRORLEVEL%
IF %ERRORLEVEL%==1 (SET P=A)
IF %ERRORLEVEL%==2 (SET P=B)
IF %ERRORLEVEL%==3 (SET P=C)
IF %ERRORLEVEL%==4 (SET P=D)
IF %ERRORLEVEL%==5 (SET P=E)
IF %ERRORLEVEL%==6 (SET P=F)
IF %ERRORLEVEL%==7 (SET P=G)
IF %ERRORLEVEL%==8 (SET P=H)
IF %ERRORLEVEL%==9 (SET P=I)
IF %ERRORLEVEL%==10 (SET P=J)
IF %ERRORLEVEL%==11 (SET P=K)
IF %ERRORLEVEL%==12 (SET P=L)
IF %ERRORLEVEL%==13 (SET P=M)
IF %ERRORLEVEL%==14 (SET P=N)
IF %ERRORLEVEL%==15 (SET P=O)
IF %ERRORLEVEL%==16 (SET P=P)
IF %ERRORLEVEL%==17 (SET P=Q)
IF %ERRORLEVEL%==18 (SET P=R)
IF %ERRORLEVEL%==19 (SET P=S)
IF %ERRORLEVEL%==20 (SET P=T)
IF %ERRORLEVEL%==21 (SET P=U)
IF %ERRORLEVEL%==22 (SET P=V)
IF %ERRORLEVEL%==23 (SET P=W)
IF %ERRORLEVEL%==24 (SET P=X)
IF %ERRORLEVEL%==25 (SET P=Y)
IF %ERRORLEVEL%==26 (SET P=Z)
IF %ERRORLEVEL%==27 (SET P=1)
IF %ERRORLEVEL%==28 (SET P=2)
IF %ERRORLEVEL%==29 (SET P=3)
IF %ERRORLEVEL%==30 (SET P=4)
IF %ERRORLEVEL%==31 (SET P=5)
IF %ERRORLEVEL%==32 (SET P=6)
IF %ERRORLEVEL%==33 (SET P=7)
IF %ERRORLEVEL%==34 (SET P=8)
IF %ERRORLEVEL%==35 (SET P=9)
IF /I %P%==%Z% (IF %J%==15 (GOTO WIN) ELSE (SET /A J=J+1)) ELSE (GOTO OVER)
GOTO BEGIN

:ERROR
ECHO ���󣺶�ʧchoice.exe��������choice.exe����ѯWin DOS������Ա��
PAUSE
EXIT

:OVER
CLS
ECHO ��Ϸ��������������
ECHO �Ѷ�ʱ�䣺%T%��
ECHO ���ĵ÷�Ϊ��%J%��
ECHO ����Ŭ��Ŷ��
ECHO �Ƿ�����һ�֣�
CHOICE /C YN
IF %ERRORLEVEL%==2 EXIT
SET J=0
GOTO MAIN

:WIN
CLS
ECHO ��ϲ�㣬��Ӯ����
ECHO �Ѷ�ʱ�䣺%T%��
ECHO ���ĵ÷�Ϊ��%J%��
ECHO �Ƿ���ս�����Ѷȣ�
CHOICE /C YN
IF %ERRORLEVEL%==2 EXIT
SET J=0
SET /A T=T-1
TITLE ������Ϸ-�Ѷ�ʱ�䣺%T%
GOTO BEGIN