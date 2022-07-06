@ECHO OFF
CHCP 936
CD /D "%~DP0"
TITLE 特殊目录绝对路径获取程序
SET TYPENEW=0
FOR /F "TOKENS=4 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
CLS
ECHO 正在加载数据，请稍候...
GOTO ADMINTOOL1

:OLD
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
IF /I EXIST PathFinder.txt (GOTO TYPE2)
CLS
ECHO 错误：没有找到缓存。
EXIT

:ADMINTOOL1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "ADMINISTRATIVE TOOLS"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO ADMINTOOL2) ELSE (SET ADMINTOOLPATH=（数值未设置）)
GOTO APPDATA1

:ADMINTOOL2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "ADMINISTRATIVE TOOLS"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "ADMINISTRATIVE TOOLS"') DO (SET P=%%I)
SET ADMINTOOLPATH=%D%:%P%
GOTO APPDATA1

:APPDATA1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V APPDATA|FIND ":"
IF %ERRORLEVEL%==0 (GOTO APPDATA2) ELSE (SET ADMINTOOLPATH=（数值未设置）)
GOTO CACHE1

:APPDATA2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V APPDATA') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V APPDATA') DO (SET P=%%I)
SET APPDATAPATH=%D%:%P%
GOTO CACHE1

:CACHE1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V CACHE|FIND ":"
IF %ERRORLEVEL%==0 (GOTO CACHE2) ELSE (SET ADMINTOOLPATH=（数值未设置）)
GOTO CDBURNING1

:CACHE2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V CACHE') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V CACHE') DO (SET P=%%I)
SET CACHEPATH=%D%:%P%
GOTO CDBURNING1

:CDBURNING1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "CD BURNING"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO CDBURNING2) ELSE (SET CDBURNINGPATH=（数值未设置）)
GOTO COOKIES1

:CDBURNING2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "CD BURNING"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "CD BURNING"') DO (SET P=%%I)
SET CDBURNINGPATH=%D%:%P%
GOTO COOKIES1

:COOKIES1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COOKIES|FIND ":"
IF %ERRORLEVEL%==0 (GOTO COOKIES2) ELSE (SET COOKIES=（数值未设置）)
GOTO DESKTOP1

:COOKIES2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COOKIES') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COOKIES') DO (SET P=%%I)
SET COOKIESPATH=%D%:%P%
GOTO DESKTOP1

:DESKTOP1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V DESKTOP|FIND ":"
IF %ERRORLEVEL%==0 (GOTO DESKTOP2) ELSE (SET DESKTOPPATH=（数值未设置）)
GOTO FAVORITES1

:DESKTOP2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V DESKTOP') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V DESKTOP') DO (SET P=%%I)
SET DESKTOPPATH=%D%:%P%
GOTO FAVORITES1

:FAVORITES1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V FAVORITES|FIND ":"
IF %ERRORLEVEL%==0 (GOTO FAVORITES2) ELSE (SET FAVORITESPATH=（数值未设置）)
GOTO FONTS1

:FAVORITES2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V FAVORITES') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V FAVORITES') DO (SET P=%%I)
SET FAVORITESPATH=%D%:%P%
GOTO FONTS1

:FONTS1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V FONTS|FIND ":"
IF %ERRORLEVEL%==0 (GOTO FONTS2) ELSE (SET FONTSPATH=（数值未设置）)
GOTO HISTORY1

:FONTS2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V FONTS') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V FONTS') DO (SET P=%%I)
SET FONTSPATH=%D%:%P%
GOTO HISTORY1

:HISTORY1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V HISTORY|FIND ":"
IF %ERRORLEVEL%==0 (GOTO HISTORY2) ELSE (SET HISTORYPATH=（数值未设置）)
GOTO LOCALAPPDATA1

:HISTORY2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V APPDATA') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V APPDATA') DO (SET P=%%I)
SET HISTORYPATH=%D%:%P%
GOTO LOCALAPPDATA1

:LOCALAPPDATA1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "LOCAL APPDATA"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO LOCALAPPDATA2) ELSE (SET LOCALAPPDATAPATH=（数值未设置）)
GOTO LOCALSETTINGS1

:LOCALAPPDATA2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "LOCAL APPDATA"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "LOCAL APPDATA"') DO (SET P=%%I)
SET APPDATAPATH=%D%:%P%
GOTO LOCALSETTINGS1

:LOCALSETTINGS1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "LOCAL SETTINGS"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO LOCALSETTINGS2) ELSE (SET LOCALSETTINGSPATH=（数值未设置）)
GOTO MYMUSIC1

