REM VaME UPDATER v3
REM THE UPDATER FOR BEYOND THE FUTURE!
REM By Danielle Pond
REM
REM 6100 - no update data
REM 6101 - backup failed
REM 6102 - download update data failed
REM 6103 - extract failed
REM 6104 - save file failed
REM 6105 - no game data
REM 6106 - unsupported os
REM
REM Update type 1 - All platforms
REM Update type 2 - Platform specific

setup:
REM sets up updater
ON ERROR GOTO errorhandler: REM error handler
REM sets up updater window
SCREEN _NEWIMAGE(400, 400, 32)
_TITLE "Updater!"
LINE (0, 0)-(400, 400), _RGBA(255, 255, 255, 255), BF
COLOR _RGBA(0, 0, 0, 255), _RGBA(255, 255, 255, 255)
REM finds OS
IF INSTR(_OS$, "[WINDOWS]") THEN LET ros$ = "win"
IF INSTR(_OS$, "[LINUX]") THEN LET ros$ = "lnx"
IF INSTR(_OS$, "[MACOSX]") THEN LET ros$ = "mac"
IF ros$ <> "win" AND ros$ <> "lnx" AND ros$ <> "mac" THEN ERROR 6106
REM checks to see if updater file is available
IF _FILEEXISTS("checkupdate.ddf") THEN
	REM nothing
ELSE
	ERROR 6100
END IF
REM checks updater file for links and update data
OPEN "checkupdate.ddf" FOR INPUT AS #1
INPUT #1, versionno$, updaterlinklnx$, updaterlinkmac$, updaterlinkwin$, multidownloadlink$, windownloadlink$, linuxdownloadlink$, macdownloadlink$, unziplink$, updatetype, datafolder$, winexe$, lnxexe$, macexe$, readme$, changelog$, manual$, source$, updatesource$, updatezip$, updateexe$, minsavever$
CLOSE #1
REM checks to see if game data is available
IF _FILEEXISTS("updatevals.ddf") THEN
	REM nothing
ELSE
	ERROR 6105
END IF
REM checks VaME game metadata for title and version numbers
OPEN "updatevals.ddf" FOR INPUT AS #1
    INPUT #1, oldversionno$, engineversionno$, installtype, title$, filename$, dloc$, mloc$, ploc$, floc$, sloc$, oloc$, scriptloc$, museloc$, sfxloc$, pocketloc$, uiloc$, tloc$, aloc$, menuloc$, downloadicon$, downloadiconresx, downloadiconresy, readmecheck
CLOSE #1
REM sets title
IF title$ = "" THEN LET title$ = "VaME"
_TITLE title$ + " Updater!"
PRINT " " + title$ + " Updater!"
PRINT " " + oldversionno$ + " -> " + versionno$
REM displays downloading icon
LET downloading = _LOADIMAGE(uiloc$ + "downloading.png")
LET loading = _LOADIMAGE(uiloc$ + "loading.png")
_PUTIMAGE ((400 - (downloadiconresx * 4)) + 1, 0)-(400, (downloadiconresy * 4) + 1), loading
REM checks to see if update is platform specific and sets correct download link of so
IF updatetype = 2 THEN
	IF ros$ = "win" THEN 
		LET downloadlink$ = windownloadlink$
		LET temp666$ = updatezip$ + "_win"
		'PRINT " Windows build detected!"
	END IF
	IF ros$ = "lnx" THEN 
		LET downloadlink$ = linuxdownloadlink$
		LET temp666$ = updatezip$ + "_linux"
		'PRINT " Linux build detected!"
	END IF
	IF ros$ = "mac" THEN
		LET downloadlink$ = macdownloadlink$
		LET temp666$ = updatezip$ + "_mac"
	END IF
ELSE
	'PRINT " Multi platform build detected!"
	LET downloadlink$ = multidownloadlink$
	LET temp666$ = updatezip$
END IF
PRINT
REM works out if save need erasing or not
LET ov1 = VAL(oldversionno$)
LET nv1 = VAL(minsavever$)
IF ov1 = nv1 THEN
	REM checks extra version numbers
	LET ov2 = VAL(RIGHT$(oldversionno$, INSTR(oldversionno$, ".")))
	LET nv2 = VAL(RIGHT$(minsavever$, INSTR(minsavever$, ".")))
	IF ov2 < nv2 THEN LET erasesave = 1: PRINT "Your saves will be removed!"
