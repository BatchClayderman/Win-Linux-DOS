@ECHO OFF
CHCP 936
CD /D "%~DP0"
TITLE ����Ŀ¼����·����ȡ����
SET TYPENEW=0
FOR /F "TOKENS=4 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
CLS
ECHO ���ڼ������ݣ����Ժ�...
GOTO ADMINTOOL1

:OLD
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
IF /I EXIST PathFinder.txt (GOTO TYPE2)
CLS
ECHO ����û���ҵ����档
EXIT

:ADMINTOOL1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "ADMINISTRATIVE TOOLS"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO ADMINTOOL2) ELSE (SET ADMINTOOLPATH=����ֵδ���ã�)
GOTO APPDATA1

:ADMINTOOL2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "ADMINISTRATIVE TOOLS"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "ADMINISTRATIVE TOOLS"') DO (SET P=%%I)
SET ADMINTOOLPATH=%D%:%P%
GOTO APPDATA1

:APPDATA1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V APPDATA|FIND ":"
IF %ERRORLEVEL%==0 (GOTO APPDATA2) ELSE (SET ADMINTOOLPATH=����ֵδ���ã�)
GOTO CACHE1

:APPDATA2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V APPDATA') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V APPDATA') DO (SET P=%%I)
SET APPDATAPATH=%D%:%P%
GOTO CACHE1

:CACHE1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V CACHE|FIND ":"
IF %ERRORLEVEL%==0 (GOTO CACHE2) ELSE (SET ADMINTOOLPATH=����ֵδ���ã�)
GOTO CDBURNING1

:CACHE2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V CACHE') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V CACHE') DO (SET P=%%I)
SET CACHEPATH=%D%:%P%
GOTO CDBURNING1

:CDBURNING1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "CD BURNING"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO CDBURNING2) ELSE (SET CDBURNINGPATH=����ֵδ���ã�)
GOTO COOKIES1

:CDBURNING2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "CD BURNING"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "CD BURNING"') DO (SET P=%%I)
SET CDBURNINGPATH=%D%:%P%
GOTO COOKIES1

:COOKIES1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COOKIES|FIND ":"
IF %ERRORLEVEL%==0 (GOTO COOKIES2) ELSE (SET COOKIES=����ֵδ���ã�)
GOTO DESKTOP1

:COOKIES2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COOKIES') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COOKIES') DO (SET P=%%I)
SET COOKIESPATH=%D%:%P%
GOTO DESKTOP1

:DESKTOP1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V DESKTOP|FIND ":"
IF %ERRORLEVEL%==0 (GOTO DESKTOP2) ELSE (SET DESKTOPPATH=����ֵδ���ã�)
GOTO FAVORITES1

:DESKTOP2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V DESKTOP') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V DESKTOP') DO (SET P=%%I)
SET DESKTOPPATH=%D%:%P%
GOTO FAVORITES1

:FAVORITES1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V FAVORITES|FIND ":"
IF %ERRORLEVEL%==0 (GOTO FAVORITES2) ELSE (SET FAVORITESPATH=����ֵδ���ã�)
GOTO FONTS1

:FAVORITES2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V FAVORITES') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V FAVORITES') DO (SET P=%%I)
SET FAVORITESPATH=%D%:%P%
GOTO FONTS1

:FONTS1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V FONTS|FIND ":"
IF %ERRORLEVEL%==0 (GOTO FONTS2) ELSE (SET FONTSPATH=����ֵδ���ã�)
GOTO HISTORY1

:FONTS2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V FONTS') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V FONTS') DO (SET P=%%I)
SET FONTSPATH=%D%:%P%
GOTO HISTORY1

:HISTORY1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V HISTORY|FIND ":"
IF %ERRORLEVEL%==0 (GOTO HISTORY2) ELSE (SET HISTORYPATH=����ֵδ���ã�)
GOTO LOCALAPPDATA1

:HISTORY2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V APPDATA') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V APPDATA') DO (SET P=%%I)
SET HISTORYPATH=%D%:%P%
GOTO LOCALAPPDATA1