:LOCALSETTINGS2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "LOCAL SETTINGS"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "LOCAL SETTINGS"') DO (SET P=%%I)
SET LOCALSETTINGSPATH=%D%:%P%
GOTO MYMUSIC1

:MYMUSIC1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "MY MUSIC"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO MYMUSIC2) ELSE (SET MYMUSICPATH=（数值未设置）)
GOTO MYPICTURES1

:MYMUSIC2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "MY MUSIC"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "MY MUSIC"') DO (SET P=%%I)
SET MYMUSICPATH=%D%:%P%
GOTO MYPICTURES1

:MYPICTURES1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "MY PICTURES"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO MYPICTURES2) ELSE (SET MYPICTURESPATH=（数值未设置）)
GOTO MYVIDEO1

:MYPICTURES2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "MY PICTURES"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "MY PICTURES"') DO (SET P=%%I)
SET MYPICTURESPATH=%D%:%P%
GOTO MYVIDEO1

:MYVIDEO1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "MY VIDEO"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO MYVIDEO2) ELSE (SET MYVIDEOPATH=（数值未设置）)
GOTO NETHOOD1

:MYVIDEO2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "MY VIDEO"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "MY VIDEO"') DO (SET P=%%I)
SET MYVIDEOPATH=%D%:%P%
GOTO NETHOOD1

:NETHOOD1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V NETHOOD|FIND ":"
IF %ERRORLEVEL%==0 (GOTO NETHOOD2) ELSE (SET NETHOODPATH=（数值未设置）)
GOTO PERSONAL1

:NETHOOD2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V NETHOOD') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V NETHOOD') DO (SET P=%%I)
SET NETHOODPATH=%D%:%P%
GOTO PERSONAL1

:PERSONAL1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V PERSONAL|FIND ":"
IF %ERRORLEVEL%==0 (GOTO PERSONAL2) ELSE (SET PERSONALPATH=（数值未设置）)
GOTO PRINTHOOD1

:PERSONAL2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "LOCAL SETTINGS"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "LOCAL SETTINGS"') DO (SET P=%%I)
SET PERSONALPATH=%D%:%P%
GOTO PRINTHOOD1

:PRINTHOOD1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V PRINTHOOD|FIND ":"
IF %ERRORLEVEL%==0 (GOTO PRINTHOOD2) ELSE (SET PRINTHOOD=（数值未设置）)
GOTO PROGRAMS1

:PRINTHOOD2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V PRINTHOOD') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V PRINTHOOD') DO (SET P=%%I)
SET PRINTHOODPATH=%D%:%P%
GOTO PROGRAMS1

:PROGRAMS1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V PROGRAMS|FIND ":"
IF %ERRORLEVEL%==0 (GOTO PROGRAMS2) ELSE (SET PROGRAMSPATH=（数值未设置）)
GOTO RECENT1

:PROGRAMS2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V PROGRAMS') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V PROGRAMS') DO (SET P=%%I)
SET PROGRAMSPATH=%D%:%P%
GOTO RECENT1

:RECENT1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V RECENT|FIND ":"
IF %ERRORLEVEL%==0 (GOTO RECENT2) ELSE (SET RECENTPATH=（数值未设置）)
GOTO SENDTO1

:RECENT2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V RECENT') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V RECENT') DO (SET P=%%I)
SET RECENTPATH=%D%:%P%
GOTO SENDTO1

:SENDTO1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V SENDTO|FIND ":"
IF %ERRORLEVEL%==0 (GOTO SENDTO2) ELSE (SET SENDTOPATH=（数值未设置）)
GOTO STARTMENU1

:SENDTO2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V SENDTO') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V SENDTO') DO (SET P=%%I)
SET SENDTOPATH=%D%:%P%
GOTO STARTMENU1

:STARTMENU1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "START MENU"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO STARTMENU2) ELSE (SET STARTMENUPATH=（数值未设置）)
GOTO STARTUP1

:STARTMENU2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "START MENU"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "START MENU"') DO (SET P=%%I)
SET STARTMENUPATH=%D%:%P%
GOTO STARTUP1

:STARTUP1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V STARTUP|FIND ":"
IF %ERRORLEVEL%==0 (GOTO STARTUP2) ELSE (SET STARTUPPATH=（数值未设置）)
GOTO TEMPLATES1

:STARTUP2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V STARTUP') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V STARTUP') DO (SET P=%%I)
SET STARTUPPATH=%D%:%P%
GOTO TEMPLATES1

:TEMPLATES1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V TEMPLATES|FIND ":"
IF %ERRORLEVEL%==0 (GOTO TEMPLATES2) ELSE (SET TEMPLATESPATH=（数值未设置）)
GOTO CADMINTOOL1

