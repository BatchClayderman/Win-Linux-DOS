@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE ��ӿ�������������롰0���˳�����
CLS
GOTO RUN

:RUN
CLS
ECHO �������׼�ļ�ȫ·�����ļ���ק���˴������»س�����
SET /P FILE=
IF %FILE%==0 EXIT
VER|FIND /I "XP"
IF %ERRORLEVEL%==0 (XCOPY %FILE% "C:\Documents and Settings\Administrator\����ʼ���˵�\����\����\" /V /Y)
FOR %%I IN (%FILE%) DO (REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V "%%~NI" /D %FILE%)
PAUSE
GOTO RUN