:LOCALAPPDATA1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "LOCAL APPDATA"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO LOCALAPPDATA2) ELSE (SET LOCALAPPDATAPATH=����ֵδ���ã�)
GOTO LOCALSETTINGS1

:LOCALAPPDATA2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "LOCAL APPDATA"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "LOCAL APPDATA"') DO (SET P=%%I)
SET APPDATAPATH=%D%:%P%
GOTO LOCALSETTINGS1

:LOCALSETTINGS1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "LOCAL SETTINGS"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO LOCALSETTINGS2) ELSE (SET LOCALSETTINGSPATH=����ֵδ���ã�)
GOTO MYMUSIC1

:LOCALSETTINGS2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "LOCAL SETTINGS"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "LOCAL SETTINGS"') DO (SET P=%%I)
SET LOCALSETTINGSPATH=%D%:%P%
GOTO MYMUSIC1

:MYMUSIC1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "MY MUSIC"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO MYMUSIC2) ELSE (SET MYMUSICPATH=����ֵδ���ã�)
GOTO MYPICTURES1

:MYMUSIC2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "MY MUSIC"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "MY MUSIC"') DO (SET P=%%I)
SET MYMUSICPATH=%D%:%P%
GOTO MYPICTURES1

:MYPICTURES1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "MY PICTURES"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO MYPICTURES2) ELSE (SET MYPICTURESPATH=����ֵδ���ã�)
GOTO MYVIDEO1

:MYPICTURES2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "MY PICTURES"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "MY PICTURES"') DO (SET P=%%I)
SET MYPICTURESPATH=%D%:%P%
GOTO MYVIDEO1

:MYVIDEO1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "MY VIDEO"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO MYVIDEO2) ELSE (SET MYVIDEOPATH=����ֵδ���ã�)
GOTO NETHOOD1

:MYVIDEO2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "MY VIDEO"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "MY VIDEO"') DO (SET P=%%I)
SET MYVIDEOPATH=%D%:%P%
GOTO NETHOOD1

:NETHOOD1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V NETHOOD|FIND ":"
IF %ERRORLEVEL%==0 (GOTO NETHOOD2) ELSE (SET NETHOODPATH=����ֵδ���ã�)
GOTO PERSONAL1

:NETHOOD2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V NETHOOD') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V NETHOOD') DO (SET P=%%I)
SET NETHOODPATH=%D%:%P%
GOTO PERSONAL1

:PERSONAL1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V PERSONAL|FIND ":"
IF %ERRORLEVEL%==0 (GOTO PERSONAL2) ELSE (SET PERSONALPATH=����ֵδ���ã�)
GOTO PRINTHOOD1

:PERSONAL2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "LOCAL SETTINGS"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "LOCAL SETTINGS"') DO (SET P=%%I)
SET PERSONALPATH=%D%:%P%
GOTO PRINTHOOD1

:PRINTHOOD1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V PRINTHOOD|FIND ":"
IF %ERRORLEVEL%==0 (GOTO PRINTHOOD2) ELSE (SET PRINTHOOD=����ֵδ���ã�)
GOTO PROGRAMS1

:PRINTHOOD2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V PRINTHOOD') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V PRINTHOOD') DO (SET P=%%I)
SET PRINTHOODPATH=%D%:%P%
GOTO PROGRAMS1

:PROGRAMS1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V PROGRAMS|FIND ":"
IF %ERRORLEVEL%==0 (GOTO PROGRAMS2) ELSE (SET PROGRAMSPATH=����ֵδ���ã�)
GOTO RECENT1

:PROGRAMS2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V PROGRAMS') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V PROGRAMS') DO (SET P=%%I)
SET PROGRAMSPATH=%D%:%P%
GOTO RECENT1

:RECENT1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V RECENT|FIND ":"
IF %ERRORLEVEL%==0 (GOTO RECENT2) ELSE (SET RECENTPATH=����ֵδ���ã�)
GOTO SENDTO1

