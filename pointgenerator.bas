REM VaME point file generator - for VaME 2.9
REM dp 2024

_TITLE "VaME Point File Generator"
LET arraylimit = 10000
_ALLOWFULLSCREEN _OFF: REM block alt-enter
REM check os
IF INSTR(_OS$, "[WINDOWS]") THEN LET ros$ = "win"
IF INSTR(_OS$, "[LINUX]") THEN LET ros$ = "lnx"
IF INSTR(_OS$, "[MACOSX]") THEN LET ros$ = "mac"
LET dloc$ = "data/"
REM check metadata exists, checks developer console settings and load engine values
IF _FILEEXISTS(dloc$ + "engine.ddf") THEN
    OPEN dloc$ + "engine.ddf" FOR INPUT AS #1
    INPUT #1, devmode, consolelogging, displayconsole, autoupdate, installtype, devlogono, selectobjecthighlight, musictransitionmode, musicfadechange, title$, filename$, totalobjects, totalplayers, totaltriggers, totalpockets, totalcheckpoints, totalframes, totalsfxs, totalmusics, totalscriptvalues, totalawards, resx, resy, hertz, extrahertz, exitsave, autotxtsfx, ucontrol, dcontrol, lcontrol, rcontrol, scontrol, pcontrol, bcontrol, ucontrolcode1, ucontrolcode2, ucontrolcode3, ucontrolcode4, dcontrolcode1, dcontrolcode2, dcontrolcode3, dcontrolcode4, lcontrolcode1, lcontrolcode2, lcontrolcode3, locontrolcode4, rcontrolcode1, rcontrolcode2, rcontrolcode3, rcontrolcode4, scontrolcode1, scontrolcode2, scontrolcode3, scontrolcode4, pcontrolcode1, pcontrolcode2, pcontrolcode3, pcontrolcode4, bcontrolcode1, bcontrolcode2, bcontrolcode3, bcontrolcode4, enableobjectoffsets, enableplayeroffsets, enablemapoffsets, fadespeed, pace, objectstep, collisionstep, playeridle, footpace, fontname$, fontsize, fontstyle$, fontbuffer, imode, playerwalkdivide, scriptwalkdivide, scriptimage$, scriptimageresx, scriptimageresy, pockethudimage$, pockethudresx, pockethudresy, pocketarrowright$, pocketarrowleft$, pocketarrowselectright$, pocketarrowselectleft$, pocketarrowunavailableright$, pocketarrowunavailableleft$, pocketarrowresx, pocketarrowresy, pockethudanispeed, pocketarrowrlocx, pocketarrowrlocy, pocketarrowllocx, pocketarrowllocy, pocketspritex, pocketspritey, pocketspriteresx, pocketspriteresy, pocketbanner$, pocketbannerresx, pocketbannerresy, textbannersound, textbanner$, textbannername$, textbannerresx, textbannerresy, pocketselect$, pocketselectx, pocketselecty, pocketselectresx, pocketselectresy, lookaction$, lookx, useaction$, giveaction$, combineaction$, usex, givex, combinex, textbannerfacey, textbannerfaceresx, textbannerfaceresy, choicebanner$, choicearrowl, choicearrowr, tos$, tdelay, stposx, stposy, tanidelay, terminalcol1, terminalcol2, terminalcol3, terminalrow1, terminalrow2, terminalfacex, terminalfacey, currencyname$, loadicon$, loadiconresx, loadiconresy, saveicon$, saveiconresx, saveiconresy, downloadicon$, downloadiconresx, downloadiconresy, torcheffectfile$, loadbar$, devlogo$, devlogomode, awardbanner$, awardbannerresx, awardbannerresy, awardbannerlocx, awardbannerlocy, awarditemresx, awarditemresy, awarditemlocx, awarditemlocy, awardtextlocx, awardtextlocy, awardgracetime, awardtitle$, awardnotification$, awardspeed, awardnone$, awardarrowleft$, awardarrowright$, awardarrowselectleft$, awardarrowselectright$, versionno$, engineversionno$, updatelink$, letmenuselectcolourr, letmenuselectcolourg, letmenuselectcolourb, letmenuselectcoloura, bgmenuselectcolourr, bgmenuselectcolourg, bgmenuselectcolourb, bgmenuselectcoloura, letmenudefaultcolourr, letmenudefaultcolourg, letmenudefaultcolourb, letmenudefaultcoloura, bgmenudefaultcolourr, bgmenudefaultcolourg, bgmenudefaultcolourb, bgmenudefaultcoloura, letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura, bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura, letpocketselectcolourr, letpocketselectcolourg, letpocketselectcolourb, letpocketselectcoloura, bgpocketselectcolourr, bgpocketselectcolourg, bgpocketselectcolourb, bgpocketselectcoloura, letpocketdefaultcolourr, letpocketdefaultcolourg, letpocketdefaultcolourb, letpocketdefaultcoloura, bgpocketdefaultcolourr, bgpocketdefaultcolourg, bgpocketdefaultcolourb, bgpocketdefaultcoloura, letcurrencycolourr, letcurrencycolourg, letcurrencycolourb, letcurrencycoloura, bgcurrencycolourr, bgcurrencycolourg, bgcurrencycolourb, bgcurrencycoloura, letspeechcolourr, letspeechcolourg, letspeechcolourb, letspeechcoloura, bgspeechcolourr, bgspeechcolourg, bgspeechcolourb, bgspeechcoloura, letterminalcolourr, letterminalcolourg, letterminalcolourb, letterminalcoloura, bgterminalcolourr, bgterminalcolourg, bgterminalcolourb, bgterminalcoloura, letselectbannercolourr, letselectbannercolourg, letselectbannercolourb, letselectbannercoloura, bgselectbannercolourr, bgselectbannercolourg, bgselectbannercolourb, bgselectbannercoloura, spoofoptiontitle$, spoofoption1$, spoofoption2$, spoofoption1result$, spoofoption2result$, moddingname$
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
        END
    END IF