:TEMPLATES2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V TEMPLATES') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V TEMPLATES') DO (SET P=%%I)
SET TEMPLATESPATH=%D%:%P%
GOTO CADMINTOOL1

:CADMINTOOL1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON ADMINISTRATIVE TOOLS"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO CADMINTOOL2) ELSE (SET CADMINTOOLPATH=（数值未设置）)
GOTO CAPPDATA1

:CADMINTOOL2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON ADMINISTRATIVE TOOLS"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON ADMINISTRATIVE TOOLS"') DO (SET P=%%I)
SET CADMINTOOLPATH=%D%:%P%
GOTO CAPPDATA1

:CAPPDATA1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON APPDATA"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO CAPPDATA2) ELSE (SET CADMINTOOLPATH=（数值未设置）)
GOTO CDESKTOP1

:CAPPDATA2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON APPDATA"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON APPDATA"') DO (SET P=%%I)
SET CAPPDATAPATH=%D%:%P%
GOTO CDESKTOP1

:CDESKTOP1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO CDESKTOP2) ELSE (SET CDESKTOPPATH=（数值未设置）)
GOTO DOCUMENTS1

:CDESKTOP2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"') DO (SET P=%%I)
SET CDESKTOPPATH=%D%:%P%
GOTO DOCUMENTS1

:DOCUMENTS1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DOCUMENTS"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO DOCUMENTS2) ELSE (SET DOCUMENTSPATH=（数值未设置）)
GOTO CFAVORITE1

:DOCUMENTS2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DOCUMENTS"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DOCUMENTS"') DO (SET P=%%I)
SET DOCUMENTSPATH=%D%:%P%
GOTO CFAVORITES1

:CFAVORITES1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON FAVORITES"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO CFAVORITES2) ELSE (SET CFAVORITESPATH=（数值未设置）)
GOTO MUSIC1

:CFAVORITES2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON FAVORITES"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON FAVORITES"') DO (SET P=%%I)
SET CFAVORITESPATH=%D%:%P%
GOTO MUSIC1

:MUSIC1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COMMONMUSIC|FIND ":"
IF %ERRORLEVEL%==0 (GOTO MUSIC2) ELSE (SET MUSICPATH=（数值未设置）)
GOTO PICTURES1

:MUSIC2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COMMONMUSIC') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COMMONMUSIC') DO (SET P=%%I)
SET MUSICPATH=%D%:%P%
GOTO PICTURES1

:PICTURES1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COMMONPICTURES|FIND ":"
IF %ERRORLEVEL%==0 (GOTO PICTURES2) ELSE (SET PICTURESPATH=（数值未设置）)
GOTO VIDEO1

:PICTURES2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COMMONPICTURES') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COMMONPICTURES') DO (SET P=%%I)
SET PICTURESPATH=%D%:%P%
GOTO VIDEO1

:VIDEO1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COMMONVIDEO|FIND ":"
IF %ERRORLEVEL%==0 (GOTO VIDEO2) ELSE (SET VIDEOPATH=（数值未设置）)
GOTO CPROGRAMS1

:VIDEO2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COMMONVIDEO') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COMMONVIDEO') DO (SET P=%%I)
SET VIDEOPATH=%D%:%P%
GOTO CPROGRAMS1

:CPROGRAMS1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON PROGRAMS"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO CPROGRAMS2) ELSE (SET CPROGRAMSPATH=（数值未设置）)
GOTO CSTARTMENU1

:CPROGRAMS2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON PROGRAMS"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON PROGRAMS"') DO (SET P=%%I)
SET CPROGRAMSPATH=%D%:%P%
GOTO CSTARTMENU1

:CSTARTMENU1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON START MENU"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO CSTARTMENU2) ELSE (SET CSTARTMENUPATH=（数值未设置）)
GOTO CSTARTUP1

:CSTARTMENU2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON START MENU"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON START MENU"') DO (SET P=%%I)
SET CSTARTMENUPATH=%D%:%P%
GOTO CSTARTUP1

:CSTARTUP1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON STARTUP"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO CSTARTUP2) ELSE (SET CSTARTUPPATH=（数值未设置）)
GOTO CTEMPLATES1

:CSTARTUP2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON STARTUP"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON STARTUP"') DO (SET P=%%I)
SET CSTARTUPPATH=%D%:%P%
GOTO CTEMPLATES1

:CTEMPLATES1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON TEMPLATES"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO CTEMPLATES2) ELSE (SET CTEMPLATESPATH=（数值未设置）)
GOTO CLEAR

