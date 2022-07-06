@ECHO OFF
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE 日期与时间
SET MESS=0

:MAIN
CLS
ECHO 当前系统时间：%DATE% %TIME%。
ECHO   0=退出程序
ECHO   1=修改日期与时间
ECHO   2=自动同步
ECHO   3=打开日期与时间对话框
ECHO 请选择一项操作以继续：
CHOICE /C 1230
IF %ERRORLEVEL%==4 EXIT
CLS
IF %ERRORLEVEL%==3 (RUNDLL32 /D shell32.dll,Control_RunDLL timedate.cpl) ELSE (GOTO %ERRORLEVEL%)
ECHO 如果没有弹出对话框，请检查您的系统。
PAUSE
GOTO MAIN

:1
CLS
IF NOT %MESS%==0 (ECHO %MESS%)
SET MESS=0
ECHO 说明：此处修改日期与时间将会绕开系统操作的访问机制，直接从底层进行写入。
ECHO 当前系统时间：%DATE% %TIME%。
ECHO   Y=年  L=月  D=日
ECHO   H=时  M=分  S=秒
ECHO   1=重新加载日期与时间
ECHO   0=返回主面板
ECHO 请选择一项以继续：
CHOICE /C YLDHMS10
CLS
IF %ERRORLEVEL%==8 (GOTO MAIN)
IF %ERRORLEVEL%==7 (GOTO 1)
SET /A F=%ERRORLEVEL%+2
GOTO %F%0

:2
CLS
W32TM /REGISTER
NET START "WINDOWS TIME"
W32TM /RESYNC
ECHO.
ECHO.
ECHO 如果时差太大，请先确保年份相同再执行同步，按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:30
SET Y=
SET YC=0

:31
CLS
ECHO 导航：按“B”可返回上一级面板，按“M”可返回主面板；
ECHO       按“Q”可重新输入。输入四位数后，系统将自动跳转。
ECHO 请输入年：%Y%
CHOICE /C 1234567890BMQ>NUL
IF %ERRORLEVEL%==12 (GOTO MAIN)
IF %ERRORLEVEL%==11 (GOTO 1)
IF %ERRORLEVEL%==13 (GOTO 30)
IF %ERRORLEVEL%==10 (IF "%Y%"=="" (GOTO 31) ELSE (SET Y=%Y%0&SET /A YC+=1)) ELSE (SET Y=%Y%%ERRORLEVEL%&SET /A YC+=1)
IF %YC%==4 (GOTO 32) ELSE (GOTO 31)

:32
SET L=%DATE:~5,2%
SET D=%DATE:~8,2%
DATE %Y%-%L%-%D%
SET YY=%DATE:~0,4%
IF %YY%==%Y% (SET MESS=年份修改成功！) ELSE (SET MESS=年份修改失败！)
GOTO 10

:40
CLS
ECHO 导航：按“B”可返回上一级面板，按“M”可返回主面板。
ECHO       数字0=10月  N=11月  D=12月
ECHO 请选择月：
CHOICE /C 1234567890NDBM
IF %ERRORLEVEL%==14 (GOTO MAIN)
IF %ERRORLEVEL%==13 (GOTO 1)
SET L=%ERRORLEVEL%
IF %L% LSS 10 (SET L=0%L%)
SET Y=%DATE:~0,4%
SET D=%DATE:~8,2%
DATE %Y%-%L%-%D%
SET LL=%DATE:~5,2%
IF %LL%==%L% (SET MESS=月份修改成功！) ELSE (SET MESS=月份修改失败！)
GOTO 10

:50
CLS
ECHO 导航：按“V”可返回上一级面板，按“W”可返回主面板。
ECHO       1-9：数字对应的按键     10：数字0
ECHO       A=11    B=12    C=13    D=14    E=15
ECHO       F=16    G=17    H=18    I=19    J=20
ECHO       K=21    L=22    M=23    N=24    O=25
ECHO       P=26    Q=27    R=28    S=29    T=30
ECHO       U=31    V=上一级面板    W=主面板
ECHO 请选择日：
CHOICE /C 1234567890ABCDEFGHIJKLMNOPQRSTUVW
IF %ERRORLEVEL%==33 (GOTO MAIN)
IF %ERRORLEVEL%==32 (GOTO 1)
SET D=%ERRORLEVEL%
IF %D% LSS 10 (SET D=0%D%)
SET Y=%DATE:~0,4%
SET L=%DATE:~5,2%
DATE %Y%-%L%-%D%
SET DD=%DATE:~8,2%
IF %DD%==%D% (SET MESS=日号修改成功！) ELSE (SET MESS=日号修改失败！)
GOTO 10

