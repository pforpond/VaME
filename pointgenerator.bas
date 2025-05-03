REM VaME point file generator - for VaME 2.9
REM dp 2024

ON ERROR GOTO errorhandler
_TITLE "VaME Point Collision Generator"
REM enable console
$CONSOLE
_CONSOLE ON
LET arraylimit = 1000000
_ALLOWFULLSCREEN _OFF: REM block alt-enter
PRINT "OBJECT SPRITE VIEWER"
REM check os
IF INSTR(_OS$, "[WINDOWS]") THEN LET ros$ = "win"
IF INSTR(_OS$, "[LINUX]") THEN LET ros$ = "lnx"
IF INSTR(_OS$, "[MACOSX]") THEN LET ros$ = "mac"
LET dloc$ = "data/"
REM check metadata exists, checks developer console settings and load engine values
IF _FILEEXISTS(dloc$ + "engine.ddf") THEN
    OPEN dloc$ + "engine.ddf" FOR INPUT AS #1
    INPUT #1, devmode, consolelogging, displayconsole, autoupdate, installtype, devlogono, selectobjecthighlight, musictransitionmode, musicfadechange, title$, filename$, totalobjects, totalplayers, totaltriggers, totalpockets, totalcheckpoints, totalframes, totalsfxs, totalmusics, totalscriptvalues, totalawards, resx, resy, hertz, extrahertz, exitsave, autotxtsfx, ucontrol, dcontrol, lcontrol, rcontrol, scontrol, pcontrol, bcontrol, ucontrolcode1, ucontrolcode2, ucontrolcode3, ucontrolcode4, dcontrolcode1, dcontrolcode2, dcontrolcode3, dcontrolcode4, lcontrolcode1, lcontrolcode2, lcontrolcode3, locontrolcode4, rcontrolcode1, rcontrolcode2, rcontrolcode3, rcontrolcode4, scontrolcode1, scontrolcode2, scontrolcode3, scontrolcode4, pcontrolcode1, pcontrolcode2, pcontrolcode3, pcontrolcode4, bcontrolcode1, bcontrolcode2, bcontrolcode3, bcontrolcode4, enableobjectoffsets, enableplayeroffsets, enablemapoffsets, fadespeed, pace, objectstep, collisionstep, playeridle, footpace, fontname$, fontsize, fontstyle$, fontbuffer, imode, playerwalkdivide, scriptwalkdivide, scriptimage$, scriptimageresx, scriptimageresy, pockethudimage$, pockethudresx, pockethudresy, pocketarrowright$, pocketarrowleft$, pocketarrowselectright$, pocketarrowselectleft$, pocketarrowunavailableright$, pocketarrowunavailableleft$, pocketarrowresx, pocketarrowresy, pockethudanispeed, pocketarrowrlocx, pocketarrowrlocy, pocketarrowllocx, pocketarrowllocy, pocketspritex, pocketspritey, pocketspriteresx, pocketspriteresy, pocketbanner$, pocketbannerresx, pocketbannerresy, textbannersound, textbanner$, textbannername$, textbannerresx, textbannerresy, pocketselect$, pocketselectx, pocketselecty, pocketselectresx, pocketselectresy, lookaction$, lookx, useaction$, giveaction$, combineaction$, usex, givex, combinex, textbannerfacey, textbannerfaceresx, textbannerfaceresy, choicebanner$, choicearrowl, choicearrowr, currencyname$, loadicon$, loadiconresx, loadiconresy, saveicon$, saveiconresx, saveiconresy, downloadicon$, downloadiconresx, downloadiconresy, torcheffectfile$, loadbar$, devlogo$, devlogomode, awardbanner$, awardbannerresx, awardbannerresy, awardbannerlocx, awardbannerlocy, awarditemresx, awarditemresy, awarditemlocx, awarditemlocy, awardtextlocx, awardtextlocy, awardgracetime, awardtitle$, awardnotification$, awardspeed, awardnone$, awardarrowleft$, awardarrowright$, awardarrowselectleft$, awardarrowselectright$, versionno$, engineversionno$, updatelink$, updatekey$, letmenuselectcolourr, letmenuselectcolourg, letmenuselectcolourb, letmenuselectcoloura, bgmenuselectcolourr, bgmenuselectcolourg, bgmenuselectcolourb, bgmenuselectcoloura, letmenudefaultcolourr, letmenudefaultcolourg, letmenudefaultcolourb, letmenudefaultcoloura, bgmenudefaultcolourr, bgmenudefaultcolourg, bgmenudefaultcolourb, bgmenudefaultcoloura, letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura, bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura, letpocketselectcolourr, letpocketselectcolourg, letpocketselectcolourb, letpocketselectcoloura, bgpocketselectcolourr, bgpocketselectcolourg, bgpocketselectcolourb, bgpocketselectcoloura, letpocketdefaultcolourr, letpocketdefaultcolourg, letpocketdefaultcolourb, letpocketdefaultcoloura, bgpocketdefaultcolourr, bgpocketdefaultcolourg, bgpocketdefaultcolourb, bgpocketdefaultcoloura, letcurrencycolourr, letcurrencycolourg, letcurrencycolourb, letcurrencycoloura, bgcurrencycolourr, bgcurrencycolourg, bgcurrencycolourb, bgcurrencycoloura, letspeechcolourr, letspeechcolourg, letspeechcolourb, letspeechcoloura, bgspeechcolourr, bgspeechcolourg, bgspeechcolourb, bgspeechcoloura, letterminalcolourr, letterminalcolourg, letterminalcolourb, letterminalcoloura, bgterminalcolourr, bgterminalcolourg, bgterminalcolourb, bgterminalcoloura, letselectbannercolourr, letselectbannercolourg, letselectbannercolourb, letselectbannercoloura, bgselectbannercolourr, bgselectbannercolourg, bgselectbannercolourb, bgselectbannercoloura, spoofoptiontitle$, spoofoption1$, spoofoption2$, spoofoption1result$, spoofoption2result$, moddingname$
    CLOSE #1
    REM finds metadata directory paths
    IF _FILEEXISTS(dloc$ + "fileloc.ddf") THEN
        OPEN dloc$ + "fileloc.ddf" FOR INPUT AS #1
        IF ros$ = "win" THEN INPUT #1, dloc$, mloc$, ploc$, floc$, sloc$, oloc$, scriptloc$, museloc$, sfxloc$, pocketloc$, uiloc$, tloc$, aloc$, menuloc$, awardloc$
        IF ros$ = "lnx" OR ros$ = "mac" THEN INPUT #1, temp47$, temp47$, temp47$, temp47$, temp47$, temp47$, temp47$, temp47$, temp47$, temp47$, temp47$, temp47$, temp47$, temp47$, temp47$, dloc$, mloc$, ploc$, floc$, sloc$, oloc$, scriptloc$, museloc$, sfxloc$, pocketloc$, uiloc$, tloc$, aloc$, menuloc$, awardloc$: LET temp47$ = ""
        CLOSE #1
    ELSE
        BEEP
        PRINT "MISSING FILELOC.DDF"
        SYSTEM
    END IF