:RECENT2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V RECENT') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V RECENT') DO (SET P=%%I)
SET RECENTPATH=%D%:%P%
GOTO SENDTO1

:SENDTO1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V SENDTO|FIND ":"
IF %ERRORLEVEL%==0 (GOTO SENDTO2) ELSE (SET SENDTOPATH=����ֵδ���ã�)
GOTO STARTMENU1

:SENDTO2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V SENDTO') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V SENDTO') DO (SET P=%%I)
SET SENDTOPATH=%D%:%P%
GOTO STARTMENU1

:STARTMENU1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "START MENU"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO STARTMENU2) ELSE (SET STARTMENUPATH=����ֵδ���ã�)
GOTO STARTUP1

:STARTMENU2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "START MENU"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "START MENU"') DO (SET P=%%I)
SET STARTMENUPATH=%D%:%P%
GOTO STARTUP1

:STARTUP1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V STARTUP|FIND ":"
IF %ERRORLEVEL%==0 (GOTO STARTUP2) ELSE (SET STARTUPPATH=����ֵδ���ã�)
GOTO TEMPLATES1

:STARTUP2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V STARTUP') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V STARTUP') DO (SET P=%%I)
SET STARTUPPATH=%D%:%P%
GOTO TEMPLATES1

:TEMPLATES1
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V TEMPLATES|FIND ":"
IF %ERRORLEVEL%==0 (GOTO TEMPLATES2) ELSE (SET TEMPLATESPATH=����ֵδ���ã�)
GOTO CADMINTOOL1

:TEMPLATES2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V TEMPLATES') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V TEMPLATES') DO (SET P=%%I)
SET TEMPLATESPATH=%D%:%P%
GOTO CADMINTOOL1

:CADMINTOOL1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON ADMINISTRATIVE TOOLS"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO CADMINTOOL2) ELSE (SET CADMINTOOLPATH=����ֵδ���ã�)
GOTO CAPPDATA1

:CADMINTOOL2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON ADMINISTRATIVE TOOLS"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON ADMINISTRATIVE TOOLS"') DO (SET P=%%I)
SET CADMINTOOLPATH=%D%:%P%
GOTO CAPPDATA1

:CAPPDATA1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON APPDATA"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO CAPPDATA2) ELSE (SET CADMINTOOLPATH=����ֵδ���ã�)
GOTO CDESKTOP1

:CAPPDATA2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON APPDATA"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON APPDATA"') DO (SET P=%%I)
SET CAPPDATAPATH=%D%:%P%
GOTO CDESKTOP1

:CDESKTOP1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO CDESKTOP2) ELSE (SET CDESKTOPPATH=����ֵδ���ã�)
GOTO DOCUMENTS1

:CDESKTOP2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"') DO (SET P=%%I)
SET CDESKTOPPATH=%D%:%P%
GOTO DOCUMENTS1

:DOCUMENTS1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DOCUMENTS"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO DOCUMENTS2) ELSE (SET DOCUMENTSPATH=����ֵδ���ã�)
GOTO CFAVORITE1

:DOCUMENTS2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DOCUMENTS"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DOCUMENTS"') DO (SET P=%%I)
SET DOCUMENTSPATH=%D%:%P%
GOTO CFAVORITES1

:CFAVORITES1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON FAVORITES"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO CFAVORITES2) ELSE (SET CFAVORITESPATH=����ֵδ���ã�)
GOTO MUSIC1

:CFAVORITES2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON FAVORITES"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON FAVORITES"') DO (SET P=%%I)
SET CFAVORITESPATH=%D%:%P%
GOTO MUSIC1

:MUSIC1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COMMONMUSIC|FIND ":"
IF %ERRORLEVEL%==0 (GOTO MUSIC2) ELSE (SET MUSICPATH=����ֵδ���ã�)
GOTO PICTURES1

:MUSIC2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COMMONMUSIC') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COMMONMUSIC') DO (SET P=%%I)
SET MUSICPATH=%D%:%P%
GOTO PICTURES1

