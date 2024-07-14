REM VaME Obselete updater notifier!

REM finds OS
IF INSTR(_OS$, "[WINDOWS]") THEN LET ros$ = "win"
IF INSTR(_OS$, "[LINUX]") THEN LET ros$ = "lnx"
REM sets up updater window
SCREEN _NEWIMAGE(400, 400, 32)
_TITLE "Updater!"
LINE (0, 0)-(400, 400), _RGBA(255, 255, 255, 255), BF
COLOR _RGBA(0, 0, 0, 255), _RGBA(255, 255, 255, 255)
PRINT "Update to VaME 2.9 and above at"
PRINT "https://github.com/pforpond/VaME"
PRINT
PRINT "Press any key to launch current VaME"
PRINT "or close this window to cancel!"
DO
	REM nawthing
LOOP WHILE INKEY$ = ""
IF ros$ = "win" THEN SHELL _DONTWAIT "vame_win.exe -noupdate"
IF ros$ = "lnx" THEN SHELL _DONTWAIT "./vame_linux -noupdate"