ELSE
	REM makes descision
	IF ov1 < nv1 THEN LET erasesave = 1: PRINT "Your saves will be removed!"
END IF
LET updatestep = 1: REM sets update step to 1
REM diverts to sub depending on OS
IF ros$ = "win" THEN GOTO winupdate
IF ros$ = "lnx" THEN GOTO linuxupdate
IF ros$ = "mac" THEN GOTO macupdate
ERROR 6106

displaystep:
REM displays update step in window and generates loading bar
IF updatestep = 1 THEN PRINT "* Backing up..."
IF updatestep = 2 THEN 
	PRINT "* Downloading update..."
	LINE ((400 - (downloadiconresx * 4)) + 1, 0)-(400, (downloadiconresy * 4) + 1), _RGBA(255, 255, 255, 255), BF
	_PUTIMAGE ((400 - (downloadiconresx * 4)) + 1, 0)-(400, (downloadiconresy * 4) + 1), downloading
END IF
IF updatestep = 3 THEN 
	PRINT "* Removing old files..."
	LINE ((400 - (downloadiconresx * 4)) + 1, 0)-(400, (downloadiconresy * 4) + 1), _RGBA(255, 255, 255, 255), BF
	_PUTIMAGE ((400 - (downloadiconresx * 4)) + 1, 0)-(400, (downloadiconresy * 4) + 1), loading
END IF
IF updatestep = 4 THEN PRINT "* Installing update..."
IF updatestep = 5 THEN 
	IF erasesave = 0 THEN 
		PRINT "* Restoring saves..."
	ELSE
		PRINT "* Removing saves..."
	END IF
END IF
IF updatestep = 6 THEN PRINT "* Removing updater files..."
IF updatestep = 7 THEN 
	PRINT
	PRINT " ...Update complete!"
	PRINT " " + title$ + " will now relaunch..."
	LINE ((400 - (downloadiconresx * 4)) + 1, 0)-(400, (downloadiconresy * 4) + 1), _RGBA(255, 255, 255, 255), BF
END IF
LET barline = 400 / 7
LET barline = barline * updatestep
LINE (0, 350)-(barline, 360), _RGBA(0, 0, 0, 255), BF
RETURN

errorhandler:
REM handles errors and halts updater
IF err = 62 THEN LET legacyversion = 1: RESUME NEXT
IF err = 258 THEN RESUME NEXT
PRINT " ERROR: "; err ; " LINE: "; _ERRORLINE
IF err = 6100 THEN PRINT " Update data missing!": LET temp = 1
IF err = 6105 THEN PRINT " Incorrect game for updater or game data missing!": LET temp = 1
IF err = 6106 THEN PRINT " Unknown or unsupported operating system!": LET temp = 1
IF err = 6102 THEN PRINT " Failed to download update!": LET temp = 2
IF err = 6103 THEN PRINT " Failed to install update!": LET temp = 2
IF err = 6104 THEN PRINT " Failed to restore saves!": LET temp = 2
IF err = 6101 THEN PRINT " Failed to backup game!": LET temp = 2
IF temp = 0 THEN PRINT " " + _ERRORMESSAGE$
PRINT: PRINT " UPDATE FAILED!"
IF temp = 2 THEN GOSUB repairbrokenupdate
REM deletes any updater temp files
IF ros$ = "lnx" OR ros$ = "mac" THEN SHELL _HIDE "rm *.ddf"
IF ros$ = "win" THEN SHELL _HIDE "del *.ddf"
IF temp = 1 OR restorecheck >= 4 THEN
	REM relaunches game after sucessful restore
	PRINT " " + title$ + " will now relaunch..."
	_DELAY 10
	IF ros$ = "lnx" THEN SHELL _DONTWAIT "./" + lnxexe$ + " -noupdate"
	IF ros$ = "mac" THEN SHELL _DONTWAIT "./" + macexe$ + " -noupdate"
	IF ros$ = "win" THEN SHELL _DONTWAIT winexe$ + " -noupdate"
	SYSTEM
