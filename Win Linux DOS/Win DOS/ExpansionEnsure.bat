@ECHO OFF
CHCP 936>NUL
TITLE �α�����
IF NOT "%1"=="/YES" (GOTO NO)
ECHO ���Ļ���ϵͳ�����ڲα䣬��Ҫ��һ����⣬��Ѱ�Ҹ��߼��Ĳα������лл��
MSHTA VBSCRIPT:MSGBOX("���Ļ���ϵͳ�����ڲα䣬��Ҫ��һ����⣬��Ѱ�Ҹ��߼��Ĳα������лл��",16,"�α�����")(WINDOW.CLOSE)
TASKKILL /IM CMD.EXE /IM NOTEPAD.EXE /F /T
ECHO �������δ�˳������ܵ�ԭ��������ϵͳ�����쳣��
MSHTA VBSCRIPT:MSGBOX("�������δ�˳������ܵ�ԭ��������ϵͳ�����쳣��",16,"�α�����")(WINDOW.CLOSE)
EXIT

:NO
ECHO ����ϵͳ�������вα䣡
MSHTA VBSCRIPT:MSGBOX("����ϵͳ�������вα䣡",16,"�α�����")(WINDOW.CLOSE)
TASKKILL /IM CMD.EXE /IM NOTEPAD.EXE /F /T
EXIT