ELSE
	BEEP
    PRINT "MISSING ENGINE.DDF"
    SYSTEM
END IF
LET temp6 = 0
DO
    LET temp6 = temp6 + 1
    IF temp6 = 1 THEN LET temp3$ = dloc$
    IF temp6 = 2 THEN LET temp3$ = ploc$
    IF temp6 = 3 THEN LET temp3$ = mloc$
    IF temp6 = 4 THEN LET temp3$ = floc$
    IF temp6 = 5 THEN LET temp3$ = sloc$
    IF temp6 = 6 THEN LET temp3$ = oloc$
    IF temp6 = 7 THEN LET temp3$ = scriptloc$
    IF temp6 = 8 THEN LET temp3$ = museloc$
    IF temp6 = 9 THEN LET temp3$ = sfxloc$
    IF temp6 = 10 THEN LET temp3$ = pocketloc$
    IF temp6 = 11 THEN LET temp3$ = uiloc$
    IF temp6 = 12 THEN LET temp3$ = tloc$
    IF temp6 = 13 THEN LET temp3$ = aloc$
    IF temp6 = 14 THEN LET temp3$ = menuloc$
    IF temp6 = 15 THEN LET temp3$ = awardloc$
    IF _DIREXISTS(temp3$) THEN
		REM nothing
    ELSE
        BEEP
        PRINT "MISSING ENGINE DIRECTORY - " + temp3$
        SYSTEM
    END IF
