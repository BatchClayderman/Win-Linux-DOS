@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=4 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE һ�����ϵͳ�����ٶ�-���ڼ���У����Ժ�...
SET A=0
CLS
SET C=%DATE%
SET R=%TIME%

:A
SET /A A=A+1
ECHO %A%
IF %A%==10000 (GOTO B) ELSE (GOTO A)

:B
SET S=%TIME%
SET R1=%R:~0,2%
SET R2=%R:~3,2%
SET R3=%R:~6,2%
SET R4=%R:~9,2%
SET S1=%S:~0,2%
SET S2=%S:~3,2%
SET S3=%S:~6,2%
SET S4=%S:~9,2%
SET D=%DATE%
IF NOT "%C%"=="%D%" (GOTO E)
SET /A T1=%S1%-%R1%
SET /A T1=%S1%-%R1%
SET /A T2=%S2%-%R2%
SET /A T2=%S2%-%R2%
SET /A T3=%S3%-%R3%
SET /A T3=%S3%-%R3%
SET /A T4=%S4%-%R4%
SET /A T4=%S4%-%R4%
SET /A T=%T1%*3600
SET /A T=%T2%*60+%T%
SET /A T=%T3%+%T%
IF %T4% LSS 0 (SET /A T=%T%-1&SET /A T4=%T4%+100)
IF %T% GEQ 100 (SET MESS=���ͣ�����ϵͳ�����ٶ���ô����ţ��������)
IF %T% LSS 100 (SET MESS=����ϵͳ�����ٶȽ���������ִ�м����Ż���)
IF %T% LSS 60 (SET MESS=����ϵͳ�����ٶȴ��ڻ��������Ҳ��������)
IF %T% LSS 30 (SET MESS=����ϵͳ�����ٶ���ĺܿ죬������ȫ��������û���)
IF %T% LSS 10 (SET MESS=�ۣ�����ϵͳ�쵽��Ҫ����������)
IF %T% LSS 3 (SET MESS=����ȥ�ɣ�����ϵͳ�Ѿ��쵽�����ߵľ��硣)
IF %T%==0 (SET MESS=�������ϵͳû�з����α䣬���������п�Ժ����ר����)
TITLE һ�����ϵͳ�����ٶ�-������
CLS
ECHO ��ʼ���Ե�ʱ�䣺%R%��ֹͣ���Ե�ʱ�䣺%S%���ܺ�ʱ��%T%.%T4%�롣
ECHO %MESS%
ECHO ϵͳ�����ٶȼ����ϣ��밴������˳���
PAUSE>NUL
EXIT

:E
TITLE �޷���ɲ��ԡ�
CLS
ECHO ���󣺲��Ժ�ʱ��Խ���ڣ�������ֹͣ����ȷ��û�п�Խ���ڲ���������������ԡ�
PAUSE
CLS
TITLE һ�����ϵͳ�����ٶ�-���ڼ���У����Ժ�...
SET A=0
SET C=%DATE%
SET R=%TIME%
GOTO A