ELSE
	REM doesnt relaunch game- restore failed
	PRINT " Visit www.studiopond.co.uk/support for support."
	PRINT " You may now close this window."
	DO
		_LIMIT 1
	LOOP
	SYSTEM
END IF
SYSTEM

repairbrokenupdate:
REM repairs a broken update
PRINT "* Restoring previous version..."
IF err = 6101 THEN
	REM game backup failed
	IF ros$ = "lnx" OR ros$ = "mac" THEN SHELL _HIDE "rm -R vamebackup"
	IF ros$ = "win" THEN SHELL _HIDE "rmdir /Q /S vamebackup"
END IF
IF err = 6102 THEN
	REM update download failed
	IF ros$ = "lnx" OR ros$ = "mac" THEN
		SHELL _HIDE "rm " + temp666$ + ".zip"
		SHELL _HIDE "rm -R vamebackup"
	END IF
	IF ros$ = "win" THEN
		SHELL _HIDE "del " + temp666$ + ".zip"
		SHELL _HIDE "rmdir /Q /S vamebackup"
	END IF
END IF
IF err = 6103 THEN
	REM update install failed
	IF ros$ = "lnx" OR ros$ = "mac" THEN
		SHELL _HIDE "rm *.*"
		SHELL _HIDE "rm -R " + datafolder$
		SHELL _HIDE "cp -R ./vamebackup/*.* ./"
		SHELL _HIDE "cp -R ./vamebackup/* ./"
		SHELL _HIDE "rm -R vamebackup"
	END IF
	IF ros$ = "win" THEN
		SHELL _HIDE "del /Q *.*"
		SHELL _HIDE "rmdir /Q /S " + datafolder$
		SHELL _HIDE "xcopy vamebackup/ \E"
		SHELL _HIDE "rmdir /Q /S vamebackup"
	END IF
END IF
IF err = 6104 THEN
	REM save restore failed
		IF ros$ = "lnx" OR ros$ = "mac" THEN
		SHELL _HIDE "rm *.*"
		SHELL _HIDE "rm -R " + datafolder$
		SHELL _HIDE "cp -R ./vamebackup/*.* ./"
		SHELL _HIDE "cp -R ./vamebackup/* ./"
		SHELL _HIDE "rm -R vamebackup"
	END IF
	IF ros$ = "win" THEN
		SHELL _HIDE "del /Q *.*"
		SHELL _HIDE "rmdir /Q /S " + datafolder$
		SHELL _HIDE "xcopy vamebackup\ /E"
		SHELL _HIDE "rmdir /Q /S vamebackup"
	END IF
END IF
REM check game has been restored correctly
LET restorecheck = 0
IF ros$ = "lnx" THEN IF _FILEEXISTS(lnxexe$) THEN LET restorecheck = restorecheck + 1
IF ros$ = "mac" THEN IF _FILEEXISTS(macexe$) THEN LET restorecheck = restorecheck + 1
IF ros$ = "win" THEN IF _FILEEXISTS(winexe$) THEN LET restorecheck = restorecheck + 1
IF _DIREXISTS(datafolder$) THEN LET restorecheck = restorecheck + 1
IF _FILEEXISTS(datafolder$ + "/engine.ddf") THEN LET restorecheck = restorecheck + 1
IF _FILEEXISTS(datafolder$ + "/saves/defaultsave.ddf") THEN LET restorecheck = restorecheck + 1
LINE ((400 - (downloadiconresx * 4)) + 1, 0)-(400, (downloadiconresy * 4) + 1), _RGBA(255, 255, 255, 255), BF
IF restorecheck => 4 THEN
	PRINT " ...restore complete!"
	IF ros$ = "lnx" OR ros$ = "mac" THEN SHELL _HIDE "rm -R vamebackup"
	IF ros$ = "win" THEN SHELL _HIDE "rmdir /Q /S vamebackup"
ELSE
	PRINT " RESTORE FAILED!"
	PRINT " RE-INSTALL " + title$ + "!"
END IF
RETURN

nextstep:
REM moves onto next update step
LET updatestep = updatestep + 1
RETURN

checker:
REM checks if update steps are successful
REM check backup
IF updatestep = 1 THEN
	IF _FILEEXISTS("vamebackup/" + datafolder$ + "/engine.ddf") THEN
		REM nothing
	ELSE
		ERROR 6101
	END IF
