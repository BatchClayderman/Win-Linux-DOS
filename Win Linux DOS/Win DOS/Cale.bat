@ECHO OFF
CHCP 936
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE �๦�ܼ�����
GOTO MAIN

:MAIN
SET NS=0
CLS
ECHO �๦�ܼ����������
ECHO ����Ҫʹ����һ���㹦�ܣ�
ECHO   0=�˳�����
ECHO   1=�����������
ECHO   2=��������
ECHO   3=�ֽ�������
ECHO   4=�����2019��ȫ�������ѧ���¿α�ģ��I�����еĵ�7С��
ECHO   5=��֤������������
ECHO   6=��2019��ȫ�������ѧ���¿α�ģ��III�����еĵ�7С��
ECHO   7=��������
ECHO   8=�����ڼ�������
ECHO   9=쳲�������������
ECHO ��ܰ��ʾ��Mathematics�ͼ��λ��幦�ܽ�Ϊ�ḻ��
ECHO ��ѡ��һ���Լ�����
CHOICE /C 1234567890
IF %ERRORLEVEL%==10 EXIT
CLS
GOTO %ERRORLEVEL%0

:10
CLS
ECHO ��ѡ����������
ECHO   0=���������
ECHO   1=�������
ECHO   2=���С��
ECHO   3=�������
CHOICE /C 1230
IF %ERRORLEVEL%==4 (GOTO MAIN)
CLS
GOTO 1%ERRORLEVEL%

:11
ECHO ���������������Χ�����ֵ��
SET /P A=
SET /A B=A+1
SET /A A=B-1
IF NOT %A%==0 (GOTO 14)
ECHO �������Χ�����ֵ����Ϊ0�������������벢����������ԡ�
PAUSE>NUL
CLS
GOTO 11

:12
ECHO ���������С������Χ�����ֵ��
SET /P A=
SET /A B=A*1
SET /A A=B*1
IF NOT %A%==0 (GOTO 15)
ECHO �������Χ�����ֵ����Ϊ0�������������벢����������ԡ�
PAUSE>NUL
CLS
GOTO 12

:13
ECHO ��������ӷ�Χ�����ֵ��
SET /P A=
SET /A B=A+1
SET /A A=B-1
IF NOT %A%==0 (GOTO 19)
ECHO ���ӵ����ֵ����Ϊ0�������������벢����������ԡ�
PAUSE>NUL
CLS
GOTO 13

:14
CLS
SET /A R=%RANDOM%%%%B%
ECHO ���������Χ�����ֵΪ��%A%���������������Ϊ��%R%��
CHOICE /C YN /M "ѡ��Y�������������������ѡ��N����������塣"
IF %ERRORLEVEL%==1 (GOTO 14)
GOTO MAIN

:15
ECHO ��ѡ��С�����λ����0Ϊ������λ����
CHOICE /C 1234567890
SET W=%ERRORLEVEL%
IF %W%==10 (GOTO 17)
SET T=0
GOTO 16

:16
SET /A T=T+1
SET /A C%T%=%RANDOM%%%10
IF NOT %T%==%W% (GOTO 16)
SET /A C0=%RANDOM%%%%B%
GOTO 18

:17
SET /A C1=%RANDOM%%%%B%
SET /A C2=%RANDOM%%%1000000000
CLS
ECHO ���������Χ�����ֵΪ��%A%��С�����λ��Ϊ��%W%��
ECHO ���������С��Ϊ��%C1%.%C2%��
CHOICE /C YN /M "ѡ��Y�������������С����ѡ��N����������塣"
IF %ERRORLEVEL%==1 (GOTO 17)
SET C1=
SET C2=
GOTO MAIN