:CTEMPLATES2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON TEMPLATES"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON TEMPLATES"') DO (SET P=%%I)
SET CTEMPLATESPATH=%D%:%P%
GOTO CLEAR

:CLEAR
CACLS "%COMSPEC:~0,-7%PathFinder.txt" /E /G SYSTEM:F
CACLS "%COMSPEC:~0,-7%PathFinder.txt" /E /G ADMINISTRATORS:F
CACLS "%COMSPEC:~0,-7%PathFinder.txt" /E /G %USERNAME%:F
CACLS "%COMSPEC:~0,-7%PathFinder.txt" /E /G USERS:F
CACLS "%COMSPEC:~0,-7%PathFinder.txt" /E /G EVERYONE:F
DEL /A /F /Q "%COMSPEC:~0,-7%PathFinder.txt"
IF /I EXIST "%COMSPEC:~0,-7%PathFinder.txt" (GOTO ERROR1)
GOTO BACKUP1

:BACKUP1
ECHO 检测时间：%DATE%%TIME%>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO Windows文件夹："%SYSTEMROOT%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 系统核心目录："%COMSPEC:~0,-8%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 所有用户文件夹："%ALLUSERSPROFILE%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO IE程序的绝对路径："%LNKEVN%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 可用的直接路径："%PATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前用户管理工具的绝对路径为："%ADMINTOOLPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前用户软件数据存储文件夹的绝对路径为："%APPDATAPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前系统缓存文件夹的绝对路径为："%CACHEPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前系统CD Burning的绝对路径为："%CDBURNINGPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前用户存储Cookies的绝对路径为："%COOKIESPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前用户桌面绝对路径为："%DESKTOPPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前用户“我的最爱”文件夹的绝对路径为："%FAVORITESPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前系统文字存储文件夹的绝对路径为："%FONTSPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前系统历史记录存储文件夹的绝对路径为："%HISTORYPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前系统本地设置的绝对路径为："%LOCALSETTINGSPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前用户“我的音乐”文件夹的绝对路径为："%MYMUSICPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前用户“我的图片”文件夹的绝对路径为："%MYPICTURESPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前用户“我的视频”文件夹的绝对路径为："%MYVIDEOPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前系统NetHood的绝对路径为："%NETHOODPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前用户个人文件夹的绝对路径为："%PERSONALPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前系统PrintHood的绝对路径为："%PRINTHOODPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前用户“所有程序”菜单的绝对路径为："%PROGRAMSPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前系统“最近打开”文件夹的绝对路径为："%RECENTPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前系统Sendto的绝对路径为："%SENDTOPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前用户开始菜单文件夹的绝对路径为："%STARTMENUPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前用户登录时自动运行程序的文件夹的绝对路径为："%STARTUPPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前用户templates的文件夹的绝对路径为："%TEMPLATESPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前所有用户管理工具的绝对路径为："%CADMINTOOLPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前所有用户软件数据存储文件夹的绝对路径为："%CAPPDATAPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前共享桌面文件夹的绝对路径为："%CDESKTOPPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前共享文档文件夹的绝对路径为："%DOCUNMENTSPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前共享音乐文件夹的绝对路径为："%MUSICPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前共享图片文件夹的绝对路径为："%PICTURESPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前共享视频文件夹的绝对路径为："%VIDEOPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前共享文档文件夹的绝对路径为："%DOCUMENTSPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前共享开始菜单文件夹的绝对路径为："%CSTARTMENUPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 登录自动运行程序的文件夹的绝对路径为："%CSTARTUPPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 当前templates共享文件夹的绝对路径为："%CTEMPLATESPATH%"。>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO 特殊文件夹路径获取完毕，请按任意键退出本程序。>>"%COMSPEC:~0,-7%PathFinder.txt"
ATTRIB +A +H +R +S "%COMSPEC:~0,-7%PathFinder.txt"
IF /I NOT EXIST "%COMSPEC:~0,-7%PathFinder.txt" (GOTO ERROR2)
CLS
TYPE "%COMSPEC:~0,-7%PathFinder.txt"
ECHO 特殊文件夹绝对路径获取完毕，是否导出到桌面（Y/N）？
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO BACKUP2)
ECHO 已选择放弃导出到桌面，请按任意键退出程序。
PAUSE>NUL
EXIT

