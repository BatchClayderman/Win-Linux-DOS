@ECHO OFF
CHCP 936
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE 多功能计算器
GOTO MAIN

:MAIN
SET NS=0
CLS
ECHO 多功能计算器主面板
ECHO 您想要使用哪一计算功能？
ECHO   0=退出程序
ECHO   1=随机数产生器
ECHO   2=四则运算
ECHO   3=分解质因数
ECHO   4=解决《2019年全国理科数学（新课标模拟I）》中的第7小题
ECHO   5=验证“冰雹”猜想
ECHO   6=《2019年全国理科数学（新课标模拟III）》中的第7小题
ECHO   7=函数计算
ECHO   8=由日期计算星期
ECHO   9=斐波那契数列推算
ECHO 温馨提示：Mathematics和几何画板功能较为丰富。
ECHO 请选择一项以继续：
CHOICE /C 1234567890
IF %ERRORLEVEL%==10 EXIT
CLS
GOTO %ERRORLEVEL%0

:10
CLS
ECHO 请选择随机数类别：
ECHO   0=返回主面板
ECHO   1=随机整数
ECHO   2=随机小数
ECHO   3=随机分数
CHOICE /C 1230
IF %ERRORLEVEL%==4 (GOTO MAIN)
CLS
GOTO 1%ERRORLEVEL%

:11
ECHO 请输入随机整数范围的最大值：
SET /P A=
SET /A B=A+1
SET /A A=B-1
IF NOT %A%==0 (GOTO 14)
ECHO 随机数范围的最大值不能为0，请检查您的输入并按任意键重试。
PAUSE>NUL
CLS
GOTO 11

:12
ECHO 请输入随机小数数范围的最大值：
SET /P A=
SET /A B=A*1
SET /A A=B*1
IF NOT %A%==0 (GOTO 15)
ECHO 随机数范围的最大值不能为0，请检查您的输入并按任意键重试。
PAUSE>NUL
CLS
GOTO 12

:13
ECHO 请输入分子范围的最大值：
SET /P A=
SET /A B=A+1
SET /A A=B-1
IF NOT %A%==0 (GOTO 19)
ECHO 分子的最大值不能为0，请检查您的输入并按任意键重试。
PAUSE>NUL
CLS
GOTO 13

:14
CLS
SET /A R=%RANDOM%%%%B%
ECHO 随机整数范围的最大值为：%A%，产生的随机整数为：%R%。
CHOICE /C YN /M "选择“Y”继续产生随机整数，选择“N”返回主面板。"
IF %ERRORLEVEL%==1 (GOTO 14)
GOTO MAIN

:15
ECHO 请选择小数点后位数（0为不定数位）：
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
ECHO 随机整数范围的最大值为：%A%，小数点后位数为：%W%。
ECHO 产生的随机小数为：%C1%.%C2%。
CHOICE /C YN /M "选择“Y”继续产生随机小数，选择“N”返回主面板。"
IF %ERRORLEVEL%==1 (GOTO 17)
SET C1=
SET C2=
GOTO MAIN

:18
SET T=0
CLS
ECHO 随机整数范围的最大值为：%A%，小数点后位数为：%W%。
ECHO 产生的随机小数为：%C0%.%C1%%C2%%C3%%C4%%C6%%C6%%C7%%C8%%C9%。
CHOICE /C YN /M "选择“Y”继续产生随机小数，选择“N”返回主面板。"
IF %ERRORLEVEL%==1 (GOTO 16)
ECHO 正在清除缓存，请稍候...
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
ECHO 请输入分母范围的最大值：
SET /P C=
SET /A D=C+1
SET /A C=D-1
IF NOT %A%==0 (GOTO 110)
ECHO 分母的最大值不能为0，请检查您的输入并按任意键重试。
PAUSE>NUL
CLS
GOTO 19

:110
SET /A F2=%RANDOM%%%%B%
IF %F2%==0 (GOTO 110)
SET /A F1=%RANDOM%%%%A%
SET /A F=%F1%/%F2%
IF %F1% GEQ %F2% (SET F3=假) ELSE (SET F3=真)
CLS
ECHO 随机分数分子范围的最大值为%A%，分母范围的最大值为%C%。
ECHO 产生随机分数为：%F1%/%F2%，其近似整数值为%F%，是一个%F3%分数。
CHOICE /C YN /M "选择“Y”继续产生随机分数，选择“N”返回主面板。"
IF %ERRORLEVEL%==1 (GOTO 110)
GOTO MAIN