:18
SET T=0
CLS
ECHO ���������Χ�����ֵΪ��%A%��С�����λ��Ϊ��%W%��
ECHO ���������С��Ϊ��%C0%.%C1%%C2%%C3%%C4%%C6%%C6%%C7%%C8%%C9%��
CHOICE /C YN /M "ѡ��Y�������������С����ѡ��N����������塣"
IF %ERRORLEVEL%==1 (GOTO 16)
ECHO ����������棬���Ժ�...
SET C0=
SET C1=
SET C2=
SET C3=
SET C4=
SET C5=
SET C6=
SET C7=
SET C8=
SET C9=
GOTO MAIN

:19
ECHO �������ĸ��Χ�����ֵ��
SET /P C=
SET /A D=C+1
SET /A C=D-1
IF NOT %A%==0 (GOTO 110)
ECHO ��ĸ�����ֵ����Ϊ0�������������벢����������ԡ�
PAUSE>NUL
CLS
GOTO 19

:110
SET /A F2=%RANDOM%%%%B%
IF %F2%==0 (GOTO 110)
SET /A F1=%RANDOM%%%%A%
SET /A F=%F1%/%F2%
IF %F1% GEQ %F2% (SET F3=��) ELSE (SET F3=��)
CLS
ECHO ����������ӷ�Χ�����ֵΪ%A%����ĸ��Χ�����ֵΪ%C%��
ECHO �����������Ϊ��%F1%/%F2%�����������ֵΪ%F%����һ��%F3%������
CHOICE /C YN /M "ѡ��Y�������������������ѡ��N����������塣"
IF %ERRORLEVEL%==1 (GOTO 110)
GOTO MAIN

:20
CLS
ECHO ��ܰ��ʾ��
ECHO   1������֧���������㣬����Ҫ���ţ���ʹ��Ӣ�����ţ�
ECHO   2�������õ���һ������Ĵ𰸣���������ĸ��D�����档
ECHO ���������ʽ��
SET /P C=
SET /A D=%C%
ECHO ���㡰%C%���Ľ��Ϊ%D%��
CHOICE /C YN /M "ѡ��Y���������㣬ѡ��N����������塣"
IF %ERRORLEVEL%==1 (GOTO 20)
GOTO MAIN

:30
SET C=0
SET N=
SET O=

:300
CLS
IF %C% GTR 10 (GOTO E)
IF %C% LSS 0 (GOTO E)
IF %C%==10 (ECHO �Ѵﱥ��������λ��)
ECHO ��������������%N%
ECHO Y=ȷ�ϣ�E=�˳���B=�˸�Q=��ա�
CHOICE /C 1234567890YEBQ
IF %ERRORLEVEL%==11 (SET /A M=N&ECHO ����ִ�зֽ⣬���Ժ�...&GOTO 301)
IF %ERRORLEVEL%==12 (SET N=&SET C=&GOTO MAIN)
IF %ERRORLEVEL%==13 (IF NOT %C%==0 (SET N=%N:~0,-1%&SET /A C=C-1))&GOTO 300
IF %ERRORLEVEL%==14 (SET N=&SET C=0&GOTO 300)
IF %C%==10 (GOTO 300)
SET /A C=C+1
IF %ERRORLEVEL%==10 (IF %C%==1 (SET C=0&GOTO 300) ELSE (SET N=%N%0&GOTO 300))
SET N=%N%%ERRORLEVEL%
GOTO 300

:301
SETLOCAL ENABLEDELAYEDEXPANSION
IF %C%==0 (GOTO 300)
CLS
IF %N%==1 (ECHO ������1�Ȳ���������Ҳ���Ǻ������޷��ֽ���������&PAUSE&GOTO 30)
IF %N%==2 (ECHO ������2����С���������޷��ֽ���������&PAUSE&GOTO 30)
IF %N%==3 (ECHO ������3���������޷��ֽ���������&PAUSE&GOTO 30)
SET /A NM=N/2
SET NB=0
FOR /L %%I IN (2,1,%NM%) DO (
	SET /A NA=%N%/%%I
	SET /A NA=!NA!*%%I
	IF !NA!==%N% (SET NB=1)
)
IF %NB%==0 (ECHO ������%N%���������޷��ֽ���������&PAUSE&GOTO 30)
ENDLOCAL

:31
SET /A T=M/2
SET /A T=T*2
IF NOT %T%==%M% (GOTO 32)
SET O=%O%2��
SET /A M=M/2
IF %M%==1 (GOTO 39)
GOTO 31

:32
SET /A T=M/3
SET /A T=T*3
IF NOT %T%==%M% (GOTO 33)
SET O=%O%3��
SET /A M=M/3
IF %M%==1 (GOTO 39)
GOTO 32

:33
SET /A T=M/5
SET /A T=T*5
IF NOT %T%==%M% (GOTO 34)
SET O=%O%5��
SET /A M=M/5
IF %M%==1 (GOTO 39)
GOTO 33

:34
SET /A T=M/7
SET /A T=T*7
IF NOT %T%==%M% (GOTO 35)
SET O=%O%7��
SET /A M=M/7
IF %M%==1 (GOTO 39)
GOTO 34

:35
SET /A T=M/11
SET /A T=T*11
IF NOT %T%==%M% (GOTO 36)
SET O=%O%11��
SET /A M=M/11
IF %M%==1 (GOTO 39)
GOTO 35

:36
SET /A T=M/13
SET /A T=T*13
IF NOT %T%==%M% (GOTO 37)
SET O=%O%13��
SET /A M=M/13
IF %M%==1 (GOTO 39)
GOTO 36

:37
SET /A T=M/17
SET /A T=T*17
IF NOT %T%==%M% (GOTO 38)
SET O=%O%17��
SET /A M=M/17
IF %M%==1 (GOTO 39)
GOTO 37

:38
SET /A T=M/19
SET /A T=T*19
IF NOT %T%==%M% (GOTO 39)
SET O=%O%19��
SET /A M=M/19
IF %M%==1 (GOTO 39)
GOTO 38

:39
IF %M%==1 (SET O=%O:~,-1%) ELSE (SET O=%O%%M%&ECHO �ֽ�������û����ȫ�ɹ���%N%������������������20�������������£�)
ECHO �ֽ�%N%����%N%=%O%��
PAUSE
GOTO 30

:40
ECHO ����ʵ�ʣ���֤�����������롣
ECHO �����֪��������Ϊ11�����濪ʼ���ü����������֤��
SET Q=11
SET N=1
SET R=2050
SET LP=1
SET NS=1
PAUSE
CLS
ECHO ���ڼ�����������������������Ժ�...
GOTO 56

:50
CLS
ECHO ��ѡ����֤��ʽ��
ECHO   1=ָ����������֤
ECHO   2=�Զ���֤
ECHO   3=ָ������������֤
ECHO   0=���������
ECHO ��ѡ��һ���Լ�����
CHOICE /C 1230
IF %ERRORLEVEL%==4 (GOTO MAIN)
SET GT=5%ERRORLEVEL%
SET N=
SET Q=
SET R=
SET C=0
CLS
GOTO %GT%

:51
CLS
IF %C% GTR 9 (GOTO E)
IF %C% LSS 0 (GOTO E)
IF %C%==9 (ECHO �Ѵﱥ��������λ��)
ECHO ��������������%N%
ECHO Y=ȷ�ϣ�E=�˳���B=�˸�Q=��ա�
CHOICE /C 1234567890YEBQ
IF %ERRORLEVEL%==11 (ECHO ����ִ�����㣬���Ժ�...&GOTO 54)
IF %ERRORLEVEL%==12 (SET N=&SET C=&GOTO 50)
IF %ERRORLEVEL%==13 (IF NOT %C%==0 (SET N=%N:~0,-1%&SET /A C=C-1))&GOTO 51
IF %ERRORLEVEL%==14 (SET N=&SET C=0&GOTO 51)
IF %C%==9 (GOTO 51)
SET /A C=C+1
IF %ERRORLEVEL%==10 (IF %C%==1 (SET C=0&GOTO 51) ELSE (SET N=%N%0&GOTO 51))
SET N=%N%%ERRORLEVEL%
GOTO 51