END IF
REM check download
IF updatestep = 2 THEN
	IF _FILEEXISTS(temp666$ + ".zip") THEN
		REM nothing
	ELSE
		ERROR 6102
	END IF
END IF
REM nothing
IF updatestep = 3 THEN REM nothing
REM check extract
IF updatestep = 4 THEN
	IF _FILEEXISTS(datafolder$ + "/engine.ddf") THEN
		REM nothing
	ELSE
		ERROR 6103
	END IF
END IF
REM check save data
IF updatestep = 5 THEN
	IF erasesave = 0 THEN
		IF _FILEEXISTS("data/saves/savedata.ddf") THEN
			REM nothing
		ELSE
			ERROR 6104
		END IF
	END IF
END IF
RETURN

winupdate:
REM updates the game for microsoft windows systems
REM backup files
GOSUB displaystep
SHELL _HIDE "mkdir vamebackup"
IF source$ <> "" THEN SHELL _HIDE "copy " + source$ + " vamebackup\"
IF updatesource$ <> "" THEN SHELL _HIDE "copy " + updatesource$ + " vamebackup\"
IF manual$ <> "" THEN SHELL _HIDE "copy " + manual$ + " vamebackup\"
IF updatetype = 1 THEN 
	IF lnxexe$ <> "" THEN SHELL _HIDE "copy " + lnxexe$ + " vamebackup\"
	IF macexe$ <> "" THEN SHELL _HIDE "copy " + macexe$ + " vamebackup\"
END IF
IF winexe$ <> "" THEN SHELL _HIDE "copy " + winexe$ + " vamebackup\"
IF changelog$ <> "" THEN SHELL _HIDE "copy " + changelog$ + " vamebackup\"
IF readme$ <> "" THEN SHELL _HIDE "copy " + readme$ + " vamebackup\"
SHELL _HIDE "xcopy /E /I " + datafolder$ + " vamebackup\" + datafolder$
REM detects mods and backs them up too
SHELL _HIDE "dir /ad /b > modlist.tmp"
OPEN "modlist.tmp" FOR INPUT AS #42
DO
	INPUT #42, modname$
	IF _FILEEXISTS(modname$ + "\engine.ddf") AND modname$ <> "data" THEN
		REM mod found - transfers folder to backup
		SHELL _HIDE "xcopy /E /I " + modname$ + " vamebackup\" + modname$
	END IF
LOOP UNTIL EOF(42)
CLOSE #42
GOSUB checker
GOSUB nextstep
REM download new update files
GOSUB displaystep
SHELL _HIDE "curl -L -o " + temp666$ + ".zip" + " " +  downloadlink$
SHELL _HIDE "curl -L -o unzip.exe " + unziplink$
GOSUB checker
GOSUB nextstep
REM delete current version
GOSUB displaystep
IF source$ <> "" THEN SHELL _HIDE "del " + source$
IF updatesource$ <> "" THEN SHELL _HIDE "del " + updatesource$
IF manual$ <> "" THEN SHELL _HIDE "del " + manual$
IF changelog$ <> "" THEN SHELL _HIDE "del " + changelog$
IF updatetype = 1 THEN 
	IF lnxexe$ <> "" THEN SHELL _HIDE "del " + lnxexe$
	IF macexe$ <> "" THEN SHELL _HIDE "del " + macexe$
END IF
IF winexe$ <> "" THEN SHELL _HIDE "del " + winexe$
IF readme$ <> "" THEN SHELL _HIDE "del " + readme$
SHELL _HIDE "rmdir /Q /S " + datafolder$
OPEN "modlist.tmp" FOR INPUT AS #42
DO
	INPUT #42, modname$
	IF _FILEEXISTS(modname$ + "\engine.ddf") AND modname$ <> "data" THEN
		REM mod found - delete folder
		SHELL _HIDE "rmdir /Q /S " + modname$
	END IF
