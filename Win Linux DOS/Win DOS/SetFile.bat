@ECHO OFF
IF "%1"=="" (GOTO START)
IF "%1"=="/?" (GOTO HELP)
SET =%1
GOTO %:~1,9%

:START
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
GOTO MAIN

:FILE
IF /I NOT EXIST "%COMSPEC:~0,-7%SetFile.bat" (XCOPY "%~DP0SetFile.bat" "%COMSPEC:~0,-7%" /H /R /V /Y)
IF /I NOT EXIST "%COMSPEC:~0,-7%SetFile.bat" (ECHO 执行操作失败！&EXIT /B)
ATTRIB +A -H +R +S "%COMSPEC:~0,-7%SetFile.bat"
REG ADD HKCR\*\shell\secret /VE /T Reg_SZ /D 设密而不隐藏 /F
REG ADD HKCR\*\shell\secret\command /VE /T Reg_SZ /D "SetFile.bat /secret \"%%1\"" /F
REG ADD HKCR\*\shell\secret /V NoWorkingDirectory /D "" /F
REG ADD HKCR\*\shell\set /VE /T Reg_SZ /D 全选文件属性 /F
REG ADD HKCR\*\shell\set\command /VE /T Reg_SZ /D "SetFile.bat /set \"%%1\"" /F
REG ADD HKCR\*\shell\set /V NoWorkingDirectory /D "" /F
REG ADD HKCR\*\shell\show /VE /T Reg_SZ /D 去除所有文件属性 /F
REG ADD HKCR\*\shell\show\command /VE /T Reg_SZ /D "SetFile.bat /show \"%%1\"" /F
REG ADD HKCR\*\shell\show /V NoWorkingDirectory /D "" /F
REG ADD HKCR\Folder\shell\secret /VE /T Reg_SZ /D 设密而不隐藏 /F
REG ADD HKCR\Folder\shell\secret\command /VE /T Reg_SZ /D "SetFile.bat /secret \"%%1\"" /F
REG ADD HKCR\Folder\shell\secret /V NoWorkingDirectory /D "" /F
REG ADD HKCR\Folder\shell\set /VE /T Reg_SZ /D 全选子文件属性 /F
REG ADD HKCR\Folder\shell\set\command /VE /T Reg_SZ /D "SetFile.bat /set \"%%1\"" /F
REG ADD HKCR\Folder\shell\set /V NoWorkingDirectory /D "" /F
REG ADD HKCR\Folder\shell\show /VE /T Reg_SZ /D 去除所有子文件属性 /F
REG ADD HKCR\Folder\shell\show\command /VE /T Reg_SZ /D "SetFile.bat /show \"%%1\"" /F
REG ADD HKCR\Folder\shell\show /V NoWorkingDirectory /D "" /F
SET =
EXIT /B

:HELP
ECHO 快速全选/去除文件属性或设密而不隐藏。
ECHO [用法] SetFile [/set [ImagePath]] [/show [/ImagePath]] [/x] [/?]
ECHO	secret	设密而不隐藏
ECHO 	set	全选文件属性
ECHO 	show	去除所有文件属性
ECHO 	x    	将SetFile写为系统程序
ECHO 	unx	从系统中移除SetFile
ECHO 	file	添加到右键菜单
ECHO 	unfile	取消右键菜单
ECHO 	?	显示此消息
ECHO 	其它	手动操作
ECHO 注意：当出现多个参数时，SetFile只读取第一个参数及其对应的参数对象。
ECHO           当设置的对象为文件夹时，SetFile会对目录下所有文件变更属性。
ECHO 格式：SetFile /set [ImagePath]
ECHO           SetFile /show [ImagePath]
EXIT /B

:MAIN
TITLE 设置为系统隐藏的只读存档文件或文件夹
CLS
ECHO 如有多个文件或文件夹，请用空格将每个文件或文件夹隔开。
ECHO 如果是文件夹路径，请勿在文件夹路径最后加“\”。
ECHO 如果需要对整个文件夹及其所有子目录和子文件操作，请在路径最后加上“\*”。
ECHO 例如：要想对C:\中所有子文件和子目录操作，请输入“"C:\*"”并回车。
ECHO 若要退出程序，请手动关闭本窗口；若要暂停或终止操作，请按下“Ctrl+C”。
ECHO 当按下“Ctrl+C”无响应时，请再次按下“Ctrl+C”，若程序仍无响应，请关闭窗口。
ECHO 请将文件或文件夹拖拽到下方或输入全路径：
SET /P FILE=
ATTRIB +A +H +R +S %FILE% /D /S
ATTRIB +A +H +R +S %FILE%
ECHO 执行操作完毕！
PAUSE
GOTO MAIN

:SECRET
ATTRIB /D /S +A -H +R +S %2
SET =%2
SET =%:~1,-1%
ATTRIB /D /S +A -H +R +S "%%\*"
SET =
EXIT /B

:SET
ATTRIB /D /S +A +H +R +S %2
SET =%2
SET =%:~1,-1%
ATTRIB /D /S +A +H +R +S "%%\*"
SET =
EXIT /B

:SHOW
ATTRIB /D /S -A -H -R -S %2
SET =%2
SET =%:~1,-1%
ATTRIB /D /S -A -H -R -S "%%\*"
SET =
EXIT /B

:UNFILE
REG DELETE HKCR\*\shell\secret /F
REG DELETE HKCR\*\shell\set /F
REG DELETE HKCR\*\shell\show /F
REG DELETE HKCR\Folder\shell\secret /F
REG DELETE HKCR\Folder\shell\set /F
REG DELETE HKCR\Folder\shell\show /F
SET =
EXIT /B

:UNX
DEL /A /F /Q %COMSPEC:~0,-7%SetFile.bat
IF /I EXIST "%COMSPEC:~0,-7%SetFile.bat" (ECHO 无法从系统目录中移除SetFile！) ELSE (ECHO 操作成功结束！)
GOTO UNFILE

:X
IF /I EXIST "%COMSPEC:~0,-7%SetFile.bat" (ECHO 系统目录下存在同名文件。&EXIT /B)
XCOPY "%~DP0SetFile.bat" "%COMSPEC:~0,-7%" /H /R /V /Y>NUL
IF /I EXIST "%COMSPEC:~0,-7%SetFile.bat" (ECHO 操作成功结束！) ELSE (ECHO 执行操作失败！&EXIT /B)
ATTRIB +A -H +R +S "%COMSPEC:~0,-7%SetFile.bat"
SET =
EXIT /B