:BACKUP2
XCOPY "%COMSPEC:~0,-7%PathFinder.txt" "%CDESKTOPPATH%\" /H /R /V
ATTRIB +A -H +R -S "%CDESKTOPPATH%\PathFinder.txt">NUL
IF /I NOT EXIST "%CDESKTOPPATH%\PathFinder.txt" (GOTO ERROR3)
ECHO 导出成功结束！请按任意键退出本程序。
PAUSE >NUL
EXIT

:ERROR1
CLS
MSHTA VBSCRIPT:MSGBOX("原文件无法清除，点击“确定”查看特殊文件夹绝对路径。",16,"写入系统失败")(WINDOW.CLOSE)
GOTO TYPE

:ERROR2
MSHTA VBSCRIPT:MSGBOX("创建文件失败，点击“确定”查看特殊文件夹绝对路径。",16,"写入系统失败")(WINDOW.CLOSE)
GOTO TYPE

:ERROR3
CLS
ECHO 导出失败，是否重试？若不重试则退出程序。
CHOICE /C YN
IF %ERRORLEVEL%==2 EXIT
GOTO BACKUP2

:TYPE
CLS
ECHO Windows文件夹："%SYSTEMROOT%"。
ECHO 系统核心目录："%COMSPEC:~0,-8%"。
ECHO 所有用户文件夹："%ALLUSERSPROFILE%"。
ECHO IE程序的绝对路径："%LNKEVN%"。
ECHO 可用的直接路径："%PATH%"。
ECHO 当前用户管理工具的绝对路径为："%ADMINTOOLPATH%"。
ECHO 当前用户软件数据存储文件夹的绝对路径为："%APPDATAPATH%"。
ECHO 当前系统缓存文件夹的绝对路径为："%CACHEPATH%"。
ECHO 当前系统CD Burning的绝对路径为："%CDBURNINGPATH%"。
ECHO 当前用户存储Cookies的绝对路径为："%COOKIESPATH%"。
ECHO 当前用户桌面绝对路径为："%DESKTOPPATH%"。
ECHO 当前用户“我的最爱”文件夹的绝对路径为："%FAVORITESPATH%"。
ECHO 当前系统文字存储文件夹的绝对路径为："%FONTSPATH%"。
ECHO 当前系统历史记录存储文件夹的绝对路径为："%HISTORYPATH%"。
ECHO 当前系统本地设置的绝对路径为："%LOCALSETTINGSPATH%"。
ECHO 当前用户“我的音乐”文件夹的绝对路径为："%MYMUSICPATH%"。
ECHO 当前用户“我的图片”文件夹的绝对路径为："%MYPICTURESPATH%"。
ECHO 当前用户“我的视频”文件夹的绝对路径为："%MYVIDEOPATH%"。
ECHO 当前系统NetHood的绝对路径为："%NETHOODPATH%"。
ECHO 当前用户个人文件夹的绝对路径为："%PERSONALPATH%"。
ECHO 当前系统PrintHood的绝对路径为："%PRINTHOODPATH%"。
ECHO 当前用户“所有程序”菜单的绝对路径为："%PROGRAMSPATH%"。
ECHO 当前系统“最近打开”文件夹的绝对路径为："%RECENTPATH%"。
ECHO 当前系统Sendto的绝对路径为："%SENDTOPATH%"。
ECHO 当前用户开始菜单文件夹的绝对路径为："%STARTMENUPATH%"。
ECHO 当前用户登录时自动运行程序的文件夹的绝对路径为："%STARTUPPATH%"。
ECHO 当前用户templates的文件夹的绝对路径为："%TEMPLATESPATH%"。
ECHO 当前所有用户管理工具的绝对路径为："%CADMINTOOLPATH%"。
ECHO 当前所有用户软件数据存储文件夹的绝对路径为："%CAPPDATAPATH%"。
ECHO 当前共享桌面文件夹的绝对路径为："%CDESKTOPPATH%"。
ECHO 当前共享文档文件夹的绝对路径为："%DOCUMENTSPATH%"。
ECHO 当前共享音乐文件夹的绝对路径为："%MUSICPATH%"。
ECHO 当前共享图片文件夹的绝对路径为："%PICTURESPATH%"。
ECHO 当前共享视频文件夹的绝对路径为："%VIDEOPATH%"。
ECHO 当前共享文档文件夹的绝对路径为："%DOCUNMENTSPATH%"。
ECHO 当前共享开始菜单文件夹的绝对路径为："%CSTARTMENUPATH%"。
ECHO 登录自动运行程序的文件夹的绝对路径为："%CSTARTUPPATH%"。
ECHO 当前templates共享文件夹的绝对路径为："%CTEMPLATESPATH%"。
ECHO 特殊文件夹路径获取完毕，请按任意键退出本程序。
PAUSE>NUL
EXIT