LOOP UNTIL temp6 = 14
_DEST _CONSOLE
REM screen text
PRINT "VaME POINT FILE GENERATOR!"
IF ros$ = "win" THEN PRINT "You are on Microsoft Windows"
IF ros$ = "mac" THEN PRINT "You are on Apple macOS"
IF ros$ = "lnx" THEN PRINT "You are on Linux"
PRINT
REM dimming
DIM objectname(arraylimit) AS STRING
DIM objectlongname(arraylimit) AS STRING
DIM objectx(arraylimit) AS DOUBLE
DIM objecty(arraylimit) AS DOUBLE
DIM objects(arraylimit) AS INTEGER
DIM objectl(arraylimit) AS INTEGER
DIM objectlayer(arraylimit) AS INTEGER
DIM objectspeed(arraylimit) AS INTEGER
DIM objectoffset(arraylimit) AS SINGLE
DIM objectresx(arraylimit) AS INTEGER
DIM objectresy(arraylimit) AS INTEGER
DIM objecta(arraylimit) AS INTEGER
DIM objectb(arraylimit) AS INTEGER
DIM objectcollision(arraylimit) AS INTEGER
DIM objectpoint(arraylimit * 1000) AS _UNSIGNED LONG
DIM pointoutput1(arraylimit * 1000) AS INTEGER
DIM pointoutput2(arraylimit * 1000) AS _UNSIGNED LONG
DIM pointx(arraylimit * 1000) AS INTEGER
DIM pointy(arraylimit * 1000) AS INTEGER
'DIM currentpointcount AS _UNSIGNED LONG
GOTO countfiles

countfiles:
REM counts number of objects in game
PRINT "Searching for Object files..."
IF ros$ = "win" THEN SHELL _HIDE "dir /ad /b " + oloc$ + "> " + dloc$ + "objectlist.tmp"
IF ros$ = "lnx" OR ros$ = "mac" THEN SHELL _HIDE "ls -d " + oloc$ + "* > " + dloc$ + "objectlist.tmp"
OPEN dloc$ + "objectlist.tmp" FOR INPUT AS #1
DO
	INPUT #1, tempobject1$
	REM remove previous directories
	IF ros$ = "lnx" THEN LET temp = LEN(tempobject1$) - LEN(oloc$): LET tempobject1$ = MID$(tempobject1$, LEN(oloc$), temp + 1)
	'PRINT tempobject1$
	REM remove slashes
	FOR i = 1 TO LEN(tempobject1$)
        LET tempobject2$ = MID$(tempobject1$, i, 1)
        IF tempobject2$ <> "/" AND tempobject2$ <> "\" THEN LET tempobject3$ = tempobject3$ + tempobject2$
    NEXT i
    'PRINT tempobject3$
    IF _FILEEXISTS(oloc$ + tempobject3$ + "/" + tempobject3$ + ".ddf") THEN 
		LET numberofobjects = numberofobjects + 1
		LET objectname$(numberofobjects) = tempobject3$
	END IF
    LET tempobject1$ = ""
    LET tempobject2$ = ""
    LET tempobject3$ = ""
LOOP UNTIL EOF(1)
CLOSE #1
PRINT LTRIM$(STR$(numberofobjects)) + " Objects found!"
PRINT
GOTO areyousure

areyousure:
REM asks for user confirmation
PRINT "Would you like to add point collision to " + LTRIM$(STR$(numberofobjects)) + " objects?"
PRINT "Y/N (S for slow mode, P for pause mode)"
INPUT a$
IF UCASE$(a$) = "N" THEN 
	PRINT "Operation aborted by user."
	IF ros$ = "win" THEN SHELL _HIDE "del " + dloc$ + "objectlist.tmp"
	IF ros$ = "lnx" THEN SHELL _HIDE "rm " + dloc$ + "objectlist.tmp"
	SYSTEM
