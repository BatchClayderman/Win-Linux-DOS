@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
SET V=0
SET X=0
SET N=1
IF EXIST "%COMSPEC:~0,-7%wbem\wmic.exe" (SET W=1) ELSE (SET W=0)
GOTO M

:M
TITLE 磁盘工具
CLS
ECHO 磁盘工具主面板
IF %W%==0 (ECHO 系统文件wmic.exe意外丢失，请手动查看硬件信息。如有不便，请谅解！) ELSE (WMIC LOGICALDISK GET CAPTION,VOLUMENAME)
ECHO   0=退出程序
ECHO   1=检查磁盘
ECHO   2=转换为NTFS
ECHO   3=格式化磁盘
ECHO   4=修改卷标
ECHO   5=碎片整理
ECHO 请选择一项以继续：
CHOICE /C 123450
SET C=%ERRORLEVEL%
IF %C%==6 EXIT
GOTO MAIN

:MAIN
CLS
ECHO 磁盘选择面板
IF %W%==0 (ECHO 系统文件wmic.exe意外丢失，请手动查看硬件信息。如有不便，请谅解！) ELSE (WMIC LOGICALDISK GET CAPTION,VOLUMENAME)
IF %C%==1 (ECHO 您想要检查哪个磁盘？)
IF %C%==2 (ECHO 您想要将哪个磁盘转换为NTFS格式？)
IF %C%==3 (ECHO 您想要格式化哪个磁盘？)
IF %C%==4 (ECHO 您想要对哪个磁盘进行碎片整理？)
ECHO 导航：选择“0”可返回主面板。
CHOICE /C 0CDEFGHIJKLMNOPQRSTUVWXYZ
IF %ERRORLEVEL%==1 (GOTO M)
IF %ERRORLEVEL%==2 (SET D=C)
IF %ERRORLEVEL%==3 (SET D=D)
IF %ERRORLEVEL%==4 (SET D=E)
IF %ERRORLEVEL%==5 (SET D=F)
IF %ERRORLEVEL%==6 (SET D=G)
IF %ERRORLEVEL%==7 (SET D=H)
IF %ERRORLEVEL%==8 (SET D=I)
IF %ERRORLEVEL%==9 (SET D=J)
IF %ERRORLEVEL%==10 (SET D=K)
IF %ERRORLEVEL%==11 (SET D=L)
IF %ERRORLEVEL%==12 (SET D=M)
IF %ERRORLEVEL%==13 (SET D=N)
IF %ERRORLEVEL%==14 (SET D=O)
IF %ERRORLEVEL%==15 (SET D=P)
IF %ERRORLEVEL%==16 (SET D=Q)
IF %ERRORLEVEL%==17 (SET D=R)
IF %ERRORLEVEL%==18 (SET D=S)
IF %ERRORLEVEL%==19 (SET D=T)
IF %ERRORLEVEL%==20 (SET D=U)
IF %ERRORLEVEL%==21 (SET D=V)
IF %ERRORLEVEL%==22 (SET D=W)
IF %ERRORLEVEL%==23 (SET D=X)
IF %ERRORLEVEL%==24 (SET D=Y)
IF %ERRORLEVEL%==25 (SET D=Z)
SET D=%D%:
ECHO %D%
CLS
GOTO %C%

:1
IF NOT EXIST "%COMSPEC:~0,-7%CHKDSK.EXE" (SET E=chkdsk.exe&GOTO E)
ECHO 可用的模式如下：
ECHO   0=重新选择磁盘
ECHO   1=只读模式
ECHO   2=修复模式
ECHO   3=卸卷模式（推荐使用）
ECHO   4=深入不卸卷模式
ECHO   5=卸卷深入模式
ECHO 请选择一种模式检查%D:~0,-1%盘：
CHOICE /C 123450
IF %ERRORLEVEL%==1 (SET OP=)
IF %ERRORLEVEL%==2 (SET OP=/F)
IF %ERRORLEVEL%==3 (SET OP=/X)
IF %ERRORLEVEL%==4 (SET OP=/R)
IF %ERRORLEVEL%==5 (SET OP=/X /R)
IF %ERRORLEVEL%==6 (GOTO MAIN)
CLS
TITLE 正在按要求检查磁盘%D%，请稍候...
CHKDSK %OP% %D%
GOTO 7

