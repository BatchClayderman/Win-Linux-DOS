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
IF "%FILE:~0,1%"=="0" (EXIT)
XCOPY %FILE% "C:\Documents and Settings\Administrator\����ʼ���˵�\����\����\" /V /Y
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V /Q %FILE%
PAUSE
GOTO RUN