LOOP UNTIL EOF(42)
CLOSE #42
GOSUB nextstep
REM extract new version
GOSUB displaystep
SHELL _HIDE "unzip -o " + temp666$ + ".zip"
GOSUB checker
GOSUB nextstep
REM copy over old save
GOSUB displaystep
SHELL _HIDE "del " + datafolder$ + "\saves\savedata.ddf"
IF erasesave = 0 THEN
	SHELL _HIDE "copy vamebackup\" + datafolder$ + "\saves\savedata.ddf  " + datafolder$ + "\saves\"
	SHELL _HIDE "copy vamebackup\" + datafolder$ + "\saves\*.old  " + datafolder$ + "\saves\"
	SHELL _HIDE "copy vamebackup\" + datafolder$ + "\saves\options.ddf " + datafolder$ + "\saves\"
	SHELL _HIDE "copy vamebackup\" + datafolder$ + "\consolelog.txt  " + datafolder$ + "\"
	OPEN "modlist.tmp" FOR INPUT AS #42
	DO
		INPUT #42, modname$
		IF _FILEEXISTS("vamebackup\" + modname$ + "\engine.ddf") AND modname$ <> "data" THEN
			REM new mod found - transfers saves to new folder
			SHELL _HIDE "del " + modname$ + "\saves\savedata.ddf"
			SHELL _HIDE "copy vamebackup\" + modname$ + "\saves\savedata.ddf  " + modname$ + "\saves\"
			SHELL _HIDE "copy vamebackup\" + modname$ + "\saves\*.old  " + modname$ + "\saves\"
			SHELL _HIDE "copy vamebackup\" + modname$ + "\saves\options.ddf " + modname$ + "\saves\"
			SHELL _HIDE "copy vamebackup\" + modname$ + "\consolelog.txt  " + modname$ + "\"
		ELSE
			REM new mod not found! copy back the old one!
			IF modname$ <> "data" THEN SHELL _HIDE "xcopy /E /I vamebackup\" + modname$ + " " + modname$ + "\"
		END IF
	LOOP UNTIL EOF(42)
	CLOSE #42
ELSE
	REM restore options only!
	SHELL _HIDE "copy vamebackup\" + datafolder$ + "\saves\options.ddf " + datafolder$ + "\saves\"
	OPEN "modlist.tmp" FOR INPUT AS #42
	DO
		INPUT #42, modname$
		IF _FILEEXISTS("vamebackup\" + modname$ + "\engine.ddf") AND modname$ <> "data" THEN
			REM new mod found - transfers saves to new folder
			SHELL _HIDE "copy vamebackup\" + modname$ + "\saves\options.ddf " + modname$ + "\saves\"
		ELSE
			REM new mod not found! copy back the old one!
			IF modname$ <> "data" THEN SHELL _HIDE "xcopy /E /I vamebackup\" + modname$ + " " + modname$ + "\"
		END IF
	LOOP UNTIL EOF(42)
	CLOSE #42
END IF
GOSUB checker
GOSUB nextstep
REM delete updater files
GOSUB displaystep
SHELL _HIDE "del " + temp666$ + ".zip"
SHELL _HIDE "del checkupdate.ddf"
SHELL _HIDE "del unzip.exe"
SHELL _HIDE "rmdir /Q /S vamebackup"
SHELL _HIDE "del modlist.tmp"
GOSUB nextstep
GOSUB displaystep
_DELAY 10
IF readmecheck = 2 THEN SHELL "type " + readme$ + " | more && pause"
SHELL _DONTWAIT winexe$ + " -noupdate"
_SCREENHIDE
SYSTEM

linuxupdate:
REM updates the game for linux systems
REM backup files
GOSUB displaystep
SHELL _HIDE "mkdir vamebackup"
IF source$ <> "" THEN SHELL _HIDE "cp " + source$ + " vamebackup/"
IF updatesource$ <> "" THEN SHELL _HIDE "cp " + updatesource$ + " vamebackup/"
IF manual$ <> "" THEN SHELL _HIDE "cp " + manual$ + " vamebackup/"
IF lnxexe$ <> "" THEN SHELL _HIDE "cp " + lnxexe$ + " vamebackup/"
IF updatetype = 1 THEN 
	IF winexe$ <> "" THEN SHELL _HIDE "cp " + winexe$ + " vamebackup/"
	IF macexe$ <> "" THEN SHELL _HIDE "cp " + macexe$ + " vamebackup/"
END IF
IF changelog$ <> "" THEN SHELL _HIDE "cp " + changelog$ + " vamebackup/"
IF readme$ <> "" THEN SHELL _HIDE "cp " + readme$ + " vamebackup/"
SHELL _HIDE "cp -R " + datafolder$ + " vamebackup/"
REM detects mods and backs them up too
SHELL _HIDE "ls -d */ > modlist.tmp"
OPEN "modlist.tmp" FOR INPUT AS #42
DO
	INPUT #42, modname$
	IF _FILEEXISTS(modname$ + "engine.ddf") AND modname$ <> "data" THEN
		REM mod found - transfers folder to backup
		SHELL _HIDE "cp -R " + modname$ + " vamebackup/"
	END IF
LOOP UNTIL EOF(42)
CLOSE #42
GOSUB checker
GOSUB nextstep
REM download new update files
GOSUB displaystep
SHELL _HIDE "curl -L -o " + temp666$ + ".zip " + downloadlink$
IF _FILEEXISTS(temp666$ + ".zip") THEN
	REM nothing
ELSE
	SHELL _HIDE "wget -q -O " + temp666$ + ".zip " + downloadlink$
END IF
GOSUB checker
GOSUB nextstep
REM delete current version
GOSUB displaystep
IF source$ <> "" THEN SHELL _HIDE "rm " + source$
IF updatesource$ <> "" THEN SHELL _HIDE "rm " + updatesource$
IF manual$ <> "" THEN SHELL _HIDE "rm " + manual$
IF changelog$ <> "" THEN SHELL _HIDE "rm " + changelog$
IF lnxexe$ <> "" THEN SHELL _HIDE "rm " + lnxexe$
IF updatetype = 1 THEN 
	IF winexe$ <> "" THEN SHELL _HIDE "rm " + winexe$
	IF macexe$ <> "" THEN SHELL _HIDE "rm " + macexe$
END IF
IF readme$ <> "" THEN SHELL _HIDE "rm " + readme$
SHELL _HIDE "rm -R " + datafolder$
OPEN "modlist.tmp" FOR INPUT AS #42
DO
	INPUT #42, modname$
	IF _FILEEXISTS(modname$ + "engine.ddf") AND modname$ <> "data" THEN
		REM mod found - transfers folder to backup
		SHELL _HIDE "rm -R " + modname$
	END IF
LOOP UNTIL EOF(42)
CLOSE #42
GOSUB nextstep
REM extract new version
GOSUB displaystep
SHELL _HIDE "unzip -o " + temp666$ + ".zip"
GOSUB checker
GOSUB nextstep
REM copy over old save
GOSUB displaystep
SHELL _HIDE "rm " + datafolder$ + "/saves/savedata.ddf"
IF erasesave = 0 THEN
	SHELL _HIDE "cp vamebackup/" + datafolder$ + "/saves/savedata.ddf " + datafolder$ + "/saves/"
	SHELL _HIDE "cp vamebackup/" + datafolder$ + "/saves/*.old " + datafolder$ + "/saves/"
	SHELL _HIDE "cp vamebackup/" + datafolder$ + "/saves/options.ddf " + datafolder$ + "/saves/"
	SHELL _HIDE "cp vamebackup/" + datafolder$ + "/consolelog.txt " + datafolder$ + "/"
	OPEN "modlist.tmp" FOR INPUT AS #42
	DO
		INPUT #42, modname$
		IF _FILEEXISTS("vamebackup/" + modname$ + "engine.ddf") AND modname$ <> "data" THEN
			REM mod found - transfers saves to new folder
			SHELL _HIDE "rm " + modname$ + "saves/savedata.ddf"
			SHELL _HIDE "cp vamebackup/" + modname$ + "saves/savedata.ddf " + modname$ + "saves/"
			SHELL _HIDE "cp vamebackup/" + modname$ + "saves/*.old " + modname$ + "saves/"
			SHELL _HIDE "cp vamebackup/" + modname$ + "saves/options.ddf " + modname$ + "saves/"
			SHELL _HIDE "cp vamebackup/" + modname$ + "consolelog.txt " + modname$
		ELSE
			REM new mod not found! copy back the old one!
			IF modname$ <> "data" THEN SHELL _HIDE "cp -R vamebackup/" + modname$ + " ./"
		END IF
		LOOP UNTIL EOF(42)
	CLOSE #42
ELSE
	REM restore options only!
	SHELL _HIDE "cp vamebackup/" + datafolder$ + "/saves/options.ddf " + datafolder$ + "/saves/"
	OPEN "modlist.tmp" FOR INPUT AS #42
	DO
		INPUT #42, modname$
		IF _FILEEXISTS("vamebackup/" + modname$ + "engine.ddf") AND modname$ <> "data" THEN
			REM mod found - transfers saves to new folder
			SHELL _HIDE "cp vamebackup/" + modname$ + "saves/options.ddf " + modname$ + "saves/"
		ELSE
			REM new mod not found! copy back the old one!
			IF modname$ <> "data" THEN SHELL _HIDE "cp -R vamebackup/" + modname$ + " ./"
		END IF
		LOOP UNTIL EOF(42)
	CLOSE #42
END IF
GOSUB checker
GOSUB nextstep
REM delete updater files
GOSUB displaystep
SHELL _HIDE "rm " + temp666$ + ".zip"
SHELL _HIDE "rm checkupdate.ddf"
SHELL _HIDE "rm -R vamebackup"
SHELL _HIDE "rm modlist.tmp"
GOSUB nextstep
GOSUB displaystep
_DELAY 10
'IF readmecheck = 2 THEN SHELL _DONTWAIT "cat " + readme$ + " | more"
SHELL _HIDE "chmod +rwxrwxrwx " + lnxexe$: SHELL _DONTWAIT "./" + lnxexe$ + " -noupdate"
_SCREENHIDE
SYSTEM

macupdate:
REM updates the game for macos systems
REM backup files
GOSUB displaystep
SHELL _HIDE "mkdir vamebackup"
IF source$ <> "" THEN SHELL _HIDE "cp " + source$ + " vamebackup/"
IF updatesource$ <> "" THEN SHELL _HIDE "cp " + updatesource$ + " vamebackup/"
IF manual$ <> "" THEN SHELL _HIDE "cp " + manual$ + " vamebackup/"
IF macexe$ <> "" THEN SHELL _HIDE "cp " + macexe$ + " vamebackup/"
IF updatetype = 1 THEN
	IF winexe$ <> "" THEN SHELL _HIDE "cp " + winexe$ + " vamebackup/"
	IF lnxexe$ <> "" THEN SHELL _HIDE "cp " + lnxexe$ + " vamebackup/"
END IF
IF changelog$ <> "" THEN SHELL _HIDE "cp " + changelog$ + " vamebackup/"
IF readme$ <> "" THEN SHELL _HIDE "cp " + readme$ + " vamebackup/"
SHELL _HIDE "cp -R " + datafolder$ + " vamebackup/"
REM detects mods and backs them up too
SHELL _HIDE "ls -d */ > modlist.tmp"
OPEN "modlist.tmp" FOR INPUT AS #42
DO
	INPUT #42, modname$
	IF _FILEEXISTS(modname$ + "engine.ddf") AND modname$ <> "data" THEN
		REM mod found - transfers folder to backup
		SHELL _HIDE "cp -R " + modname$ + " vamebackup/"
	END IF
LOOP UNTIL EOF(42)
CLOSE #42
GOSUB checker
GOSUB nextstep
REM download new update files
GOSUB displaystep
SHELL _HIDE "curl -L -o " + temp666$ + ".zip " + downloadlink$
IF _FILEEXISTS(temp666$ + ".zip") THEN
	REM nothing
ELSE
	SHELL _HIDE "wget -q -O " + temp666$ + ".zip " + downloadlink$
END IF
GOSUB checker
GOSUB nextstep
REM delete current version
GOSUB displaystep
IF source$ <> "" THEN SHELL _HIDE "rm " + source$
IF updatesource$ <> "" THEN SHELL _HIDE "rm " + updatesource$
IF manual$ <> "" THEN SHELL _HIDE "rm " + manual$
IF changelog$ <> "" THEN SHELL _HIDE "rm " + changelog$
IF macexe$ <> "" THEN SHELL _HIDE "rm " + macexe$
IF updatetype = 1 THEN 
	IF winexe$ <> "" THEN SHELL _HIDE "rm " + winexe$
	IF lnxexe$ <> "" THEN SHELL _HIDE "rm " + lnxexe$
END IF
IF readme$ <> "" THEN SHELL _HIDE "rm " + readme$
SHELL _HIDE "rm -R " + datafolder$
OPEN "modlist.tmp" FOR INPUT AS #42
DO
	INPUT #42, modname$
	IF _FILEEXISTS(modname$ + "engine.ddf") AND modname$ <> "data" THEN
		REM mod found - transfers folder to backup
		SHELL _HIDE "rm -R " + modname$
	END IF
LOOP UNTIL EOF(42)
CLOSE #42
GOSUB nextstep
REM extract new version
GOSUB displaystep
SHELL _HIDE "unzip -o " + temp666$ + ".zip"
GOSUB checker
GOSUB nextstep
REM copy over old save
GOSUB displaystep
SHELL _HIDE "rm " + datafolder$ + "/saves/savedata.ddf"
IF erasesave = 0 THEN
	SHELL _HIDE "cp vamebackup/" + datafolder$ + "/saves/savedata.ddf " + datafolder$ + "/saves/"
	SHELL _HIDE "cp vamebackup/" + datafolder$ + "/saves/*.old " + datafolder$ + "/saves/"
	SHELL _HIDE "cp vamebackup/" + datafolder$ + "/saves/options.ddf " + datafolder$ + "/saves/"
	SHELL _HIDE "cp vamebackup/" + datafolder$ + "/consolelog.txt " + datafolder$ + "/"
	OPEN "modlist.tmp" FOR INPUT AS #42
	DO
		INPUT #42, modname$
		IF _FILEEXISTS("vamebackup/" + modname$ + "engine.ddf") AND modname$ <> "data" THEN
			REM mod found - transfers saves to new folder
			SHELL _HIDE "rm " + modname$ + "saves/savedata.ddf"
			SHELL _HIDE "cp vamebackup/" + modname$ + "saves/savedata.ddf " + modname$ + "saves/"
			SHELL _HIDE "cp vamebackup/" + modname$ + "saves/*.old " + modname$ + "saves/"
			SHELL _HIDE "cp vamebackup/" + modname$ + "saves/options.ddf " + modname$ + "saves/"
			SHELL _HIDE "cp vamebackup/" + modname$ + "consolelog.txt " + modname$
		ELSE
			REM new mod not found! copy back the old one!
			IF modname$ <> "data" THEN SHELL _HIDE "cp -R vamebackup/" + modname$ + " ./"
		END IF
		LOOP UNTIL EOF(42)
	CLOSE #42
ELSE
	REM restore options only!
	SHELL _HIDE "cp vamebackup/" + datafolder$ + "/saves/options.ddf " + datafolder$ + "/saves/"
	OPEN "modlist.tmp" FOR INPUT AS #42
	DO
		INPUT #42, modname$
		IF _FILEEXISTS("vamebackup/" + modname$ + "engine.ddf") AND modname$ <> "data" THEN
			REM mod found - transfers saves to new folder
			SHELL _HIDE "cp vamebackup/" + modname$ + "saves/options.ddf " + modname$ + "saves/"
		ELSE
			REM new mod not found! copy back the old one!
			IF modname$ <> "data" THEN SHELL _HIDE "cp -R vamebackup/" + modname$ + " ./"
		END IF
		LOOP UNTIL EOF(42)
	CLOSE #42
END IF
GOSUB checker
GOSUB nextstep
REM delete updater files
GOSUB displaystep
SHELL _HIDE "rm " + temp666$ + ".zip"
SHELL _HIDE "rm checkupdate.ddf"
SHELL _HIDE "rm -R vamebackup"
SHELL _HIDE "rm modlist.tmp"
GOSUB nextstep
GOSUB displaystep
_DELAY 10
'IF readmecheck = 2 THEN SHELL _DONTWAIT "cat " + readme$ + " | more"
SHELL _HIDE "chmod +rwxrwxrwx " + macexe$: SHELL _DONTWAIT "./" + macexe$ + " -noupdate"
_SCREENHIDE
SYSTEM