END IF
IF UCASE$(a$) = "Y" THEN GOTO generatepoints
IF UCASE$(a$) = "S" THEN LET slowmode = 1: GOTO generatepoints
IF UCASE$(a$) = "P" THEN LET pausemode = 1: GOTO generatepoints
GOTO areyousure

generatepoints:
REM generates point data for array
_DEST 0
FOR x = 1 TO numberofobjects
	_DEST _CONSOLE
	PRINT "Checking data for object: " + objectname$(x) + " (" + LTRIM$(STR$(x)) + "/" + LTRIM$(STR$(numberofobjects)) + ")"
	_DEST 0
	IF _FILEEXISTS(oloc$ + objectname$(x) + "/" + objectname$(x) + "a.png") THEN
		REM import data
		OPEN oloc$ + objectname$(x) + "/" + objectname$(x) + ".ddf" FOR INPUT AS #1
		INPUT #1, objectlongname$(x), objectresx(x), objectresy(x), objects(x), objectlayer(x), objectspeed(x), objectcollision(x)
		CLOSE #1
		_DEST _CONSOLE
		PRINT "Generating point data for object: " + objectname$(x)
		_DEST 0
		GOSUB pointingfordummies
		_DEST _CONSOLE
		PRINT "Point data generated for object: " + objectname$(x)
		_DEST 0
		IF skipsave = 0 THEN GOSUB savedata
	ELSE
		REM skip item
		BEEP
		_DEST _CONSOLE
		PRINT "Sprites for object " + objectname$(x) + " were not found! Skipping..."
		_DEST 0
		'_DELAY 1
	END IF
NEXT x
_DEST _CONSOLE
PRINT "Point generation complete!"
_DEST 0
GOTO pointingcomplete

pointingfordummies:
REM probes sprites for point data
SCREEN _NEWIMAGE(objectresx(x) + 1, objectresy(x) + 1, 32)
REM $RESIZE:STRETCH
LET spritefile = _LOADIMAGE(oloc$ + objectname$(x) + "/" + objectname$(x) + "a.png")
LET dotdude = _LOADIMAGE(uiloc$ + "dotdude.png")
_PUTIMAGE(1, 1), spritefile
LET px = 0
LET py = 1
LET pointloop = 0
LET endloop = 0
LET skipsave = 0
DO
	LET pointloop = pointloop + 1
	LET px = px + 1
	LET objectpoint(pointloop) = POINT(px, py)
	LET pointx(pointloop) = px
	LET pointy(pointloop) = py
	IF objectpoint(pointloop) > 0 THEN _PUTIMAGE (px, py), dotdude: IF slowmode = 1 THEN _DELAY 0.0001
	IF px => objectresx(x) AND py => objectresy(x) THEN LET endloop = 1
	IF px > objectresx(x) THEN LET px = 1: LET py = py + 1
LOOP UNTIL endloop = 1 OR pointloop > (arraylimit * 1000)
IF pausemode = 1 THEN
	_DEST _CONSOLE
	PRINT "PRESS ENTER TO CONTINUE!"
	INPUT a$
	_DEST 0
END IF
IF pointloop > (arraylimit * 1000) THEN
	_DEST _CONSOLE
	PRINT "SPRITE TOO LARGE FOR POINT COLLISION - SKIPPING!"
	_DEST 0
	LET skipsave = 1
END IF
SCREEN 0
PRINT "OBJECT SPRITE VIEWER"
_FREEIMAGE spritefile
_FREEIMAGE dotdude
RETURN

savedata:
REM compresses data for save file
_DEST _CONSOLE
PRINT "Compressing point data to object: " + objectname$(x)
_DEST 0
LET currentpointcount = 1
IF objectpoint(1) > 0 THEN 
	LET currentobjectpoint = 1
	LET oldobjectpoint = 1