ELSE
	BEEP
    PRINT "MISSING ENGINE.DDF"
    END
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
        END
    END IF
LOOP UNTIL temp6 = 14
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
DIM pointx(arraylimit) AS INTEGER
DIM pointy(arraylimit) AS INTEGER
REM enable console
$CONSOLE
_CONSOLE ON
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
PRINT "Y/N"
INPUT a$
IF UCASE$(a$) = "N" THEN 
	PRINT "Operation aborted by user."
	IF ros$ = "win" THEN SHELL _HIDE "del " + dloc$ + "objectlist.tmp"
	IF ros$ = "lnx" THEN SHELL _HIDE "rm " + dloc$ + "objectlist.tmp"
	END
END IF
IF UCASE$(a$) = "Y" THEN GOTO generatepoints
GOTO areyousure

generatepoints:
REM generates point data for array
FOR x = 1 TO numberofobjects
	PRINT "Checking data for object: " + objectname$(x) + " (" + LTRIM$(STR$(x)) + "/" + LTRIM$(STR$(numberofobjects)) + ")"
	_DELAY 1
	IF _FILEEXISTS(oloc$ + objectname$(x) + "/" + objectname$(x) + "a.png") THEN
		REM import data
		OPEN oloc$ + objectname$(x) + "/" + objectname$(x) + ".ddf" FOR INPUT AS #1
		INPUT #1, objectlongname$(x), objectresx(x), objectresy(x), objects(x), objectlayer(x), objectspeed(x), objectcollision(x)
		CLOSE #1
		PRINT "Generating point data for object: " + objectname$(x) + " (" + LTRIM$(STR$(x)) + "/" + LTRIM$(STR$(numberofobjects)) + ")"
		GOSUB pointingfordummies
		PRINT "Point data generated for object: " + objectname$(x) + " (" + LTRIM$(STR$(x)) + "/" + LTRIM$(STR$(numberofobjects)) + ")"
		_DELAY 1
	ELSE
		REM skip item
		BEEP
		PRINT "Sprites for object " + objectname$(x) + " were not found! Skipping..."
		_DELAY 1
	END IF
NEXT x
PRINT "Point generation complete!"
GOTO savedata

pointingfordummies:
REM probes sprites for point data
SCREEN _NEWIMAGE(objectresx(x) + 1, objectresy(x) + 1, 32)
LET spritefile = _LOADIMAGE(oloc$ + objectname$(x) + "/" + objectname$(x) + "a.png")
_PUTIMAGE(1, 1), spritefile
LET px = 0
LET py = 0
LET pointloop = 0
LET endloop = 0
DO
	LET pointloop = pointloop + 1
	LET objectpoint(pointloop) = POINT(px, py)
	LET pointx(pointloop) = px
	LET pointy(pointloop) = py
	_DEST _CONSOLE
	PRINT LTRIM$(STR$(pointx(pointloop))) + "," + LTRIM$(STR$(pointy(pointloop))) + ": " + LTRIM$(STR$(objectpoint(pointloop)))
	_DEST 0
	LET px = px + 1
	IF px => objectresx(x) + 1 AND py => objectresy(x) + 1 THEN LET endloop = 1
	IF px > objectresx(x) THEN LET px = 1: LET py = py + 1
	_DELAY 0.001
LOOP UNTIL endloop = 1
SCREEN 0
_FREEIMAGE spritefile
RETURN

savedata:
REM saves the point data to file
PRINT
PRINT "Saving point data to object files..."
FOR x = 1 TO numberofobjects
	PRINT "Saving point data to object: " + objectname$(x) + " (" + LTRIM$(STR$(x)) + "/" + LTRIM$(STR$(numberofobjects)) + ")"
	OPEN oloc$ + objectname$(x) + "/" + objectname$(x) + ".ddf" FOR OUTPUT AS #1
	WRITE #1, objectlongname$(x), objectresx(x), objectresy(x), objects(x), objectlayer(x), objectspeed(x), objectcollision(x)
	FOR d = 1 TO (objectresx(x) * objectresy(x))
		IF objectpoint(d) <> 0 THEN WRITE #1, pointx(d), pointy(d)
	NEXT d
	CLOSE #1
	_DELAY 0.1
	PRINT "Point data for object: " + objectname$(x) + " is saved!"
NEXT x
PRINT
PRINT "Object point collision fully generated and saved!"
PRINT "Have a nice day :)"
IF ros$ = "win" THEN SHELL _HIDE "del " + dloc$ + "objectlist.tmp"
IF ros$ = "lnx" THEN SHELL _HIDE "rm " + dloc$ + "objectlist.tmp"
END



