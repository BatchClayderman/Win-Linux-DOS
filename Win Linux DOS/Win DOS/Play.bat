@ECHO OFF
CHCP 936
CD /D "%~DP0"
TITLE 键盘游戏
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
SETLOCAL ENABLEDELAYEDEXPANSION
CLS
IF /I NOT EXIST "%~DP0choice.exe" (IF /I NOT EXIST "%COMSPEC:~0,-7%choice.exe" (GOTO ERROR))
SET C=ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789
SET "A=                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        "
SET T=0
SET J=0
CLS
ECHO 为避免系统无响应，请先打开大写锁键。
ECHO.
ECHO 游戏玩法：选择时长后迅速按下屏幕上出现的字母，按下“0”可认输。
PAUSE
GOTO MAIN

:MAIN
CLS
ECHO 数字越小，难度越大，请选择难度时间（单位：秒）：
CHOICE /C 123456789
SET T=%ERRORLEVEL%
TITLE 键盘游戏-难度时间：%T%
SET J=0
GOTO BEGIN

:BEGIN
SET /A Z=%RANDOM%%%35
SET /A K=%RANDOM%%%1000
SET Z=!C:~%Z%,1!
SET K=!A:~%K%!
SET L=%K%%Z%
CLS
ECHO 得分：%J%分。
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
ECHO 错误：丢失choice.exe，请下载choice.exe或咨询Win DOS开发人员。
PAUSE
EXIT

:OVER
CLS
ECHO 游戏结束！你输啦！
ECHO 难度时间：%T%。
ECHO 您的得分为：%J%。
ECHO 继续努力哦！
ECHO 是否再来一局？
CHOICE /C YN
IF %ERRORLEVEL%==2 EXIT
SET J=0
GOTO MAIN

:WIN
CLS
ECHO 恭喜你，你赢啦！
ECHO 难度时间：%T%。
ECHO 您的得分为：%J%。
ECHO 是否挑战更高难度？
CHOICE /C YN
IF %ERRORLEVEL%==2 EXIT
SET J=0
SET /A T=T-1
TITLE 键盘游戏-难度时间：%T%
GOTO BEGIN