:PICTURES1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COMMONPICTURES|FIND ":"
IF %ERRORLEVEL%==0 (GOTO PICTURES2) ELSE (SET PICTURESPATH=����ֵδ���ã�)
GOTO VIDEO1

:PICTURES2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COMMONPICTURES') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COMMONPICTURES') DO (SET P=%%I)
SET PICTURESPATH=%D%:%P%
GOTO VIDEO1

:VIDEO1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COMMONVIDEO|FIND ":"
IF %ERRORLEVEL%==0 (GOTO VIDEO2) ELSE (SET VIDEOPATH=����ֵδ���ã�)
GOTO CPROGRAMS1

:VIDEO2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COMMONVIDEO') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V COMMONVIDEO') DO (SET P=%%I)
SET VIDEOPATH=%D%:%P%
GOTO CPROGRAMS1

:CPROGRAMS1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON PROGRAMS"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO CPROGRAMS2) ELSE (SET CPROGRAMSPATH=����ֵδ���ã�)
GOTO CSTARTMENU1

:CPROGRAMS2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON PROGRAMS"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON PROGRAMS"') DO (SET P=%%I)
SET CPROGRAMSPATH=%D%:%P%
GOTO CSTARTMENU1

:CSTARTMENU1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON START MENU"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO CSTARTMENU2) ELSE (SET CSTARTMENUPATH=����ֵδ���ã�)
GOTO CSTARTUP1

:CSTARTMENU2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON START MENU"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON START MENU"') DO (SET P=%%I)
SET CSTARTMENUPATH=%D%:%P%
GOTO CSTARTUP1

:CSTARTUP1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON STARTUP"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO CSTARTUP2) ELSE (SET CSTARTUPPATH=����ֵδ���ã�)
GOTO CTEMPLATES1

:CSTARTUP2
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON STARTUP"') DO (SET D=%%I)
SET D=%D:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON STARTUP"') DO (SET P=%%I)
SET CSTARTUPPATH=%D%:%P%
GOTO CTEMPLATES1