ELSE
	LET currentobjectpoint = 0
	LET oldobjectpoint = 0
END IF
LET d = 1
LET u = 1
DO
	LET d = d + 1
	IF objectpoint(d) > 0 THEN
		REM point is solid
		LET currentobjectpoint = 1
	ELSE
		REM point is not solid
		LET currentobjectpoint = 0
	END IF
	IF currentobjectpoint <> oldobjectpoint THEN
		REM previous point not the same
		LET pointoutput1(u) = oldobjectpoint
		LET pointoutput2(u) = currentpointcount
		LET u = u + 1
		LET currentpointcount = 1
	ELSE
		REM previous point is the same
		LET currentpointcount = currentpointcount + 1
	END IF
	LET oldobjectpoint = currentobjectpoint
LOOP UNTIL d => (objectresx(x) * objectresy(x))
LET pointoutput1(u) = oldobjectpoint
LET pointoutput2(u) = currentpointcount
LET u = u + 1
'IF pointoutput1(1) = 0 AND pointoutput2(1) = 0 THEN
'	LET pointoutput1(1) = currentobjectpoint
'	LET pointoutput2(1) = currentpointcount
'	LET u = u + 1
'END IF
REM saves the point data to file
_DEST _CONSOLE
PRINT "Saving point data to object: " + objectname$(x)
OPEN oloc$ + objectname$(x) + "/" + objectname$(x) + ".ddf" FOR OUTPUT AS #1
WRITE #1, objectlongname$(x), objectresx(x), objectresy(x), objects(x), objectlayer(x), objectspeed(x), objectcollision(x)
FOR d = 1 TO u - 1
	'IF objectpoint(d) <> 0 THEN WRITE #1, pointx(d), pointy(d)
	WRITE #1, pointoutput1(d), pointoutput2(d)
NEXT d
CLOSE #1
'_DELAY 0.1
PRINT "Point data for object: " + objectname$(x) + " is saved!"
FOR d = 1 TO objectresx(x) * objectresy(x)
	LET objectpoint(d) = 0
NEXT d
FOR d = 1 TO u
	LET pointoutput1(d) = 0
	LET pointoutput2(d) = 0
NEXT d
_DEST 0
REM check for if a collision backup file has been saved and revert back to that
IF _FILEEXISTS(oloc$ + objectname$(x) + "/" + objectname$(x) + "[COLBACKUP].ddf") THEN
	IF ros$ = "lnx" OR ros$ = "mac" THEN
		REM linux 
		SHELL _HIDE "rm " + oloc$ + objectname$(x) + "/" + objectname$(x) + ".ddf"
		SHELL _HIDE "cp " + oloc$ + objectname$(x) + "/" + objectname$(x) + "[COLBACKUP].ddf " + oloc$ + objectname$(x) + "/" + objectname$(x) + ".ddf"
		_DEST _CONSOLE
		PRINT "Point data for object: " + objectname$(x) + " has been reverted to a backup!"
		_DEST 0
	END IF
	IF ros$ = "win" THEN
		REM windows
		SHELL _HIDE "del " + oloc$ + objectname$(x) + "\" + objectname$(x) + ".ddf"
		SHELL _HIDE "copy " + oloc$ + objectname$(x) + "\" + objectname$(x) + "[COLBACKUP].ddf " + oloc$ + objectname$(x) + "\" + objectname$(x) + ".ddf"
		_DEST _CONSOLE
		PRINT "Point data for object: " + objectname$(x) + " has been reverted to a backup!"
		_DEST 0
	END IF
END IF
_DEST _CONSOLE
PRINT
_DEST 0
RETURN

errorhandler:
_DEST _CONSOLE
PRINT ERR, _ERRORLINE
_DEST 0
RESUME NEXT

pointingcomplete:
_DEST _CONSOLE
PRINT
PRINT "Have a nice day :)"
_DEST 0
IF ros$ = "win" THEN SHELL _HIDE "del " + dloc$ + "objectlist.tmp"
IF ros$ = "lnx" THEN SHELL _HIDE "rm " + dloc$ + "objectlist.tmp"
SYSTEM