:52
SET /A N=N+1
SET C=5
GOTO 54

:53
CLS
SET L=0
ECHO �Ƿ�����1��ѭ����
CHOICE /C YNC
IF %ERRORLEVEL%==3 (GOTO 50)
SET LP=%ERRORLEVEL%
IF %LP%==2 (SET MS=��) ELSE (SET MS=)

:531
CLS
IF %C% GTR 5 (GOTO E)
IF %C% LSS 0 (GOTO E)
IF %C%==5 (ECHO �Ѵﱥ��������λ��)
ECHO �����������������%R%
ECHO Y=ȷ�ϣ�E=�˳���B=�˸�Q=��ա�
CHOICE /C 1234567890YEBQ
IF %ERRORLEVEL%==11 (IF %C%==0 (GOTO 531) ELSE (SET C=0&SET Q=&GOTO 532))
IF %ERRORLEVEL%==12 (SET R=&SET C=&GOTO 50)
IF %ERRORLEVEL%==13 (IF NOT %C%==0 (SET R=%R:~0,-1%&SET /A C=C-1))&GOTO 531
IF %ERRORLEVEL%==14 (SET R=&SET C=0&GOTO 531)
IF %C%==9 (GOTO 531)
SET /A C=C+1
IF %ERRORLEVEL%==10 (IF %C%==1 (SET C=0&GOTO 531) ELSE (SET R=%R%0&GOTO 531))
SET R=%R%%ERRORLEVEL%
GOTO 531

:532
CLS
IF %C% GTR 5 (GOTO E)
IF %C% LSS 0 (GOTO E)
IF %C%==5 (ECHO �Ѵﱥ�Ͳ�����λ��)
ECHO ���������������%Q%
ECHO Y=ȷ�ϣ�E=�˳���B=�˸�Q=��ա�
CHOICE /C 1234567890YEBQ
IF %ERRORLEVEL%==11 (IF NOT %C%==0 (SET K=0&SET N=0&CLS&ECHO ������%MS%��ѭ����������Ϊ%Q%�Ĳ�����%R%����������&GOTO 56))
IF %ERRORLEVEL%==12 (SET Q=&SET C=&GOTO 50)
IF %ERRORLEVEL%==13 (IF NOT %C%==0 (SET Q=%Q:~0,-1%&SET /A C=C-1))&GOTO 532
IF %ERRORLEVEL%==14 (SET Q=&SET C=0&GOTO 532)
IF %C%==5 (GOTO 532)
SET /A C=C+1
IF %ERRORLEVEL%==10 (IF %C%==1 (SET C=0&GOTO 532) ELSE (SET Q=%Q%0&GOTO 532))
SET Q=%Q%%ERRORLEVEL%
GOTO 532

:54
IF "%N%"=="" (GOTO E)
IF %N% LSS 1 (GOTO E)
IF %C% GTR 9 (GOTO E)
IF %C% LSS 1 (GOTO E)
SET K=0
SET /A M=N

:55
SET /A T=M/2
SET /A T=T*2
IF %T%==%M% (SET /A M=M/2) ELSE (SET /A M=M*3+1)
SET /A K=K+1
IF %M%==1 (GOTO 59)
GOTO 55

:56
IF %N%==%R% (GOTO 58) ELSE (SET /A N=N+1)
SET /A M=N
SET K=0

:57
SET /A T=M/2
SET /A T=T*2
IF %T%==%M% (SET /A M=M/2) ELSE (SET /A M=M*3+1)
SET /A K=K+1
IF %M%==1 (IF %LP%==2 (IF %K%==%Q% (ECHO %N%&SET /A L=L+1)))
IF %M%==1 (IF %LP%==2 (GOTO 56))
IF %LP%==1 (IF %K%==%Q% (IF %M%==1 (ECHO %N%&SET /A L=L+1)))
IF %LP%==1 (IF %K%==%Q% (GOTO 56))
GOTO 57