:CTEMPLATES1
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON TEMPLATES"|FIND ":"
IF %ERRORLEVEL%==0 (GOTO CTEMPLATES2) ELSE (SET CTEMPLATESPATH=����ֵδ���ã�)
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
ECHO ���ʱ�䣺%DATE%%TIME%>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO Windows�ļ��У�"%SYSTEMROOT%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ϵͳ����Ŀ¼��"%COMSPEC:~0,-8%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO �����û��ļ��У�"%ALLUSERSPROFILE%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO IE����ľ���·����"%LNKEVN%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ���õ�ֱ��·����"%PATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰ�û������ߵľ���·��Ϊ��"%ADMINTOOLPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰ�û�������ݴ洢�ļ��еľ���·��Ϊ��"%APPDATAPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰϵͳ�����ļ��еľ���·��Ϊ��"%CACHEPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰϵͳCD Burning�ľ���·��Ϊ��"%CDBURNINGPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰ�û��洢Cookies�ľ���·��Ϊ��"%COOKIESPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰ�û��������·��Ϊ��"%DESKTOPPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰ�û����ҵ�����ļ��еľ���·��Ϊ��"%FAVORITESPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰϵͳ���ִ洢�ļ��еľ���·��Ϊ��"%FONTSPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰϵͳ��ʷ��¼�洢�ļ��еľ���·��Ϊ��"%HISTORYPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰϵͳ�������õľ���·��Ϊ��"%LOCALSETTINGSPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰ�û����ҵ����֡��ļ��еľ���·��Ϊ��"%MYMUSICPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰ�û����ҵ�ͼƬ���ļ��еľ���·��Ϊ��"%MYPICTURESPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰ�û����ҵ���Ƶ���ļ��еľ���·��Ϊ��"%MYVIDEOPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰϵͳNetHood�ľ���·��Ϊ��"%NETHOODPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰ�û������ļ��еľ���·��Ϊ��"%PERSONALPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰϵͳPrintHood�ľ���·��Ϊ��"%PRINTHOODPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰ�û������г��򡱲˵��ľ���·��Ϊ��"%PROGRAMSPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰϵͳ������򿪡��ļ��еľ���·��Ϊ��"%RECENTPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰϵͳSendto�ľ���·��Ϊ��"%SENDTOPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰ�û���ʼ�˵��ļ��еľ���·��Ϊ��"%STARTMENUPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰ�û���¼ʱ�Զ����г�����ļ��еľ���·��Ϊ��"%STARTUPPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰ�û�templates���ļ��еľ���·��Ϊ��"%TEMPLATESPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰ�����û������ߵľ���·��Ϊ��"%CADMINTOOLPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰ�����û�������ݴ洢�ļ��еľ���·��Ϊ��"%CAPPDATAPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰ���������ļ��еľ���·��Ϊ��"%CDESKTOPPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰ�����ĵ��ļ��еľ���·��Ϊ��"%DOCUNMENTSPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰ���������ļ��еľ���·��Ϊ��"%MUSICPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰ����ͼƬ�ļ��еľ���·��Ϊ��"%PICTURESPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰ������Ƶ�ļ��еľ���·��Ϊ��"%VIDEOPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰ�����ĵ��ļ��еľ���·��Ϊ��"%DOCUMENTSPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰ����ʼ�˵��ļ��еľ���·��Ϊ��"%CSTARTMENUPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��¼�Զ����г�����ļ��еľ���·��Ϊ��"%CSTARTUPPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO ��ǰtemplates�����ļ��еľ���·��Ϊ��"%CTEMPLATESPATH%"��>>"%COMSPEC:~0,-7%PathFinder.txt"
ECHO �����ļ���·����ȡ��ϣ��밴������˳�������>>"%COMSPEC:~0,-7%PathFinder.txt"
ATTRIB +A +H +R +S "%COMSPEC:~0,-7%PathFinder.txt"
IF /I NOT EXIST "%COMSPEC:~0,-7%PathFinder.txt" (GOTO ERROR2)
CLS
TYPE "%COMSPEC:~0,-7%PathFinder.txt"
ECHO �����ļ��о���·����ȡ��ϣ��Ƿ񵼳������棨Y/N����
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO BACKUP2)
ECHO ��ѡ��������������棬�밴������˳�����
PAUSE>NUL
EXIT

:BACKUP2
XCOPY "%COMSPEC:~0,-7%PathFinder.txt" "%CDESKTOPPATH%\" /H /R /V
ATTRIB +A -H +R -S "%CDESKTOPPATH%\PathFinder.txt">NUL
IF /I NOT EXIST "%CDESKTOPPATH%\PathFinder.txt" (GOTO ERROR3)
ECHO �����ɹ��������밴������˳�������
PAUSE >NUL
EXIT

:ERROR1
CLS
MSHTA VBSCRIPT:MSGBOX("ԭ�ļ��޷�����������ȷ�����鿴�����ļ��о���·����",16,"д��ϵͳʧ��")(WINDOW.CLOSE)
GOTO TYPE

:ERROR2
MSHTA VBSCRIPT:MSGBOX("�����ļ�ʧ�ܣ������ȷ�����鿴�����ļ��о���·����",16,"д��ϵͳʧ��")(WINDOW.CLOSE)
GOTO TYPE

:ERROR3
CLS
ECHO ����ʧ�ܣ��Ƿ����ԣ������������˳�����
CHOICE /C YN
IF %ERRORLEVEL%==2 EXIT
GOTO BACKUP2