:20
CLS
ECHO 温馨提示：
ECHO   1．程序支持四则运算，如需要括号，请使用英文括号；
ECHO   2．如需用到上一个计算的答案，请输入字母“D”代替。
ECHO 请输入计算式：
SET /P C=
SET /A D=%C%
ECHO 计算“%C%”的结果为%D%。
CHOICE /C YN /M "选择“Y”继续计算，选择“N”返回主面板。"
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
IF %C%==10 (ECHO 已达饱和运算数位。)
ECHO 请输入正整数：%N%
ECHO Y=确认，E=退出，B=退格，Q=清空。
CHOICE /C 1234567890YEBQ
IF %ERRORLEVEL%==11 (SET /A M=N&ECHO 正在执行分解，请稍候...&GOTO 301)
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
IF %N%==1 (ECHO 正整数1既不是质数，也不是合数，无法分解质因数。&PAUSE&GOTO 30)
IF %N%==2 (ECHO 正整数2是最小的质数，无法分解质因数。&PAUSE&GOTO 30)
IF %N%==3 (ECHO 正整数3是质数，无法分解质因数。&PAUSE&GOTO 30)
SET /A NM=N/2
SET NB=0
FOR /L %%I IN (2,1,%NM%) DO (
	SET /A NA=%N%/%%I
	SET /A NA=!NA!*%%I
	IF !NA!==%N% (SET NB=1)
)
IF %NB%==0 (ECHO 正整数%N%是质数，无法分解质因数。&PAUSE&GOTO 30)
ENDLOCAL

:31
SET /A T=M/2
SET /A T=T*2
IF NOT %T%==%M% (GOTO 32)
SET O=%O%2×
SET /A M=M/2
IF %M%==1 (GOTO 39)
GOTO 31

:32
SET /A T=M/3
SET /A T=T*3
IF NOT %T%==%M% (GOTO 33)
SET O=%O%3×
SET /A M=M/3
IF %M%==1 (GOTO 39)
GOTO 32

:33
SET /A T=M/5
SET /A T=T*5
IF NOT %T%==%M% (GOTO 34)
SET O=%O%5×
SET /A M=M/5
IF %M%==1 (GOTO 39)
GOTO 33

:34
SET /A T=M/7
SET /A T=T*7
IF NOT %T%==%M% (GOTO 35)
SET O=%O%7×
SET /A M=M/7
IF %M%==1 (GOTO 39)
GOTO 34

:35
SET /A T=M/11
SET /A T=T*11
IF NOT %T%==%M% (GOTO 36)
SET O=%O%11×
SET /A M=M/11
IF %M%==1 (GOTO 39)
GOTO 35

:36
SET /A T=M/13
SET /A T=T*13
IF NOT %T%==%M% (GOTO 37)
SET O=%O%13×
SET /A M=M/13
IF %M%==1 (GOTO 39)
GOTO 36

:37
SET /A T=M/17
SET /A T=T*17
IF NOT %T%==%M% (GOTO 38)
SET O=%O%17×
SET /A M=M/17
IF %M%==1 (GOTO 39)
GOTO 37

:38
SET /A T=M/19
SET /A T=T*19
IF NOT %T%==%M% (GOTO 39)
SET O=%O%19×
SET /A M=M/19
IF %M%==1 (GOTO 39)
GOTO 38

:39
IF %M%==1 (SET O=%O:~,-1%) ELSE (SET O=%O%%M%&ECHO 分解质因数没有完全成功，%N%所含的质因数超过了20，部分因数如下：)
ECHO 分解%N%，得%N%=%O%。
PAUSE
GOTO 30

:40
ECHO 本题实质：验证“冰雹”猜想。
ECHO 依题可知操作次数为11，下面开始利用计算机程序验证。
SET Q=11
SET N=1
SET R=2050
SET LP=1
SET NS=1
PAUSE
CLS
ECHO 正在计算满足题意的正整数，请稍候...
GOTO 56

:50
CLS
ECHO 请选择验证方式：
ECHO   1=指定正整数验证
ECHO   2=自动验证
ECHO   3=指定操作次数验证
ECHO   0=返回主面板
ECHO 请选择一项以继续：
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
IF %C%==9 (ECHO 已达饱和运算数位。)
ECHO 请输入正整数：%N%
ECHO Y=确认，E=退出，B=退格，Q=清空。
CHOICE /C 1234567890YEBQ
IF %ERRORLEVEL%==11 (ECHO 正在执行验算，请稍候...&GOTO 54)
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
ECHO 是否允许1的循环？
CHOICE /C YNC
IF %ERRORLEVEL%==3 (GOTO 50)
SET LP=%ERRORLEVEL%
IF %LP%==2 (SET MS=不) ELSE (SET MS=)

:531
CLS
IF %C% GTR 5 (GOTO E)
IF %C% LSS 0 (GOTO E)
IF %C%==5 (ECHO 已达饱和运算数位。)
ECHO 请输入最大正整数：%R%
ECHO Y=确认，E=退出，B=退格，Q=清空。
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
IF %C%==5 (ECHO 已达饱和操作数位。)
ECHO 请输入操作次数：%Q%
ECHO Y=确认，E=退出，B=退格，Q=清空。
CHOICE /C 1234567890YEBQ
IF %ERRORLEVEL%==11 (IF NOT %C%==0 (SET K=0&SET N=0&CLS&ECHO 以下是%MS%可循环操作次数为%Q%的不超过%R%的正整数：&GOTO 56))
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
IF %NS%==1 (ECHO 满足题意的正整数共有%L%个，故本题答案为B。) ELSE (ECHO 验算成功结束，在不超过%R%的范围内，操作次数为%Q%的正整数共有%L%个。)
PAUSE
GOTO 50

:59
ECHO 正整数%N%满足猜想，其操作次数为%K%。
IF %GT%==51 (ECHO 请按任意键返回上一级面板。&PAUSE>NUL)
IF %GT%==53 (GOTO 56)
GOTO %GT%

:60
SET A=0
SET B=
SET K=0

:61
CLS
ECHO B=退格 C=清空 M=确定 E=退出
ECHO 请输入学号n：%N%
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
ECHO 输出值为%A%。
SET K=0
SET N=
PAUSE
GOTO MAIN

:70
ECHO 请输入关于x的函数：
SET /P fx=
ECHO 请输入自变量x的值：
SET /P x=
SET /A Y=%fx%
CLS
ECHO f(%x%)=%Y%
PAUSE
GOTO 70

:80
FOR /F "TOKENS=1-3 DELIMS=-" %%A IN ("%DATE:~0,10%") DO (SET A=%%A&SET M=%%B&SET D=%%C)
ECHO 不输入则默认是今日（%A%年%M%月%D%日）。
ECHO 请输入年：
SET /P A=
ECHO 请输入月：
SET /P M=
ECHO 请输入日：
SET /P D=
SET /A Y=A
IF %M%==1 (SET N=14&SET /A Y=Y+1)
IF %M%==2 (SET N=15&SET /A Y=Y+1)
SET /A X=Y-Y/100*100
SET /A N=M+1
SET /A W=Y/400-Y/100*2+X+X/4+13*N/5+D-1
IF %W% LSS 0 (SET /A V=W-7&SET /A W=W-V/7*7) ELSE (SET /A W=W-W/7*7)
ECHO %A%年%M%月%D%日对应的星期数为%W%。
ECHO 是否返回主面板？选择“Y”返回主面板，选择“N”计算另一日期。
CHOICE /C YN
CLS
IF %ERRORLEVEL%==1 (GOTO MAIN)
GOTO 80

:90
ECHO 请按任意键启动运算。
PAUSE>NUL
SET A=1
SET B=2
CLS
ECHO 斐波那契数列推算如下：

:91
ECHO %A%
ECHO %B%
SET /A A=A+B
SET /A B=A+B
IF %B% LEQ 1134903170 (GOTO 91) ELSE (GOTO 92)

:92
ECHO 推算完成，请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:E
MSHTA VBSCRIPT:MSGBOX("第一代反病毒软件提醒您：多功能计算器被溢出，已成功阻止！",64,"发现缓冲区溢出")(WINDOW.CLOSE)
START /I /REALTIME %~S0
EXIT