:58
IF %NS%==1 (ECHO �������������������%L%�����ʱ����ΪB��) ELSE (ECHO ����ɹ��������ڲ�����%R%�ķ�Χ�ڣ���������Ϊ%Q%������������%L%����)
PAUSE
GOTO 50

:59
ECHO ������%N%������룬���������Ϊ%K%��
IF %GT%==51 (ECHO �밴�����������һ����塣&PAUSE>NUL)
IF %GT%==53 (GOTO 56)
GOTO %GT%

:60
SET A=0
SET B=
SET K=0

:61
CLS
ECHO B=�˸� C=��� M=ȷ�� E=�˳�
ECHO ������ѧ��n��%N%
CHOICE /C 1234567890BCME
IF %ERRORLEVEL%==11 (IF NOT %K%==0 (SET N=%N:~0,-1%&SET /A K=K-1&GOTO 61))
IF %ERRORLEVEL%==12 (SET N=&SET K=0&GOTO 61)
IF %ERRORLEVEL%==13 (GOTO 62)
IF %ERRORLEVEL%==14 (SET N=&SET K=0&GOTO MAIN)
IF %K%==4 (GOTO 61)
IF %ERRORLEVEL%==10 (SET N=%N%0&SET /A K=K+1&GOTO 61)
SET N=%N%%ERRORLEVEL%
SET /A K=K+1
GOTO 61

:62
IF %N%==0 (GOTO 63)
IF %K% GTR 4 (GOTO E)
SET /A A=A+1
SET /A T=N/100
FIND "%T%," "%B%"
IF %ERRORLEVEL%==1 (SET B=%B%%T%,)
SET /A A=10*%ERRORLEVEL%+%A%
SET N=
SET K=0
GOTO 61

:63
ECHO ���ֵΪ%A%��
SET K=0
SET N=
PAUSE
GOTO MAIN

:70
ECHO ���������x�ĺ�����
SET /P fx=
ECHO �������Ա���x��ֵ��
SET /P x=
SET /A Y=%fx%
CLS
ECHO f(%x%)=%Y%
PAUSE
GOTO 70

:80
FOR /F "TOKENS=1-3 DELIMS=-" %%A IN ("%DATE:~0,10%") DO (SET A=%%A&SET M=%%B&SET D=%%C)
ECHO ��������Ĭ���ǽ��գ�%A%��%M%��%D%�գ���
ECHO �������꣺
SET /P A=
ECHO �������£�
SET /P M=
ECHO �������գ�
SET /P D=
SET /A Y=A
IF %M%==1 (SET N=14&SET /A Y=Y+1)
IF %M%==2 (SET N=15&SET /A Y=Y+1)
SET /A X=Y-Y/100*100
SET /A N=M+1
SET /A W=Y/400-Y/100*2+X+X/4+13*N/5+D-1
IF %W% LSS 0 (SET /A V=W-7&SET /A W=W-V/7*7) ELSE (SET /A W=W-W/7*7)
ECHO %A%��%M%��%D%�ն�Ӧ��������Ϊ%W%��
ECHO �Ƿ񷵻�����壿ѡ��Y����������壬ѡ��N��������һ���ڡ�
CHOICE /C YN
CLS
IF %ERRORLEVEL%==1 (GOTO MAIN)
GOTO 80

:90
ECHO �밴������������㡣
PAUSE>NUL
SET A=1
SET B=2
CLS
ECHO 쳲����������������£�

:91
ECHO %A%
ECHO %B%
SET /A A=A+B
SET /A B=A+B
IF %B% LEQ 1134903170 (GOTO 91) ELSE (GOTO 92)

:92
ECHO ������ɣ��밴�������������塣
PAUSE>NUL
GOTO MAIN

:E
MSHTA VBSCRIPT:MSGBOX("��һ��������������������๦�ܼ�������������ѳɹ���ֹ��",64,"���ֻ��������")(WINDOW.CLOSE)
START /I /REALTIME %~S0
EXIT