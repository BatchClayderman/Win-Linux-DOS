@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=4 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE һ�����ϵͳ�����ļ�
CLS
ECHO �����������
ECHO     1��ϵͳ�̼�ϵͳĿ¼�µ�tmp��_mp�Ȼ����ļ���
ECHO     2���û�������cookies�����������¼�ȣ�
ECHO     3������վ��ͼƬ�ļ����е�����ͼ�ļ���.db����
ECHO     4��ע����еļټ�ֵ��
ECHO     5���������Ż������в�����΢��������
ECHO     6�����ļ��У����������
ECHO �������ϣ���������е�һ�����������ѡ��N���˳���
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (CHOICE /C YN /T %%I /D Y)
IF %ERRORLEVEL%==2 EXIT
CLS
DEL /A /F /Q /S "%SYSTEMDIRVE%\*.tmp"
DEL /A /F /Q /S "%SYSTEMDIRVE%\*._mp"
DEL /A /F /Q /S "%SYSTEMDIRVE%\*.log"
DEL /A /F /Q /S "%SYSTEMDIRVE%\*.gid"
DEL /A /F /Q /S "%SYSTEMDIRVE%\*.chk"
DEL /A /F /Q /S "%SYSTEMDIRVE%\*.old"
DEL /A /F /Q /S "%WINDIR%\*.bak"
DEL /A /F /Q /S "%WINDIR%\*.log"
DEL /A /F /Q /S "%WINDIR%\prefetch\*"
DEL /A /F /Q /S "%WINDIR%\TEMP\*"
DEL /A /F /Q /S "%USERPROFILE%\cookies\*"
DEL /A /F /Q /S "%USERPROFILE%\recent\*"
DEL /A /F /Q /S "%USERPROFILE%\Local Settings\Temporary Internet Files\*"
DEL /A /F /Q /S "%USERPROFILE%\Local Settings\Temp\*"
DEL /A /F /Q /S "%USERPROFILE%\Recent\*"
For /F "Skip=1" %%i in ('WMIC LOGICALDISK GET NAME') do (RD %%i\Recycler /S /Q)
For /F "Skip=1" %%i in ('WMIC LOGICALDISK GET NAME') do (DEL /F /A /S /Q %%i\thumbs.db)
DEL /A /F /Q %SYSTEMDRIVE%\SpeedUp1.reg
DEL /A /F /Q %SYSTEMDRIVE%\SpeedUp2.reg
DEL /A /F /Q %SYSTEMDRIVE%\SpeedUp.reg
DEL /A /F /Q /S "%SYSTEMDRIVE%\abc.txt"
DEL "%TEMP%\rp.txt" /A /F /Q
DEL "%TEMP%\password.txt" /A /F /Q
DEL "%TEMP%\password.vbs" /A /F /Q
DEL "%TEMP%\V" /A /F /Q
SetLocal EnableDelayedExpansion
REG DELETE HKCU\Software\Classes\CLSID\{07999AC3-058B-40BF-984F-69EB1E554CA7} /f>NUL 2>NUL
REG DELETE HKCU\Software\Classes\CLSID\{6DDF00DB-1234-46EC-8356-27E7B2051192} /f>NUL 2>NUL
REG DELETE HKCU\Software\Classes\CLSID\{D5B91409-A8CA-4973-9A0B-59F713D25671} /f>NUL 2>NUL
REG DELETE HKCU\Software\Classes\CLSID\{7B8E9164-324D-4A2E-A46D-0165FB2000EC} /f>NUL 2>NUL
REG DELETE HKCU\Software\Classes\CLSID\{5ED60779-4DE2-4E07-B862-974CA4FF2E9C} /f>NUL 2>NUL
REG DELETE HKLM\Software\Classes\CLSID\{07999AC3-058B-40BF-984F-69EB1E554CA7} /f>NUL 2>NUL
REG DELETE HKLM\Software\Classes\CLSID\{6DDF00DB-1234-46EC-8356-27E7B2051192} /f>NUL 2>NUL
REG DELETE HKLM\Software\Classes\CLSID\{D5B91409-A8CA-4973-9A0B-59F713D25671} /f>NUL 2>NUL
REG DELETE HKLM\Software\Classes\CLSID\{7B8E9164-324D-4A2E-A46D-0165FB2000EC} /f>NUL 2>NUL
REG DELETE HKLM\Software\Classes\CLSID\{5ED60779-4DE2-4E07-B862-974CA4FF2E9C} /f>NUL 2>NUL
REG DELETE HKCU\Software\Classes\Wow6432Node\CLSID\{7B8E9164-324D-4A2E-A46D-0165FB2000EC} /f>NUL 2>NUL
REG DELETE HKCU\Software\Classes\Wow6432Node\CLSID\{5ED60779-4DE2-4E07-B862-974CA4FF2E9C} /f>NUL 2>NUL
REG DELETE HKLM\Software\Classes\Wow6432Node\CLSID\{7B8E9164-324D-4A2E-A46D-0165FB2000EC} /f>NUL 2>NUL
REG DELETE HKLM\Software\Classes\Wow6432Node\CLSID\{5ED60779-4DE2-4E07-B862-974CA4FF2E9C} /f>NUL 2>NUL
ENDLOCAL
CLS
ECHO ����������ϣ�
ECHO ������������������ܺ�ʱ�ϳ����粻��Ҫ����ѡ��N���˳���
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (CHOICE /C YN /T %%I /D N)
IF %ERRORLEVEL%==2 EXIT
SETLOCAL ENABLEDELAYEDEXPANSION
FOR /F "SKIP=1" %%A IN ('WMIC LOGICALDISK GET CAPTION') DO (
	FOR /F "DELIMS=" %%B IN ('DIR /AD /B /S %%A') DO (
		SET N=0
		FOR /F %%I IN ('DIR "%%B" /A /B') DO (SET /A N+=1)
		IF !N!==0 (ECHO "%%B"&RD /Q /S "%%B")
	)
)
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (ECHO ϵͳ����������ϣ�������%%I����Զ��˳���&SLEEP %%I000)
EXIT