:2
CLS
IF NOT EXIST "%COMSPEC:~0,-7%CONVERT.EXE" (SET E=convert.exe&GOTO E)
ECHO 可调整的参数如下：
ECHO   0=重新选择磁盘
IF %X%==0 (ECHO   1=启用卸卷模式（当前已禁用卸卷模式）) ELSE (ECHO   1=禁用卸卷模式（当前已启用卸卷模式）)
IF %V%==0 (ECHO   2=启用详细模式（当前已禁用详细模式）) ELSE (ECHO   2=禁用详细模式（当前已启用详细模式）)
IF %N%==0 (ECHO   3=启用共享模式（当前已禁用共享模式）) ELSE (ECHO   3=禁用共享模式（当前已启用共享模式）)
ECHO   4=执行操作
ECHO 请选择一项以将%D%转换为NTFS格式：
CHOICE /C 12340
IF %ERRORLEVEL%==1 (IF %X%==0 (SET X=1) ELSE (SET X=0))
IF %ERRORLEVEL%==2 (IF %V%==0 (SET V=1) ELSE (SET V=0))
IF %ERRORLEVEL%==3 (IF %N%==0 (SET N=1) ELSE (SET N=0))
IF %ERRORLEVEL%==4 (GOTO 6)
IF %ERRORLEVEL%==5 (GOTO MAIN)
GOTO 2

:3
IF NOT EXIST "%COMSPEC:~0,-7%FORMAT.COM" (SET E=format.com&GOTO E)
ECHO 您已选定%D%。
ECHO   0=重新选择磁盘
ECHO   1=NTFS（力荐）
ECHO   2=FAT
ECHO   3=FAT32
ECHO 请选择一种文件系统：
CHOICE /C 1230
IF %ERRORLEVEL%==1 (SET OP=NTFS)
IF %ERRORLEVEL%==2 (SET OP=FAT)
IF %ERRORLEVEL%==3 (SET OP=FAT32)
IF %ERRORLEVEL%==4 (GOTO MAIN)
ECHO 是否快速格式化？
CHOICE /C YN
IF %ERRORLEVEL%==1 (SET OP=%OP% /Q)
ECHO 是否强制格式化？
CHOICE /C YN
IF %ERRORLEVEL%==1 (SET OP=%OP% /X)
CLS
FOR /F "TOKENS=3 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
ECHO 警告：1．程序将会格式化%D:~0,-1%盘，所有数据将流失且无法恢复；
ECHO       2．若造成数据丢失或其它经济纠纷，本公司概不负责；
ECHO       3．专业格式化硬盘，推荐使用DiskGenius硬盘分区工具；
ECHO       4．出于安全考虑，如需继续格式化，请您手动输入卷标。
IF /I NOT %W%==0 (FOR /F "SKIP=1" %%I IN ('WMIC LOGICALDISK WHERE CAPTION^="%D%" GET CAPTION,VOLUMENAME') DO (ECHO 系统检测到%D:~0,-1%盘的卷标为“%%I”。))
TITLE 正在按要求格式化%D%，请稍候...
FORMAT /FS:%OP% %D%
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
GOTO 7

:4
IF NOT EXIST "%COMSPEC:~0,-7%LABEL.EXE" (SET E=label.exe&GOTO E)
IF %W%==1 (FOR /F "SKIP=1" %%I IN ('WMIC LOGICALDISK WHERE CAPTION^="%D%" GET CAPTION,VOLUMENAME') DO (ECHO 系统检测到%D:~0,-1%盘的卷标为“%%I”。))
ECHO 请输入%D%的卷标并回车：
SET /P L=
LABEL %D% %L%
GOTO 7

:5
TITLE 正在对%D%进行碎片整理，请稍候...
CLS
DEFRAG /F %D%
GOTO 7

:6
TITLE 正在将%D%转换为NTFS格式，请稍候...
CLS
IF %X%==0 (SET X=) ELSE (SET X= /X)
IF %V%==0 (SET V=) ELSE (SET V= /V)
IF %N%==0 (SET N=) ELSE (SET N= /NOSECURITY)
CONVERT %D%%X%%V%%N% /FS:NTFS
PAUSE
GOTO M

:7
ECHO 执行操作完毕，请按任意键返回主面板。
PAUSE>NUL
GOTO M

:E
ECHO 丢失系统文件%E%，无法使用此功能。
PAUSE
GOTO M