:TYPE
CLS
ECHO Windows�ļ��У�"%SYSTEMROOT%"��
ECHO ϵͳ����Ŀ¼��"%COMSPEC:~0,-8%"��
ECHO �����û��ļ��У�"%ALLUSERSPROFILE%"��
ECHO IE����ľ���·����"%LNKEVN%"��
ECHO ���õ�ֱ��·����"%PATH%"��
ECHO ��ǰ�û������ߵľ���·��Ϊ��"%ADMINTOOLPATH%"��
ECHO ��ǰ�û�������ݴ洢�ļ��еľ���·��Ϊ��"%APPDATAPATH%"��
ECHO ��ǰϵͳ�����ļ��еľ���·��Ϊ��"%CACHEPATH%"��
ECHO ��ǰϵͳCD Burning�ľ���·��Ϊ��"%CDBURNINGPATH%"��
ECHO ��ǰ�û��洢Cookies�ľ���·��Ϊ��"%COOKIESPATH%"��
ECHO ��ǰ�û��������·��Ϊ��"%DESKTOPPATH%"��
ECHO ��ǰ�û����ҵ�����ļ��еľ���·��Ϊ��"%FAVORITESPATH%"��
ECHO ��ǰϵͳ���ִ洢�ļ��еľ���·��Ϊ��"%FONTSPATH%"��
ECHO ��ǰϵͳ��ʷ��¼�洢�ļ��еľ���·��Ϊ��"%HISTORYPATH%"��
ECHO ��ǰϵͳ�������õľ���·��Ϊ��"%LOCALSETTINGSPATH%"��
ECHO ��ǰ�û����ҵ����֡��ļ��еľ���·��Ϊ��"%MYMUSICPATH%"��
ECHO ��ǰ�û����ҵ�ͼƬ���ļ��еľ���·��Ϊ��"%MYPICTURESPATH%"��
ECHO ��ǰ�û����ҵ���Ƶ���ļ��еľ���·��Ϊ��"%MYVIDEOPATH%"��
ECHO ��ǰϵͳNetHood�ľ���·��Ϊ��"%NETHOODPATH%"��
ECHO ��ǰ�û������ļ��еľ���·��Ϊ��"%PERSONALPATH%"��
ECHO ��ǰϵͳPrintHood�ľ���·��Ϊ��"%PRINTHOODPATH%"��
ECHO ��ǰ�û������г��򡱲˵��ľ���·��Ϊ��"%PROGRAMSPATH%"��
ECHO ��ǰϵͳ������򿪡��ļ��еľ���·��Ϊ��"%RECENTPATH%"��
ECHO ��ǰϵͳSendto�ľ���·��Ϊ��"%SENDTOPATH%"��
ECHO ��ǰ�û���ʼ�˵��ļ��еľ���·��Ϊ��"%STARTMENUPATH%"��
ECHO ��ǰ�û���¼ʱ�Զ����г�����ļ��еľ���·��Ϊ��"%STARTUPPATH%"��
ECHO ��ǰ�û�templates���ļ��еľ���·��Ϊ��"%TEMPLATESPATH%"��
ECHO ��ǰ�����û������ߵľ���·��Ϊ��"%CADMINTOOLPATH%"��
ECHO ��ǰ�����û�������ݴ洢�ļ��еľ���·��Ϊ��"%CAPPDATAPATH%"��
ECHO ��ǰ���������ļ��еľ���·��Ϊ��"%CDESKTOPPATH%"��
ECHO ��ǰ�����ĵ��ļ��еľ���·��Ϊ��"%DOCUMENTSPATH%"��
ECHO ��ǰ���������ļ��еľ���·��Ϊ��"%MUSICPATH%"��
ECHO ��ǰ����ͼƬ�ļ��еľ���·��Ϊ��"%PICTURESPATH%"��
ECHO ��ǰ������Ƶ�ļ��еľ���·��Ϊ��"%VIDEOPATH%"��
ECHO ��ǰ�����ĵ��ļ��еľ���·��Ϊ��"%DOCUNMENTSPATH%"��
ECHO ��ǰ����ʼ�˵��ļ��еľ���·��Ϊ��"%CSTARTMENUPATH%"��
ECHO ��¼�Զ����г�����ļ��еľ���·��Ϊ��"%CSTARTUPPATH%"��
ECHO ��ǰtemplates�����ļ��еľ���·��Ϊ��"%CTEMPLATESPATH%"��
ECHO �����ļ���·����ȡ��ϣ��밴������˳�������
PAUSE>NUL
EXIT