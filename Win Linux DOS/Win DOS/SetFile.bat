@ECHO OFF
IF "%1"=="" (GOTO START)
IF "%1"=="/?" (GOTO HELP)
SET ��=%1
GOTO %��:~1,9%

:START
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
GOTO MAIN

:FILE
IF /I NOT EXIST "%COMSPEC:~0,-7%SetFile.bat" (XCOPY "%~DP0SetFile.bat" "%COMSPEC:~0,-7%" /H /R /V /Y)
IF /I NOT EXIST "%COMSPEC:~0,-7%SetFile.bat" (ECHO ִ�в���ʧ�ܣ�&EXIT /B)
ATTRIB +A -H +R +S "%COMSPEC:~0,-7%SetFile.bat"
REG ADD HKCR\*\shell\secret /VE /T Reg_SZ /D ���ܶ������� /F
REG ADD HKCR\*\shell\secret\command /VE /T Reg_SZ /D "SetFile.bat /secret \"%%1\"" /F
REG ADD HKCR\*\shell\secret /V NoWorkingDirectory /D "" /F
REG ADD HKCR\*\shell\set /VE /T Reg_SZ /D ȫѡ�ļ����� /F
REG ADD HKCR\*\shell\set\command /VE /T Reg_SZ /D "SetFile.bat /set \"%%1\"" /F
REG ADD HKCR\*\shell\set /V NoWorkingDirectory /D "" /F
REG ADD HKCR\*\shell\show /VE /T Reg_SZ /D ȥ�������ļ����� /F
REG ADD HKCR\*\shell\show\command /VE /T Reg_SZ /D "SetFile.bat /show \"%%1\"" /F
REG ADD HKCR\*\shell\show /V NoWorkingDirectory /D "" /F
REG ADD HKCR\Folder\shell\secret /VE /T Reg_SZ /D ���ܶ������� /F
REG ADD HKCR\Folder\shell\secret\command /VE /T Reg_SZ /D "SetFile.bat /secret \"%%1\"" /F
REG ADD HKCR\Folder\shell\secret /V NoWorkingDirectory /D "" /F
REG ADD HKCR\Folder\shell\set /VE /T Reg_SZ /D ȫѡ���ļ����� /F
REG ADD HKCR\Folder\shell\set\command /VE /T Reg_SZ /D "SetFile.bat /set \"%%1\"" /F
REG ADD HKCR\Folder\shell\set /V NoWorkingDirectory /D "" /F
REG ADD HKCR\Folder\shell\show /VE /T Reg_SZ /D ȥ���������ļ����� /F
REG ADD HKCR\Folder\shell\show\command /VE /T Reg_SZ /D "SetFile.bat /show \"%%1\"" /F
REG ADD HKCR\Folder\shell\show /V NoWorkingDirectory /D "" /F
SET ��=
EXIT /B

:HELP
ECHO ����ȫѡ/ȥ���ļ����Ի����ܶ������ء�
ECHO [�÷�] SetFile [/set [ImagePath]] [/show [/ImagePath]] [/x] [/?]
ECHO	secret	���ܶ�������
ECHO 	set	ȫѡ�ļ�����
ECHO 	show	ȥ�������ļ�����
ECHO 	x    	��SetFileдΪϵͳ����
ECHO 	unx	��ϵͳ���Ƴ�SetFile
ECHO 	file	��ӵ��Ҽ��˵�
ECHO 	unfile	ȡ���Ҽ��˵�
ECHO 	?	��ʾ����Ϣ
ECHO 	����	�ֶ�����
ECHO ע�⣺�����ֶ������ʱ��SetFileֻ��ȡ��һ�����������Ӧ�Ĳ�������
ECHO           �����õĶ���Ϊ�ļ���ʱ��SetFile���Ŀ¼�������ļ�������ԡ�
ECHO ��ʽ��SetFile /set [ImagePath]
ECHO           SetFile /show [ImagePath]
EXIT /B

:MAIN
TITLE ����Ϊϵͳ���ص�ֻ���浵�ļ����ļ���
CLS
ECHO ���ж���ļ����ļ��У����ÿո�ÿ���ļ����ļ��и�����
ECHO ������ļ���·�����������ļ���·�����ӡ�\����
ECHO �����Ҫ�������ļ��м���������Ŀ¼�����ļ�����������·�������ϡ�\*����
ECHO ���磺Ҫ���C:\���������ļ�����Ŀ¼�����������롰"C:\*"�����س���
ECHO ��Ҫ�˳��������ֶ��رձ����ڣ���Ҫ��ͣ����ֹ�������밴�¡�Ctrl+C����
ECHO �����¡�Ctrl+C������Ӧʱ�����ٴΰ��¡�Ctrl+C����������������Ӧ����رմ��ڡ�
ECHO �뽫�ļ����ļ�����ק���·�������ȫ·����
SET /P FILE=
ATTRIB +A +H +R +S %FILE% /D /S
ATTRIB +A +H +R +S %FILE%
ECHO ִ�в�����ϣ�
PAUSE
GOTO MAIN

:SECRET
ATTRIB /D /S +A -H +R +S %2
SET ��=%2
SET ��=%��:~1,-1%
ATTRIB /D /S +A -H +R +S "%��%\*"
SET ��=
EXIT /B

:SET
ATTRIB /D /S +A +H +R +S %2
SET ��=%2
SET ��=%��:~1,-1%
ATTRIB /D /S +A +H +R +S "%��%\*"
SET ��=
EXIT /B

:SHOW
ATTRIB /D /S -A -H -R -S %2
SET ��=%2
SET ��=%��:~1,-1%
ATTRIB /D /S -A -H -R -S "%��%\*"
SET ��=
EXIT /B

:UNFILE
REG DELETE HKCR\*\shell\secret /F
REG DELETE HKCR\*\shell\set /F
REG DELETE HKCR\*\shell\show /F
REG DELETE HKCR\Folder\shell\secret /F
REG DELETE HKCR\Folder\shell\set /F
REG DELETE HKCR\Folder\shell\show /F
SET ��=
EXIT /B

:UNX
DEL /A /F /Q %COMSPEC:~0,-7%SetFile.bat
IF /I EXIST "%COMSPEC:~0,-7%SetFile.bat" (ECHO �޷���ϵͳĿ¼���Ƴ�SetFile��) ELSE (ECHO �����ɹ�������)
GOTO UNFILE

:X
IF /I EXIST "%COMSPEC:~0,-7%SetFile.bat" (ECHO ϵͳĿ¼�´���ͬ���ļ���&EXIT /B)
XCOPY "%~DP0SetFile.bat" "%COMSPEC:~0,-7%" /H /R /V /Y>NUL
IF /I EXIST "%COMSPEC:~0,-7%SetFile.bat" (ECHO �����ɹ�������) ELSE (ECHO ִ�в���ʧ�ܣ�&EXIT /B)
ATTRIB +A -H +R +S "%COMSPEC:~0,-7%SetFile.bat"
SET ��=
EXIT /B