@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE ���������רҵ����
SET ERR=0
IF %PROCESSOR_ARCHITECTURE:~-1%==6 (SET W=32&GOTO MAIN)
IF %PROCESSOR_ARCHITECTURE:~-1%==4 (SET W=64&GOTO MAIN)
IF %PROCESSOR_ARCHITECTURE:~-1%==2 (SET W=32&SET ERR=1&GOTO MAIN)
GOTO A

:A
CLS
ECHO Win DOS�޷���ȡ���Ĳ���ϵͳλ�������ֶ�ѡ��
CHOICE /C 036 /M "�˳�������ѡ��0��32λϵͳ��ѡ��3��64λϵͳ��ѡ��6��"
IF %ERRORLEVEL%==1 EXIT
IF %ERRORLEVEL%==2 (SET W=32)
IF %ERRORLEVEL%==3 (SET W=64)
GOTO MAIN

:MAIN
CLS
ECHO ���������רҵ����-Windows %W%
IF %ERR%==1 (ECHO ����ϵͳ���ܷ����˲α䣬���������α����ǡ�)
ECHO.
ECHO �ɹ���ѡ�����£�
ECHO   0=�˳�
ECHO   1=Everything���ļ�����������
ECHO   2=360ϵͳ������
ECHO   3=����PC Hunter Standard
ECHO   4=΢�������������
ECHO   5=����DiskGeniusרҵ��
ECHO ��Ȩ����������רҵ������������˾�ṩ��������Win DOS������������ҵ��;��
ECHO ����˵��������Խ�󣬲�������Խ�ߣ����������רҵ��Ա���������������
ECHO ��ѡ��һ���Լ�����
CHOICE /C 123450
CLS
IF %ERRORLEVEL%==6 EXIT
GOTO %ERRORLEVEL%

:1
ECHO Everything
ECHO ��һ�����������������������������Everything��
ECHO ����⣬��ǰ�ܵ�ͨ��״̬����ȫ���Ƿ�������أ�
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO MAIN)
FOR /F "TOKENS=1 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (%%I "" "http://xiazai.sogou.com/comm/redir?softdown=1&u=V14ejE_E-5N_6-osPamarXM9JLZ6gqX6jMOL7ua9ouPTasz1N8ijPNNtiw_uEd3BJjOzsL4C0JMaRWCRjmB7QmE0ztUrQI5ehk1G1ISEE-qGJkgqrLJ-4qiFQfy1AZWEDle3G0r2D-Q.&pcid=-6579285700090586392&filename=Everything-1.4.1.895.x86-Setup.exe&w=1907&stamp=20180720")
GOTO MAIN

:2
ECHO 360ϵͳ������
IF %W%==64 (ECHO ����ϵͳΪ64λϵͳ���������޷��������ؽ��̱������Ƿ������) ELSE (ECHO ��������360ϵͳ�����䣬�Ƿ������)
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO MAIN)
FOR /F "TOKENS=1 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (%%I "" "http://www.360.cn/jijiuxiang/")
GOTO MAIN

:3
ECHO PC Hunter Standard
ECHO ��һ�����������������������������PC Hunter Standard��
ECHO ����⣬��ǰ�ܵ�ͨ��״̬����ȫ���Ƿ�������أ�
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO MAIN)
FOR /F "TOKENS=1 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (%%I "" "http://pc6.dun.123ch.cn/download/%E7%B3%BB%E7%BB%9F%E7%BB%B4%E6%8A%A4%E8%BD%AF%E4%BB%B6_48@87144.exe")
GOTO MAIN

:4
ECHO ���ڼ��ܵ�ͨ�������Ժ�...
TASKKILL /IM MP* /F /T
WMIC PROCESS GET NAME|FIND /I "MPSVC2.EXE">NUL
CLS
IF %ERRORLEVEL%==0 (CLS&ECHO �����������ڻ�Ծ״̬��ϵͳ��ȫ���밴�������������塣&PAUSE>NUL&GOTO MAIN)
SC START MPSVCSERVICE
WMIC PROCESS GET NAME|FIND /I "MPSVC2.EXE">NUL
IF %ERRORLEVEL%==0 (MSHTA VBSCRIPT:MSGBOX("���Ѱ�װ΢����������������������������Ǵ��ڻ�Ծ״̬��������������ϵͳ�������ȷ������������塣",64,"������רҵ����"^)(WINDOW.CLOSE^)&GOTO MAIN)
CLS
ECHO ΢�������������-�Ƚ��ĵ�������������������ҡ�863���ص�Ƽ���Ŀ)
ECHO �Ƽ����ɣ��������ķ��������ƣ�������2008�걱�����˻����簲ȫ�ܹ���ʦ��
ECHO �����������������������Ƿ������
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO MAIN)
FOR /F "TOKENS=1 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (%%I "" "http://www.depthsec.com.cn/index.php?m=&c=Product&a=personal")
GOTO MAIN

:5
ECHO DiskGeniusרҵ�ƽ��
ECHO ��һ�����������������������������DiskGeniusרҵ�������
ECHO ����⣬��ǰ�ܵ�ͨ��״̬����ȫ���Ƿ�������أ�
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO MAIN)
FOR /F "TOKENS=1 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (%%I "" "http://22355.xc.08an.com/down/diskgenius%E4%B8%93%E4%B8%9A%E7%89%88%E7%A0%B4%E8%A7%A3@211_16788.exe")
GOTO MAIN