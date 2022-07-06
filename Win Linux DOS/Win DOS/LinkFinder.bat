@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE 快捷方式追踪器
IF NOT EXIST "%COMSPEC:~0,-7%findstr.exe" (ECHO 错误：缺乏系统文件findstr.exe，无法继续，请按任意键退出。&PAUSE>NUL&EXIT)
IF NOT EXIST "%COMSPEC:~0,-7%find.exe" (ECHO 错误：缺乏系统文件find.exe，无法继续，请按任意键退出。&PAUSE>NUL&EXIT)
GOTO MAIN

:MAIN
CLS
ECHO 输入“0”回车可退出程序，若路径有空格，请在路径两端加上英文双引号。
ECHO 请在下方输入快捷方式路径或将快捷方式拖拽至此：
SET /P F=
IF %F%==0 EXIT
IF /I NOT EXIST %F% (GOTO C)
FOR %%I IN (%F%) DO (IF /I NOT "%%~XI"==".LNK" (GOTO E))
FOR /F "DELIMS=" %%I IN ('FIND ":" %F%^|FINDSTR /R "^[A-Z]:[\\]"') DO (SET P="%%I")
ECHO 快捷方式%F%指向的目标为%P%。
IF /I NOT EXIST %P% (GOTO D)
ECHO 是否查找目标？
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO MAIN)
FOR /F "TOKENS=1 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (START /REALTIME "" EXPLORER /E,/SELECT,%P%)
GOTO MAIN

:C
MSHTA VBSCRIPT:MSGBOX("您所输入的路径文件不存在，请重新输入。",16,"快捷方式追踪器")(WINDOW.CLOSE)
GOTO MAIN

:D
ECHO 目标不存在，是否删除快捷方式？
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO F)
GOTO MAIN

:E
MSHTA VBSCRIPT:MSGBOX("您所输入的路径文件不是有效的快捷方式，请重新输入。",16,"快捷方式追踪器")(WINDOW.CLOSE)
GOTO MAIN

:F
DEL /A /F /Q %F%
IF /I EXIST %F% (ECHO 删除快捷方式失败，如需强制删除，请到Win DOS主面板选择“D”。) ELSE (ECHO 快捷方式已被成功删除。)
PAUSE
GOTO MAIN