:60
CLS
ECHO 导航：按“P”可返回上一级面板，按“Q”可返回主面板。
ECHO       0-9：数字对应的按键     A=10    B=11    C=12
ECHO       D=13    E=14    F=15    G=16    H=17    I=18
ECHO       J=19    K=20    L=21    M=22    N=23
ECHO       P=上一级面板    Q=主面板
ECHO 请选择时：
CHOICE /C 0123456789ABCDEFGHIJKLMNPQ
IF %ERRORLEVEL%==25 (GOTO MAIN)
IF %ERRORLEVEL%==24 (GOTO 1)
SET H=%ERRORLEVEL%
IF %H% LSS 10 (SET H=0%H%)
SET M=%TIME:~3,2%
TIME %H%:%M%
SET HH=%TIME:~0,2%
IF %HH%==%H% (SET MESS=小时修改成功！) ELSE (SET MESS=小时修改失败！)
SET HH=
GOTO 20

:70
CLS
ECHO 导航：按“B”可返回上一级面板，按“M”可返回主面板。
ECHO 请输入分（两位数），输入完成后会自动跳转：
CHOICE /C 123450BM>NUL
IF %ERRORLEVEL%==8 (GOTO MAIN)
IF %ERRORLEVEL%==7 (GOTO 1)
IF %ERRORLEVEL%==6 (SET M=0&GOTO 71)
SET M=%ERRORLEVEL%

:71
CHOICE /C 1234567890BM>NUL
IF %ERRORLEVEL%==12 (SET M=&GOTO MAIN)
IF %ERRORLEVEL%==11 (SET M=&GOTO 1)
IF %ERRORLEVEL%==10 (SET M=%M%0&GOTO 72)
SET M=%M%%ERRORLEVEL%

:72
SET H=%TIME:~0,2%
TIME %H%:%M%
SET MM=%TIME:~3,2%
IF %MM%==%M% (SET MESS=分钟修改成功！) ELSE (SET MESS=分钟修改失败！)
SET MM=
GOTO 20

:80
CLS
IF NOT EXIST "%COMSPEC:~0,-7%SLEEP.EXE" (IF NOT EXIST SLEEP.EXE (ECHO 丢失sleep.exe，无法继续，请按任意键返回上一级面板。&ECHO 您也可以尝试在Win DOS主面板第二页中选择“N”修复。&PAUSE>NUL&GOTO 1))
IF %TIME:~3,2%==59 (GOTO 83)
ECHO 正在预处理，请稍候...
SET S=1
SET Z=1
SET A=%TIME:~9,2%
SET H=%TIME:~0,2%
SET M=%TIME:~3,2%
SET /A M+=1
SET /A S=60-S
CLS
ECHO 正在时间精准化，请等待%S%秒。
SET B=%TIME:~9,2%
SET /A Z=B-A
IF %Z% LSS 0 (SET /A Z+=60)
IF %Z% LSS 10 (SET Z=0%Z%)
CLS
ECHO 说明：设置将在输入完第二位的一瞬生效。
ECHO 导航：按“B”可返回上一级面板，按“M”可返回主面板。
ECHO 请输入秒（两位数），输入完成后会自动跳转：
CHOICE /C 123450BM>NUL
IF %ERRORLEVEL%==8 (GOTO MAIN)
IF %ERRORLEVEL%==7 (GOTO 1)
IF %ERRORLEVEL%==6 (SET S=0&GOTO 81)
SET S=%ERRORLEVEL%

:81
CHOICE /C 1234567890BM>NUL
IF %ERRORLEVEL%==12 (SET S=&GOTO MAIN)
IF %ERRORLEVEL%==11 (SET S=&GOTO 1)
IF %ERRORLEVEL%==10 (SET S=%S%0&GOTO 82)
SET S=%S%%ERRORLEVEL%

:82
SET H=%TIME:~0,2%
SET M=%TIME:~3,2%
SET /A M+=1
SET /A S=60-S
CLS
ECHO 正在时间精准化，请等待%S%秒。
IF %M%==60 (GOTO 83)
SLEEP %S%%Z%0
TIME %H%:%M%
SET S=
SET Z=
SET MESS=精确到秒成功！
GOTO 20

:83
SET S=
ECHO 系统即将整点，为防止出错，请稍后再试。
PAUSE
GOTO 20

:10
SET Y=
SET L=
SET D=
SET YY=
SET YC=
GOTO 1

:20
SET H=
SET M=
GOTO 1