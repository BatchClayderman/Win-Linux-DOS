@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
SET E=0
SET V=0
GOTO MAIN

:MAIN
TITLE 目录处理程序
CLS
ECHO 目录处理程序主面板
ECHO.
ECHO   0=退出程序
ECHO   1=查看目录
ECHO   2=散开目录
ECHO   3=归纳文件
ECHO   4=追加%SYSTEMDRIVE%\Folder.txt全盘目录信息
ECHO   5=追加%SYSTEMDRIVE%\Folder.txt全盘文件信息
ECHO 请选择一项以继续：
CHOICE /C 123450
IF %ERRORLEVEL%==1 (GOTO 1)
IF %ERRORLEVEL%==4 (GOTO 4)
IF %ERRORLEVEL%==5 (GOTO 5)
IF %ERRORLEVEL%==6 EXIT
SET /A M=%ERRORLEVEL%+5
GOTO V

:1
CLS
ECHO 查看目录面板
ECHO.
ECHO   0=返回主面板
ECHO   1=仅遍历文件结构
ECHO   2=遍历目录详细信息
IF %V%==0 (ECHO   3=启用日志（将会追加文本到%SYSTEMDRIVE%\Folder.txt中）) ELSE (ECHO   3=停用日志)
ECHO 请选择一项以继续：
CHOICE /C 1230
IF %ERRORLEVEL%==4 (GOTO MAIN)
IF %ERRORLEVEL%==3 (GOTO 3)
SET M=%ERRORLEVEL%
GOTO V

:V
CLS
IF %M%==1 (ECHO 遍历文件结构面板)
IF %M%==2 (ECHO 遍历目录详细信息面板)
IF %M%==7 (ECHO 散开目录面板)
IF %M%==8 (ECHO 归纳文件面板)
ECHO.
IF %E%==1 (ECHO 所输入的文件夹路径不存在或格式错误，请重新输入！)
ECHO 格式：1．"C:\Documents and Settings\Administrator"；
ECHO       2．"D:\1"。
ECHO 提示：输入“0”回车可返回主面板。
ECHO 警告：1．路径两端一定要带上英文双引号，路径末端不要带“\”；
ECHO       2．若程序闪退，则说明您的格式错误，无需重置设置；
ECHO       3．切勿输入超文本字符，引用变量除外，非专业人员请忽略此条。
ECHO 请在下方输入文件夹全路径：
SET /P F=
IF %F%==0 (GOTO MAIN)
IF /I NOT EXIST %F% (SET E=1&GOTO V)
IF NOT ^%F:~0,1%==^" (SET E=1&GOTO V)
IF NOT ^%F:~-1%==^" (SET E=1&GOTO V)
CLS
IF %M%==1 (
	ATTRIB +A -H -R -S %SYSTEMDRIVE%\Folder.txt
	TREE /F %F%
	IF %V%==1 (TREE /F %F%>>%SYSTEMDRIVE%\Folder.txt)
	GOTO C
)
IF %M%==2 (
	ATTRIB +A -H -R -S %SYSTEMDRIVE%\Folder.txt
	DIR /A /ON /Q /S %F%
	IF %V%==1 (DIR /A /ON /Q /S %F%>>%SYSTEMDRIVE%\Folder.txt)
	GOTO C
)
GOTO %M%

:3
IF %V%==0 (SET V=1) ELSE (SET V=0)
GOTO 1

:4
ATTRIB +A -H -R -S "%SYSTEMDRIVE%\Folder.txt"
TITLE 正在导出全盘目录信息，请稍候...
CLS
ECHO 全盘目录信息：>>%SYSTEMDRIVE%\Folder.txt
For /F "Skip=1" %%I IN ('WMIC LOGICALDISK GET NAME') DO (TREE %%I\ /F>>%SYSTEMDRIVE%\Folder.txt)
GOTO C

:5
ATTRIB +A -H -R -S %SYSTEMDRIVE%\Folder.txt
TITLE 正在导出全盘文件信息，请稍候...
CLS
FOR /F "SKIP=1" %%I IN ('WMIC LOGICALDISK GET CAPTION') DO (DIR /A /ON /Q /S %%I>>%SYSTEMDRIVE%\Folder.txt)
GOTO C

:7
ECHO 正在解散目录%F%下的所有常规文件，请稍候...
CLS
FOR /R %F:~0,-1%\" %%I IN (*) DO (MOVE "%%I" %F%)
GOTO END

:8
ECHO 正在整理文件夹%F%内的常规文件，请稍候...
CLS
FOR /F "DELIMS=" %%I IN ('DIR /A-D /B %F%') DO (MD %F:~0,-1%\%%~XI\"&MOVE %F:~0,-1%\%%I" %F:~0,-1%\%%~XI")
GOTO END

:C
IF %V%==0 (PAUSE&GOTO MAIN)
CLS
ATTRIB +A -H +R +S "%SYSTEMDRIVE%\Folder.txt"
IF /I EXIST %SYSTEMDRIVE%\Folder.txt (ECHO 操作成功结束。&START /REALTIME NOTEPAD %SYSTEMDRIVE%\Folder.txt) ELSE (ECHO 追加文本失败。)
PAUSE
GOTO MAIN

:END
CLS
ECHO 操作成功结束，请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN