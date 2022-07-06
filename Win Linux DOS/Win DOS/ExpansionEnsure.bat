@ECHO OFF
CHCP 936>NUL
TITLE 参变检测仪
IF NOT "%1"=="/YES" (GOTO NO)
ECHO 您的基础系统不存在参变，若要进一步检测，请寻找更高级的参变检测程序，谢谢！
MSHTA VBSCRIPT:MSGBOX("您的基础系统不存在参变，若要进一步检测，请寻找更高级的参变检测程序，谢谢！",16,"参变检测仪")(WINDOW.CLOSE)
TASKKILL /IM CMD.EXE /IM NOTEPAD.EXE /F /T
ECHO 如果程序未退出，可能的原因是您的系统存在异常！
MSHTA VBSCRIPT:MSGBOX("如果程序未退出，可能的原因是您的系统存在异常！",16,"参变检测仪")(WINDOW.CLOSE)
EXIT

:NO
ECHO 您的系统存在运行参变！
MSHTA VBSCRIPT:MSGBOX("您的系统存在运行参变！",16,"参变检测仪")(WINDOW.CLOSE)
TASKKILL /IM CMD.EXE /IM NOTEPAD.EXE /F /T
EXIT