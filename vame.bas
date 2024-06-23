REM Variable Map Engine
REM Build 2.8.78
REM By Danielle Pond

REM icon, version info and error handler
ON ERROR GOTO errorhandler
$VERSIONINFO:CompanyName=STUDIO_POND
$VERSIONINFO:ProductName=VaME
$VERSIONINFO:FileDescription=Variable Map Engine
$VERSIONINFO:InternalName=VaME
$VERSIONINFO:FILEVERSION#=2,8,78,2878
$VERSIONINFO:PRODUCTVERSION#=2,8,78,2878
$EXEICON:'data\icon.ico'
_ICON
LET hardbuild$ = "2.8.78"

setup:
REM initiates engine and assigns values
LET setupboot = 1: REM sets value for engine booting
_ALLOWFULLSCREEN _OFF: REM block alt-enter
REM check os
IF INSTR(_OS$, "[WINDOWS]") THEN LET ros$ = "win"
IF INSTR(_OS$, "[LINUX]") THEN LET ros$ = "lnx"
IF INSTR(_OS$, "[MACOSX]") THEN LET ros$ = "mac"
IF ros$ <> "win" AND ros$ <> "lnx" AND ros$ <> "mac" THEN ERROR 430
GOSUB modload: REM checks to see if any mods are requested instead of main game
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
        ERROR 420
    END IF
    REM establishes print mode
    _PRINTMODE _FILLBACKGROUND
    REM launches console
    $CONSOLE
    IF displayconsole = 1 THEN
        _CONSOLE ON
        IF title$ <> "" THEN
            _CONSOLETITLE title$ + " Console"
        ELSE
            _CONSOLETITLE "VaME Console"
        END IF
    END IF
    IF displayconsole = 0 THEN _CONSOLE OFF
    REM reports system info to console
    GOSUB consoleboot: REM announces system boot to consolelog.txt
    LET eventtitle$ = "OPERATING SYSTEM DETECTED:"
    IF ros$ = "win" THEN LET eventdata$ = "Microsoft Windows"
    IF ros$ = "lnx" THEN LET eventdata$ = "Linux"
    IF ros$ = "mac" THEN LET eventdata$ = "Apple macOS"
    LET eventnumber = 0
    GOSUB consoleprinter
    LET eventtitle$ = "LOADED METADATA:"
    LET eventdata$ = dloc$ + "engine.ddf"
    LET eventnumber = 0
    GOSUB consoleprinter
ELSE
    ERROR 420: REM error if directory unavailable
END IF
IF title$ = "" THEN LET title$ = "VaME": REM sets program name if none exists
REM report game title and engine info to console...
LET eventtitle$ = "ENGINE VERSION NUMBER:"
LET eventdata$ = hardbuild$
LET eventnumber = 0
GOSUB consoleprinter
IF modrunning = 0 THEN LET eventtitle$ = "GAME DATA FOUND:"
IF modrunning = 1 THEN LET eventtitle$ = "MOD DATA FOUND:"
LET eventdata$ = title$
LET eventnumber = 0
GOSUB consoleprinter
IF modrunning = 0 THEN LET eventtitle$ = "GAME VERSION NUMBER:"
IF modrunning = 1 THEN LET eventtitle$ = "MOD VERSION NUMBER:"
LET eventdata$ = versionno$
LET eventnumber = 0
GOSUB consoleprinter
REM checks build versions match, checks for developer build
LET finddev% = INSTR(finddev% + 1, engineversionno$, "DEV")
IF finddev% THEN LET hardbuild$ = hardbuild$ + "DEV": LET finddev% = 0
IF engineversionno$ <> hardbuild$ THEN ERROR 427
REM check if remaining metadata directories exist
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
        LET eventtitle$ = "DIRECTORY ACTIVE:"
        LET eventdata$ = temp3$
        LET eventnumber = 0
        GOSUB consoleprinter
    ELSE
        ERROR 421: REM error if directory unavailable
    END IF
LOOP UNTIL temp6 = 14
LET fadestatus = -1: REM resets fade tracking value for first time use
GOSUB parameterload: REM loads any launch parameters
GOSUB dimmer: REM assigns array values
GOSUB deleteupdaters: REM deletes any left over updater files
GOSUB inputload: REM checks and informs console of enabled game controls
GOSUB optionload: REM loads options values
GOSUB saveload: REM load savedata values
GOSUB screenload: REM sets screen and resolution settings
GOSUB uiload: REM loads misc items into memory for quick access later
GOSUB loadbarsetup: REM sets up loading bar
GOSUB loadbar: REM display loading bar
GOSUB fontload: REM loads font
GOSUB musicload: REM loads music files into memory for quick access later
GOSUB sfxload: REM loads sound effect files into memory for quick access later
GOSUB pocketload: REM loads pocket files into memory for quick access later
GOSUB awardload: REM loads game award files into memory
GOSUB terminalload: REM loads terminal files into memory for quick access later
IF noupdate = 0 AND erasesaveonly = 0 AND savedisplay = 0 THEN GOSUB updatechecker: REM checks the internet for updates
REM displays developer logo
GOSUB devlogo
IF erasesaveonly = 1 THEN GOTO erasesave
REM directs to mainmenu
LET menu$ = "mainmenu"
GOSUB menugenerator
REM setup timer
RANDOMIZE TIMER
LET itime = TIMER: REM timer function
LET sitime = TIMER: REM save timer function
LET ctime = 0: REM timer function
LET stime = 0: REM save timer function
LET frames = 0: REM reset frame count
GOSUB mainplayerload: REM loads player data
GOSUB mapload: REM loads map data
REM scrub temporary values
LET temp6 = 0: LET temp3$ = "": LET setupboot = 0
GOTO game

dimmer:
REM assigns array values
REM map object values
DIM objectname(totalobjects) AS STRING
DIM objectlongname(totalobjects) AS STRING
DIM objectx(totalobjects) AS DOUBLE
DIM objecty(totalobjects) AS DOUBLE
DIM objects(totalobjects) AS INTEGER
DIM objectl(totalobjects) AS INTEGER
DIM objectlayer(totalobjects) AS INTEGER
DIM objectspeed(totalobjects) AS INTEGER
DIM objectoffset(totalobjects) AS SINGLE
DIM objectresx(totalobjects) AS INTEGER
DIM objectresy(totalobjects) AS INTEGER
DIM objecta(totalobjects) AS INTEGER
DIM objectb(totalobjects) AS INTEGER
DIM objectcollision(totalobjects) AS INTEGER
DIM findobject(totalobjects) AS INTEGER
DIM autoobjectcull(totalobjects) AS INTEGER
DIM objecthighlight(totalobjects) AS INTEGER
REM map player values
DIM playername(totalplayers) AS STRING
DIM playerlongname(totalplayers) AS STRING
DIM playerx(totalplayers) AS DOUBLE
DIM playery(totalplayers) AS DOUBLE
DIM mplayerx(totalplayers) AS INTEGER
DIM mplayery(totalplayers) AS INTEGER
DIM playergrace(totalplayers) AS INTEGER
DIM playerdefault(totalplayers) AS INTEGER
DIM playerspeed(totalplayers) AS INTEGER
DIM playerresx(totalplayers) AS INTEGER
DIM playerresy(totalplayers) AS INTEGER
DIM players(totalplayers) AS INTEGER
DIM playercollision(totalplayers) AS INTEGER
DIM playernote1(totalplayers) AS INTEGER
DIM playernote2(totalplayers) AS INTEGER
DIM carryplayerd(totalplayers) AS INTEGER
DIM carryplayerjourney(totalplayers) AS INTEGER
DIM carryplayerx(totalplayers) AS INTEGER
DIM carryplayery(totalplayers) AS INTEGER
DIM carryplayerlayer(totalplayers) AS INTEGER
DIM carryplayerperiod(totalplayers) AS INTEGER
DIM dplayerx(totalplayers) AS INTEGER
DIM dplayery(totalplayers) AS INTEGER
DIM playerd(totalplayers) AS INTEGER
DIM playerjourney(totalplayers) AS INTEGER
DIM playeroffset(totalplayers) AS SINGLE
DIM playerperiod(totalplayers) AS INTEGER
DIM playerscript(totalplayers) AS INTEGER
DIM playerwalking(totalplayers) AS INTEGER
DIM pfootloop(totalplayers) AS INTEGER
DIM pfoot(totalplayers) AS INTEGER
DIM findplayer(totalplayers) AS INTEGER
DIM playerf(totalplayers) AS INTEGER
DIM playerb(totalplayers) AS INTEGER
DIM playerr(totalplayers) AS INTEGER
DIM playerl(totalplayers) AS INTEGER
DIM playerfl(totalplayers) AS INTEGER
DIM playerfr(totalplayers) AS INTEGER
DIM playerbl(totalplayers) AS INTEGER
DIM playerbr(totalplayers) AS INTEGER
DIM playerrl(totalplayers) AS INTEGER
DIM playerrr(totalplayers) AS INTEGER
DIM playerll(totalplayers) AS INTEGER
DIM playerlr(totalplayers) AS INTEGER
DIM playerfi1(totalplayers) AS INTEGER
DIM playerfi2(totalplayers) AS INTEGER
DIM playerbi1(totalplayers) AS INTEGER
DIM playerbi2(totalplayers) AS INTEGER
DIM playerli1(totalplayers) AS INTEGER
DIM playerli2(totalplayers) AS INTEGER
DIM playerri1(totalplayers) AS INTEGER
DIM playerri2(totalplayers) AS INTEGER
DIM playerface1(totalplayers) AS INTEGER
DIM playerface2(totalplayers) AS INTEGER
DIM playerlayer(totalplayers) AS INTEGER
DIM playerlayer2(totalplayers) AS INTEGER
DIM autoplayercull(totalplayers) AS INTEGER
DIM playerhighlight(totalplayers) AS INTEGER
REM sfx values
DIM sfx(totalsfxs) AS STRING
DIM sfxdata(totalsfxs) AS INTEGER
REM music values
DIM music(totalmusics) AS STRING
DIM musicdata(totalmusics) AS INTEGER
REM map trigger values
DIM triggername(totaltriggers) AS STRING
DIM triggerx1(totaltriggers) AS INTEGER
DIM triggery1(totaltriggers) AS INTEGER
DIM triggerx2(totaltriggers) AS INTEGER
DIM triggery2(totaltriggers) AS INTEGER
DIM triggera(totaltriggers) AS INTEGER
DIM triggerd(totaltriggers) AS INTEGER
REM pocket values
DIM pocketname(totalpockets) AS STRING
DIM pocketshort(totalpockets) AS STRING
DIM pocketdescription(totalpockets) AS STRING
DIM pocketitem(totalpockets) AS INTEGER
DIM temppocketitem(totalpockets) AS INTEGER
DIM pocketsprite(totalpockets) AS INTEGER
DIM pocketvisible(totalpockets) AS INTEGER
DIM temppocketvisible(totalpockets) AS INTEGER
FOR x = 1 TO totalpockets
    LET pocketvisible(x) = 1
NEXT x
REM checkpoint values
DIM checkpoint(totalcheckpoints) AS INTEGER
DIM tempcheckpoint(totalcheckpoints) AS INTEGER
REM animation values
DIM frame(totalframes) AS INTEGER
DIM aniframe(totalframes) AS INTEGER
REM award values
DIM awardname(totalawards) AS STRING
DIM awarddescription(totalawards) AS STRING
DIM awardvalue(totalawards) AS INTEGER
DIM awardsprite(totalawards) AS INTEGER
DIM tempawardvalue(totalawards) AS INTEGER
REM extra values
DIM choicename(100) AS STRING
DIM bannercharacter(100000) AS STRING
DIM bannertemp(100000) AS STRING
DIM scriptvalue(totalscriptvalues) AS INTEGER
DIM tempscriptvalue(totalscriptvalues) AS INTEGER
DIM frames AS _INTEGER64
DIM temps(100000) AS STRING
DIM tempn(100000) AS DOUBLE
CONST RSHIFT& = 100303
CONST LSHIFT& = 100304
REM print to console
LET eventtitle$ = "OBJECT ARRAY LIMIT:"
LET eventdata$ = ""
LET eventnumber = totalobjects
GOSUB consoleprinter
LET eventtitle$ = "PLAYER ARRAY LIMIT:"
LET eventdata$ = ""
LET eventnumber = totalplayers
GOSUB consoleprinter
LET eventtitle$ = "TRIGGER ARRAY LIMIT:"
LET eventdata$ = ""
LET eventnumber = totaltriggers
GOSUB consoleprinter
LET eventtitle$ = "POCKET ARRAY LIMIT:"
LET eventdata$ = ""
LET eventnumber = totalpockets
GOSUB consoleprinter
LET eventtitle$ = "CHECKPOINT ARRAY LIMIT:"
LET eventdata$ = ""
LET eventnumber = totalcheckpoints
GOSUB consoleprinter
LET eventtitle$ = "ANIMATION FRAME ARRAY LIMIT:"
LET eventdata$ = ""
LET eventnumber = totalframes
GOSUB consoleprinter
LET eventtitle$ = "MUSIC ARRAY LIMIT:"
LET eventdata$ = ""
LET eventnumber = totalmusics
GOSUB consoleprinter
LET eventtitle$ = "SOUND EFFECT ARRAY LIMIT:"
LET eventdata$ = ""
LET eventnumber = totalsfxs
GOSUB consoleprinter
LET eventtitle$ = "ARRAY VALUES ASSIGNED"
LET eventdata$ = ""
LET eventnumber = 0
GOSUB consoleprinter
RETURN

generateoffsets:
REM generates random map animation offsets
REM objects
IF enableobjectoffsets = 1 THEN
    DO
        LET x = x + 1
        LET objectoffset(x) = RND
    LOOP UNTIL x >= mapobjectno OR x >= totalobjects
    IF mapobjectno <> 0 THEN
        LET eventtitle$ = "OFFSETS GENERATED:"
        LET eventdata$ = "objects"
        LET eventnumber = mapobjectno
        GOSUB consoleprinter
    END IF
END IF
LET x = 0
REM players
IF enableplayeroffsets = 1 THEN
    DO
        LET x = x + 1
        LET playeroffset(x) = RND
    LOOP UNTIL x >= mapplayerno OR x >= totalplayers
    IF mapplayerno <> 0 THEN
        LET eventtitle$ = "OFFSETS GENERATED:"
        LET eventdata$ = "players"
        LET eventnumber = mapplayerno
        GOSUB consoleprinter
    END IF
END IF
REM map
IF enablemapoffsets = 1 THEN
    LET mapanioffset = RND
    LET parallaxoffset = RND
    LET eventtitle$ = "OFFSET GENERATED:"
    LET eventdata$ = "map"
    LET eventnumber = mapno
    GOSUB consoleprinter
END IF
LET x = 0: REM scrub temp values
RETURN

inputload:
REM checks and informs console of enabled inputs
DO
    LET temp139 = temp139 + 1
    LET eventtitle$ = "INPUT CONRTOL:"
    IF temp139 = 1 THEN
        IF ucontrol = 1 THEN
            IF ucontrolcode1 = 0 THEN ERROR 428
            IF ucontrolcode2 = 0 THEN LET ucontrolcode2 = 6666666
            IF ucontrolcode3 = 0 THEN LET ucontrolcode3 = 6666666
            IF ucontrolcode4 = 0 THEN LET ucontrolcode4 = 6666666
            LET eventdata$ = "up control enabled"
        ELSE
            LET eventdata$ = "up control disabled"
        END IF
    END IF
    IF temp139 = 2 THEN
        IF dcontrol = 1 THEN
            IF dcontrolcode1 = 0 THEN ERROR 428
            IF dcontrolcode2 = 0 THEN LET dcontrolcode2 = 6666666
            IF dcontrolcode3 = 0 THEN LET dcontrolcode3 = 6666666
            IF dcontrolcode4 = 0 THEN LET dcontrolcode4 = 6666666
            LET eventdata$ = "down control enabled"
        ELSE
            LET eventdata$ = "down control disabled"
        END IF
    END IF
    IF temp139 = 3 THEN
        IF lcontrol = 1 THEN
            IF lcontrolcode1 = 0 THEN ERROR 428
            IF lcontrolcode2 = 0 THEN LET lcontrolcode2 = 6666666
            IF lcontrolcode3 = 0 THEN LET lcontrolcode3 = 6666666
            IF lcontrolcode4 = 0 THEN LET lcontrolcode4 = 6666666
            LET eventdata$ = "left control enabled"
        ELSE
            LET eventdata$ = "left control disabled"
        END IF
    END IF
    IF temp139 = 4 THEN
        IF rcontrol = 1 THEN
            IF rcontrolcode1 = 0 THEN ERROR 428
            IF rcontrolcode2 = 0 THEN LET rcontrolcode2 = 6666666
            IF rcontrolcode3 = 0 THEN LET rcontrolcode3 = 6666666
            IF rcontrolcode4 = 0 THEN LET rcontrolcode4 = 6666666
            LET eventdata$ = "right control enabled"
        ELSE
            LET eventdata$ = "right control disabled"
        END IF
    END IF
    IF temp139 = 5 THEN
        IF scontrol = 1 THEN
            IF scontrolcode1 = 0 THEN ERROR 428
            IF scontrolcode2 = 0 THEN LET scontrolcode2 = 6666666
            IF scontrolcode3 = 0 THEN LET scontrolcode3 = 6666666
            IF scontrolcode4 = 0 THEN LET scontrolcode4 = 6666666
            LET eventdata$ = "select control enabled"
        ELSE
            LET eventdata$ = "select control disabled"
        END IF
    END IF
    IF temp139 = 6 THEN
        IF pcontrol = 1 THEN
            IF pcontrolcode1 = 0 THEN ERROR 428
            IF pcontrolcode2 = 0 THEN LET pcontrolcode2 = 6666666
            IF pcontrolcode3 = 0 THEN LET pcontrolcode3 = 6666666
            IF pcontrolcode4 = 0 THEN LET pcontrolcode4 = 6666666
            LET eventdata$ = "pocket control enabled"
        ELSE
            LET eventdata$ = "pocket control disabled"
        END IF
    END IF
    IF temp139 = 7 THEN
        IF bcontrol = 1 THEN
            IF bcontrolcode1 = 0 THEN ERROR 428
            IF bcontrolcode2 = 0 THEN LET bcontrolcode2 = 6666666
            IF bcontrolcode3 = 0 THEN LET bcontrolcode3 = 6666666
            IF bcontrolcode4 = 0 THEN LET bcontrolcode4 = 6666666
            LET eventdata$ = "back control enabled"
        ELSE
            LET eventdata$ = "back control disabled"
        END IF
    END IF
    LET eventnumber = temp139
    GOSUB consoleprinter
LOOP UNTIL temp139 = 7
LET temp139 = 0: REM scrubs temp values
RETURN

deleteupdaters:
REM deletes any updater files if needed
IF _FILEEXISTS(LCASE$(filename$) + "updater_win.exe") THEN
    REM windows updater
    SHELL _HIDE "del " + LCASE$(filename$) + "updater_win.exe"
    LET temp132 = 1
END IF
IF _FILEEXISTS(LCASE$(filename$) + "updater_linux") THEN
    REM linux updater
    SHELL _HIDE "rm " + LCASE$(filename$) + "updater_linux"
    LET temp132 = 1
END IF
IF _FILEEXISTS(LCASE$(filename$) + "updater_macos") THEN
	REM macos updater
	SHELL _HIDE "rm " + LCASE$(filename$) + "updater_macos"
	LET temp132 = 1
END IF
IF _FILEEXISTS("windownloader.bat") THEN
    REM download batch file for windows
    SHELL _HIDE "del windownloader.bat"
    LET temp132 = 1
END IF
IF _FILEEXISTS("checkupdate.ddf") THEN
    REM latest update metadata
    IF ros$ = "win" THEN
        SHELL _HIDE "del checkupdate.ddf"
    ELSE
        SHELL _HIDE "rm checkupdate.ddf"
    END IF
    LET temp132 = 1
END IF
IF _FILEEXISTS(LCASE$(title$) + "update.zip") THEN
    REM compressed update files
    IF ros$ = "win" THEN
        SHELL _HIDE "del " + LCASE$(title$) + "update.zip"
    ELSE
        SHELL _HIDE "rm " + LCASE$(title$) + "update.zip"
    END IF
    LET temp132 = 1
END IF
IF _FILEEXISTS("unzip.exe") THEN
    REM uncompressor for windows
    SHELL _HIDE "del unzip.exe"
    LET temp132 = 1
END IF
IF _FILEEXISTS("updatevals.ddf") THEN
    REM additional update values
    IF ros$ = "win" THEN
        SHELL _HIDE "del updatevals.ddf"
    ELSE
        SHELL _HIDE "rm updatevals.ddf"
    END IF
    LET temp132 = 1
END IF
IF temp132 = 1 THEN
    REM prints to console
    LET eventtitle$ = "UPDATER FILE DELETED"
    LET eventdata$ = ""
    LET eventnumber = 0
    GOSUB consoleprinter
END IF
LET temp132 = 0
RETURN

modload:
REM loads mods
IF _COMMANDCOUNT = 0 THEN
    IF ros$ = "win" THEN LET dloc$ = "data\": LET consolelog$ = "data\consolelog.txt"
    IF ros$ = "lnx" OR ros$ = "mac" THEN LET dloc$ = "data/": LET consolelog$ = "data/consolelog.txt"
    RETURN
END IF
DO
    LET temp158 = temp158 + 1
    LET parameter$ = COMMAND$(temp158)
    LET findmod% = INSTR(findmod% + 1, UCASE$(parameter$), "-MOD=")
LOOP UNTIL temp158 >= _COMMANDCOUNT
IF findmod% > 1 THEN ERROR 431: REM errors out if more than one mod is loaded
REM sets mod folder to use if mod is requested
IF findmod% THEN
    REM mod parameter found - strips mod name from parameter
    LET findmod% = 0
    LET dloc$ = RIGHT$(parameter$, LEN(parameter$) - INSTR(parameter$, "="))
    LET dloc$ = LCASE$(dloc$)
    LET modname$ = dloc$
    IF modname$ = "data" THEN ERROR 432
    IF ros$ = "win" THEN LET dloc$ = dloc$ + "\"
    IF ros$ = "lnx" OR ros$ = "mac" THEN LET dloc$ = dloc$ + "/"
    LET consolelog$ = dloc$ + "consolelog.txt"
    REM checks requested mod folder and engine.ddf exists
    IF _FILEEXISTS(dloc$ + "engine.ddf") THEN
        LET noupdate = 1: REM disables updates if mod is running
        LET modrunning = 1: REM lets engine know its a mod that is running
    ELSE
        ERROR 432: REM error if mod isnt found
    END IF
ELSE
    REM no mod parameter found
    IF ros$ = "win" THEN LET dloc$ = "data\": LET consolelog$ = "data\consolelog.txt"
    IF ros$ = "lnx" OR ros$ = "mac" THEN LET dloc$ = "data/": LET consolelog$ = "data/consolelog.txt"
END IF
LET temp158 = 0: REM scrub temp values
RETURN

parameterload:
REM loads and applies any launch parameters (excluding mods)
IF _COMMANDCOUNT = 0 THEN RETURN: REM return for if no parameters
DO
    LET temp129 = temp129 + 1
    LET parameter$ = COMMAND$(temp129)
    LET findmod% = INSTR(findmod% + 1, UCASE$(parameter$), "-MOD=")
    LET findplayrecord% = INSTR(findplayrecord% + 1, UCASE$(parameter$), "-PLAYRECORD=")
    IF UCASE$(parameter$) = "-LITE" THEN LET liteload = 1: LET soundmode = 1: LET temp130 = 1
    IF UCASE$(parameter$) = "-NOUPDATE" THEN LET noupdate = 1: LET temp130 = 1
    IF UCASE$(parameter$) = "-DEVMODE" THEN LET devmode = 1: LET temp130 = 1
    IF UCASE$(parameter$) = "-CONSOLE" THEN LET displayconsole = 1: LET temp130 = 1
    IF UCASE$(parameter$) = "-ERASESAVE" THEN LET erasesaveonly = 1: LET temp130 = 1
    IF UCASE$(parameter$) = "-NOSAVE" THEN LET nosave = 1: LET temp130 = 1
    IF UCASE$(parameter$) = "-NOFX" THEN LET disablefade = 1: LET temp130 = 1
    IF UCASE$(parameter$) = "-FIX" THEN LET fixvame = 1: LET temp130 = 1
    IF UCASE$(parameter$) = "-WINDOWED" THEN LET forcewindowed = 1: LET temp130 = 1
    IF UCASE$(parameter$) = "-FULLSCREEN" THEN LET forcefullscreen = 1: LET temp130 = 1
    IF findmod% THEN LET temp130 = 1
    IF temp130 = 1 THEN
        LET eventtitle$ = "PARAMETER LOADED:"
        LET eventdata$ = parameter$
        LET eventnumber = 0
        GOSUB consoleprinter
    ELSE
        LET eventtitle$ = "INVALID PARAMETER:"
        LET eventdata$ = parameter$
        LET eventnumber = 0
        GOSUB consoleprinter
    END IF
    LET temp130 = 0: LET findmod% = 0
LOOP UNTIL temp129 >= _COMMANDCOUNT
REM errors for conflicting parameters
IF fixvame = 1 AND noupdate = 1 THEN ERROR 426
IF forcewindowed = 1 AND forcefullscreen = 1 THEN ERROR 433
LET temp129 = 0: LET temp130 = 0: LET findmod% = 0: REM scrub temp values
RETURN

devlogo:
REM developer logo
REM play sound (if needed)
FOR logoloop = 1 TO devlogono
    IF devlogomode = 1 THEN
        LET playsfx$ = "devlogo" + LTRIM$(STR$(logoloop))
        GOSUB sfxplay
    END IF
    LET temp206 = (fadespeed - fadespeed) - fadespeed
    FOR i% = 255 TO 0 STEP temp206
        _LIMIT hertz: REM sets framerate
        IF logoloop = 1 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo1
        IF logoloop = 2 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo2
        IF logoloop = 3 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo3
        IF logoloop = 4 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo4
        IF logoloop = 5 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo5
        IF logoloop = 6 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo6
        IF logoloop = 7 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo7
        IF logoloop = 8 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo8
        IF logoloop = 9 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo9
        IF logoloop = 10 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo10
        LINE (0, 0)-(resx - 1, resy - 1), _RGBA(0, 0, 0, i%), BF: REM slowly fills screen with black box
        _DISPLAY
    NEXT
    _AUTODISPLAY
    IF logoloop = 1 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo1
    IF logoloop = 2 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo2
    IF logoloop = 3 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo3
    IF logoloop = 4 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo4
    IF logoloop = 5 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo5
    IF logoloop = 6 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo6
    IF logoloop = 7 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo7
    IF logoloop = 8 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo8
    IF logoloop = 9 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo9
    IF logoloop = 10 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo10
    REM play sound (if needed)
    IF devlogomode = 2 THEN
        LET playsfx$ = "devlogo" + LTRIM$(STR$(logoloop))
        GOSUB sfxplay
    END IF
    _KEYCLEAR
    DO
        LET temp128 = temp128 + 1
        _DELAY 1
    LOOP UNTIL _KEYHIT = scontrolcode1 OR _KEYHIT = scontrolcode2 OR _KEYHIT = scontrolcode3 OR _KEYHIT = scontrolcode4 OR temp128 = 3
    _KEYCLEAR
    LET eventtitle$ = "DEVELOPER LOGO" + STR$(logoloop) + " DISPLAYED"
    LET eventdata$ = ""
    LET eventnumber = 0
    GOSUB consoleprinter
    LET temp206 = fadespeed
    FOR i% = 0 TO 255 STEP temp206
        _LIMIT hertz: REM sets framerate
        IF logoloop = 1 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo1
        IF logoloop = 2 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo2
        IF logoloop = 3 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo3
        IF logoloop = 4 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo4
        IF logoloop = 5 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo5
        IF logoloop = 6 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo6
        IF logoloop = 7 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo7
        IF logoloop = 8 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo8
        IF logoloop = 9 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo9
        IF logoloop = 10 THEN _PUTIMAGE (0, 0)-(resx - 1, resy - 1), devlogo10
        LINE (0, 0)-(resx, resy), _RGBA(0, 0, 0, i%), BF: REM slowly empties black box from screen
        _DISPLAY
    NEXT
    _AUTODISPLAY
    LET temp128 = 0: REM scrub temp values
NEXT logoloop
RETURN

loadbarsetup:
REM gathers amount of assets to be loaded
LET loadassets = 0
OPEN pocketloc$ + "pocketfiles.ddf" FOR INPUT AS #1
DO
    INPUT #1, temp$
    LET loadassets = loadassets + 1
LOOP UNTIL EOF(1)
CLOSE #1
OPEN museloc$ + "musicfiles.ddf" FOR INPUT AS #1
DO
    INPUT #1, temp$
    LET loadassets = loadassets + 1
LOOP UNTIL EOF(1)
CLOSE #1
OPEN sfxloc$ + "sfxfiles.ddf" FOR INPUT AS #1
DO
    INPUT #1, temp$
    LET loadassets = loadassets + 1
LOOP UNTIL EOF(1)
CLOSE #1
OPEN awardloc$ + "awards.ddf" FOR INPUT AS #1
DO
    INPUT #1, temp$
    INPUT #1, temp$
    LET loadassets = loadassets + 1
LOOP UNTIL EOF(1)
CLOSE #1
LET loadassets = loadassets + 3
LET loadbarsize = (resx - (loadiconresx + 5) - 5)
LET loadcount = 0
LET loadbarsize = loadbarsize / loadassets
RETURN

loadbar:
REM displays loading gfx
LET temp127 = temp125
LET loadcount = loadcount + 1
_PUTIMAGE (1, 1)-(loadiconresx, loadiconresy), loadicon: REM displays load icon
_PUTIMAGE (loadiconresx + 5, 1)-((loadiconresx + 5) + temp127 - 1, loadiconresy), loadbar: REM displays load bar
RETURN

awardload:
REM loads awards into memory
OPEN awardloc$ + "awards.ddf" FOR INPUT AS #1
DO
    LET temp211 = temp211 + 1
    INPUT #1, awardname$(temp211)
    INPUT #1, awarddescription$(temp211)
    LET awardsprite(temp211) = _LOADIMAGE(awardloc$ + "award" + LTRIM$(STR$(temp211)) + ".png")
    REM prints load to console
    LET eventtitle$ = "AWARD LOADED:"
    LET eventdata$ = awardname$(temp211)
    LET eventnumber = temp211
    GOSUB consoleprinter
    REM updates loadbar
    IF setupboot = 1 THEN
        LET temp125 = temp125 + loadbarsize
        GOSUB loadbar
    END IF
LOOP UNTIL EOF(1) OR temp211 >= totalawards
CLOSE #1
LET temp211 = 0: REM scrub temp values
RETURN

pocketload:
REM loads pocket items into memory
REM open file list
OPEN pocketloc$ + "pocketfiles.ddf" FOR INPUT AS #1
REM load sprites and metadata
DO
    LET temp57 = temp57 + 1
    INPUT #1, pocketfile$: REM reads name of pocket file to be loaded
    OPEN pocketloc$ + pocketfile$ + "/" + pocketfile$ + ".ddf" FOR INPUT AS #666
    REM loads pocket files and assigns them a slot
    INPUT #666, pocketname(temp57), pocketdescription(temp57): LET pocketsprite(temp57) = _LOADIMAGE(pocketloc$ + pocketfile$ + "/" + pocketfile$ + ".png"): LET pocketshort(temp57) = pocketfile$
    CLOSE #666
    REM prints load to console
    LET eventtitle$ = "POCKET ITEM LOADED:"
    LET eventdata$ = pocketfile$
    LET eventnumber = temp57
    GOSUB consoleprinter
    REM updates loadbar
    IF setupboot = 1 THEN
        LET temp125 = temp125 + loadbarsize
        GOSUB loadbar
    END IF
LOOP UNTIL EOF(1) OR temp57 >= totalpockets
LET pocketnos = temp57: REM set pocketnos
CLOSE #1
LET temp57 = 0: REM scrubs temp values
RETURN

awardunload:
REM unloads all awards from memeory
OPEN awardloc$ + "awards.ddf" FOR INPUT AS #1
DO
    LET temp58 = temp58 + 1
    INPUT #1, temp64$
    INPUT #1, temp65$
    _FREEIMAGE awardsprite(temp58)
    REM prints unload to console
    LET eventtitle$ = "AWARD UNLOADED:"
    LET eventdata$ = temp64$
    LET eventnumber = temp58
    GOSUB consoleprinter
LOOP UNTIL EOF(1) OR temp58 >= totalawards
CLOSE #1
LET temp58 = 0: REM scrub temp values
RETURN

pocketunload:
REM unloads all pocket files from memory
OPEN pocketloc$ + "pocketfiles.ddf" FOR INPUT AS #1
DO
    LET temp58 = temp58 + 1
    INPUT #1, pocketfile$
    _FREEIMAGE pocketsprite(temp58)
    LET pocketvisible(temp58) = 0: REM resets visible value
    REM prints unload to console
    LET eventtitle$ = "POCKET ITEM UNLOADED:"
    LET eventdata$ = pocketfile$
    LET eventnumber = temp58
    GOSUB consoleprinter
LOOP UNTIL EOF(1) OR temp58 >= totalpockets
CLOSE #1
LET temp58 = 0: REM scrub temp values
RETURN

pocketdraw:
REM draws pocket interface and provides input
REM return for if directional keys are being pressed
IF keypressedup = 1 OR keypresseddown = 1 OR keypressedleft = 1 OR keypressedright = 1 THEN RETURN
REM return for if no items in pocket
LET temp170 = 0: LET temp171 = 0
DO
    LET temp170 = temp170 + 1
    IF pocketvisible(temp170) = 0 THEN IF pocketitem(temp170) = 1 THEN LET temp171 = temp171 + 1
LOOP UNTIL temp170 >= totalpockets
IF pocketcarry - temp171 <= 0 THEN
    LET scriptname$ = "nopocket"
    LET mapscript = 5
    GOSUB script
    RETURN
END IF
REM sets up pocket
GOSUB slightfadeout: REM dims screen
COLOR _RGBA(letpocketdefaultcolourr, letpocketdefaultcolourg, letpocketdefaultcolourb, letpocketdefaultcoloura), _RGBA(bgpocketdefaultcolourr, bgpocketdefaultcolourg, bgpocketdefaultcolourb, bgpocketdefaultcoloura)
REM sets values
LET pocketline = 0
LET pocketdisplay = 0
GOSUB pocketcalcup: REM calculates first pocketitem to display
REM plays sfx
LET playsfx$ = "openpocket"
GOSUB sfxplay
REM pocket animation
LET temp206 = (pocketspritey - pockethudresy) - 1
DO
    _LIMIT pockethudanispeed
    _PUTIMAGE (0, (0 - temp59))-(pockethudresx - 1, temp59), pockethud
    _PUTIMAGE (pocketspritex, temp206)-(((pocketspritex + pocketspriteresx) - 1), ((pocketspriteresy - 1) + temp206)), pocketsprite(pocketdisplay)
    LET temp59 = temp59 + 1
    LET temp206 = temp206 + 1
LOOP UNTIL temp59 >= pockethudresy
IF mainmenu = 0 THEN
    DO
        _LIMIT pockethudanispeed
        _PUTIMAGE (((resx / 2) - (pocketbannerresx / 2)), pockethudresy)-(((resx / 2) + (pocketbannerresx / 2)) - 1, (temp59 - 1) - 1), pocketbanner
        LET temp59 = temp59 + 1
    LOOP UNTIL temp59 >= (pockethudresy + pocketbannerresy + 1)
END IF
REM prints pockets active to console
LET eventtitle$ = "POCKETS:"
LET eventdata$ = "ACTIVE!"
LET pocketon = 1
LET eventnumber = 0
LET pocketredraw = 1
LET awarddisplay = 0
GOSUB consoleprinter
DO
    REM sets values
    LET temp60 = 0
    IF pocketdisplay = 0 THEN GOSUB pocketcalcup
    REM draws pocket
    IF pocketredraw = 1 THEN
        _PUTIMAGE (0, 0)-(pockethudresx - 1, pockethudresy - 1), pockethud
        _PUTIMAGE (pocketarrowrlocx, pocketarrowrlocy)-((pocketarrowrlocx + pocketarrowresx) - 1, (pocketarrowrlocy + pocketarrowresy) - 1), pocketarrowr
        _PUTIMAGE (pocketarrowllocx, pocketarrowllocy)-((pocketarrowllocx + pocketarrowresx) - 1, (pocketarrowllocy + pocketarrowresy) - 1), pocketarrowl
        _PUTIMAGE (((resx / 2) - (pocketbannerresx / 2)), (pockethudresy))-(((resx / 2) + (pocketbannerresx / 2) - 1), (pocketbannerresy + pockethudresy - 1) - 1), pocketbanner
    END IF
    _KEYCLEAR
    DO
        _LIMIT extrahertz
        LET b = _KEYHIT: REM inputter
        REM displays pocket image
        IF pocketredraw = 1 THEN _PUTIMAGE (pocketspritex, pocketspritey)-((pocketspritex + pocketspriteresx) - 1, (pocketspritey + pocketspriteresy) - 1), pocketsprite(pocketdisplay)
        REM calculates what text to display
        LET pocketdisplayname$ = pocketname(pocketdisplay): LET pocketdisplaydescription$ = pocketdescription(pocketdisplay): LET currentpocketshort$ = pocketshort(pocketdisplay)
        REM adds value to currency
        IF currentpocketshort$ = "currency" THEN LET temp22$ = pocketdisplayname$: LET pocketdisplayname$ = pocketdisplayname$ + " " + STR$(currency)
        REM calculates centre
        LET centretext$ = pocketdisplayname$
        GOSUB centretext
        REM displays pocket item info text
        COLOR _RGBA(letpocketdefaultcolourr, letpocketdefaultcolourg, letpocketdefaultcolourb, letpocketdefaultcoloura), _RGBA(bgpocketdefaultcolourr, bgpocketdefaultcolourg, bgpocketdefaultcolourb, bgpocketdefaultcoloura)
        IF pocketredraw = 1 THEN _PRINTSTRING ((resx / 2) - (centreno / 2), (pockethudresy)), pocketdisplayname$
        REM removes value from currency
        IF currentpocketshort$ = "currency" THEN LET pocketdisplayname$ = temp22$
        GOSUB timeframecounter
    LOOP UNTIL b = bcontrolcode1 OR b = bcontrolcode2 OR b = bcontrolcode3 OR b = bcontrolcode4 OR b = pcontrolcode1 OR b = pcontrolcode2 OR b = pcontrolcode3 OR b = pcontrolcode4 OR b = lcontrolcode1 OR b = lcontrolcode2 OR b = lcontrolcode3 OR b = lcontrolcode4 OR b = rcontrolcode1 OR b = rcontrolcode2 OR b = rcontrolcode3 OR b = rcontrolcode4 OR b = scontrolcode1 OR b = scontrolcode2 OR b = scontrolcode3 OR b = scontrolcode4
    REM arrow keys divert
    IF b = rcontrolcode1 OR b = rcontrolcode2 OR b = rcontrolcode3 OR b = rcontrolcode4 THEN
        REM right key
        _KEYCLEAR
        LET pocketredraw = 0
        LET temp6177 = pocketline
        GOSUB pocketcalcup
        IF temp6177 <> pocketline THEN
            LET playsfx$ = "move"
            GOSUB sfxplay
            GOSUB pocketarrowright
        END IF
        LET temp6177 = 0
    END IF
    IF b = lcontrolcode1 OR b = lcontrolcode2 OR b = lcontrolcode3 OR b = lcontrolcode4 THEN
        REM left key
        _KEYCLEAR
        LET pocketredraw = 0
        LET temp6177 = pocketline
        GOSUB pocketcalcdown
        IF temp6177 <> pocketline THEN
            LET playsfx$ = "move"
            GOSUB sfxplay
            GOSUB pocketarrowleft
        END IF
        LET temp6177 = 0
    END IF
    IF b = scontrolcode1 OR b = scontrolcode2 OR b = scontrolcode3 OR b = scontrolcode4 THEN _KEYCLEAR: LET playsfx$ = "select": GOSUB sfxplay: GOSUB pocketext
LOOP UNTIL b = bcontrolcode1 OR b = bcontrolcode2 OR b = bcontrolcode3 OR b = bcontrolcode4 OR b = pcontrolcode1 OR b = pcontrolcode2 OR b = pcontrolcode3 OR b = pcontrolcode4
_KEYCLEAR
CLOSE #1
IF pocketdivert = 0 THEN
    REM plays sfx
    LET playsfx$ = "closepocket"
    GOSUB sfxplay
END IF
GOSUB slightfadein
CLOSE #1: REM closes pocketfiles.ddf
LET clearscreen = 1: REM sets screen for refresh
REM resets pocket divert
IF pocketdivert = 1 THEN LET pocketdivert = 0
REM scrub values
COLOR 0, 0
LET temp59 = 0: LET temp60 = 0: LET temp66 = 0: LET temp67 = 0: LET temp170 = 0: LET temp171 = 0: LET temp206 = 0: LET pocketon = 0
LET pocketdisplayname$ = "": LET pocketdisplaydescription$ = "": LET temp22$ = "": REM scrub temp values
RETURN

pocketext:
REM draws extension to pocket (controls)
REM draws images
_PUTIMAGE (pocketselectx, pocketselecty)-((pocketselectx + pocketselectresx) - 1, (pocketselecty + pocketselectresy) - 1), pocketselect
_PUTIMAGE (((resx / 2) - (pocketbannerresx / 2)), (pockethudresy))-(((resx / 2) + (pocketbannerresx / 2) - 1), (pocketbannerresy + pockethudresy - 1) - 1), pocketbanner
_PUTIMAGE (pocketarrowrlocx, pocketarrowrlocy)-((pocketarrowrlocx + pocketarrowresx) - 1, (pocketarrowrlocy + pocketarrowresy) - 1), pocketarrowru
_PUTIMAGE (pocketarrowllocx, pocketarrowllocy)-((pocketarrowllocx + pocketarrowresx) - 1, (pocketarrowllocy + pocketarrowresy) - 1), pocketarrowlu
LET temp74 = 1
REM text and input
_KEYCLEAR
DO
    _LIMIT extrahertz
    LET c = _KEYHIT: REM inputter
    IF temp74 = 1 THEN COLOR _RGBA(letpocketselectcolourr, letpocketselectcolourg, letpocketselectcolourb, letpocketselectcoloura), _RGBA(bgpocketselectcolourr, bgpocketselectcolourg, bgpocketselectcolourb, bgpocketselectcoloura)
    IF temp74 = 2 THEN COLOR _RGBA(letpocketdefaultcolourr, letpocketdefaultcolourg, letpocketdefaultcolourb, letpocketdefaultcoloura), _RGBA(bgpocketdefaultcolourr, bgpocketdefaultcolourg, bgpocketdefaultcolourb, bgpocketdefaultcoloura)
    _PRINTSTRING ((lookx), (pockethudresy)), lookaction$
    IF temp74 = 2 THEN COLOR _RGBA(letpocketselectcolourr, letpocketselectcolourg, letpocketselectcolourb, letpocketselectcoloura), _RGBA(bgpocketselectcolourr, bgpocketselectcolourg, bgpocketselectcolourb, bgpocketselectcoloura)
    IF temp74 = 1 THEN COLOR _RGBA(letpocketdefaultcolourr, letpocketdefaultcolourg, letpocketdefaultcolourb, letpocketdefaultcoloura), _RGBA(bgpocketdefaultcolourr, bgpocketdefaultcolourg, bgpocketdefaultcolourb, bgpocketdefaultcoloura)
    IF objecttype$ = "OBJ" THEN
        _PRINTSTRING ((usex), (pockethudresy)), useaction$
    END IF
    IF objecttype$ = "NPC" THEN
        _PRINTSTRING ((givex), (pockethudresy)), giveaction$
    END IF
    IF objecttype$ = "NON" THEN
        _PRINTSTRING ((combinex), (pockethudresy)), combineaction$
    END IF
    GOSUB timeframecounter
    IF c = rcontrolcode1 OR c = rcontrolcode2 OR c = rcontrolcode3 OR c = rcontrolcode4 THEN
        _KEYCLEAR
        IF temp74 = 1 THEN
            LET playsfx$ = "move"
            GOSUB sfxplay
            LET temp74 = 2
        END IF
    END IF
    IF c = lcontrolcode1 OR c = lcontrolcode2 OR c = lcontrolcode3 OR c = lcontrolcode4 THEN
        _KEYCLEAR
        IF temp74 = 2 THEN
            LET playsfx$ = "move"
            GOSUB sfxplay
            LET temp74 = 1
        END IF
    END IF
LOOP UNTIL c = scontrolcode1 OR c = scontrolcode2 OR c = scontrolcode3 OR c = scontrolcode4 OR c = bcontrolcode1 OR c = bcontrolcode2 OR c = bcontrolcode3 OR c = bcontrolcode4 OR c = pcontrolcode1 OR c = pcontrolcode2 OR c = pcontrolcode3 OR c = pcontrolcode4
IF c = scontrolcode1 OR c = scontrolcode2 OR c = scontrolcode3 OR c = scontrolcode4 THEN
    _KEYCLEAR
    REM play select sound
    LET playsfx$ = "select"
    GOSUB sfxplay
    IF temp74 = 1 THEN
        REM Look at item
        COLOR _RGBA(letpocketdefaultcolourr, letpocketdefaultcolourg, letpocketdefaultcolourb, letpocketdefaultcoloura), _RGBA(bgpocketdefaultcolourr, bgpocketdefaultcolourg, bgpocketdefaultcolourb, bgpocketdefaultcoloura)
        _PRINTSTRING ((lookx), (pockethudresy)), lookaction$
        _DELAY 0.1
        COLOR _RGBA(letpocketselectcolourr, letpocketselectcolourg, letpocketselectcolourb, letpocketselectcoloura), _RGBA(bgpocketselectcolourr, bgpocketselectcolourg, bgpocketselectcolourb, bgpocketselectcoloura)
        _PRINTSTRING ((lookx), (pockethudresy)), lookaction$
        REM checks to see if item needs a script running
        LET lookscript% = INSTR(lookscript% + 1, pocketdisplaydescription$, "[RUNSCRIPT]")
        IF lookscript% THEN
            LET temp30$ = LEFT$(pocketdisplaydescription$, INSTR(pocketdisplaydescription$, " ") - 1)
            LET temp31$ = RIGHT$(pocketdisplaydescription$, LEN(pocketdisplaydescription$) - LEN(temp30$))
            LET temp31$ = LTRIM$(temp31$)
            GOSUB slightfadein
            REM runs script
            LET scriptname$ = temp31$
            LET mapscript = 3
            GOSUB script
            LET pocketdivert = 1
        ELSE
            GOSUB slightfadein
            LET objecttype$ = "OBJ"
            LET textspeech$ = pocketdisplaydescription$
            GOSUB textbannerdraw
            LET pocketdivert = 1
        END IF
        LET b = bcontrolcode1: LET lookscript% = 0: LET temp30$ = "": LET temp31$ = "": REM scrub temp values
    END IF
    IF temp74 = 2 THEN
        IF objecttype$ = "NPC" THEN
            REM give item to npc
            COLOR _RGBA(letpocketdefaultcolourr, letpocketdefaultcolourg, letpocketdefaultcolourb, letpocketdefaultcoloura), _RGBA(bgpocketdefaultcolourr, bgpocketdefaultcolourg, bgpocketdefaultcolourb, bgpocketdefaultcoloura)
            _PRINTSTRING ((givex), (pockethudresy)), giveaction$
            _DELAY 0.1
            COLOR _RGBA(letpocketselectcolourr, letpocketselectcolourg, letpocketselectcolourb, letpocketselectcoloura), _RGBA(bgpocketselectcolourr, bgpocketselectcolourg, bgpocketselectcolourb, bgpocketselectcoloura)
            _PRINTSTRING ((givex), (pockethudresy)), giveaction$
            GOSUB usepocket
            LET objecttype$ = ""
        END IF
        IF objecttype$ = "OBJ" THEN
            REM use item with world
            COLOR _RGBA(letpocketdefaultcolourr, letpocketdefaultcolourg, letpocketdefaultcolourb, letpocketdefaultcoloura), _RGBA(bgpocketdefaultcolourr, bgpocketdefaultcolourg, bgpocketdefaultcolourb, bgpocketdefaultcoloura)
            _PRINTSTRING ((usex), (pockethudresy)), useaction$
            _DELAY 0.1
            COLOR _RGBA(letpocketselectcolourr, letpocketselectcolourg, letpocketselectcolourb, letpocketselectcoloura), _RGBA(bgpocketselectcolourr, bgpocketselectcolourg, bgpocketselectcolourb, bgpocketselectcoloura)
            _PRINTSTRING ((usex), (pockethudresy)), useaction$
            GOSUB usepocket
            LET objecttype$ = ""
        END IF
        IF objecttype$ = "NON" THEN
            REM use item with item
            COLOR _RGBA(letpocketdefaultcolourr, letpocketdefaultcolourg, letpocketdefaultcolourb, letpocketdefaultcoloura), _RGBA(bgpocketdefaultcolourr, bgpocketdefaultcolourg, bgpocketdefaultcolourb, bgpocketdefaultcoloura)
            _PRINTSTRING ((combinex), (pockethudresy)), combineaction$
            _DELAY 0.1
            COLOR _RGBA(letpocketselectcolourr, letpocketselectcolourg, letpocketselectcolourb, letpocketselectcoloura), _RGBA(bgpocketselectcolourr, bgpocketselectcolourg, bgpocketselectcolourb, bgpocketselectcoloura)
            _PRINTSTRING ((combinex), (pockethudresy)), combineaction$
            GOSUB pocketcombine
        END IF
    END IF
END IF
COLOR _RGBA(letpocketdefaultcolourr, letpocketdefaultcolourg, letpocketdefaultcolourb, letpocketdefaultcoloura), _RGBA(bgpocketdefaultcolourr, bgpocketdefaultcolourg, bgpocketdefaultcolourb, bgpocketdefaultcoloura)
LET temp74 = 0: REM scrub temp values
RETURN

pocketcombine:
REM combines pocket items
REM return for if pocket only has one item or less
IF pocketcarry - temp171 <= 1 THEN
    LET scriptname$ = "nopocketmerge"
    LET mapscript = 5
    GOSUB script
    LET pocketdivert = 1
    LET b = bcontrolcode1
    RETURN
END IF
REM sets values
LET temp81 = pocketdisplay
LET temp19$ = pocketdisplayname$
LET temp20$ = pocketdisplaydescription$
LET temp21$ = currentpocketshort$
LET temp149 = pocketline
LET pocketdisplayname$ = ""
LET pocketdisplaydescription$ = ""
LET currentpocketshort$ = ""
LET pocketdisplay = 0
LET pocketline = 0
LET pocketredraw = 1
REM redraws pocket
_PUTIMAGE (0, 0)-(pockethudresx - 1, pockethudresy - 1), pockethud
REM displays pocket image
_PUTIMAGE (pocketspritex, pocketspritey)-((pocketspritex + pocketspriteresx) - 1, (pocketspritey + pocketspriteresy) - 1), pocketsprite(temp81)
_PUTIMAGE (pocketselectx, pocketselecty)-((pocketselectx + pocketselectresx) - 1, (pocketselecty + pocketselectresy) - 1), pocketselect
REM calculates what pocket item to display
DO
    _LIMIT extrahertz
    LET temp60 = 0
    LET temp83 = temp83 + 1
    IF pocketdisplay = 0 THEN GOSUB pocketcalcup
    REM if pocket is attempting to display currently selected item for merging
    IF pocketdisplay = temp81 THEN
        LET temp84 = 0
        DO
            LET temp84 = temp84 + 1
            IF temp83 = 1 THEN GOSUB pocketcalcup: LET temp169 = 1
            IF d = rcontrolcode1 OR d = rcontrolcode2 OR d = rcontrolcode3 OR d = rcontrolcode4 AND temp169 = 0 THEN
                IF temp84 < 5 THEN GOSUB pocketcalcup
                IF temp84 >= 5 THEN GOSUB pocketcalcdown
            END IF
            IF d = lcontrolcode1 OR d = lcontrolcode2 OR d = lcontrolcode3 OR d = lcontrolcode4 THEN
                IF temp84 < 5 THEN GOSUB pocketcalcdown
                IF temp84 >= 5 THEN GOSUB pocketcalcup
            END IF
            LET temp169 = 0: REM scrub temp values
        LOOP UNTIL pocketdisplay <> temp81
    END IF
    REM draws second pocket
    IF pocketredraw = 1 THEN
        _PUTIMAGE (0, pockethudresy)-(pockethudresx - 1, pockethudresy + pockethudresy - 1), pockethud
        _PUTIMAGE (pocketarrowrlocx, pocketarrowrlocy + pockethudresy)-((pocketarrowrlocx + pocketarrowresx) - 1, (pocketarrowrlocy + pocketarrowresy + pockethudresy) - 1), pocketarrowr
        _PUTIMAGE (pocketarrowllocx, pocketarrowllocy + pockethudresy)-((pocketarrowllocx + pocketarrowresx) - 1, (pocketarrowllocy + pocketarrowresy + pockethudresy) - 1), pocketarrowl
        _PUTIMAGE (((resx / 2) - (pocketbannerresx / 2)), (pockethudresy + pockethudresy))-(((resx / 2) + (pocketbannerresx / 2)) - 1, (pocketbannerresy + pockethudresy + pockethudresy) - 1), pocketbanner
    END IF
    _KEYCLEAR
    DO
        _LIMIT extrahertz
        IF pocketredraw = 1 THEN _PUTIMAGE (pocketspritex, pocketspritey + pockethudresy)-((pocketspritex + pocketspriteresx) - 1, (pocketspritey + pocketspriteresy + pockethudresy) - 1), pocketsprite(pocketdisplay)
        REM calculates what text to display
        LET pocketdisplayname$ = pocketname(pocketdisplay): LET pocketdisplaydescription$ = pocketdescription(pocketdisplay): LET currentpocketshort$ = pocketshort(pocketdisplay)
        REM calculates centre
        LET centretext$ = pocketdisplayname$
        GOSUB centretext
        REM sets colours
        COLOR _RGBA(letpocketdefaultcolourr, letpocketdefaultcolourg, letpocketdefaultcolourb, letpocketdefaultcoloura), _RGBA(bgpocketdefaultcolourr, bgpocketdefaultcolourg, bgpocketdefaultcolourb, bgpocketdefaultcoloura)
        REM prints text to screen
        IF pocketredraw = 1 THEN
            _PRINTSTRING (1, 1), combineaction$
            _PRINTSTRING (1, 1 + fontsize * 2), "WITH"
            _PRINTSTRING ((resx / 2) - (centreno / 2), (pockethudresy + pockethudresy)), pocketdisplayname$
        END IF
        LET d = _KEYHIT
        GOSUB timeframecounter
    LOOP UNTIL d = bcontrolcode1 OR d = bcontrolcode2 OR d = bcontrolcode3 OR d = bcontrolcode4 OR d = pcontrolcode1 OR d = pcontrolcode2 OR d = pcontrolcode3 OR d = pcontrolcode4 OR d = lcontrolcode1 OR d = lcontrolcode2 OR d = lcontrolcode3 OR d = lcontrolcode4 OR d = rcontrolcode1 OR d = rcontrolcode2 OR d = rcontrolcode3 OR d = rcontrolcode4 OR d = scontrolcode1 OR d = scontrolcode2 OR d = scontrolcode3 OR d = scontrolcode4
    IF d = rcontrolcode1 OR d = rcontrolcode2 OR d = rcontrolcode3 OR d = rcontrolcode4 THEN
        REM right key
        _KEYCLEAR
        LET pocketredraw = 0
        LET temp6177 = pocketline
        GOSUB pocketcalcup
        IF temp6177 <> pocketline THEN
            LET playsfx$ = "move"
            GOSUB sfxplay
            GOSUB pocketarrowright
        END IF
        LET temp6177 = 0
    END IF
    IF d = lcontrolcode1 OR d = lcontrolcode2 OR d = lcontrolcode3 OR d = lcontrolcode4 THEN
        REM left key
        _KEYCLEAR
        LET pocketredraw = 0
        LET temp6177 = pocketline
        GOSUB pocketcalcdown
        IF temp149 = 1 AND temp6177 = 2 THEN LET temp6177 = pocketline: REM prevents sound bug if first inventory item is being merged
        IF temp6177 <> pocketline THEN
            LET playsfx$ = "move"
            GOSUB sfxplay
            GOSUB pocketarrowleft
        END IF
        LET temp6177 = 0
    END IF
    IF d = scontrolcode1 OR d = scontrolcode2 OR d = scontrolcode3 OR d = scontrolcode4 THEN _KEYCLEAR: LET playsfx$ = "select": GOSUB sfxplay: GOSUB usepocketpocket
LOOP UNTIL d = bcontrolcode1 OR d = bcontrolcode2 OR d = bcontrolcode3 OR d = bcontrolcode4 OR d = pcontrolcode1 OR d = pcontrolcode2 OR d = pcontrolcode3 OR d = pcontrolcode4
_KEYCLEAR
LET c = bcontrolcode1: LET b = bcontrolcode1: REM quits inventory
LET pocketdisplay = temp81: LET temp149 = 0: LET temp81 = 0: LET temp83 = 0: LET temp19$ = "": LET temp20$ = "": LET temp21$ = "": REM scrubs temp values
RETURN

usepocketpocket:
REM COMBINES POCKET ITEMS
LET pocketon = 3
REM checks script file exists
LET scriptname$ = LCASE$(currentpocketshort$) + LCASE$(temp21$)
IF _FILEEXISTS(scriptloc$ + "combine/" + scriptname$ + ".vsf") THEN
    REM first match works
    GOSUB slightfadein
    LET mapscript = 2
    GOSUB script
    LET selectobject$ = ""
ELSE
    REM first match fails
    LET scriptname$ = LCASE$(temp21$) + LCASE$(currentpocketshort$)
    IF _FILEEXISTS(scriptloc$ + "combine/" + scriptname$ + ".vsf") THEN
        REM second match works
        GOSUB slightfadein
        LET mapscript = 2
        GOSUB script
        LET selectobject$ = ""
    ELSE
        REM second match fails
        GOSUB slightfadein
        LET scriptname$ = "badpocketmerge"
        LET mapscript = 5
        GOSUB script
    END IF
END IF
LET pocketdivert = 1
LET d = bcontrolcode1: LET c = bcontrolcode1: LET b = bcontrolcode1: LET temp43$ = "": LET temp150 = 0: REM quits pockets
RETURN

usepocket:
REM USES POCKET ITEM
LET pocketon = 2
REM uses pocket item with world object
LET scriptname$ = LCASE$(selectobject$) + LCASE$(currentpocketshort$)
IF _FILEEXISTS(scriptloc$ + mapdir$ + scriptname$ + ".vsf") THEN
    REM if match does work
    GOSUB slightfadein
    LET mapscript = 1
    GOSUB script
    LET terminalhold$ = currentpocketshort$
ELSE
    REM if match doesn't work
    IF objecttype$ = "OBJ" THEN
        GOSUB slightfadein
        LET scriptname$ = "badobjectmerge"
        LET mapscript = 5
        GOSUB script
    END IF
    IF objecttype$ = "NPC" THEN
        GOSUB slightfadein
        LET scriptname$ = LCASE$(selectobject$) + "nope"
        LET mapscript = 1
        GOSUB script
    END IF
END IF
LET pocketdivert = 1
LET c = bcontrolcode1: LET b = bcontrolcode1: REM quits pockets
RETURN

givecurrency:
REM gives currency to player
IF currencychange = 0 THEN RETURN: REM return for if there is no currency change
LET currency = currency + currencychange: REM adds money
REM changes font colour
COLOR _RGBA(letcurrencycolourr, letcurrencycolourg, letcurrencycolourb, letcurrencycoloura), _RGBA(bgcurrencycolourr, bgcurrencycolourg, bgcurrencycolourb, bgcurrencycoloura)
REM find
OPEN pocketloc$ + "pocketfiles.ddf" FOR INPUT AS #1
DO
    LET temp93 = temp93 + 1
    INPUT #1, pocketfile$
LOOP UNTIL pocketfile$ = "currency" OR EOF(1)
CLOSE #1
IF silentgive = 0 THEN
    REM animation
    GOSUB slightfadeout
    DO
        REM pockets scroll in
        _LIMIT pockethudanispeed
        _PUTIMAGE (0, (0 - temp94))-(pockethudresx - 1, temp94 - 1), pockethud
        LET temp94 = temp94 + 1
    LOOP UNTIL temp94 >= pockethudresy
    LET temp94 = (0 - pocketspriteresx)
    DO
        REM Pocket item scrolls in
        _LIMIT pockethudanispeed
        _PUTIMAGE (0, 0)-(pockethudresx - 1, pockethudresy - 1), pockethud
        _PUTIMAGE (temp94, pocketspritey)-((temp94 + pocketspriteresx) - 1, (pocketspritey + pocketspriteresy) - 1), pocketsprite(temp93)
        _PRINTSTRING (temp94 - (pocketspriteresx / 2), pocketspritey), STR$(currencychange)
        LET temp94 = temp94 + 1
        GOSUB timeframecounter
    LOOP UNTIL temp94 >= pocketspritex
    REM plays sound effect
    LET playsfx$ = "pickup"
    GOSUB sfxplay
    _DELAY 0.5
    GOSUB slightfadein
END IF
REM tells console printer
LET eventtitle$ = "CURRENCY ADDED:"
LET eventdata$ = "+" + STR$(currencychange)
LET eventnumber = currency
GOSUB consoleprinter
COLOR 0, 0
LET currencychange = 0: LET temp93 = 0: LET temp94 = 0: LET silentgive = 0: REM scrubs temp values
RETURN

takecurrency:
REM takes currency from player
IF currencychange = 0 THEN RETURN: REM return for if there is no currency change
LET currency = currency - currencychange: REM removes money
REM changes font colour
COLOR _RGBA(letcurrencycolourr, letcurrencycolourg, letcurrencycolourb, letcurrencycoloura), _RGBA(bgcurrencycolourr, bgcurrencycolourg, bgcurrencycolourb, bgcurrencycoloura)
REM finds currency slot
OPEN pocketloc$ + "pocketfiles.ddf" FOR INPUT AS #1
DO
    LET temp91 = temp91 + 1
    INPUT #1, pocketfile$
LOOP UNTIL pocketfile$ = "currency" OR EOF(1)
CLOSE #1
IF silenttake = 0 THEN
    REM animation
    GOSUB slightfadeout
    DO
        REM pockets scroll in
        _LIMIT pockethudanispeed
        _PUTIMAGE (0, (0 - temp92))-(pockethudresx - 1, temp92 - 1), pockethud
        LET temp92 = temp92 + 1
    LOOP UNTIL temp92 >= pockethudresy
    LET temp92 = pocketspritex
    DO
        REM Pocket item scrolls out
        _LIMIT pockethudanispeed
        _PUTIMAGE (0, 0)-(pockethudresx - 1, pockethudresy - 1), pockethud
        _PUTIMAGE (temp92, pocketspritey)-((temp92 + pocketspriteresx) - 1, (pocketspritey + pocketspriteresy) - 1), pocketsprite(temp91)
        _PRINTSTRING (temp92 - (pocketspriteresx / 2), pocketspritey), STR$(currencychange)
        LET temp92 = temp92 + 1
        GOSUB timeframecounter
    LOOP UNTIL temp92 >= (resx + (pocketspriteresx / 2) + 1)
    REM plays sound effect
    LET playsfx$ = "drop"
    GOSUB sfxplay
    _DELAY 0.5
    GOSUB slightfadein
END IF
REM tells console printer
LET eventtitle$ = "CURRENCY REMOVED:"
LET eventdata$ = "-" + STR$(currencychange)
LET eventnumber = currency
GOSUB consoleprinter
REM checks if currency is below 0
IF currency < 0 THEN
    LET currency = 0
    REM tells console
    LET eventtitle$ = "CURRENCY BELOW ZERO"
    LET eventdata$ = "VALUE FIXED:"
    LET eventnumber = currency
    GOSUB consoleprinter
END IF
COLOR 0, 0
LET currencychange = 0: LET temp91 = 0: LET temp92 = 0: LET silenttake = 0: REM scrubs temp values
RETURN

centretext:
REM calculates position of centre text (centreno)
LET centreno = 0
LET temp70 = 0
LET temp174 = 0
FOR i = 1 TO LEN(centretext$)
    LET x$ = MID$(centretext$, i, 1)
    IF imode < 2 THEN IF x$ <> "i" AND x$ <> "!" THEN LET temp70 = temp70 + 1
    IF imode = 2 THEN IF UCASE$(x$) <> "I" AND x$ <> "!" THEN LET temp70 = temp70 + 1
    IF banneron = 1 THEN LET temp174 = temp174 + fontbuffer
NEXT i
LET centreno = (temp70 * (fontsize / 2)) + LEN(centretext$) + temp174
LET temp70 = 0: LET temp174 = 0: LET x$ = "": LET centretext$ = "": REM scrub temp values
RETURN

pocketarrowright:
REM flashes pocket arrow right
IF temp81 = 0 THEN
    _PUTIMAGE (pocketarrowrlocx, pocketarrowrlocy)-((pocketarrowrlocx + pocketarrowresx) - 1, (pocketarrowrlocy + pocketarrowresy) - 1), pocketarrowrs
ELSE
    _PUTIMAGE (pocketarrowrlocx, pocketarrowrlocy + pockethudresy)-((pocketarrowrlocx + pocketarrowresx) - 1, (pocketarrowrlocy + pocketarrowresy + pockethudresy) - 1), pocketarrowrs
END IF
_DELAY 0.1
RETURN

pocketarrowleft:
REM flashes pocket arrow left
IF temp81 = 0 THEN
    _PUTIMAGE (pocketarrowllocx, pocketarrowllocy)-((pocketarrowllocx + pocketarrowresx) - 1, (pocketarrowllocy + pocketarrowresy) - 1), pocketarrowls
ELSE
    _PUTIMAGE (pocketarrowllocx, pocketarrowllocy + pockethudresy)-((pocketarrowllocx + pocketarrowresx) - 1, (pocketarrowllocy + pocketarrowresy + pockethudresy) - 1), pocketarrowls
END IF
_DELAY 0.1
RETURN

pocketcalcdown:
REM calculates what pocket item to display
REM sets values
LET temp61 = pocketdisplay
LET temp62 = pocketline
LET oldpocketdisplay = pocketdisplay
LET pocketdisplay = 0
REM goes back a line and checks if pocket item is available
DO
    OPEN pocketloc$ + "pocketfiles.ddf" FOR INPUT AS #1
    LET temp60 = 0
    LET pocketline = pocketline - 1
    DO
        LET temp60 = temp60 + 1
        INPUT #1, pocketfile$
        IF EOF(1) THEN
            REM if file ends
            LET pocketdisplay = temp61
            LET pocketline = temp62
            LET temp60 = 0
            LET temp61 = 0
            LET temp62 = 0
            CLOSE #1
            IF pocketdisplay <> oldpocketdisplay THEN LET pocketredraw = 1:
            RETURN
        END IF
    LOOP UNTIL temp60 = pocketline
    IF pocketitem(temp60) = 1 AND pocketvisible(temp60) = 1 THEN LET pocketdisplay = temp60
    CLOSE #1
LOOP UNTIL pocketdisplay > 0
LET pocketline = temp60
IF pocketdisplay <> oldpocketdisplay THEN LET pocketredraw = 1
LET temp60 = 0: LET temp61 = 0: LET temp62 = 0: REM scrubs temp values
RETURN

pocketcalcup:
REM calculates what pocket item to display
REM sets values
LET temp61 = pocketdisplay
LET temp62 = pocketline
LET oldpocketdisplay = pocketdisplay
LET pocketdisplay = 0
REM gets to current line
OPEN pocketloc$ + "pocketfiles.ddf" FOR INPUT AS #1
IF pocketline > 0 THEN
    DO
        LET temp60 = temp60 + 1
        INPUT #1, pocketfile$
        IF EOF(1) THEN
            REM if file ends
            LET temp60 = 0
            LET pocketdisplay = temp61
            LET pocketline = temp62
            LET temp61 = 0
            LET temp62 = 0
            CLOSE #1
            IF pocketdisplay <> oldpocketdisplay THEN LET pocketredraw = 1
            RETURN
        END IF
    LOOP UNTIL temp60 >= pocketline
END IF
DO
    LET temp60 = temp60 + 1
    INPUT #1, pocketfile$
    IF pocketitem(temp60) = 1 AND pocketvisible(temp60) = 1 THEN LET pocketdisplay = temp60
    IF pocketdisplay > 0 THEN CLOSE #1: LET pocketline = temp60: IF pocketdisplay <> oldpocketdisplay THEN LET pocketredraw = 1: LET temp60 = 0: RETURN
    IF EOF(1) THEN
        REM if file ends
        LET temp60 = 0
        LET pocketdisplay = temp61
        LET pocketline = temp62
        LET temp61 = 0
        LET temp62 = 0
        CLOSE #1
        COLOR 0, 0
        RETURN
    END IF
LOOP
CLOSE #1
COLOR 0, 0
IF pocketdisplay <> oldpocketdisplay THEN LET pocketredraw = 1
LET pocketline = temp60: LET temp60 = 0: LET temp61 = 0: LET temp62 = 0 REM clear temp values
RETURN

choicebannerdraw:
REM draws choice banner
_KEYCLEAR
LET banneron = 1
COLOR _RGBA(letspeechcolourr, letspeechcolourg, letspeechcolourb, letspeechcoloura), _RGBA(bgspeechcolourr, bgspeechcolourg, bgspeechcolourb, bgspeechcoloura)
IF pocketon = 0 AND mainmenu = 0 OR scriptrun = 1 THEN GOSUB slightfadeout
LET temp71 = (resy + 1)
REM draws choice banner and arrows
DO
    GOSUB timeframecounter
    _LIMIT pockethudanispeed
    _PUTIMAGE (0, temp71)-(textbannerresx - 1, (textbannerresy + temp71) - 1), choicebanner
    _PUTIMAGE (choicearrowr, (temp71 + (textbannerresy / 2)) - (pocketarrowresy / 2))-(choicearrowr + pocketarrowresx - 1, (pocketarrowresy + (temp71 + (textbannerresy / 2))) - (pocketarrowresy / 2) - 1), pocketarrowr
    LET temp71 = temp71 - 1
LOOP UNTIL temp71 <= (resy - textbannerresy - 1)
GOSUB choicebannercalc
COLOR 0, 0
IF pocketon = 0 AND mainmenu = 0 OR scriptrun = 1 THEN GOSUB slightfadein
LET temp71 = 0: LET banneron = 0
_KEYCLEAR
RETURN

choicebannercalc:
REM calculates text positioning and menu inputs
REM prints choice banner to console
IF findbackchoice% THEN
    LET eventtitle$ = "BACKWARDS CHOICE BANNER:"
ELSE
    LET eventtitle$ = "CHOICE BANNER:"
END IF
LET x = 0
DO
    LET x = x + 1
    IF x = 1 THEN
        LET eventdata$ = choicename$(x)
    ELSE
        LET eventdata$ = eventdata$ + " / " + choicename$(x)
    END IF
LOOP UNTIL x >= choicetotal
LET x = 0
LET eventnumber = choicetotal
GOSUB consoleprinter
LET choiceno = 1
LET temp71 = temp71 + 1
choiceloop:
REM clears values
LET x = 0
DO
    LET x = x + 1
    LET bannercharacter(x) = ""
LOOP UNTIL x = LEN(choicename$(choiceno))
REM centres text
LET centretext$ = choicename$(choiceno)
GOSUB centretext
REM draws ui
_PUTIMAGE (0, (resy - textbannerresy))-(textbannerresx - 1, resy - 1), choicebanner
IF choiceno = 1 THEN
    REM nothing
ELSE
    _PUTIMAGE (choicearrowl, (temp71 + (textbannerresy / 2)) - (pocketarrowresy / 2))-(choicearrowl + pocketarrowresx - 1, (pocketarrowresy + (temp71 + (textbannerresy / 2))) - (pocketarrowresy / 2) - 1), pocketarrowl
END IF
IF choiceno = choicetotal THEN
    REM nothing
ELSE
    _PUTIMAGE (choicearrowr, (temp71 + (textbannerresy / 2)) - (pocketarrowresy / 2))-(choicearrowr + pocketarrowresx - 1, (pocketarrowresy + (temp71 + (textbannerresy / 2))) - (pocketarrowresy / 2) - 1), pocketarrowr
END IF
LET x = 0
DO
    LET x = x + 1
    LET bannercharacter(x) = MID$(choicename$(choiceno), x, 1)
LOOP UNTIL x >= LEN(choicename$(choiceno))
LET x = 0: LET y = 0: LET temp14$ = "": LET temp201 = 0
DO
    REM prints choice to screen letter by letter
    LET temp201 = temp201 + 1
    IF y = 0 THEN
        _LIMIT hertz
    ELSE
        _LIMIT extrahertz
    END IF
    LET temp14$ = bannercharacter$(temp201)
    LET ci = _KEYHIT
    GOSUB timeframecounter
    IF ci = scontrolcode1 OR ci = scontrolcode2 OR ci = scontrolcode3 OR ci = scontrolcode4 THEN LET y = 1
    COLOR _RGBA(letspeechcolourr, letspeechcolourg, letspeechcolourb, letspeechcoloura), _RGBA(bgspeechcolourr, bgspeechcolourg, bgspeechcolourb, bgspeechcoloura)
    REM i mode
    IF imode = 0 THEN
        _PRINTSTRING ((resx / 2) - (centreno / 2) + x, 125), temp14$
    ELSE
        IF imode = 1 THEN
            IF temp14$ = "i" THEN
                _PRINTSTRING ((resx / 2) - (centreno / 2) + x + (fontsize / 4), 125), temp14$
            ELSE
                _PRINTSTRING ((resx / 2) - (centreno / 2) + x, 125), temp14$
            END IF
        END IF
        IF imode = 2 THEN
            IF UCASE$(temp14$) = "I" THEN
                _PRINTSTRING ((resx / 2) - (centreno / 2) + x + (fontsize / 4), 125), temp14$
            ELSE
                _PRINTSTRING ((resx / 2) - (centreno / 2) + x, 125), temp14$
            END IF
        END IF
    END IF
    IF y = 0 THEN _DELAY 0.05: REM letter delay
    LET x = x + (fontsize / 2) + 1
    IF temp14$ <> " " THEN LET x = x + fontbuffer
LOOP UNTIL temp201 >= LEN(choicename$(choiceno))
_KEYCLEAR
LET x = 0: LET y = 0: LET temp14$ = ""
CLOSE #1
DO
    DO
        REM takes player inputs
        _LIMIT hertz
        LET ci = _KEYHIT
        GOSUB timeframecounter
    LOOP UNTIL ci = lcontrolcode1 OR ci = lcontrolcode2 OR ci = lcontrolcode3 OR ci = lcontrolcode4 OR ci = rcontrolcode1 OR ci = rcontrolcode2 OR ci = rcontrolcode3 OR ci = rcontrolcode4 OR ci = scontrolcode1 OR ci = scontrolcode2 OR ci = scontrolcode3 OR ci = scontrolcode4
    REM processes player inputs
    IF ci = lcontrolcode1 OR ci = lcontrolcode2 OR ci = lcontrolcode3 OR ci = lcontrolcode4 THEN
        REM left
        IF choiceno > 1 THEN
            _KEYCLEAR
            LET playsfx$ = "move"
            GOSUB sfxplay
            _PUTIMAGE (choicearrowl, (temp71 + (textbannerresy / 2)) - (pocketarrowresy / 2))-(choicearrowl + pocketarrowresx - 1, (pocketarrowresy + (temp71 + (textbannerresy / 2))) - (pocketarrowresy / 2) - 1), pocketarrowls
            _DELAY 0.1
            _PUTIMAGE (choicearrowl, (temp71 + (textbannerresy / 2)) - (pocketarrowresy / 2))-(choicearrowl + pocketarrowresx - 1, (pocketarrowresy + (temp71 + (textbannerresy / 2))) - (pocketarrowresy / 2) - 1), pocketarrowl
            LET choiceno = choiceno - 1
            GOTO choiceloop
        END IF
    END IF
    IF ci = rcontrolcode1 OR ci = rcontrolcode2 OR ci = rcontrolcode3 OR ci = rcontrolcode4 THEN
        REM right
        IF choiceno < choicetotal THEN
            _KEYCLEAR
            LET playsfx$ = "move"
            GOSUB sfxplay
            _PUTIMAGE (choicearrowr, (temp71 + (textbannerresy / 2)) - (pocketarrowresy / 2))-(choicearrowr + pocketarrowresx - 1, (pocketarrowresy + (temp71 + (textbannerresy / 2))) - (pocketarrowresy / 2) - 1), pocketarrowrs
            _DELAY 0.1
            _PUTIMAGE (choicearrowr, (temp71 + (textbannerresy / 2)) - (pocketarrowresy / 2))-(choicearrowr + pocketarrowresx - 1, (pocketarrowresy + (temp71 + (textbannerresy / 2))) - (pocketarrowresy / 2) - 1), pocketarrowr
            LET choiceno = choiceno + 1
            GOTO choiceloop
        END IF
    END IF
    IF ci = scontrolcode1 OR ci = scontrolcode2 OR ci = scontrolcode3 OR ci = scontrolcode4 THEN
        REM select
        _KEYCLEAR
        LET playsfx$ = "select"
        GOSUB sfxplay
        REM clears values
        LET x = 0
        DO
            LET x = x + 1
            LET bannercharacter(x) = ""
        LOOP UNTIL x = LEN(choicename$(choiceno))
        REM tells console
        LET eventtitle$ = "CHOICE MADE:"
        LET eventdata$ = choicename$(choiceno)
        LET eventnumber = choiceno
        GOSUB consoleprinter
        LET x = 0
        DO
            LET x = x + 1
            LET choicename$(x) = ""
        LOOP UNTIL x >= choicetotal
        LET x = 0
        LET choicetotal = 0
        RETURN
    END IF
    _KEYCLEAR
LOOP
RETURN

textbannerdraw:
REM draws text banner and NPC pic
_KEYCLEAR
LET banneron = 1
LET awarddisplay = 0
COLOR _RGBA(letspeechcolourr, letspeechcolourg, letspeechcolourb, letspeechcoloura), _RGBA(bgspeechcolourr, bgspeechcolourg, bgspeechcolourb, bgspeechcoloura)
IF mainmenu = 0 THEN GOSUB slightfadeout
LET temp71 = (resy + 1)
REM sets speakers name
IF objecttype$ = "NPC" THEN
    REM sets player name if NPC
    REM matches player
    LET x = 0
    DO
        LET x = x + 1
        IF selectobject$ = playername$(x) THEN LET speakername$ = playerlongname$(x): LET temp80 = x
    LOOP UNTIL x >= mapplayerno OR x >= totalplayers
    LET x = 0
END IF
IF objecttype$ = "OBJ" THEN
    REM sets to main player name if object
    LET speakername$ = mainplayerlongname$
END IF
IF objecttype$ = "NON" THEN LET speakername$ = ""
REM draws text banner
DO
    _LIMIT pockethudanispeed
    IF mainmenu = 0 AND setupboot = 0 AND erasesaveonly = 0 THEN
        IF speakername$ <> "" THEN
            _PUTIMAGE (0, temp71 - fontsize)-(fontsize * LEN(speakername$), temp71), textbannername
            COLOR _RGBA(letspeechcolourr, letspeechcolourg, letspeechcolourb, letspeechcoloura), _RGBA(bgspeechcolourr, bgspeechcolourg, bgspeechcolourb, bgspeechcoloura)
            _PRINTSTRING (fontsize, temp71 - fontsize), speakername$
        END IF
    END IF
    _PUTIMAGE (0, temp71)-(textbannerresx - 1, (textbannerresy + temp71) - 1), textbanner
    LET temp71 = temp71 - 1
LOOP UNTIL temp71 <= (resy - textbannerresy - 1)
LET temp71 = resx + 1
REM draws player portrait
DO
    _LIMIT pockethudanispeed
    IF mainmenu = 0 THEN
        IF objecttype$ = "OBJ" THEN
            IF ctime MOD 2 THEN
                _PUTIMAGE (temp71, textbannerfacey)-((temp71 + textbannerfaceresx - 1), (textbannerfacey + textbannerfaceresy - 1)), mpface1
            ELSE
                _PUTIMAGE (temp71, textbannerfacey)-((temp71 + textbannerfaceresx - 1), (textbannerfacey + textbannerfaceresy - 1)), mpface2
            END IF
        END IF
        IF objecttype$ = "NPC" THEN
            IF ctime MOD 2 THEN
                _PUTIMAGE (temp71, textbannerfacey)-((temp71 + textbannerfaceresx - 1), (textbannerfacey + textbannerfaceresy - 1)), playerface1(temp80)
            ELSE
                _PUTIMAGE (temp71, textbannerfacey)-((temp71 + textbannerfaceresx - 1), (textbannerfacey + textbannerfaceresy - 1)), playerface2(temp80)
            END IF
        END IF
    END IF
    LET temp71 = temp71 - 1
LOOP UNTIL temp71 = (resx - textbannerfaceresx)
_PUTIMAGE (0, (resy - textbannerresy))-(textbannerresx - 1, resy - 1), textbanner
IF mainmenu = 0 THEN
    IF objecttype$ = "OBJ" THEN
        IF ctime MOD 2 THEN
            _PUTIMAGE (temp71, textbannerfacey)-((temp71 + textbannerfaceresx - 1), (textbannerfacey + textbannerfaceresy - 1)), mpface1
        ELSE
            _PUTIMAGE (temp71, textbannerfacey)-((temp71 + textbannerfaceresx - 1), (textbannerfacey + textbannerfaceresy - 1)), mpface2
        END IF
    END IF
    IF objecttype$ = "NPC" THEN
        IF ctime MOD 2 THEN
            _PUTIMAGE (temp71, textbannerfacey)-((temp71 + textbannerfaceresx - 1), (textbannerfacey + textbannerfaceresy - 1)), playerface1(temp80)
        ELSE
            _PUTIMAGE (temp71, textbannerfacey)-((temp71 + textbannerfaceresx - 1), (textbannerfacey + textbannerfaceresy - 1)), playerface2(temp80)
        END IF
    END IF
END IF
GOSUB textbannercalc
COLOR 0, 0
IF mainmenu = 0 THEN GOSUB slightfadein
LET temp71 = 0: LET temp80 = 0: LET temp9000 = 0: LET textspeech$ = "": LET banneron = 0: REM scrub temp values
_KEYCLEAR: REM clears keyboard input
RETURN

talksfx:
REM generates sound effects for player talking
IF soundmode = 1 OR soundmode = 3 THEN RETURN: REM return for if sfx is off.
IF autotxtsfx = 1 THEN
    IF temp124 = 0 THEN LET temp124 = 1: REM sets values
    REM mainplayer
    IF objecttype$ = "OBJ" OR objecttype$ = "" THEN
        IF textline$ <> " " OR textline$ <> "" THEN
            SOUND 0, 0
            IF temp124 = 1 THEN SOUND mpnote1, 1
            IF temp124 = 2 THEN SOUND mpnote2, 1
        ELSE
            SOUND 0, 0
        END IF
    END IF
    REM NPC
    IF objecttype$ = "NPC" THEN
        IF textline$ <> " " OR textline$ <> "" THEN
            SOUND 0, 0
            IF temp124 = 1 THEN LET temp125 = playernote1(temp80)
            IF temp124 = 2 THEN LET temp125 = playernote2(temp80)
            SOUND temp125, 1
        ELSE
            SOUND 0, 0
        END IF
    END IF
    REM changes note value
    IF temp124 = 1 THEN LET temp124 = 2: RETURN
    IF temp124 = 2 THEN LET temp124 = 1: RETURN
END IF
IF autotxtsfx = 2 THEN
    IF temp9000 = 1 THEN RETURN
    LET playsfx$ = "talk": GOSUB sfxplay: REM plays sound efffect
    LET temp9000 = 1
END IF
IF autotxtsfx = 3 THEN
    IF temp9000 = 1 THEN RETURN
    IF objecttype$ = "OBJ" OR objecttype$ = "" THEN
        LET playsfx$ = "talk-" + mplayermodel$: GOSUB sfxplay
    END IF
    IF objecttype$ = "NPC" THEN
        LET playsfx$ = "talk-" + playername$(temp80): GOSUB sfxplay
    END IF
    LET temp9000 = 1
END IF
RETURN

textbannercalc:
REM calculates how long text is to be in text banner
COLOR _RGBA(letspeechcolourr, letspeechcolourg, letspeechcolourb, letspeechcoloura), _RGBA(bgspeechcolourr, bgspeechcolourg, bgspeechcolourb, bgspeechcoloura)
REM outputs text to temp variables letter by letter
DO
    LET temp72 = temp72 + 1
    LET bannercharacter$(temp72) = MID$(textspeech$, temp72, 1)
LOOP UNTIL temp72 >= LEN(textspeech$)
REM prints text banner to console
LET eventtitle$ = "TEXT BANNER:"
LET eventdata$ = textspeech$
LET eventnumber = temp72
GOSUB consoleprinter
REM puts appropiate letters in place
LET temp72 = 5
LET temp75 = 1
LET temp76 = 1
LET temp201 = 0
LET bannerlettercount = 0
DO
    IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN IF skipallowed = 1 THEN LET scriptskip = 1
    LET temp201 = temp201 + 1
    REM limit fps
    IF temp76 = 1 THEN
        _LIMIT hertz
    ELSE
        _LIMIT extrahertz
    END IF
    LET d = _KEYHIT
    GOSUB timeframecounter
    LET textline$ = bannercharacter$(temp201)
    REM prints letter to screen adds pixels if the letter is i.
    IF imode = 0 THEN
        IF temp75 = 1 THEN _PRINTSTRING (temp72, 120), textline$
        IF temp75 = 2 THEN _PRINTSTRING (temp72, 130), textline$
    ELSE
        IF imode = 1 THEN
            IF textline$ = "i" THEN
                IF temp75 = 1 THEN _PRINTSTRING (temp72 + (fontsize / 4), 120), textline$
                IF temp75 = 2 THEN _PRINTSTRING (temp72 + (fontsize / 4), 130), textline$
            ELSE
                IF temp75 = 1 THEN _PRINTSTRING (temp72, 120), textline$
                IF temp75 = 2 THEN _PRINTSTRING (temp72, 130), textline$
            END IF
        END IF
        IF imode = 2 THEN
            IF UCASE$(textline$) = "I" THEN
                IF temp75 = 1 THEN _PRINTSTRING (temp72 + (fontsize / 4), 120), textline$
                IF temp75 = 2 THEN _PRINTSTRING (temp72 + (fontsize / 4), 130), textline$
            ELSE
                IF temp75 = 1 THEN _PRINTSTRING (temp72, 120), textline$
                IF temp75 = 2 THEN _PRINTSTRING (temp72, 130), textline$
            END IF
        END IF
    END IF
    LET bannerlettercount = bannerlettercount + 1: REM adds one to letter counter
    REM animates player portrait
    IF mainmenu = 0 THEN
        IF objecttype$ = "OBJ" THEN
            IF ctime MOD 2 THEN
                _PUTIMAGE (temp71, textbannerfacey)-((temp71 + textbannerfaceresx - 1), (textbannerfacey + textbannerfaceresy - 1)), mpface1
            ELSE
                _PUTIMAGE (temp71, textbannerfacey)-((temp71 + textbannerfaceresx - 1), (textbannerfacey + textbannerfaceresy - 1)), mpface2
            END IF
        END IF
        IF objecttype$ = "NPC" THEN
            IF ctime MOD 2 THEN
                _PUTIMAGE (temp71, textbannerfacey)-((temp71 + textbannerfaceresx - 1), (textbannerfacey + textbannerfaceresy - 1)), playerface1(temp80)
            ELSE
                _PUTIMAGE (temp71, textbannerfacey)-((temp71 + textbannerfaceresx - 1), (textbannerfacey + textbannerfaceresy - 1)), playerface2(temp80)
            END IF
        END IF
    END IF
    REM plays talking sounds
    IF temp76 = 1 THEN GOSUB talksfx
    LET temp72 = temp72 + (fontsize / 2) + 1
    IF textline$ <> " " THEN LET temp72 = temp72 + fontbuffer
    IF temp76 = 1 THEN _DELAY 0.05: REM letter draw delay
    REM if space is pressed
    IF d = scontrolcode1 OR d = scontrolcode2 OR d = scontrolcode3 OR d = scontrolcode4 THEN _KEYCLEAR: LET temp76 = 2
    REM if space happens close to end of line
    IF textline$ = " " THEN
        REM detects length of next word
        LET i = 0: LET ii = 0: LET iii = 0: LET iiii = 0
        DO
            LET i = i + 1
            LET x$ = MID$(textspeech$, i, 1)
            IF i > bannerlettercount THEN
                IF x$ = " " THEN
                    LET ii = ii + 1
                    LET iii = 1
                ELSE
                    LET ii = ii + 1
                END IF
            END IF
        LOOP UNTIL iii = 1 OR i > LEN(textspeech$)
        LET iiii = i - bannerlettercount
        IF temp72 + ((fontsize / 2) * iiii) + iiii >= resx - 5 THEN LET temp72 = resx: REM forces a reset of text cursor if word is too long
        LET i = 0: LET ii = 0: LET iii = 0: LET iiii = 0: REM scubs temp values
    END IF
    REM if textspeech$ is too long for text banner
    IF temp72 >= resx - 5 THEN
        LET temp72 = 5: REM resets text cursor
        IF temp75 = 1 THEN
            LET temp75 = 2: REM puts text cursor down a line
        ELSE
            DO
                IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN IF skipallowed = 1 THEN LET scriptskip = 1
                _LIMIT hertz
                LET dd = _KEYHIT
                GOSUB timeframecounter
                IF mainmenu = 0 THEN
                    IF objecttype$ = "OBJ" THEN
                        IF ctime MOD 2 THEN
                            _PUTIMAGE (temp71, textbannerfacey)-((temp71 + textbannerfaceresx - 1), (textbannerfacey + textbannerfaceresy - 1)), mpface1
                        ELSE
                            _PUTIMAGE (temp71, textbannerfacey)-((temp71 + textbannerfaceresx - 1), (textbannerfacey + textbannerfaceresy - 1)), mpface2
                        END IF
                    END IF
                    IF objecttype$ = "NPC" THEN
                        IF ctime MOD 2 THEN
                            _PUTIMAGE (temp71, textbannerfacey)-((temp71 + textbannerfaceresx - 1), (textbannerfacey + textbannerfaceresy - 1)), playerface1(temp80)
                        ELSE
                            _PUTIMAGE (temp71, textbannerfacey)-((temp71 + textbannerfaceresx - 1), (textbannerfacey + textbannerfaceresy - 1)), playerface2(temp80)
                        END IF
                    END IF
                END IF
            LOOP UNTIL dd = scontrolcode1 OR dd = scontrolcode2 OR dd = scontrolcode3 OR dd = scontrolcode4 OR skipscript = 1
            _KEYCLEAR
            _PUTIMAGE (0, (resy - textbannerresy))-(textbannerresx - 1, resy - 1), textbanner
            LET temp75 = 1
            LET temp76 = 1
        END IF
    END IF
LOOP UNTIL temp201 >= LEN(textspeech$) OR scriptskip = 1
CLOSE #1
DO
    IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN IF skipallowed = 1 THEN LET scriptskip = 1
    _LIMIT hertz
    LET ddd = _KEYHIT
    GOSUB timeframecounter
    IF mainmenu = 0 THEN
        IF objecttype$ = "OBJ" THEN
            IF ctime MOD 2 THEN
                _PUTIMAGE (temp71, textbannerfacey)-((temp71 + textbannerfaceresx - 1), (textbannerfacey + textbannerfaceresy - 1)), mpface1
            ELSE
                _PUTIMAGE (temp71, textbannerfacey)-((temp71 + textbannerfaceresx - 1), (textbannerfacey + textbannerfaceresy - 1)), mpface2
            END IF
        END IF
        IF objecttype$ = "NPC" THEN
            IF ctime MOD 2 THEN
                _PUTIMAGE (temp71, textbannerfacey)-((temp71 + textbannerfaceresx - 1), (textbannerfacey + textbannerfaceresy - 1)), playerface1(temp80)
            ELSE
                _PUTIMAGE (temp71, textbannerfacey)-((temp71 + textbannerfaceresx - 1), (textbannerfacey + textbannerfaceresy - 1)), playerface2(temp80)
            END IF
        END IF
    END IF
LOOP UNTIL ddd = scontrolcode1 OR ddd = scontrolcode2 OR ddd = scontrolcode3 OR ddd = scontrolcode4 OR scriptskip = 1
REM plays select sound effect
IF textbannersound = 1 THEN
    LET playsfx$ = "select"
    GOSUB sfxplay
END IF
REM clears banner values
ERASE bannercharacter$
_KEYCLEAR
COLOR 0, 0
LET temp72 = 0: LET temp73 = 0: LET temp75 = 0: LET temp76 = 0: LET temp201 = 0: LET temp14$ = "": LET textline$ = "": LET temp124 = 0: LET temp125 = 0: REM scrub temp values
RETURN

uiload:
REM loads UI items into memory
LET scriptimage = _LOADIMAGE(uiloc$ + scriptimage$ + ".png")
LET pockethud = _LOADIMAGE(uiloc$ + pockethudimage$ + ".png")
LET pocketarrowr = _LOADIMAGE(uiloc$ + pocketarrowright$ + ".png")
LET pocketarrowl = _LOADIMAGE(uiloc$ + pocketarrowleft$ + ".png")
LET pocketarrowrs = _LOADIMAGE(uiloc$ + pocketarrowselectright$ + ".png")
LET pocketarrowls = _LOADIMAGE(uiloc$ + pocketarrowselectleft$ + ".png")
LET pocketbanner = _LOADIMAGE(uiloc$ + pocketbanner$ + ".png")
LET textbanner = _LOADIMAGE(uiloc$ + textbanner$ + ".png")
LET awardbanner = _LOADIMAGE(uiloc$ + awardbanner$ + ".png")
LET choicebanner = _LOADIMAGE(uiloc$ + choicebanner$ + ".png")
LET pocketselect = _LOADIMAGE(uiloc$ + pocketselect$ + ".png")
LET pocketarrowlu = _LOADIMAGE(uiloc$ + pocketarrowunavailableleft$ + ".png")
LET pocketarrowru = _LOADIMAGE(uiloc$ + pocketarrowunavailableright$ + ".png")
LET loadicon = _LOADIMAGE(uiloc$ + loadicon$ + ".png")
LET saveicon = _LOADIMAGE(uiloc$ + saveicon$ + ".png")
LET downloadicon = _LOADIMAGE(uiloc$ + downloadicon$ + ".png")
LET torcheffect = _LOADIMAGE(uiloc$ + torcheffectfile$ + ".png")
LET loadbar = _LOADIMAGE(uiloc$ + loadbar$ + ".png")
LET awardnone = _LOADIMAGE(awardloc$ + "awardnone.png")
LET awardarrowr = _LOADIMAGE(uiloc$ + awardarrowright$ + ".png")
LET awardarrowl = _LOADIMAGE(uiloc$ + awardarrowleft$ + ".png")
LET awardarrowrs = _LOADIMAGE(uiloc$ + awardarrowselectright$ + ".png")
LET awardarrowls = _LOADIMAGE(uiloc$ + awardarrowselectleft$ + ".png")
FOR logoloop = 1 TO devlogono
    IF logoloop = 1 THEN LET devlogo1 = _LOADIMAGE(uiloc$ + devlogo$ + "1.png")
    IF logoloop = 2 THEN LET devlogo2 = _LOADIMAGE(uiloc$ + devlogo$ + "2.png")
    IF logoloop = 3 THEN LET devlogo3 = _LOADIMAGE(uiloc$ + devlogo$ + "3.png")
    IF logoloop = 4 THEN LET devlogo4 = _LOADIMAGE(uiloc$ + devlogo$ + "4.png")
    IF logoloop = 5 THEN LET devlogo5 = _LOADIMAGE(uiloc$ + devlogo$ + "5.png")
    IF logoloop = 6 THEN LET devlogo6 = _LOADIMAGE(uiloc$ + devlogo$ + "6.png")
    IF logoloop = 7 THEN LET devlogo7 = _LOADIMAGE(uiloc$ + devlogo$ + "7.png")
    IF logoloop = 8 THEN LET devlogo8 = _LOADIMAGE(uiloc$ + devlogo$ + "8.png")
    IF logoloop = 9 THEN LET devlogo9 = _LOADIMAGE(uiloc$ + devlogo$ + "9.png")
    IF logoloop = 10 THEN LET devlogo10 = _LOADIMAGE(uiloc$ + devlogo$ + "10.png")
NEXT logoloop
LET textbannername = _LOADIMAGE(uiloc$ + textbannername$ + ".png")
LET errortexture = _LOADIMAGE(uiloc$ + "error.png")
LET eventtitle$ = "UI ITEMS LOADED"
LET eventdata$ = ""
LET eventnumber = 0
GOSUB consoleprinter
RETURN

uiunload:
REM unloads UI items from memory
_FREEIMAGE scriptimage
_FREEIMAGE pockethud
_FREEIMAGE pocketarrowr
_FREEIMAGE pocketarrowl
_FREEIMAGE pocketarrowrs
_FREEIMAGE pocketarrowls
_FREEIMAGE pocketbanner
_FREEIMAGE textbanner
_FREEIMAGE awardbanner
_FREEIMAGE choicebanner
_FREEIMAGE pocketselect
_FREEIMAGE pocketarrowru
_FREEIMAGE pocketarrowlu
_FREEIMAGE loadicon
_FREEIMAGE saveicon
_FREEIMAGE downloadicon
_FREEIMAGE torcheffect
_FREEIMAGE loadbar
_FREEIMAGE awardnone
_FREEIMAGE awardarrowl
_FREEIMAGE awardarrowr
_FREEIMAGE awardarrowls
_FREEIMAGE awardarrowrs
FOR logoloop = 1 TO devlogono
    IF logoloop = 1 THEN _FREEIMAGE devlogo1
    IF logoloop = 2 THEN _FREEIMAGE devlogo2
    IF logoloop = 3 THEN _FREEIMAGE devlogo3
    IF logoloop = 4 THEN _FREEIMAGE devlogo4
    IF logoloop = 5 THEN _FREEIMAGE devlogo5
    IF logoloop = 6 THEN _FREEIMAGE devlogo6
    IF logoloop = 7 THEN _FREEIMAGE devlogo7
    IF logoloop = 8 THEN _FREEIMAGE devlogo8
    IF logoloop = 9 THEN _FREEIMAGE devlogo9
    IF logoloop = 10 THEN _FREEIMAGE devlogo10
NEXT logoloop
_FREEIMAGE textbannername
_FREEIMAGE errortexture
LET eventtitle$ = "UI ITEMS UNLOADED"
LET eventdata$ = ""
LET eventnumber = 0
GOSUB consoleprinter
RETURN

musicplay:
REM plays music
REM diverts
IF soundmode = 1 OR soundmode = 4 THEN RETURN: REM diverts if sound is off
IF playmusic$ = currentmusic$ THEN RETURN: REM diverts if music is the same
IF musictransitionmode = 1 AND tempmusicfade = 0 OR tempmusiccut = 1 THEN IF currentmusic$ <> "" AND musicpause = 0 THEN GOSUB musicstop: REM stops currently playing music
IF musictransitionmode = 2 AND tempmusiccut = 0 OR tempmusicfade = 1 THEN
    REM fades in music
    IF currentmusic$ <> "" AND musicpause = 0 THEN GOSUB musicfadeoutstart: REM fades out currently playing music
    IF musicfadein = 1 THEN
        LET musicfadeinvol = musicfadeoutvol
    ELSE
        LET musicfadein = 1
        LET musicfadeinvol = 0
    END IF
END IF
OPEN museloc$ + "musicfiles.ddf" FOR INPUT AS #1
DO
    INPUT #1, musicfile$
    LET temp30 = temp30 + 1
    IF temp30 = 1 THEN
        IF playmusic$ = musicfile$ THEN
            IF musicfadein = 1 THEN _SNDVOL menumusic%, 0.01: LET fadeinmusic = temp30
            LET currentmusic$ = musicfile$: _SNDLOOP menumusic%
        END IF
    ELSE
        IF playmusic$ = musicfile$ THEN
            IF musicfadein = 1 THEN _SNDVOL musicdata(temp30 - 1), 0.01: LET fadeinmusic = temp30
            LET currentmusic$ = musicfile$: _SNDLOOP musicdata(temp30 - 1)
        END IF
    END IF
LOOP UNTIL EOF(1)
CLOSE #1
REM prints result to console
IF currentmusic$ <> "" THEN
    IF currentmusic$ = playmusic$ THEN
        IF musicfadein = 1 THEN
            LET eventtitle$ = "MUSIC FADING IN + PLAYING:"
        ELSE
            LET eventtitle$ = "MUSIC PLAYING:"
        END IF
        LET eventdata$ = currentmusic$
        LET eventnumber = 0
        GOSUB consoleprinter
        LET musicpause = 0: REM tells engine music is not paused
    ELSE
        LET eventtitle$ = "MUSIC NOT PLAYING:"
        LET eventdata$ = "FILE NOT LOADED"
        LET eventnumber = 0
        GOSUB consoleprinter
    END IF
END IF
LET temp30 = 0: REM scrub temp values
RETURN

musicpause:
REM pauses music
REM if soundmode = 1 THEN RETURN: rem return for is sound is off
OPEN museloc$ + "musicfiles.ddf" FOR INPUT AS #1
DO
    INPUT #1, musicfile$
    LET temp32 = temp32 + 1
    IF temp32 = 1 THEN
        IF currentmusic$ = musicfile$ THEN _SNDPAUSE menumusic%: LET musicpause = 1
    ELSE
        IF temp32 = 2 THEN IF currentmusic$ = musicfile$ THEN _SNDPAUSE musicdata(temp32 - 1): LET musicpause = 1
    END IF
LOOP UNTIL EOF(1)
CLOSE #1
IF musicpause = 1 THEN
    REM prints result to console
    LET eventtitle$ = "MUSIC PAUSED:"
    LET eventdata$ = currentmusic$
    LET eventnumber = 0
    GOSUB consoleprinter
END IF
LET temp32 = 0: REM scrub temp values
RETURN

musicfadein:
REM fades in music
IF soundmode = 1 OR soundmode = 4 OR musicfadein = 0 THEN RETURN: REM return for is sound is off or no fade needed
LET musicfadeinvol = musicfadeinvol + musicfadechange
IF musicfadeinvol > musicvol THEN LET musicfadeinvol = musicvol
IF fadeinmusic = 1 THEN
    _SNDVOL menumusic%, musicfadeinvol
ELSE
    _SNDVOL musicdata(fadeinmusic - 1), musicfadeinvol
END IF
IF musicfadeinvol = musicvol THEN
    REM music fade in finished!
    LET musicfadein = 0
    LET fadeinmusic = 0
    LET musicfadeinvol = 0
    LET eventtitle$ = "MUSIC FADE IN FINISHED!"
    LET eventdata$ = ""
    LET eventnumber = 0
    GOSUB consoleprinter
END IF
RETURN

musicfadeout:
REM fades out music
IF soundmode = 1 OR soundmode = 4 OR musicfadeout = 0 THEN RETURN: REM return for is sound is off or no fade needed
LET musicfadeoutvol = musicfadeoutvol - musicfadechange
IF musicfadeoutvol < 0 THEN LET musicfadeoutvol = 0
IF fadeoutmusic = 1 THEN
    _SNDVOL menumusic%, musicfadeoutvol
ELSE
    _SNDVOL musicdata(fadeoutmusic - 1), musicfadeoutvol
END IF
IF musicfadeoutvol = 0 THEN
    REM music fade out finished!
    IF fadeoutmusic = 1 THEN
        _SNDSTOP menumusic%
        _SNDVOL menumusic%, musicvol
    ELSE
        _SNDSTOP musicdata(fadeoutmusic - 1)
        _SNDVOL musicdata(fadeoutmusic - 1), musicvol
    END IF
    LET musicfadeout = 0
    LET fadeoutmusic = 0
    REM tells console
    LET eventtitle$ = "MUSIC FADE OUT FINISHED!"
    LET eventdata$ = ""
    LET eventnumber = 0
    GOSUB consoleprinter
    REM double checks no unwanted music is playing
    GOSUB musicfadestopper
END IF
RETURN

musicfadestopper:
REM checks for any unwanted music tracks that are still playing and stops them
OPEN museloc$ + "musicfiles.ddf" FOR INPUT AS #1
DO
    INPUT #1, musicfile$
    LET temp31 = temp31 + 1
    IF currentmusic$ <> musicfile$ THEN
        IF temp31 = 1 THEN
            _SNDSTOP menumusic%
        ELSE
            _SNDSTOP musicdata(temp31 - 1)
        END IF
    END IF
LOOP UNTIL EOF(1)
CLOSE #1
LET temp31 = 0: REM scrub temp values
RETURN

musicfadeoutstart:
REM begins fading music out
IF soundmode = 1 OR soundmode = 4 THEN RETURN: REM return for is sound is off
OPEN museloc$ + "musicfiles.ddf" FOR INPUT AS #1
DO
    INPUT #1, musicfile$
    LET temp31 = temp31 + 1
    IF currentmusic$ = musicfile$ THEN
        LET oldmusic$ = currentmusic$
        LET fadeoutmusic = temp31
        LET currentmusic$ = ""
        IF musicfadeout = 0 THEN
            LET musicfadeoutvol = musicvol
        ELSE
            LET musicfadeoutvol = musicfadeinvol
        END IF
        LET musicfadeout = 1
    END IF
LOOP UNTIL EOF(1)
CLOSE #1
REM prints result to console
IF currentmusic$ = "" THEN
    LET eventtitle$ = "MUSIC FADE OUT BEGINS:"
    LET eventdata$ = oldmusic$
    LET eventnumber = 0
    GOSUB consoleprinter
ELSE
    LET eventtitle$ = "MUSIC NOT STOPPED:"
    LET eventdata$ = "FILE NOT LOADED"
    LET eventnumber = 0
    GOSUB consoleprinter
END IF
LET temp31 = 0: REM scrub temp values
RETURN

musicstop:
REM stops music
IF soundmode = 1 OR soundmode = 4 THEN RETURN: REM return for is sound is off
OPEN museloc$ + "musicfiles.ddf" FOR INPUT AS #1
DO
    INPUT #1, musicfile$
    LET temp31 = temp31 + 1
    IF temp31 = 1 THEN
        IF currentmusic$ = musicfile$ THEN LET oldmusic$ = currentmusic$: LET currentmusic$ = "": _SNDSTOP menumusic%
    ELSE
        IF currentmusic$ = musicfile$ THEN LET oldmusic$ = currentmusic$: LET currentmusic$ = "": _SNDSTOP musicdata(temp31 - 1)
    END IF
LOOP UNTIL EOF(1)
CLOSE #1
REM prints result to console
IF currentmusic$ = "" THEN
    LET eventtitle$ = "MUSIC STOPPED:"
    LET eventdata$ = oldmusic$
    LET eventnumber = 0
    GOSUB consoleprinter
ELSE
    LET eventtitle$ = "MUSIC NOT STOPPED:"
    LET eventdata$ = "FILE NOT LOADED"
    LET eventnumber = 0
    GOSUB consoleprinter
END IF
LET temp31 = 0: REM scrub temp values
RETURN

musicload:
REM loads music files into memory
IF liteload = 1 THEN RETURN: REM return for if liteload is active
OPEN museloc$ + "musicfiles.ddf" FOR INPUT AS #1
DO
    LET temp28 = temp28 + 1
    INPUT #1, musicfile$: REM reads name of music file to be loaded
    REM loads music files and assigns them a slot
    IF temp28 = 1 THEN
        LET menumusic% = _SNDOPEN(museloc$ + musicfile$ + ".ogg")
    ELSE
        LET music$(temp28 - 1) = musicfile$: LET musicdata(temp28 - 1) = _SNDOPEN(museloc$ + musicfile$ + ".ogg")
    END IF
    REM prints load to console
    LET eventtitle$ = "MUSIC LOADED:"
    LET eventdata$ = musicfile$
    LET eventnumber = temp28
    GOSUB consoleprinter
    IF setupboot = 1 THEN
        REM loadbar
        LET temp125 = temp125 + loadbarsize
        GOSUB loadbar
    END IF
LOOP UNTIL EOF(1)
CLOSE #1
GOSUB musicvol: REM sets music volume level
REM scrub temp values
LET temp28 = 0
RETURN

musicvol:
REM changes volume of music
IF soundmode = 1 OR soundmode = 4 THEN RETURN: REM return for if music if off
OPEN museloc$ + "musicfiles.ddf" FOR INPUT AS #1
DO
    INPUT #1, musicfile$
    LET temp133 = temp133 + 1
    IF temp133 = 1 THEN
        _SNDVOL menumusic%, musicvol
    ELSE
        _SNDVOL musicdata(temp133 - 1), musicvol
    END IF
LOOP UNTIL EOF(1)
CLOSE #1
REM prints to console
LET eventtitle$ = "MUSIC VOLUME SET:"
LET eventdata$ = ""
LET eventnumber = musicvol
GOSUB consoleprinter
LET temp133 = 0: REM scrub temp values
RETURN

musicunload:
REM unloads music files from memory
OPEN museloc$ + "musicfiles.ddf" FOR INPUT AS #1
DO
    INPUT #1, musicfile$
    LET temp29 = temp29 + 1
    IF temp29 = 1 THEN
        _SNDCLOSE menumusic%
    ELSE
        _SNDCLOSE musicdata(temp29 - 1)
    END IF
    LET eventtitle$ = "MUSIC UNLOADED:"
    LET eventdata$ = musicfile$
    LET eventnumber = temp29
    GOSUB consoleprinter
LOOP UNTIL EOF(1)
CLOSE #1
LET temp29 = 0: REM scrub temp values
RETURN

sfxstop:
REM stops all playing sfx
OPEN sfxloc$ + "sfxfiles.ddf" FOR INPUT AS #8
DO
    INPUT #8, sfxfile$
    LET temp37 = temp37 + 1
    _SNDSTOP sfxdata(temp37)
LOOP UNTIL EOF(8)
CLOSE #8
LET eventtitle$ = "SOUND EFFECTS STOPPED!"
LET eventdata$ = ""
LET eventnumber = 0
GOSUB consoleprinter
LET temp37 = 0
RETURN

sfxplay:
REM plays sfx
REM diverts
IF soundmode = 1 OR soundmode = 3 THEN RETURN
OPEN sfxloc$ + "sfxfiles.ddf" FOR INPUT AS #8
DO
    INPUT #8, sfxfile$
    LET temp37 = temp37 + 1
    IF playsfx$ = sfxfile$ THEN _SNDPLAY sfxdata(temp37): LET temp38 = 1
LOOP UNTIL EOF(8)
CLOSE #8
REM prints result to console
IF temp38 = 1 THEN
    LET eventtitle$ = "SOUND EFFECT PLAYING:"
    LET eventdata$ = playsfx$
    LET eventnumber = 0
    GOSUB consoleprinter
ELSE
    LET eventtitle$ = "SOUND EFFECT NOT PLAYING:"
    LET eventdata$ = "file not loaded"
    LET eventnumber = 0
    GOSUB consoleprinter
END IF
LET temp37 = 0: LET temp38 = 0: REM scrub temp values
RETURN

sfxloop:
REM loops a sound effect
REM diverts
IF soundmode = 1 OR soundmode = 3 THEN RETURN
OPEN sfxloc$ + "sfxfiles.ddf" FOR INPUT AS #8
DO
    INPUT #8, sfxfile$
    LET temp37 = temp37 + 1
    IF playsfx$ = sfxfile$ THEN _SNDLOOP sfxdata(temp37): LET temp38 = 1
LOOP UNTIL EOF(8)
CLOSE #8
REM prints result to console
IF temp38 = 1 THEN
    LET eventtitle$ = "SOUND EFFECT LOOPING:"
    LET eventdata$ = playsfx$
    LET eventnumber = 0
    GOSUB consoleprinter
ELSE
    LET eventtitle$ = "SOUND EFFECT NOT LOOPING:"
    LET eventdata$ = "file not loaded"
    LET eventnumber = 0
    GOSUB consoleprinter
END IF
LET temp37 = 0: LET temp38 = 0: REM scrub temp values
RETURN

sfxload:
REM loads sfx files into memory
IF liteload = 1 THEN RETURN: REM return for if liteload is active
OPEN sfxloc$ + "sfxfiles.ddf" FOR INPUT AS #1
DO
    LET temp35 = temp35 + 1
    INPUT #1, sfxfile$: REM reads name of music file to be loaded
    REM loads music files and assigns them a slot
    LET sfx$(temp35) = sfxfile$: LET sfxdata(temp35) = _SNDOPEN(sfxloc$ + sfxfile$ + ".ogg")
    REM prints load to console
    LET eventtitle$ = "SOUND EFFECT LOADED:"
    LET eventdata$ = sfxfile$
    LET eventnumber = temp35
    GOSUB consoleprinter
    IF setupboot = 1 THEN
        REM loading bar
        LET temp125 = temp125 + loadbarsize
        GOSUB loadbar
    END IF
LOOP UNTIL EOF(1)
CLOSE #1
GOSUB sfxvol
REM scrub temp values
LET temp35 = 0
RETURN

sfxvol:
REM sets sfx volume
IF soundmode = 1 OR soundmode = 3 THEN RETURN: REM return for is sound is off
OPEN sfxloc$ + "sfxfiles.ddf" FOR INPUT AS #1
DO
    INPUT #1, sfxfile$
    LET temp134 = temp134 + 1
    _SNDVOL sfxdata(temp134), sfxvol
LOOP UNTIL EOF(1)
CLOSE #1
REM prints to console
LET eventtitle$ = "SOUND EFFECT VOLUME SET:"
LET eventdata$ = ""
LET eventnumber = sfxvol
GOSUB consoleprinter
LET temp134 = 0: REM scub temp values
RETURN

sfxunload:
REM unloads sfx files from memory
OPEN sfxloc$ + "sfxfiles.ddf" FOR INPUT AS #1
DO
    INPUT #1, sfxfile$
    LET temp36 = temp36 + 1
    _SNDCLOSE sfxdata(temp36)
    LET eventtitle$ = "SOUND EFFECT UNLOADED:"
    LET eventdata$ = sfxfile$
    LET eventnumber = temp36
    GOSUB consoleprinter
LOOP UNTIL EOF(1)
CLOSE #1
LET temp36 = 0: REM scrub temp values
RETURN

optionload:
REM loads options
REM checks to see if options file exists
IF _FILEEXISTS(sloc$ + "options.ddf") THEN
    REM loads options
    OPEN sloc$ + "options.ddf" FOR INPUT AS #1
    INPUT #1, screenmode, soundmode, musicvol, sfxvol
    CLOSE #1
    REM prints to console
    LET eventtitle$ = "OPTION DATA LOADED:"
    LET eventdata$ = menuloc$ + "options.ddf"
    LET eventnumber = 0
    GOSUB consoleprinter
ELSE
    REM copies default options
    LET eventtitle$ = "OPTIONS FILE MISSING OR CORRUPT"
    LET eventdata$ = "resetting to default"
    LET eventnumber = 0
    GOSUB consoleprinter
    IF _FILEEXISTS(sloc$ + "defaultoptions.ddf") THEN
        REM nothing
    ELSE
        ERROR 434
    END IF
    REM Linux
    IF ros$ = "lnx" OR ros$ = "mac" THEN
        SHELL _HIDE "cp " + sloc$ + "defaultoptions.ddf " + sloc$ + "options.ddf"
    END IF
    REM windows
    IF ros$ = "win" THEN
        SHELL _HIDE "copy " + sloc$ + "defaultoptions.ddf " + sloc$ + "options.ddf"
    END IF
    GOTO optionload
END IF
RETURN

savevalue:
REM saves a specific value to save file
REM loads savedata, stores temp values
OPEN sloc$ + "savedata.ddf" FOR INPUT AS #1
INPUT #1, tempmapno, tempcurrency, tempposx, tempposy, tempdirection, tempigametime, temppocketcarry
REM loads pocket items
LET x = 0
DO
    LET x = x + 1
    INPUT #1, temppocketitem(x)
LOOP UNTIL x >= totalpockets
REM loads extra pocket data
LET x = 0
DO
    LET x = x + 1
    INPUT #1, temppocketvisible(x)
LOOP UNTIL x >= totalpockets
REM loads checkpoints
LET x = 0
DO
    LET x = x + 1
    INPUT #1, tempcheckpoint(x)
LOOP UNTIL x >= totalcheckpoints
REM loads custom script values
LET x = 0
DO
    LET x = x + 1
    INPUT #1, tempscriptvalue(x)
LOOP UNTIL x >= totalscriptvalues
REM writes awards
LET x = 0
DO
    LET x = x + 1
    INPUT #1, tempawardvalue(x)
LOOP UNTIL x >= totalawards
REM loads main player
LET x = 0
INPUT #1, tempmplayermodel$
CLOSE #1
REM saves time to file
OPEN sloc$ + "savedata.ddf" FOR OUTPUT AS #1
WRITE #1, tempmapno, tempcurrency, tempposx, tempposy, tempdirection, gametime, temppocketcarry
REM writes pocket items
LET x = 0
DO
    LET x = x + 1
    WRITE #1, temppocketitem(x)
LOOP UNTIL x >= totalpockets
REM writes extra pocket data
LET x = 0
DO
    LET x = x + 1
    WRITE #1, temppocketvisible(x)
LOOP UNTIL x >= totalpockets
REM writes checkpoints
LET x = 0
DO
    LET x = x + 1
    WRITE #1, tempcheckpoint(x)
LOOP UNTIL x >= totalcheckpoints
REM writes custom script values
LET x = 0
DO
    LET x = x + 1
    IF x = valuesaveno THEN
        WRITE #1, scriptvalue(valuesaveno)
    ELSE
        WRITE #1, tempscriptvalue(x)
    END IF
LOOP UNTIL x >= totalscriptvalues
REM writes awards
LET x = 0
DO
    LET x = x + 1
    WRITE #1, awardvalue(x)
LOOP UNTIL x >= totalawards
REM writes main player
LET x = 0
WRITE #1, tempmplayermodel$
CLOSE #1
REM erases temp values
FOR x = 1 TO totalpockets
    LET temppocketitem(x) = 0
NEXT x
FOR x = 1 TO totalpockets
    LET temppocketvisible(x) = 0
NEXT x
FOR x = 1 TO totalcheckpoints
    LET tempcheckpoint(x) = 0
NEXT x
FOR x = 1 TO totalawards
    LET tempawardvalue(x) = 0
NEXT x
LET tempmplayermodel$ = ""
LET tempmapno = 0: LET tempposx = 0: LET tempposy = 0: LET tempcurrency = 0: LET tempdirection = 0: LET tempigametime = 0: LET temppocketcarry = 0
REM prints to console
LET eventtitle$ = "VALUE " + LTRIM$(STR$(valuesaveno)) + " DATA SAVED:"
LET eventdata$ = sloc$ + "savedata.ddf"
LET eventnumber = 0
GOSUB consoleprinter
RETURN

savetime:
REM saves time and award data to save file
REM loads and stores temp values
REM loads savedata
OPEN sloc$ + "savedata.ddf" FOR INPUT AS #1
INPUT #1, tempmapno, tempcurrency, tempposx, tempposy, tempdirection, tempigametime, temppocketcarry
REM loads pocket items
LET x = 0
DO
    LET x = x + 1
    INPUT #1, temppocketitem(x)
LOOP UNTIL x >= totalpockets
REM loads extra pocket data
LET x = 0
DO
    LET x = x + 1
    INPUT #1, temppocketvisible(x)
LOOP UNTIL x >= totalpockets
REM loads checkpoints
LET x = 0
DO
    LET x = x + 1
    INPUT #1, tempcheckpoint(x)
LOOP UNTIL x >= totalcheckpoints
REM loads custom script values
LET x = 0
DO
    LET x = x + 1
    INPUT #1, tempscriptvalue(x)
LOOP UNTIL x >= totalscriptvalues
REM writes awards
LET x = 0
DO
    LET x = x + 1
    INPUT #1, tempawardvalue(x)
LOOP UNTIL x >= totalawards
REM loads main player
LET x = 0
INPUT #1, tempmplayermodel$
CLOSE #1
REM saves time to file
OPEN sloc$ + "savedata.ddf" FOR OUTPUT AS #1
WRITE #1, tempmapno, tempcurrency, tempposx, tempposy, tempdirection, gametime, temppocketcarry
REM writes pocket items
LET x = 0
DO
    LET x = x + 1
    WRITE #1, temppocketitem(x)
LOOP UNTIL x >= totalpockets
REM writes extra pocket data
LET x = 0
DO
    LET x = x + 1
    WRITE #1, temppocketvisible(x)
LOOP UNTIL x >= totalpockets
REM writes checkpoints
LET x = 0
DO
    LET x = x + 1
    WRITE #1, tempcheckpoint(x)
LOOP UNTIL x >= totalcheckpoints
REM writes custom script values
LET x = 0
DO
    LET x = x + 1
    WRITE #1, tempscriptvalue(x)
LOOP UNTIL x >= totalscriptvalues
REM writes awards
LET x = 0
DO
    LET x = x + 1
    WRITE #1, awardvalue(x)
LOOP UNTIL x >= totalawards
REM writes main player
LET x = 0
WRITE #1, tempmplayermodel$
CLOSE #1
REM erases temp values
FOR x = 1 TO totalpockets
    LET temppocketitem(x) = 0
NEXT x
FOR x = 1 TO totalpockets
    LET temppocketvisible(x) = 0
NEXT x
FOR x = 1 TO totalcheckpoints
    LET tempcheckpoint(x) = 0
NEXT x
FOR x = 1 TO totalawards
    LET tempawardvalue(x) = 0
NEXT x
LET tempmplayermodel$ = ""
LET tempmapno = 0: LET tempposx = 0: LET tempposy = 0: LET tempcurrency = 0: LET tempdirection = 0: LET tempigametime = 0: LET temppocketcarry = 0
REM prints to console
LET eventtitle$ = "TIME AND AWARD DATA SAVED:"
LET eventdata$ = sloc$ + "savedata.ddf"
LET eventnumber = 0
GOSUB consoleprinter
RETURN

saveload:
REM loads save data
REM checks to see if game is already running
IF setupboot = 0 AND erasesave = 0 AND restoremenu = 0 THEN GOSUB savetime
REM halt any timed scripts
LET scripttimer = 0
LET iscripttimer = 0
LET scripttimername$ = ""
REM checks save data file exists and diverts to save erase if not
IF _FILEEXISTS(sloc$ + "savedata.ddf") THEN
    REM loads savedata
    OPEN sloc$ + "savedata.ddf" FOR INPUT AS #1
    IF setupboot = 1 THEN
        INPUT #1, mapno, currency, posx, posy, direction, igametime, pocketcarry
    ELSE
        INPUT #1, mapno, currency, posx, posy, direction, gametime, pocketcarry
    END IF
    REM loads pocket items
    LET x = 0
    DO
        LET x = x + 1
        INPUT #1, pocketitem(x)
    LOOP UNTIL x >= totalpockets
    REM loads extra pocket data
    LET x = 0
    DO
        LET x = x + 1
        INPUT #1, pocketvisible(x)
    LOOP UNTIL x >= totalpockets
    REM loads checkpoints
    LET x = 0
    DO
        LET x = x + 1
        INPUT #1, checkpoint(x)
    LOOP UNTIL x >= totalcheckpoints
    REM loads custom script values
    LET x = 0
    DO
        LET x = x + 1
        INPUT #1, scriptvalue(x)
    LOOP UNTIL x >= totalscriptvalues
    REM loads awards
    LET x = 0
    DO
        LET x = x + 1
        INPUT #1, awardvalue(x)
    LOOP UNTIL x >= totalawards
    REM loads main player
    LET x = 0
    INPUT #1, mplayermodel$
    CLOSE #1
    REM prints to console
    LET eventtitle$ = "SAVEDATA LOADED:"
    LET eventdata$ = sloc$ + "savedata.ddf"
    LET eventnumber = 0
    GOSUB consoleprinter
    LET eventtitle$ = "SAVEDATA STATUS:"
    IF exitsave = 1 THEN
        LET eventdata$ = "save on exit enabled"
    ELSE
        LET eventdata$ = "save on exit disabled"
    END IF
    LET eventnumber = exitsave
    GOSUB consoleprinter
    LET gametime = 0: REM resets time spent in save file
ELSE
    REM diverts to save erase
    LET eventtitle$ = "SAVE FILE MISSING OR CORRUPT"
    LET eventdata$ = "resetting to default"
    LET eventnumber = 0
    GOSUB consoleprinter
    IF _FILEEXISTS(sloc$ + "defaultsave.ddf") THEN
        REM nothing
    ELSE
        ERROR 422
    END IF
    REM Linux
    IF ros$ = "lnx" OR ros$ = "mac" THEN
        SHELL _HIDE "cp " + sloc$ + "defaultsave.ddf " + sloc$ + "savedata.ddf"
    END IF
    REM windows
    IF ros$ = "win" THEN
        SHELL _HIDE "copy " + sloc$ + "defaultsave.ddf " + sloc$ + "savedata.ddf"
    END IF
    GOTO saveload
END IF
RETURN

savedefault:
REM overwrites default save
LET x = 0
OPEN sloc$ + "defaultsave.ddf" FOR OUTPUT AS #1
WRITE #1, mapno, currency, posx, posy, direction, x, pocketcarry
REM writes pocket items
LET x = 0
DO
    LET x = x + 1
    WRITE #1, pocketitem(x)
LOOP UNTIL x >= totalpockets
CLOSE #1
REM writes extra pocket data
LET x = 0
DO
    LET x = x + 1
    WRITE #1, pocketvisible(x)
LOOP UNTIL x >= totalpockets
REM writes checkpoints
LET x = 0
DO
    LET x = x + 1
    WRITE #1, checkpoint(x)
LOOP UNTIL x >= totalcheckpoints
REM writes custom script values
LET x = 0
DO
    LET x = x + 1
    WRITE #1, scriptvalue(x)
LOOP UNTIL x >= totalscriptvalues
REM writes awards
LET x = 0
DO
    LET x = x + 1
    WRITE #1, awardvalue(x)
LOOP UNTIL x >= totalawards
REM writes main player
LET x = 0
WRITE #1, mplayermodel$
CLOSE #1
REM prints to console
LET eventtitle$ = "DEFAULT SAVE OVERWRITTEN:"
LET eventdata$ = sloc$ + "defaultsave.ddf"
LET eventnumber = 0
GOSUB consoleprinter
RETURN

optionsave:
REM saves the option data
OPEN sloc$ + "options.ddf" FOR OUTPUT AS #1
WRITE #1, screenmode, soundmode, musicvol, sfxvol
CLOSE #1
REM prints to console
LET eventtitle$ = "OPTIONS SAVED:"
LET eventdata$ = sloc$ + "options.ddf"
LET eventnumber = 0
GOSUB consoleprinter
RETURN

savesave:
REM saves save data x
IF nosave = 1 THEN RETURN: REM return for if nosave flag is used.
OPEN sloc$ + "savedata.ddf" FOR OUTPUT AS #1
WRITE #1, mapno, currency, posx, posy, direction, gametime, pocketcarry
REM writes pocket items
LET x = 0
DO
    LET x = x + 1
    WRITE #1, pocketitem(x)
LOOP UNTIL x >= totalpockets
REM writes extra pocket data
LET x = 0
DO
    LET x = x + 1
    WRITE #1, pocketvisible(x)
LOOP UNTIL x >= totalpockets
REM writes checkpoints
LET x = 0
DO
    LET x = x + 1
    WRITE #1, checkpoint(x)
LOOP UNTIL x >= totalcheckpoints
REM writes custom script values
LET x = 0
DO
    LET x = x + 1
    WRITE #1, scriptvalue(x)
LOOP UNTIL x >= totalscriptvalues
REM writes awards
LET x = 0
DO
    LET x = x + 1
    WRITE #1, awardvalue(x)
LOOP UNTIL x >= totalawards
REM writes main player
LET x = 0
WRITE #1, mplayermodel$
CLOSE #1
REM prints to console
LET eventtitle$ = "SAVEDATA SAVED:"
LET eventdata$ = sloc$ + "savedata.ddf"
LET eventnumber = 0
GOSUB consoleprinter
RETURN

screenload:
REM sets screen mode
_TITLE title$
SCREEN _NEWIMAGE(resx, resy, 32)
$RESIZE:STRETCH
REM manages any screen changing parameters
IF forcewindowed = 1 THEN LET screenmode = 2: LET forcewindowed = 0: REM forces windowed mode if launch parameter used
IF forcefullscreen = 1 THEN LET screenmode = 1: LET forcefullscreen = 0: REM forces fullscreen mode if launch parameter used
IF screenmode = 2 THEN _FULLSCREEN _OFF
IF screenmode = 1 THEN _FULLSCREEN _SQUAREPIXELS
IF devmode = 0 THEN _MOUSEHIDE: REM hides mouse (if devmode is off)
LET eventtitle$ = "SCREEN MODE SET:"
IF screenmode = 2 THEN LET eventdata$ = "windowed"
IF screenmode = 1 THEN LET eventdata$ = "fullscreen"
LET eventnumber = screenmode
GOSUB consoleprinter
RETURN

animation:
REM animation
REM checks if animation file exists
REM check if filename needs fixing
IF _FILEEXISTS(aloc$ + anifile$ + "/" + anifile$ + ".ddf") THEN
    REM nothing
ELSE
    ERROR 424
    LET anifile$ = ""
    LET anisprite$ = ""
    RETURN
END IF
REM loads metadata file
OPEN aloc$ + anifile$ + "/" + anifile$ + ".ddf" FOR INPUT AS #22
INPUT #22, aniframes
LET x = 0
DO
    LET x = x + 1
    INPUT #22, frame(x)
LOOP UNTIL EOF(22)
CLOSE #22
REM loads frame sprites
LET x = 0
DO
    LET x = x + 1
    LET aniframe(x) = _LOADIMAGE(aloc$ + anifile$ + "/frame" + LTRIM$(STR$(x)) + ".png")
LOOP UNTIL x >= aniframes
REM prints to console
LET eventtitle$ = "ANIMATION LOADED:"
LET eventdata$ = anifile$
LET eventnumber = aniframes
GOSUB consoleprinter
REM display frames
LET temp98 = 0: LET temp99 = 0: LET x = 0
IF anisprite$ = "mainplayer" THEN
    REM mainplayer sprite animation
    DO
        IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN IF skipallowed = 1 THEN LET scriptskip = 1
        IF temp98 = 0 THEN LET temp98 = 1
        IF temp99 = 0 THEN
            REM sets number of frames the sprite is to be displayed for
            LET temp99 = frames + frame(temp98)
        END IF
        LET effectani = 1
        GOSUB gameloop: REM draws world
        LET effectani = 0
        REM draws animation frames
        _PUTIMAGE (mpposx, mpposy), aniframe(temp98)
        IF parallaxmode = 2 THEN GOSUB parallaxdraw
        GOSUB effectdraw
        _DISPLAY
        REM calculates when to move onto next frame
        IF frames >= temp99 THEN LET temp98 = temp98 + 1: LET temp99 = 0
    LOOP UNTIL temp98 > aniframes OR scriptskip = 1
ELSE
    REM NPC or object sprite animation
    DO
        IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN IF skipallowed = 1 THEN LET scriptskip = 1
        IF temp98 = 0 THEN LET temp98 = 1
        IF temp99 = 0 THEN
            REM sets number of frames the sprite is to be displayed for
            LET temp99 = frames + frame(temp98)
        END IF
        REM finds which NPC is being animated
        LET x = 0: LET aniplayer = 0
        DO
            LET x = x + 1
            IF anisprite$ = playername(x) THEN LET aniplayer = x
        LOOP UNTIL x >= totalplayers
        LET effectani = 1
        GOSUB gameloop: REM draws world
        LET effectani = 0
        REM draws animation frames
        IF playerl(aniplayer) = 1 THEN
            IF aniplayer <> 0 THEN _PUTIMAGE (playerx(aniplayer) + posx, playery(aniplayer) + posy), aniframe(temp98)
            GOSUB mainplayerdraw
        ELSE
            GOSUB mainplayerdraw
            IF aniplayer <> 0 THEN _PUTIMAGE (playerx(aniplayer) + posx, playery(aniplayer) + posy), aniframe(temp98)
        END IF
        REM finds which object is being animated
        LET x = 0: LET aniobject = 0
        DO
            LET x = x + 1
            IF anisprite$ = objectname(x) THEN LET aniobject = x
        LOOP UNTIL x >= totalobjects
        IF objectl(aniobject) = 1 THEN
            IF aniobject <> 0 THEN _PUTIMAGE (objectx(aniobject) + posx, objecty(aniobject) + posy), aniframe(temp98)
            GOSUB mainplayerdraw
        ELSE
            GOSUB mainplayerdraw
            IF aniobject <> 0 THEN _PUTIMAGE (objectx(aniobject) + posx, objecty(aniobject) + posy), aniframe(temp98)
        END IF
        IF parallaxmode = 2 THEN GOSUB parallaxdraw
        GOSUB effectdraw
        _DISPLAY
        REM calculates when to move onto next frame
        IF frames >= temp99 THEN LET temp98 = temp98 + 1: LET temp99 = 0
    LOOP UNTIL temp98 > aniframes OR scriptskip = 1
END IF
REM unloads animation files
LET x = 0
DO
    LET x = x + 1
    _FREEIMAGE aniframe(x)
LOOP UNTIL x >= aniframes
REM prints to console
LET eventtitle$ = "ANIMATION UNLOADED:"
LET eventdata$ = anifile$
LET eventnumber = aniframes
GOSUB consoleprinter
LET anisprite$ = "": LET aniframes = 0: LET temp98 = 0: LET temp99 = 0: LET temp103 = 0: LET x = 0: REM scrub temp values
RETURN

consoleprinter:
REM prints extra engine data to console / error log
IF consolelogging = 1 THEN
    IF _FILEEXISTS(consolelog$) THEN
        REM nothing
    ELSE
        OPEN consolelog$ FOR OUTPUT AS #2
        PRINT #2, DATE$, TIME$, "VaME CONSOLE LOG"
        CLOSE #2
    END IF
    OPEN consolelog$ FOR APPEND AS #2
    IF eventnumber <> 0 THEN PRINT #2, DATE$, TIME$, eventtitle$, eventdata$; eventnumber
    IF eventnumber = 0 THEN PRINT #2, DATE$, TIME$, eventtitle$, eventdata$
    CLOSE #2
END IF
IF displayconsole = 1 THEN
    REM displays in console
    _DEST _CONSOLE
    IF eventnumber <> 0 THEN PRINT DATE$, TIME$, eventtitle$, eventdata$; eventnumber
    IF eventnumber = 0 THEN PRINT DATE$, TIME$, eventtitle$, eventdata$
    _DEST 0
END IF
REM set value for hud display
LET lastconsoleline$ = eventtitle$ + " " + eventdata$ + " " + STR$(eventnumber)
REM flush values
LET eventtitle$ = "": LET eventdata$ = "": LET eventnumber = 0
RETURN

errorhandler:
REM handles expected in-game errors
LET errdescription$ = "": REM blanks out custom error description
IF ERR = 423 THEN
    LET errdescription$ = "MISSING SCRIPT FILE - " + scriptloc$ + mapscriptdir$ + scriptname$ + ".vsf"
    GOSUB errorprinter
    RESUME NEXT
END IF
IF ERR = 258 THEN
    IF missingasset = 0 THEN
        IF asset$ <> "" THEN
            LET errdescription$ = "MISSING ASSET - " + asset$: LET missingasset = 1
        ELSE
            LET errdescription$ = "MISSING ASSET!"
        END IF
    ELSE
        LET errdescription$ = "ERROR ASSET MISSING!"
    END IF
END IF
IF ERR = 424 THEN LET errdescription$ = "MISSING ANIMATION FILE - " + anifile$: GOSUB errorprinter: RESUME NEXT
IF ERR = 425 THEN LET errdescription$ = "MISSING TERMINAL FILE - " + runterminal$: GOSUB errorprinter: RESUME NEXT
IF ERR = 435 THEN LET errdescription$ = "MISSING FULLSCREEN IMAGE - " + temp13$: GOSUB errorprinter: RESUME NEXT
IF ERR = 436 THEN LET errdescription$ = "DIVISION BY ZERO": GOSUB errorprinter: RESUME NEXT
IF ERR < 420 THEN
    GOSUB errorprinter
    RESUME NEXT
END IF
REM halts program upon unexpected error
REM == FROM HERE, PROGRAM WILL HALT AND IS CONSIDERED NON-RECOVERABLE ==
ON ERROR GOTO errorduringerror: REM error handler for the error handler (ikr)
IF ERR = 420 THEN LET errdescription$ = "MISSING ENGINE METADATA - TRY REINSTALL"
IF ERR = 421 THEN LET errdescription$ = "MISSING METADATA DIRECTORY - TRY REINSTALL"
IF ERR = 422 THEN LET errdescription$ = "MISSING DEFAULT SAVE FILE - TRY REINSTALL"
IF ERR = 426 THEN LET errdescription$ = "CONFLICTING LAUNCH PARAMETERS - CANNOT USE -FIX AND -NOUPDATE AT THE SAME TIME"
IF ERR = 427 THEN
    IF modrunning = 0 THEN LET errdescription$ = "GAME REQUIRES VaME VERSION " + engineversionno$ + " - THIS VERSION IS " + hardbuild$
    IF modrunning = 1 THEN LET errdescription$ = "MOD REQUIRES VaME VERSION " + engineversionno$ + " - THIS VERSION IS " + hardbuild$
END IF
IF ERR = 428 THEN LET errdescription$ = "REQUIRED INPUT CODE NOT DEFINED - TRY REINSTALL"
IF ERR = 429 THEN LET errdescription$ = "REQUIRED FONT FILE MISSING - TRY REINSTALL"
IF ERR = 430 THEN LET errdescription$ = "UNKNOWN / UNSUPPORTED OPERATING SYSTEM"
IF ERR = 431 THEN LET errdescription$ = "TOO MANY MOD PARAMETERS - LOAD ONLY ONE MOD AT ONCE"
IF ERR = 432 THEN
    IF modname$ <> "data" THEN LET errdescription$ = "REQUESTED MOD NOT FOUND - CHECK MOD FILES EXIST IN CORRECT LOCATION"
    IF modname$ = "data" THEN LET errdescription$ = "REQUESTED MOD NOT FOUND - CANNOT NAME MOD 'DATA'"
END IF
IF ERR = 433 THEN LET errdescription$ = "CONFLICTING LAUNCH PARAMETERS - CANNOT USE -WINDOWED AND -FULLSCREEN AT THE SAME TIME"
IF ERR = 434 THEN LET errdescription$ = "MISSING DEFAULT OPTIONS FILE - TRY REINSTALL"
IF ERR = 666 THEN LET errdescription$ = "DEMONIC ERROR - CONTACT LOCAL UAC REP"
LET errorcrash = 1: REM sets error crash value to 1
BEEP
PRINT "=== GURU MEDITATION ==="
PRINT DATE$, TIME$
PRINT "ERROR CODE: "; ERR
PRINT "LINE: "; _ERRORLINE
PRINT errdescription$
PRINT "DUMPING ERROR FILE..."
IF ERR = 420 OR ERR = 421 THEN
    PRINT "...ERROR INFO CAN NOT BE DUMPED TO FILE!"
ELSE
    GOSUB errorprinter
    PRINT "...DONE!"
    GOSUB consolequit
END IF
PRINT
IF title$ <> "" THEN
    PRINT title$; " will now close! :("
ELSE
    PRINT "VaME will now close! :("
END IF
END

errorduringerror:
REM if error handler encounters an error
BEEP
PRINT "=== SUPER GURU ==="
PRINT "ERROR MANAGER HAS CRASHED! (ikr?)"
PRINT DATE$, TIME$
PRINT "ERROR CODE: "; ERR
PRINT "LINE: "; _ERRORLINE
PRINT errdescription$: PRINT _ERRORMESSAGE$
PRINT "ERROR INFO WILL NOT BE DUMPED TO FILE!"
PRINT
IF title$ <> "" THEN
    PRINT title$; " will now close! :("
ELSE
    PRINT "VaME will now close! :("
END IF
END

whitefadein:
REM white fade in utility
IF fadestatus = 0 THEN _AUTODISPLAY: RETURN: REM return if fade already on
IF disablefade = 1 THEN _AUTODISPLAY: RETURN: REM return for if disablefade is on.
LET fadestatus = 0
LET temp206 = (fadespeed - fadespeed) - fadespeed
LET fading = 1
FOR i% = 255 TO 0 STEP temp206
    _LIMIT hertz: REM sets framerate
    GOSUB screendraw: REM draws screen
    LINE (0, 0)-(resx, resy), _RGBA(255, 255, 255, i%), BF
    _DISPLAY
NEXT
_AUTODISPLAY
LET fading = 0
REM print to console
LET eventtitle$ = "DISPLAY EFFECT:"
LET eventdata$ = "white fade in"
LET eventnumber = 0
GOSUB consoleprinter
RETURN


fadein:
REM fade in utility
IF fadestatus = 0 THEN _AUTODISPLAY: RETURN: REM return if fade already on
IF disablefade = 1 THEN _AUTODISPLAY: RETURN: REM return for if disablefade is on.
LET fadestatus = 0
LET temp206 = (fadespeed - fadespeed) - fadespeed
LET fading = 1
FOR i% = 255 TO 0 STEP temp206
    _LIMIT hertz: REM sets framerate
    GOSUB screendraw: REM draws screen
    LINE (0, 0)-(resx, resy), _RGBA(0, 0, 0, i%), BF
    _DISPLAY
NEXT
_AUTODISPLAY
LET fading = 0
REM print to console
LET eventtitle$ = "DISPLAY EFFECT:"
LET eventdata$ = "fade in"
LET eventnumber = 0
GOSUB consoleprinter
RETURN

slowfadein:
REM slow fade in utility
IF fadestatus = 0 THEN _AUTODISPLAY: RETURN: REM return if fade already off
IF disablefade = 1 THEN _AUTODISPLAY: RETURN: REM return for if disablefade is on.
LET fadestatus = 0
LET temp206 = (fadespeed - fadespeed) - fadespeed
LET fading = 1
FOR i% = 255 TO 0 STEP temp206
    _LIMIT hertz: REM sets framerate
    GOSUB screendraw: REM draws screen
    LINE (0, 0)-(resx, resy), _RGBA(0, 0, 0, i%), BF
    _DISPLAY
    _DELAY 0.5
NEXT
_AUTODISPLAY
LET fading = 0
REM print to console
LET eventtitle$ = "DISPLAY EFFECT:"
LET eventdata$ = "slow fade in"
LET eventnumber = 0
GOSUB consoleprinter
RETURN

slightfadein:
REM slight fade in utility
IF fadestatus = 0 THEN _AUTODISPLAY: RETURN: REM return if fade already off
IF disablefade = 1 THEN _AUTODISPLAY: RETURN: REM return for if disablefade is on.
LET fadestatus = 0
LET fading = 1
LET temp206 = (fadespeed - fadespeed) - fadespeed
FOR i% = (255 / 2) TO 0 STEP temp206
    _LIMIT hertz: REM sets framerate
    GOSUB screendraw: REM draws screen
    LINE (0, 0)-(resx, resy), _RGBA(0, 0, 0, i%), BF
    _DISPLAY
NEXT
_AUTODISPLAY
LET fading = 0
REM print to console
LET eventtitle$ = "DISPLAY EFFECT:"
LET eventdata$ = "undim screen"
LET eventnumber = 0
GOSUB consoleprinter
RETURN

whitefadeout:
REM fade out utility
IF fadestatus = 1 OR fadestatus = 2 THEN _AUTODISPLAY: RETURN: REM return if fade already off
IF disablefade = 1 THEN _AUTODISPLAY: RETURN: REM return for if disablefade is on.
LET temp206 = fadespeed
LET fading = 1
FOR i% = 0 TO 255 STEP fadespeed
    _LIMIT hertz: REM sets framerate
    GOSUB screendraw: REM draws screen
    LINE (0, 0)-(resx, resy), _RGBA(255, 255, 255, i%), BF
    _DISPLAY
NEXT
_AUTODISPLAY
LET fading = 0
LINE (0, 0)-(resx, resy), _RGBA(255, 255, 255, 255), BF
REM print to console
LET eventtitle$ = "DISPLAY EFFECT:"
LET eventdata$ = "white fade out"
LET eventnumber = 0
GOSUB consoleprinter
LET fadestatus = 1
RETURN

fadeout:
REM fade out utility
IF fadestatus = 1 OR fadestatus = 2 THEN _AUTODISPLAY: RETURN: REM return if fade already off
IF disablefade = 1 THEN _AUTODISPLAY: RETURN: REM return for if disablefade is on.
LET temp206 = fadespeed
LET fading = 1
FOR i% = 0 TO 255 STEP fadespeed
    _LIMIT hertz: REM sets framerate
    GOSUB screendraw: REM draws screen
    LINE (0, 0)-(resx, resy), _RGBA(0, 0, 0, i%), BF
    _DISPLAY
NEXT
_AUTODISPLAY
LET fading = 0
LINE (0, 0)-(resx, resy), _RGBA(0, 0, 0, 255), BF
REM print to console
LET eventtitle$ = "DISPLAY EFFECT:"
LET eventdata$ = "fade out"
LET eventnumber = 0
GOSUB consoleprinter
LET fadestatus = 1
RETURN

slowfadeout:
REM slow fade out utility
IF fadestatus = 1 OR fadestatus = 2 THEN _AUTODISPLAY: RETURN: REM return if fade already off
IF disablefade = 1 THEN _AUTODISPLAY: RETURN: REM return for if disablefade is on.
LET temp206 = fadespeed
LET fading = 1
FOR i% = 0 TO 255 STEP temp206
    _LIMIT hertz: REM sets framerate
    GOSUB screendraw: REM draws screen
    LINE (0, 0)-(resx, resy), _RGBA(0, 0, 0, i%), BF: REM slowly empties black box from screen
    _DISPLAY
    _DELAY 0.5
NEXT
_AUTODISPLAY
LET fadidng = 0
LINE (0, 0)-(resx, resy), _RGBA(0, 0, 0, 255), BF
REM print to console
LET eventtitle$ = "DISPLAY EFFECT:"
LET eventdata$ = "slow fade out"
LET eventnumber = 0
GOSUB consoleprinter
LET fadestatus = 1
RETURN

slightfadeout:
REM slight fade out utility
IF fadestatus = 1 OR fadestatus = 2 THEN _AUTODISPLAY: RETURN: REM return if fade already off
IF disablefade = 1 THEN _AUTODISPLAY: RETURN: REM return for if disablefade is on.
LET temp206 = fadespeed
FOR i% = 0 TO (255 / 2) STEP temp206
    _LIMIT hertz: REM sets framerate
    GOSUB screendraw: REM draws screen
    LINE (0, 0)-(resx, resy), _RGBA(0, 0, 0, i%), BF: REM slowly empties black box from screen
    _DISPLAY
NEXT
_AUTODISPLAY
REM print to console
LET eventtitle$ = "DISPLAY EFFECT:"
LET eventdata$ = "dim screen"
LET eventnumber = 0
GOSUB consoleprinter
LET fadestatus = 2
RETURN

fontunload:
REM unloads engine fonts if used
_FONT 8: REM sets font to QB64 default
REM unloads any loaded fonts
_FREEFONT gamefont&
REM prints to console
LET eventtitle$ = "FONT UNLOADED:"
LET eventdata$ = fontname$
LET eventnumber = fontsize
GOSUB consoleprinter
LET temp23 = 0: REM scrub temp values
RETURN

fontload:
REM loads engine fonts
IF setupboot = 0 THEN GOSUB fontunload: REM unloads font
REM sets up more temp files
LET temp7$ = fontname$: LET temp9 = fontsize: LET temp8$ = fontstyle$
IF temp7$ <> "" THEN
    REM if font chosen
    IF temp8$ <> "" THEN
        LET gamefont& = _LOADFONT(floc$ + temp7$, temp9, temp8$)
    ELSE
        LET gamefont& = _LOADFONT(floc$ + temp7$, temp9)
    END IF
    LET eventtitle$ = "FONT LOADED:"
    LET eventdata$ = temp7$ + temp8$
    LET eventnumber = temp9
    GOSUB consoleprinter
    _FONT gamefont&
ELSE
    REM font not chosen
    ERROR 429
END IF
IF setupboot = 1 THEN
    REM loading bar
    LET temp125 = temp125 + loadbarsize
    GOSUB loadbar
END IF
LET temp9 = 0: LET temp7$ = "": LET temp8$ = "": REM scrub temp values
RETURN

mainplayerunload:
REM unloads main player sprites from memory
_FREEIMAGE mpf: _FREEIMAGE mpb: _FREEIMAGE mpl: _FREEIMAGE mpr
_FREEIMAGE mpfl: _FREEIMAGE mpfr
_FREEIMAGE mpbl: _FREEIMAGE mpbr
_FREEIMAGE mpll: _FREEIMAGE mplr
_FREEIMAGE mprl: _FREEIMAGE mprr
_FREEIMAGE mpface1: _FREEIMAGE mpface2
_FREEIMAGE mpfi1: _FREEIMAGE mpfi2
_FREEIMAGE mpbi1: _FREEIMAGE mpbi2
_FREEIMAGE mpli1: _FREEIMAGE mpli2
_FREEIMAGE mpri1: _FREEIMAGE mpri2
REM informs console printer
LET eventtitle$ = "MAIN PLAYER UNLOADED:"
IF userquit = 1 THEN
    LET eventdata$ = mplayermodel$
ELSE
    LET eventdata$ = oldmplayermodel$
END IF
LET eventnumber = 0
GOSUB consoleprinter
RETURN

mapunload:
REM unloads map sprites from memory
_FREEIMAGE mapa: _FREEIMAGE mapb
IF parallaxmode > 0 THEN _FREEIMAGE mapp1: _FREEIMAGE mapp2
REM wipes vames if needed
IF mapobjectno > 0 THEN
    LET temp110 = 0
    DO
        LET temp110 = temp110 + 1
        LET objectname$(temp110) = ""
        LET objectlongname$(temp110) = ""
    LOOP UNTIL temp110 >= mapobjectno
END IF
IF mapplayerno > 0 THEN
    LET temp110 = 0
    DO
        LET temp110 = temp110 + 1
        LET playername$(temp110) = ""
        LET playerlongname$(temp110) = ""
    LOOP UNTIL temp110 >= mapplayerno
END IF
LET selectobject$ = ""
LET selectobjectlong$ = ""
REM informs console printer
LET eventtitle$ = "MAP UNLOADED:"
IF userquit = 1 THEN
    LET eventdata$ = mapname$
    LET eventnumber = mapno
ELSE
    LET eventdata$ = oldmapname$
    LET eventnumber = oldmapno
END IF
GOSUB consoleprinter
RETURN

collision:
REM collision sub manager
IF noclip = 1 THEN RETURN: REM return if no clip is on
LET selectobject$ = "": LET selectobjectlong$ = "": LET objecttype$ = "NON": REM clears current selected object
GOSUB mapcollision: REM map sprite boundaries
GOSUB objectcollision: REM object sprite boundaries and selection
GOSUB playercollision: REM NPC collision
GOSUB triggercollision: REM invisible trigger collision
RETURN

errorprinter:
REM dumps error information to file
IF consolelogging = 1 THEN
    OPEN consolelog$ FOR APPEND AS #2
    IF errdescription$ = "" THEN
        PRINT #2, DATE$, TIME$, "ERROR: "; ERR, "LINE: "; _ERRORLINE, _ERRORMESSAGE$
    ELSE
        PRINT #2, DATE$, TIME$, "ERROR: "; ERR, "LINE: "; _ERRORLINE, errdescription$
    END IF
    CLOSE #2
END IF
REM PRINTS TO CONSOLE
IF displayconsole = 1 THEN
    _DEST _CONSOLE
    IF errdescription$ = "" THEN
        PRINT DATE$, TIME$, "ERROR: "; ERR, "LINE: "; _ERRORLINE, _ERRORMESSAGE$
    ELSE
        PRINT DATE$, TIME$, "ERROR: "; ERR, "LINE: "; _ERRORLINE, errdescription$
    END IF
    _DEST 0
END IF
REM sets hud display value
IF errdescription$ = "" THEN
    LET lastconsoleline$ = "ERROR: " + STR$(ERR) + " LINE: " + STR$(_ERRORLINE) + " " + _ERRORMESSAGE$
ELSE
    LET lastconsoleline$ = "ERROR: " + STR$(ERR) + " LINE: " + STR$(_ERRORLINE) + " " + errdescription$
END IF
RETURN

playercollision:
REM handles NPC collision
IF mapplayerno = 0 THEN RETURN: REM return if no players attached to map
DO
    LET temp44 = temp44 + 1
    REM checks if player is on screen
    LET colpass1 = 0: LET colpass2 = 0
    IF playerx(temp44) + playerresx(temp44) > ((resx / 2) - posx) - (resx / 2) AND playerx(temp44) < ((resx / 2) - posx) + (resx / 2) THEN LET colpass1 = 1
    IF playery(temp44) + playerresy(temp44) > ((resy / 2) - posy) - (resy / 2) AND playery(temp44) < ((resy / 2) - posy) + (resy / 2) THEN LET colpass2 = 1
    IF colpass1 = 1 AND colpass2 = 1 THEN
        REM collision checks
        IF (resx / 2) + ((mpx / 2) - objectstep) >= playerx(temp44) + posx AND (resx / 2) - ((mpx / 2) - (objectstep * 2)) <= (playerx(temp44) + playerresx(temp44)) + posx THEN LET temp45 = temp45 + 1
        IF (resy / 2) - ((mpy / 2) - players(temp44)) >= playery(temp44) + posy AND (resy / 2) + (mpy / 2) <= (playery(temp44) + playerresy(temp44)) + posy THEN LET temp45 = temp45 + 1
        REM selectobject checks
        IF direction = 1 THEN
            REM UP
            IF (resx / 2) + ((mpx / 2) - objectstep) >= playerx(temp44) + posx AND (resx / 2) - ((mpx / 2) - (objectstep * 2)) <= (playerx(temp44) + playerresx(temp44)) + posx THEN LET temp166 = temp166 + 1
            IF (resy / 2) - ((mpy / 2) - players(temp44)) - pace >= playery(temp44) + posy AND (resy / 2) + (mpy / 2) - pace <= (playery(temp44) + playerresy(temp44)) + posy THEN LET temp166 = temp166 + 1
        END IF
        IF direction = 2 THEN
            REM DOWN
            IF (resx / 2) + ((mpx / 2) - objectstep) >= playerx(temp44) + posx AND (resx / 2) - ((mpx / 2) - (objectstep * 2)) <= (playerx(temp44) + playerresx(temp44)) + posx THEN LET temp166 = temp166 + 1
            IF (resy / 2) - ((mpy / 2) - players(temp44)) + pace >= playery(temp44) + posy AND (resy / 2) + (mpy / 2) + pace <= (playery(temp44) + playerresy(temp44)) + posy THEN LET temp166 = temp166 + 1
        END IF
        IF direction = 3 THEN
            REM RIGHT
            IF (resx / 2) + ((mpx / 2) - objectstep) + pace >= playerx(temp44) + posx AND (resx / 2) - ((mpx / 2) - (objectstep * 2)) + pace <= (playerx(temp44) + playerresx(temp44)) + posx THEN LET temp166 = temp166 + 1
            IF (resy / 2) - ((mpy / 2) - players(temp44)) >= playery(temp44) + posy AND (resy / 2) + (mpy / 2) <= (playery(temp44) + playerresy(temp44)) + posy THEN LET temp166 = temp166 + 1
        END IF
        IF direction = 4 THEN
            REM LEFT
            IF (resx / 2) + ((mpx / 2) - objectstep) - pace >= playerx(temp44) + posx AND (resx / 2) - ((mpx / 2) - (objectstep * 2)) - pace <= (playerx(temp44) + playerresx(temp44)) + posx THEN LET temp166 = temp166 + 1
            IF (resy / 2) - ((mpy / 2) - players(temp44)) >= playery(temp44) + posy AND (resy / 2) + (mpy / 2) <= (playery(temp44) + playerresy(temp44)) + posy THEN LET temp166 = temp166 + 1
        END IF
        LET proposedobject$ = playername(temp44)
        IF playercollision(temp44) = 1 THEN
            GOSUB playercollisionchanger: REM changes player collision if player collision is on
        ELSE
            LET temp45 = 0: LET temp168 = 0: LET temp166 = 0: REM scrubs temp values
        END IF
    END IF
LOOP UNTIL temp44 >= mapplayerno OR temp44 >= totalplayers
LET temp44 = 0: REM scrub temp values
RETURN

playercollisionchanger:
REM changes position values if player is colliding with NPC
IF temp45 = 2 THEN
    REM tells collsion printer
    IF direction = 1 THEN LET temp4$ = STR$(posy): LET temp5$ = STR$(posy - pace): LET temp6$ = "Y"
    IF direction = 2 THEN LET temp4$ = STR$(posy): LET temp5$ = STR$(posy + pace): LET temp6$ = "Y"
    IF direction = 3 THEN LET temp4$ = STR$(posx): LET temp5$ = STR$(posx + pace): LET temp6$ = "X"
    IF direction = 4 THEN LET temp4$ = STR$(posx): LET temp5$ = STR$(posx - pace): LET temp6$ = "X"
    LET temp168 = temp44
    IF direction = 1 THEN IF (posy - pace) <> temp47 THEN GOSUB collisionprinter
    IF direction = 2 THEN IF (posy + pace) <> temp47 THEN GOSUB collisionprinter
    IF direction = 3 THEN IF (posx + pace) <> temp46 THEN GOSUB collisionprinter
    IF direction = 4 THEN IF (posx - pace) <> temp46 THEN GOSUB collisionprinter
    REM changes position
    IF direction = 1 THEN LET posy = posy - pace
    IF direction = 2 THEN LET posy = posy + pace
    IF direction = 3 THEN LET posx = posx + pace
    IF direction = 4 THEN LET posx = posx - pace
    REM scrubs temp values / assigns temp values
    LET temp4$ = "": LET temp5$ = "": LET temp46 = posx: LET temp47 = posy
END IF
IF temp166 = 2 THEN
    REM tells engine what object has been collided
    LET playerhighlight(temp44) = 1
    LET selectobject$ = proposedobject$
    LET selectobjectlong$ = playerlongname$(temp44)
    LET objecttype$ = "NPC"
ELSE
    LET playerhighlight(temp44) = 0
END IF
LET temp45 = 0: LET temp168 = 0: LET temp166 = 0: REM scrubs temp values
RETURN

triggercollision:
REM handles trigger collision and selection
IF scriptrun = 1 AND allowscriptcontrol = 1 THEN RETURN: REM return for if a contrallable script is running
IF maptriggerno = 0 THEN RETURN: REM return if map has no triggers attached
DO
    LET temp24 = temp24 + 1
    IF (resx / 2) - ((mpx / 2) - objectstep) >= triggerx1(temp24) + posx AND (resx / 2) + ((mpx / 2) - (objectstep * 2)) <= triggerx2(temp24) + posx THEN LET temp25 = temp25 + 1
    IF (resy / 2) + (mpy / 2) >= triggery1(temp24) + posy AND (resy / 2) + (mpy / 2) <= triggery2(temp24) + posy THEN LET temp25 = temp25 + 1
    IF triggerd(temp24) = 1 THEN
        REM trigger is on!
        GOSUB triggercollisionchanger
    ELSE
        REM trigger is off! scrub values!
        LET temp25 = 0
    END IF
LOOP UNTIL temp24 >= maptriggerno OR temp24 >= totaltriggers
LET temp24 = 0: LET temp25 = 0: REM scrub temp values
RETURN

triggercollisionchanger:
REM sets trigger activated values if trigger has been collided
IF temp25 = 2 THEN
    LET triggera(temp24) = 1: LET eventdata$ = triggername(temp24)
    LET eventtitle$ = "TRIGGER ACVTIVE:"
    LET eventnumber = 0
    GOSUB consoleprinter
END IF
LET temp25 = 0: REM scrub temp values
RETURN

objectcollision:
REM handles object collision and selection
IF mapobjectno = 0 THEN RETURN: REM return if map has no objects attached
DO
    LET temp18 = temp18 + 1
    REM checks if object is on screen
    LET colpass1 = 0: LET colpass2 = 0
    IF objectx(temp18) + objectresx(temp18) > ((resx / 2) - posx) - (resx / 2) AND objectx(temp18) < ((resx / 2) - posx) + (resx / 2) THEN LET colpass1 = 1
    IF objecty(temp18) + objectresy(temp18) > ((resy / 2) - posy) - (resy / 2) AND objecty(temp18) < ((resy / 2) - posy) + (resy / 2) THEN LET colpass2 = 1
    IF colpass1 = 1 AND colpass2 = 1 THEN
        REM collision checks
        IF (resx / 2) + ((mpx / 2) - objectstep) >= objectx(temp18) + posx AND (resx / 2) - ((mpx / 2) - (objectstep * 2)) <= (objectx(temp18) + objectresx(temp18)) + posx THEN LET temp17 = temp17 + 1
        IF (resy / 2) - ((mpy / 2) - objects(temp18)) >= objecty(temp18) + posy AND (resy / 2) + (mpy / 2) <= (objecty(temp18) + objectresy(temp18)) + posy THEN LET temp17 = temp17 + 1
        REM selectobject check
        IF direction = 1 THEN
            IF (resx / 2) + ((mpx / 2) - objectstep) >= objectx(temp18) + posx AND (resx / 2) - ((mpx / 2) - (objectstep * 2)) <= (objectx(temp18) + objectresx(temp18)) + posx THEN LET temp167 = temp167 + 1
            IF (resy / 2) - ((mpy / 2) - objects(temp18)) - pace >= objecty(temp18) + posy AND (resy / 2) + (mpy / 2) - pace <= (objecty(temp18) + objectresy(temp18)) + posy THEN LET temp167 = temp167 + 1
        END IF
        IF direction = 2 THEN
            IF (resx / 2) + ((mpx / 2) - objectstep) >= objectx(temp18) + posx AND (resx / 2) - ((mpx / 2) - (objectstep * 2)) <= (objectx(temp18) + objectresx(temp18)) + posx THEN LET temp167 = temp167 + 1
            IF (resy / 2) - ((mpy / 2) - objects(temp18)) + pace >= objecty(temp18) + posy AND (resy / 2) + (mpy / 2) + pace <= (objecty(temp18) + objectresy(temp18)) + posy THEN LET temp167 = temp167 + 1
        END IF
        IF direction = 3 THEN
            IF (resx / 2) + ((mpx / 2) - objectstep) + pace >= objectx(temp18) + posx AND (resx / 2) - ((mpx / 2) - (objectstep * 2)) + pace <= (objectx(temp18) + objectresx(temp18)) + posx THEN LET temp167 = temp167 + 1
            IF (resy / 2) - ((mpy / 2) - objects(temp18)) >= objecty(temp18) + posy AND (resy / 2) + (mpy / 2) <= (objecty(temp18) + objectresy(temp18)) + posy THEN LET temp167 = temp167 + 1
        END IF
        IF direction = 4 THEN
            IF (resx / 2) + ((mpx / 2) - objectstep) - pace >= objectx(temp18) + posx AND (resx / 2) - ((mpx / 2) - (objectstep * 2)) - pace <= (objectx(temp18) + objectresx(temp18)) + posx THEN LET temp167 = temp167 + 1
            IF (resy / 2) - ((mpy / 2) - objects(temp18)) >= objecty(temp18) + posy AND (resy / 2) + (mpy / 2) <= (objecty(temp18) + objectresy(temp18)) + posy THEN LET temp167 = temp167 + 1
        END IF
        LET proposedobject$ = objectname(temp18)
        IF proposedobject$ = "[COLLISIONONLY]" THEN LET objectcollision(temp18) = 1
        IF objectcollision(temp18) = 1 THEN
            GOSUB objectcollisionchanger: REM changes collision if object collision is on
        ELSE
            LET temp17 = 0: LET temp168 = 0: LET temp167 = 0: REM scrubs temp values
        END IF
    END IF
LOOP UNTIL temp18 >= mapobjectno OR temp18 >= totalobjects
LET temp18 = 0: REM scrub temp values
RETURN

objectcollisionchanger:
REM changes position values if player is colliding with object
IF temp17 = 2 THEN
    REM tells collsion printer
    IF direction = 1 THEN LET temp4$ = STR$(posy): LET temp5$ = STR$(posy - pace): LET temp6$ = "Y"
    IF direction = 2 THEN LET temp4$ = STR$(posy): LET temp5$ = STR$(posy + pace): LET temp6$ = "Y"
    IF direction = 3 THEN LET temp4$ = STR$(posx): LET temp5$ = STR$(posx + pace): LET temp6$ = "X"
    IF direction = 4 THEN LET temp4$ = STR$(posx): LET temp5$ = STR$(posx - pace): LET temp6$ = "X"
    LET temp168 = temp18
    IF direction = 1 THEN IF (posy - pace) <> temp20 THEN GOSUB collisionprinter
    IF direction = 2 THEN IF (posy + pace) <> temp20 THEN GOSUB collisionprinter
    IF direction = 3 THEN IF (posx + pace) <> temp19 THEN GOSUB collisionprinter
    IF direction = 4 THEN IF (posx - pace) <> temp19 THEN GOSUB collisionprinter
    REM changes position
    IF direction = 1 THEN LET posy = posy - pace
    IF direction = 2 THEN LET posy = posy + pace
    IF direction = 3 THEN LET posx = posx + pace
    IF direction = 4 THEN LET posx = posx - pace
    REM scrubs temp values / assigns temp values
    LET temp4$ = "": LET temp5$ = "": LET temp19 = posx: LET temp20 = posy
END IF
IF temp167 = 2 THEN
    REM tells engine what object has been collided
    LET objecthighlight(temp18) = 1
    LET selectobject$ = proposedobject$
    LET selectobjectlong$ = objectlongname$(temp18)
    IF selectobject$ <> "[COLLISIONONLY]" THEN LET objecttype$ = "OBJ"
ELSE
    LET objecthighlight(temp18) = 0
END IF
LET temp17 = 0: LET temp168 = 0: LET temp167 = 0: REM scrubs temp values
RETURN

mapcollision:
REM map sprite boundaries
REM top corner
REM X
IF posx >= (resx / 2) - (mpx / 2) THEN
    LET temp4$ = STR$(posx)
    LET posx = (resx / 2) - (mpx / 2)
    LET temp5$ = STR$(posx)
    LET temp6$ = "X"
    IF temp21 <> posx THEN GOSUB collisionprinter
    LET temp21 = posx
END IF
REM Y
IF posy >= (resy / 2) - (mpy / 2) THEN
    LET temp4$ = STR$(posy)
    LET posy = (resy / 2) - (mpy / 2)
    LET temp5$ = STR$(posy)
    LET temp6$ = "Y"
    IF temp22 <> posy THEN GOSUB collisionprinter
    LET temp22 = posy
END IF
REM bottom corner
REM X
IF posx <= ((resx / 2) + (mpx / 2)) - mapx + 1 THEN
    LET temp4$ = STR$(posx)
    LET posx = ((resx / 2) + (mpx / 2)) - mapx + 1
    LET temp5$ = STR$(posx)
    LET temp6$ = "X"
    IF temp21 <> posx THEN GOSUB collisionprinter
    LET temp21 = posx
END IF
REM Y
IF posy <= ((resy / 2) + (mpy / 2)) - mapy + 1 THEN
    LET temp4$ = STR$(posy)
    LET posy = ((resy / 2) + (mpy / 2)) - mapy + 1
    LET temp5$ = STR$(posy)
    LET temp6$ = "Y"
    IF temp22 <> posy THEN GOSUB collisionprinter
    LET temp22 = posy
END IF
REM scrub temp values
LET temp4$ = "": LET temp5$ = "": LET temp6$ = ""
RETURN

collisionprinter:
REM console printer for object collision
REM return for if same collision has been printed
REM prints collision conflict to printer
LET eventtitle$ = "COLLISION CONFLICT:"
LET eventdata$ = temp6$ + temp4$ + " TO " + temp6$ + temp5$
LET eventnumber = temp168
GOSUB consoleprinter
REM temp values used scrubbed in mapcollision / objectcollisionchanger
RETURN

updatechecker:
REM automatically checks for updates
IF ros$ = "mac" THEN RETURN: REM updating is not quite ready for macos yet. coming soon!
IF exitsave = 1 AND setupboot = 0 THEN GOSUB savesave: REM saves game if needed
CLS
REM checks to see if engine is in developer mode
LET finddev% = INSTR(finddev% + 1, versionno$, "DEV")
LET find3rdparty% = INSTR(find3rdparty% + 1, versionno$, "3RDPARTY")
IF finddev% THEN
    REM disables update for developer build
    LET finddev% = 0
    IF fixvame = 1 THEN
        LET eventtitle$ = "ENGINE REPAIR:"
        IF mainmenu = 1 THEN LET scriptname$ = "enginerepairblocked": LET mapscript = 5
    ELSE
        LET eventtitle$ = "UPDATE CHECK:"
        IF mainmenu = 1 THEN LET scriptname$ = "updateblocked": LET mapscript = 5
    END IF
    LET eventdata$ = "Blocked due to developer build!"
    LET eventnumber = 0
    GOSUB consoleprinter
    IF mainmenu = 1 THEN GOSUB script
    RETURN
END IF
IF find3rdparty% THEN
    REM disables update for versions on 3rd party stores such as steam
    LET find3rdparty% = 0
    LET eventtitle$ = "UPDATE CHECK:"
    LET eventdata$ = "Blocked due to 3rd party store build!"
    LET eventnumber = 0
    GOSUB consoleprinter
    RETURN
END IF
IF modrunning = 1 THEN
    REM disables update for when running mods
    IF fixvame = 1 THEN
        LET eventtitle$ = "ENGINE REPAIR:"
        IF mainmenu = 1 THEN LET scriptname$ = "repairmodblock": LET mapscript = 5
    ELSE
        LET eventtitle$ = "UPDATE CHECK:"
        IF mainmenu = 1 THEN LET scriptname$ = "updatemodblock": LET mapscript = 5
    END IF
    LET eventdata$ = "blocked due to mod running!"
    LET eventnumber = 0
    GOSUB consoleprinter
    GOSUB script
    RETURN
END IF
REM checks for available updates
_PUTIMAGE (1, 1)-(downloadiconresx, downloadiconresy), downloadicon
IF fixvame = 1 THEN
    LET eventtitle$ = "ENGINE REPAIR:"
ELSE
    LET eventtitle$ = "UPDATE CHECK:"
END IF
LET eventdata$ = "Initialised!"
LET eventnumber = 0
GOSUB consoleprinter
REM downloads update info file
IF ros$ = "lnx" OR ros$ = "mac" THEN
    SHELL _HIDE "curl -o checkupdate.ddf " + updatelink$
    IF _FILEEXISTS("checkupdate.ddf") THEN
        REM nothing
    ELSE
        SHELL _HIDE "wget -q -O checkupdate.ddf " + updatelink$
    END IF
END IF
IF ros$ = "win" THEN
    SHELL _HIDE "copy data\utility\windownloader.bat windownloader.bat"
    SHELL _HIDE "windownloader.bat " + updatelink$ + " checkupdate.ddf"
END IF
REM checks update file
IF _FILEEXISTS("checkupdate.ddf") THEN
    REM file exists
    OPEN "checkupdate.ddf" FOR INPUT AS #1
    INPUT #1, newversionno$, updaterlinklnx$, updaterlinkwin$, downloadlink$, windownload$, lnxdownload$, unziplink$, updatetype, updatefolder$, updatewinexe$, updatelinuxexe$, updatereadme$, updatechangelog$, updatemanual$, updatesource$, updateupdatersource$, updateupdaterzip2$, updateupdaterzip$
    CLOSE #1
    IF fixvame = 1 THEN LET newversionno$ = "FIX VAME"
    IF newversionno$ <> versionno$ THEN
        REM new version available
        IF fixvame = 1 THEN
            LET scriptname$ = "repairfound": LET mapscript = 5
        ELSE
            LET scriptname$ = "updatefound": LET mapscript = 5
        END IF
        GOSUB script
        CLS
        IF fixvame = 1 THEN
            LET eventtitle$ = "ENGINE REPAIR:"
            LET eventdata$ = "solution found!"
            LET eventnumber = 0
        ELSE
            LET eventtitle$ = "UPDATE CHECK:"
            LET eventdata$ = "Update to " + newversionno$ + " available!"
            LET eventnumber = 0
        END IF
        GOSUB consoleprinter
        IF soundmode = 2 OR soundmode = 3 THEN GOSUB musicstop: REM stops music if needed
        'LET soundmode = 1
        IF fixvame = 1 THEN
            LET eventtitle$ = "ENGINE REPAIR:"
            LET eventdata$ = "Downloading repair file!"
            LET eventnumber = 0
        ELSE
            LET eventtitle$ = "UPDATE CHECK:"
            LET eventdata$ = "Downloading " + newversionno$ + " updater!"
            LET eventnumber = 0
        END IF
        GOSUB consoleprinter
        REM download updater
        _PUTIMAGE (1, 1)-(downloadiconresx, downloadiconresy), downloadicon
        IF ros$ = "mac" THEN
			LET temp29$ = updateupdaterzip$ + "_macos"
			SHELL _HIDE "curl -o " + temp29$ + " " + updaterlinkmac$
            IF _FILEEXISTS(temp29$) THEN
                REM nothing
            ELSE
                SHELL _HIDE "wget -q -O " + temp29$ + " " + updaterlinkmac$
            END IF
        END IF
        IF ros$ = "lnx" THEN
            LET temp29$ = updateupdaterzip$ + "_linux"
            SHELL _HIDE "curl -o " + temp29$ + " " + updaterlinklnx$
            IF _FILEEXISTS(temp29$) THEN
                REM nothing
            ELSE
                SHELL _HIDE "wget -q -O " + temp29$ + " " + updaterlinklnx$
            END IF
        END IF
        IF ros$ = "win" THEN
            LET temp29$ = updateupdaterzip$ + "_win.exe"
            SHELL _HIDE "windownloader.bat " + updaterlinkwin$ + " " + temp29$
        END IF
        CLS
        IF _FILEEXISTS(temp29$) THEN
            REM close engine... mark system as being updated
            LET runupdate = 1
            REM writes updater file
            OPEN "updatevals.ddf" FOR OUTPUT AS #1
            WRITE #1, versionno$, engineversionno$, installtype, title$, filename$, dloc$, mloc$, ploc$, floc$, sloc$, oloc$, scriptloc$, museloc$, sfxloc$, pocketloc$, uiloc$, tloc$, aloc$, menuloc$, downloadicon$, downloadiconresx, downloadiconresy, autoupdate
            CLOSE #1
            GOSUB endgame
            REM run updater
            IF fixvame = 1 THEN
                LET eventtitle$ = "ENGINE REPAIR:"
                LET eventdata$ = "Launching " + title$ + " repair!"
                LET eventnumber = 0
            ELSE
                LET eventtitle$ = "UPDATE CHECK:"
                LET eventdata$ = "Launching " + newversionno$ + " updater!"
                LET eventnumber = 0
            END IF
            GOSUB consoleprinter
            IF ros$ = "lnx" OR ros$ = "mac" THEN SHELL _HIDE "chmod +x " + temp29$: SHELL _DONTWAIT "./" + temp29$
            IF ros$ = "win" THEN SHELL _DONTWAIT temp29$
            _SCREENHIDE
            SYSTEM
        ELSE
            REM updater download failed!
            IF vamefix = 1 THEN
                LET eventtitle$ = "ENGINE REPAIR FAILED!"
                LET eventdata$ = ""
                LET eventnumber = 0
                IF mainmenu = 1 THEN LET scriptname$ = "repairfailed": LET mapscript = 5
            ELSE
                LET eventtitle$ = "UPDATE CHECK:"
                LET eventdata$ = "Failed to download updater!"
                LET eventnumber = 0
                IF mainmenu = 1 THEN LET scriptname$ = "updatefailed": LET mapscript = 5
            END IF
            GOSUB consoleprinter
            IF mainmenu = 1 THEN GOSUB script
            IF ros$ = "lnx" OR ros$ = "mac" THEN SHELL _HIDE "rm checkupdate.ddf"
            IF ros$ = "win" THEN SHELL _HIDE "del checkupdate.ddf": SHELL _HIDE "del windownloader.bat"
        END IF
    ELSE
        REM up to date
        LET eventtitle$ = "UPDATE CHECK:"
        LET eventdata$ = versionno$ + " is the current version!"
        LET eventnumber = 0
        GOSUB consoleprinter
        IF mainmenu = 1 THEN
            LET scriptname$ = "gameuptodate"
            LET mapscript = 5
            GOSUB script
        END IF
        IF ros$ = "lnx" OR ros$ = "mac" THEN SHELL _HIDE "rm checkupdate.ddf"
        IF ros$ = "win" THEN SHELL _HIDE "del checkupdate.ddf": SHELL _HIDE "del windownloader.bat"
    END IF
ELSE
    REM cannot download update file
    LET eventtitle$ = "UPDATE CHECK:"
    LET eventdata$ = "Cannot connect to update server!"
    LET eventnumber = 0
    GOSUB consoleprinter
    IF mainmenu = 1 THEN
        LET scriptname$ = "updateserverdown"
        LET mapscript = 5
        GOSUB script
    END IF
    IF ros$ = "win" THEN SHELL _HIDE "del windownloader.bat"
END IF
RETURN

mainplayerload:
REM loads player data and sprites
REM unload divert if map has changed and if system is not booting
IF setupboot = 0 THEN IF mplayermodel$ <> oldmplayermodel$ THEN GOSUB mainplayerunload
IF oldmplayermodel$ = mplayermodel$ THEN RETURN: REM divert for if playermodel hasn't actually changed
REM load data and sprites
OPEN ploc$ + mplayermodel$ + "/" + mplayermodel$ + ".ddf" FOR INPUT AS #1
INPUT #1, mainplayerlongname$, mpx, mpy, mps, mpnote1, mpnote2, temp, temp, temp
CLOSE #1
LET mpf = _LOADIMAGE(ploc$ + mplayermodel$ + "/" + mplayermodel$ + "-f.png")
LET mpfl = _LOADIMAGE(ploc$ + mplayermodel$ + "/" + mplayermodel$ + "-fl.png")
LET mpfr = _LOADIMAGE(ploc$ + mplayermodel$ + "/" + mplayermodel$ + "-fr.png")
LET mpb = _LOADIMAGE(ploc$ + mplayermodel$ + "/" + mplayermodel$ + "-b.png")
LET mpbl = _LOADIMAGE(ploc$ + mplayermodel$ + "/" + mplayermodel$ + "-bl.png")
LET mpbr = _LOADIMAGE(ploc$ + mplayermodel$ + "/" + mplayermodel$ + "-br.png")
LET mpr = _LOADIMAGE(ploc$ + mplayermodel$ + "/" + mplayermodel$ + "-r.png")
LET mprl = _LOADIMAGE(ploc$ + mplayermodel$ + "/" + mplayermodel$ + "-rl.png")
LET mprr = _LOADIMAGE(ploc$ + mplayermodel$ + "/" + mplayermodel$ + "-rr.png")
LET mpl = _LOADIMAGE(ploc$ + mplayermodel$ + "/" + mplayermodel$ + "-l.png")
LET mpll = _LOADIMAGE(ploc$ + mplayermodel$ + "/" + mplayermodel$ + "-ll.png")
LET mplr = _LOADIMAGE(ploc$ + mplayermodel$ + "/" + mplayermodel$ + "-lr.png")
LET mpfi1 = _LOADIMAGE(ploc$ + mplayermodel$ + "/" + mplayermodel$ + "-fi1.png")
LET mpfi2 = _LOADIMAGE(ploc$ + mplayermodel$ + "/" + mplayermodel$ + "-fi2.png")
LET mpbi1 = _LOADIMAGE(ploc$ + mplayermodel$ + "/" + mplayermodel$ + "-bi1.png")
LET mpbi2 = _LOADIMAGE(ploc$ + mplayermodel$ + "/" + mplayermodel$ + "-bi2.png")
LET mpli1 = _LOADIMAGE(ploc$ + mplayermodel$ + "/" + mplayermodel$ + "-li1.png")
LET mpli2 = _LOADIMAGE(ploc$ + mplayermodel$ + "/" + mplayermodel$ + "-li2.png")
LET mpri1 = _LOADIMAGE(ploc$ + mplayermodel$ + "/" + mplayermodel$ + "-ri1.png")
LET mpri2 = _LOADIMAGE(ploc$ + mplayermodel$ + "/" + mplayermodel$ + "-ri2.png")
LET mpface1 = _LOADIMAGE(ploc$ + mplayermodel$ + "/" + mplayermodel$ + "-face1.png")
LET mpface2 = _LOADIMAGE(ploc$ + mplayermodel$ + "/" + mplayermodel$ + "-face2.png")
REM calculates player sprite location
LET mpposx = (resx / 2) - (mpx / 2)
LET mpposy = (resy / 2) - (mpy / 2)
REM sets foot value
LET mpfoot = 1
REM tells console of load
LET eventtitle$ = "MAIN PLAYER LOADED: "
LET eventdata$ = mplayermodel$
LET eventnumber = 0
GOSUB consoleprinter
LET temp$ = ""
LET temp = 0
RETURN

controlgenerator:
REM generates control text
LET textspeech$ = "": REM wipes text speech
IF ucontrol = 1 THEN
    LET temp148 = ucontrolcode1
    GOSUB findcontrol
    LET textspeech$ = textspeech$ + temp42$ + " - MOVE UP. "
    LET temp42$ = ""
END IF
IF dcontrol = 1 THEN
    LET temp148 = dcontrolcode1
    GOSUB findcontrol
    LET textspeech$ = textspeech$ + temp42$ + " - MOVE DOWN. "
    LET temp42$ = ""
END IF
IF lcontrol = 1 THEN
    LET temp148 = lcontrolcode1
    GOSUB findcontrol
    LET textspeech$ = textspeech$ + temp42$ + " - MOVE LEFT. "
    LET temp42$ = ""
END IF
IF rcontrol = 1 THEN
    LET temp148 = rcontrolcode1
    GOSUB findcontrol
    LET textspeech$ = textspeech$ + temp42$ + " - MOVE RIGHT. "
    LET temp42$ = ""
END IF
IF scontrol = 1 THEN
    LET temp148 = scontrolcode1
    GOSUB findcontrol
    LET textspeech$ = textspeech$ + temp42$ + " - SELECT. "
    LET temp42$ = ""
END IF
IF pcontrol = 1 THEN
    LET temp148 = pcontrolcode1
    GOSUB findcontrol
    LET textspeech$ = textspeech$ + temp42$ + " - POCKETS. "
    LET temp42$ = ""
END IF
IF bcontrol = 1 THEN
    LET temp148 = bcontrolcode1
    GOSUB findcontrol
    LET textspeech$ = textspeech$ + temp42$ + " - BACK/PAUSE. "
    LET temp42$ = ""
END IF
RETURN

findcontrol:
REM finds control from unicode
IF temp148 = 27 THEN LET temp42$ = "ESC"
IF temp148 = 15104 THEN LET temp42$ = "F1"
IF temp148 = 15360 THEN LET temp42$ = "F2"
IF temp148 = 15616 THEN LET temp42$ = "F3"
IF temp148 = 15872 THEN LET temp42$ = "F4"
IF temp148 = 16128 THEN LET temp42$ = "F5"
IF temp148 = 16384 THEN LET temp42$ = "F6"
IF temp148 = 16640 THEN LET temp42$ = "F7"
IF temp148 = 16896 THEN LET temp42$ = "F8"
IF temp148 = 17152 THEN LET temp42$ = "F9"
IF temp148 = 17408 THEN LET temp42$ = "F10"
IF temp148 = 34048 THEN LET temp42$ = "F11"
IF temp148 = 34304 THEN LET temp42$ = "F12"
IF temp148 = 126 THEN LET temp42$ = "~"
IF temp148 = 96 THEN LET temp42$ = "`"
IF temp148 = 33 THEN LET temp42$ = "!"
IF temp148 = 49 THEN LET temp42$ = "1"
IF temp148 = 64 THEN LET temp42$ = "@"
IF temp148 = 50 THEN LET temp42$ = "2"
IF temp148 = 35 THEN LET temp42$ = "#"
IF temp148 = 51 THEN LET temp42$ = "3"
IF temp148 = 36 THEN LET temp42$ = "$"
IF temp148 = 52 THEN LET temp42$ = "4"
IF temp148 = 37 THEN LET temp42$ = "%"
IF temp148 = 53 THEN LET temp42$ = "5"
IF temp148 = 94 THEN LET temp42$ = "^"
IF temp148 = 54 THEN LET temp42$ = "6"
IF temp148 = 38 THEN LET temp42$ = "&"
IF temp148 = 55 THEN LET temp42$ = "7"
IF temp148 = 42 THEN LET temp42$ = "*"
IF temp148 = 56 THEN LET temp42$ = "8"
IF temp148 = 40 THEN LET temp42$ = "("
IF temp148 = 57 THEN LET temp42$ = "9"
IF temp148 = 41 THEN LET temp42$ = ")"
IF temp148 = 48 THEN LET temp42$ = "0"
IF temp148 = 95 THEN LET temp42$ = "_"
IF temp148 = 45 THEN LET temp42$ = "DASH"
IF temp148 = 43 THEN LET temp42$ = "+"
IF temp148 = 61 THEN LET temp42$ = "="
IF temp148 = 8 THEN LET temp42$ = "BACKSPACE"
IF temp148 = 9 THEN LET temp42$ = "TAB"
IF temp148 = 81 OR temp148 = 113 THEN LET temp42$ = "Q"
IF temp148 = 87 OR temp148 = 119 THEN LET temp42$ = "W"
IF temp148 = 69 OR temp148 = 101 THEN LET temp42$ = "E"
IF temp148 = 82 OR temp148 = 114 THEN LET temp42$ = "R"
IF temp148 = 84 OR temp148 = 116 THEN LET temp42$ = "T"
IF temp148 = 89 OR temp148 = 121 THEN LET temp42$ = "Y"
IF temp148 = 85 OR temp148 = 117 THEN LET temp42$ = "U"
IF temp148 = 73 OR temp148 = 105 THEN LET temp42$ = "I"
IF temp148 = 79 OR temp148 = 111 THEN LET temp42$ = "O"
IF temp148 = 80 OR temp148 = 112 THEN LET temp42$ = "P"
IF temp148 = 123 THEN LET temp42$ = "{"
IF temp148 = 91 THEN LET temp42$ = "["
IF temp148 = 125 THEN LET temp42$ = "}"
IF temp148 = 93 THEN LET temp42$ = "]"
IF temp148 = 124 THEN LET temp42$ = "|"
IF temp148 = 92 THEN LET temp42$ = "\"
IF temp148 = 65 OR temp148 = 97 THEN LET temp42$ = "A"
IF temp148 = 83 OR temp148 = 115 THEN LET temp42$ = "S"
IF temp148 = 68 OR temp148 = 100 THEN LET temp42$ = "D"
IF temp148 = 70 OR temp148 = 102 THEN LET temp42$ = "F"
IF temp148 = 71 OR temp148 = 103 THEN LET temp42$ = "G"
IF temp148 = 72 OR temp148 = 104 THEN LET temp42$ = "H"
IF temp148 = 74 OR temp148 = 106 THEN LET temp42$ = "J"
IF temp148 = 75 OR temp148 = 107 THEN LET temp42$ = "K"
IF temp148 = 76 OR temp148 = 108 THEN LET temp42$ = "L"
IF temp148 = 58 THEN LET temp42$ = ":"
IF temp148 = 59 THEN LET temp42$ = ";"
IF temp148 = 34 THEN LET temp42$ = CHR$(0) + CHR$(34)
IF temp148 = 39 THEN LET temp42$ = "'"
IF temp148 = 13 THEN LET temp42$ = "ENTER"
IF temp148 = 90 OR temp148 = 122 THEN LET temp42$ = "Z"
IF temp148 = 88 OR temp148 = 120 THEN LET temp42$ = "X"
IF temp148 = 67 OR temp148 = 99 THEN LET temp42$ = "C"
IF temp148 = 86 OR temp148 = 118 THEN LET temp42$ = "V"
IF temp148 = 66 OR temp148 = 98 THEN LET temp42$ = "B"
IF temp148 = 78 OR temp148 = 110 THEN LET temp42$ = "N"
IF temp148 = 77 OR temp148 = 109 THEN LET temp42$ = "M"
IF temp148 = 60 THEN LET temp42$ = "<"
IF temp148 = 44 THEN LET temp42$ = ","
IF temp148 = 62 THEN LET temp42$ = ">"
IF temp148 = 46 THEN LET temp42$ = "."
IF temp148 = 63 THEN LET temp42$ = "?"
IF temp148 = 47 THEN LET temp42$ = "/"
IF temp148 = 32 THEN LET temp42$ = "SPACE"
IF temp148 = 18432 THEN LET temp42$ = "UP ARROW"
IF temp148 = 20480 THEN LET temp42$ = "DOWN ARROW"
IF temp148 = 19200 THEN LET temp42$ = "LEFT ARROW"
IF temp148 = 19712 THEN LET temp42$ = "RIGHT ARROW"
IF temp42$ = "" THEN LET temp42$ = "UNSUPPORTED KEY"
LET temp148 = 0: REM scrub temp values
RETURN

menugenerator:
REM menu presented to player
IF menu$ = "" THEN
    REM return for if no menu name specified
    LET eventtitle$ = "NO MENU NAME SPECIFIED"
    LET eventdata$ = "MENU NOT LOADED"
    LET eventnumber = 0
    GOSUB consoleprinter
    RETURN
END IF
LET mainmenu = 1: REM tells engine menu is active
LET oldobjecttype$ = objecttype$: REM passes over object type to temp value
LET objecttype$ = "NON": REM removes any in-game object types.
CLS
REM menu loop
OPEN menuloc$ + menu$ + ".ddf" FOR INPUT AS #1
INPUT #1, menuchoice1$, menuchoice2$, menuchoice3$, menuchoice4$, menuchoice5$, menuchoice6$, menucommand1$, menucommand2$, menucommand3$, menucommand4$, menucommand5$, menucommand6$, mcy1, mcy2, mcy3, mcy4, mcy5, mcy6, menunos, menuposx, menubackdrop$, menumusic$
CLOSE #1
REM console dump
LET eventtitle$ = "MENU LOADED:"
LET eventdata$ = menu$
LET eventnumber = 0
GOSUB consoleprinter
REM plays music
LET playmusic$ = menumusic$
GOSUB musicplay
LET menubackdrop = _LOADIMAGE(menuloc$ + menubackdrop$ + ".png")
_PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
LET temp78 = 1
DO
    _LIMIT extrahertz
    DO
        LET d = _KEYHIT
        LET xxit = _EXIT: REM sets game exit value
        DO
            _LIMIT extrahertz
            REM centralises text
            LET temp77 = temp77 + 1
            IF temp77 = 1 THEN
                IF menuchoice1$ <> "" THEN
                    LET centretext$ = menuchoice1$
                    IF menuposx = -1 THEN GOSUB centretext
                    LET temp76 = 1
                END IF
            END IF
            IF temp77 = 2 THEN
                IF menuchoice2$ <> "" THEN
                    LET centretext$ = menuchoice2$
                    IF menuposx = -1 THEN GOSUB centretext
                    LET temp76 = 1
                END IF
            END IF
            IF temp77 = 3 THEN
                IF menuchoice3$ <> "" THEN
                    LET centretext$ = menuchoice3$
                    IF menuposx = -1 THEN GOSUB centretext
                    LET temp76 = 1
                END IF
            END IF
            IF temp77 = 4 THEN
                IF menuchoice4$ <> "" THEN
                    LET centretext$ = menuchoice4$
                    IF menuposx = -1 THEN GOSUB centretext
                    LET temp76 = 1
                END IF
            END IF
            IF temp77 = 5 THEN
                IF menuchoice5$ <> "" THEN
                    LET centretext$ = menuchoice5$
                    IF menuposx = -1 THEN GOSUB centretext
                    LET temp76 = 1
                END IF
            END IF
            IF temp77 = 6 THEN
                IF menuchoice6$ <> "" THEN
                    LET centretext$ = menuchoice6$
                    IF menuposx = -1 THEN GOSUB centretext
                    LET temp76 = 1
                END IF
            END IF
            IF temp77 > 6 THEN LET temp77 = 0
        LOOP UNTIL temp76 = 1
        REM prints text
        IF temp78 = 1 THEN
            COLOR _RGBA(letmenuselectcolourr, letmenuselectcolourg, letmenuselectcolourb, letmenuselectcoloura), _RGBA(bgmenuselectcolourr, bgmenuselectcolourg, bgmenuselectcolourb, bgmenuselectcoloura)
        ELSE
            COLOR _RGBA(letmenudefaultcolourr, letmenudefaultcolourg, letmenudefaultcolourb, letmenudefaultcoloura), _RGBA(bgmenudefaultcolourr, bgmenudefaultcolourg, bgmenudefaultcolourb, bgmenudefaultcoloura)
        END IF
        IF temp77 = 1 THEN
            IF menuposx = -1 THEN
                _PRINTSTRING ((resx / 2) - (centreno / 2), (mcy1)), menuchoice1$
            ELSE
                _PRINTSTRING (menuposx, mcy1), menuchoice1$
            END IF
        END IF
        IF temp78 = 2 THEN
            COLOR _RGBA(letmenuselectcolourr, letmenuselectcolourg, letmenuselectcolourb, letmenuselectcoloura), _RGBA(bgmenuselectcolourr, bgmenuselectcolourg, bgmenuselectcolourb, bgmenuselectcoloura)
        ELSE
            COLOR _RGBA(letmenudefaultcolourr, letmenudefaultcolourg, letmenudefaultcolourb, letmenudefaultcoloura), _RGBA(bgmenudefaultcolourr, bgmenudefaultcolourg, bgmenudefaultcolourb, bgmenudefaultcoloura)
        END IF
        IF temp77 = 2 THEN
            IF menuposx = -1 THEN
                _PRINTSTRING ((resx / 2) - (centreno / 2), (mcy2)), menuchoice2$
            ELSE
                _PRINTSTRING (menuposx, mcy2), menuchoice2$
            END IF
        END IF
        IF temp78 = 3 THEN
            COLOR _RGBA(letmenuselectcolourr, letmenuselectcolourg, letmenuselectcolourb, letmenuselectcoloura), _RGBA(bgmenuselectcolourr, bgmenuselectcolourg, bgmenuselectcolourb, bgmenuselectcoloura)
        ELSE
            COLOR _RGBA(letmenudefaultcolourr, letmenudefaultcolourg, letmenudefaultcolourb, letmenudefaultcoloura), _RGBA(bgmenudefaultcolourr, bgmenudefaultcolourg, bgmenudefaultcolourb, bgmenudefaultcoloura)
        END IF
        IF temp77 = 3 THEN
            IF menuposx = -1 THEN
                _PRINTSTRING ((resx / 2) - (centreno / 2), (mcy3)), menuchoice3$
            ELSE
                _PRINTSTRING (menuposx, mcy3), menuchoice3$
            END IF
        END IF
        IF temp78 = 4 THEN
            COLOR _RGBA(letmenuselectcolourr, letmenuselectcolourg, letmenuselectcolourb, letmenuselectcoloura), _RGBA(bgmenuselectcolourr, bgmenuselectcolourg, bgmenuselectcolourb, bgmenuselectcoloura)
        ELSE
            COLOR _RGBA(letmenudefaultcolourr, letmenudefaultcolourg, letmenudefaultcolourb, letmenudefaultcoloura), _RGBA(bgmenudefaultcolourr, bgmenudefaultcolourg, bgmenudefaultcolourb, bgmenudefaultcoloura)
        END IF
        IF temp77 = 4 THEN
            IF menuposx = -1 THEN
                _PRINTSTRING ((resx / 2) - (centreno / 2), (mcy4)), menuchoice4$
            ELSE
                _PRINTSTRING (menuposx, mcy4), menuchoice4$
            END IF
        END IF
        IF temp78 = 5 THEN
            COLOR _RGBA(letmenuselectcolourr, letmenuselectcolourg, letmenuselectcolourb, letmenuselectcoloura), _RGBA(bgmenuselectcolourr, bgmenuselectcolourg, bgmenuselectcolourb, bgmenuselectcoloura)
        ELSE
            COLOR _RGBA(letmenudefaultcolourr, letmenudefaultcolourg, letmenudefaultcolourb, letmenudefaultcoloura), _RGBA(bgmenudefaultcolourr, bgmenudefaultcolourg, bgmenudefaultcolourb, bgmenudefaultcoloura)
        END IF
        IF temp77 = 5 THEN
            IF menuposx = -1 THEN
                _PRINTSTRING ((resx / 2) - (centreno / 2), (mcy5)), menuchoice5$
            ELSE
                _PRINTSTRING (menuposx, mcy5), menuchoice5$
            END IF
        END IF
        IF temp78 = 6 THEN
            COLOR _RGBA(letmenuselectcolourr, letmenuselectcolourg, letmenuselectcolourb, letmenuselectcoloura), _RGBA(bgmenuselectcolourr, bgmenuselectcolourg, bgmenuselectcolourb, bgmenuselectcoloura)
        ELSE
            COLOR _RGBA(letmenudefaultcolourr, letmenudefaultcolourg, letmenudefaultcolourb, letmenudefaultcoloura), _RGBA(bgmenudefaultcolourr, bgmenudefaultcolourg, bgmenudefaultcolourb, bgmenudefaultcoloura)
        END IF
        LET temp76 = 0
        IF temp77 = 6 THEN
            IF menuposx = -1 THEN
                _PRINTSTRING ((resx / 2) - (centreno / 2), (mcy6)), menuchoice6$
            ELSE
                _PRINTSTRING (menuposx, mcy6), menuchoice6$
            END IF
        END IF
        GOSUB musicfadeout
        GOSUB musicfadein
        REM input
        IF d = dcontrolcode1 OR d = dcontrolcode2 OR d = dcontrolcode3 OR d = dcontrolcode4 THEN
            IF temp78 + 1 <= menunos THEN
                _KEYCLEAR
                LET playsfx$ = "move"
                GOSUB sfxplay
                LET temp78 = temp78 + 1
            END IF
        END IF
        IF d = ucontrolcode1 OR d = ucontrolcode2 OR d = ucontrolcode3 OR d = ucontrolcode4 THEN
            IF temp78 - 1 >= 1 THEN
                _KEYCLEAR
                LET playsfx$ = "move"
                GOSUB sfxplay
                LET temp78 = temp78 - 1
            END IF
        END IF
        IF temp79 > 0 THEN LET temp79 = 0
        IF _EXIT THEN
            REM end game if close button is pressed
            CLS
            _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
            GOSUB endgamemenu
            CLS
            _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
        END IF
    LOOP UNTIL d = scontrolcode1 OR d = scontrolcode2 OR d = scontrolcode3 OR d = scontrolcode4
    REM plays select sound
    LET playsfx$ = "select"
    GOSUB sfxplay
    REM deturmins which choice player made and lines up menu command
    IF temp78 = 1 THEN LET temp15$ = menucommand1$
    IF temp78 = 2 THEN LET temp15$ = menucommand2$
    IF temp78 = 3 THEN LET temp15$ = menucommand3$
    IF temp78 = 4 THEN LET temp15$ = menucommand4$
    IF temp78 = 5 THEN LET temp15$ = menucommand5$
    IF temp78 = 6 THEN LET temp15$ = menucommand6$
    IF temp15$ <> "playgame" THEN
        REM detects possible new menu request
        LET findmenu% = INSTR(findmenu% + 1, temp15$, "menu ")
        IF findmenu% THEN
            LET temp16$ = LEFT$(temp15$, INSTR(temp15$, " ") - 1)
            LET temp17$ = RIGHT$(temp15$, LEN(temp15$) - LEN(temp16$))
            LET temp17$ = LTRIM$(temp17$)
            LET temp16$ = LCASE$(temp16$)
            LET temp17$ = LCASE$(temp17$)
            CLS
            _FREEIMAGE menubackdrop
            LET menu$ = temp17$
            LET mainmenu = 0: LET temp76 = 1: LET temp77 = 0: LET temp78 = 0: LET findmenu% = 0: LET d$ = "": LET temp15$ = "": LET temp16$ = "": LET temp17$ = "": REM scrubs temp values
            GOTO menugenerator
        END IF
        REM executes menucommand
        IF temp15$ = "updategame" THEN
            CLS
            _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
            LET scriptname$ = "updateprompt"
            LET mapscript = 5
            GOSUB script
            CLS
            _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
            FOR x = 1 TO 2
                IF x = 1 THEN LET choicename$(x) = "YES"
                IF x = 2 THEN LET choicename$(x) = "NO"
            NEXT x
            LET choicetotal = 2
            GOSUB choicebannerdraw
            IF choiceno = 1 THEN
                CLS
                GOSUB updatechecker
            END IF
            LET choiceno = 0
        END IF
        REM quits game
        IF temp15$ = "endgame" THEN
            CLS
            _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
            GOSUB endgamemenu
        END IF
        REM erases save
        IF temp15$ = "erasesave" THEN
            CLS
            _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
            LET scriptname$ = "erasesave"
            LET mapscript = 5
            GOSUB script
            CLS
            _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
            FOR x = 1 TO 2
                IF x = 1 THEN LET choicename$(x) = "YES"
                IF x = 2 THEN LET choicename$(x) = "NO"
            NEXT x
            LET choicetotal = 2
            GOSUB choicebannerdraw
            IF choiceno = 1 THEN
                CLS
                LET scriptname$ = "posterasesave"
                LET mapscript = 5
                GOSUB script
                CLS
                GOSUB erasesave
            END IF
        END IF
        REM loads award menu
        IF temp15$ = "displayawards" THEN
            CLS
            GOSUB awardmenu
            CLS
            REM console dump
            LET eventtitle$ = "MENU LOADED:"
            LET eventdata$ = menu$
            LET eventnumber = 0
            GOSUB consoleprinter
        END IF
        REM reloads current save
        IF temp15$ = "loadsave" THEN
            CLS
            _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
            IF setupboot = 0 THEN
                LET scriptname$ = "loadsave"
            ELSE
                LET scriptname$ = "loadsavefail"
            END IF
            LET mapscript = 5
            GOSUB script
            IF setupboot = 0 THEN
                CLS
                _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
                FOR x = 1 TO 2
                    IF x = 1 THEN LET choicename$(x) = "YES"
                    IF x = 2 THEN LET choicename$(x) = "NO"
                NEXT x
                LET choicetotal = 2
                GOSUB choicebannerdraw
                IF choiceno = 1 THEN
                    CLS
                    GOSUB loadgame
                    CLS
                    LET scriptname$ = "postloadsave"
                    LET mapscript = 5
                    GOSUB script
                END IF
            END IF
        END IF
        REM toggles music on and off
        IF temp15$ = "musictoggle" THEN
            CLS
            _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
            LET scriptname$ = "musictoggle"
            LET mapscript = 5
            GOSUB script
            CLS
            _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
            FOR x = 1 TO 2
                IF x = 1 THEN LET choicename$(x) = "ON"
                IF x = 2 THEN LET choicename$(x) = "OFF"
            NEXT x
            LET choicetotal = 2
            GOSUB choicebannerdraw
            IF choiceno = 1 THEN
                IF soundmode = 2 OR soundmode = 3 THEN
                    CLS
                    _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
                    LET scriptname$ = "musicalreadyon"
                    LET mapscript = 5
                    GOSUB script
                END IF
                IF soundmode = 1 OR soundmode = 4 THEN
                    GOSUB musictoggle
                    CLS
                    _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
                    LET scriptname$ = "musicon"
                    LET mapscript = 5
                    GOSUB script
                END IF
            END IF
            IF choiceno = 2 THEN
                IF soundmode = 1 OR soundmode = 4 THEN
                    CLS
                    _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
                    LET scriptname$ = "musicalreadyoff"
                    LET mapscript = 5
                    GOSUB script
                END IF
                IF soundmode = 2 OR soundmode = 3 THEN
                    GOSUB musictoggle
                    CLS
                    _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
                    LET scriptname$ = "musicoff"
                    LET mapscript = 5
                    GOSUB script
                END IF
            END IF
            LET choiceno = 0
        END IF
        REM toggles sound effects on and off
        IF temp15$ = "sfxtoggle" THEN
            CLS
            _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
            LET scriptname$ = "sfxtoggle"
            LET mapscript = 5
            GOSUB script
            CLS
            _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
            FOR x = 1 TO 2
                IF x = 1 THEN LET choicename$(x) = "ON"
                IF x = 2 THEN LET choicename$(x) = "OFF"
            NEXT x
            LET choicetotal = 2
            GOSUB choicebannerdraw
            IF choiceno = 1 THEN
                IF soundmode = 2 OR soundmode = 4 THEN
                    CLS
                    _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
                    LET scriptname$ = "sfxalreadyon"
                    LET mapscript = 5
                    GOSUB script
                END IF
                IF soundmode = 1 OR soundmode = 3 THEN
                    GOSUB sfxtoggle
                    CLS
                    _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
                    LET scriptname$ = "sfxon"
                    LET mapscript = 5
                    GOSUB script
                END IF
            END IF
            IF choiceno = 2 THEN
                IF soundmode = 1 OR soundmode = 3 THEN
                    CLS
                    _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
                    LET scriptname$ = "sfxalreadyoff"
                    LET mapscript = 5
                    GOSUB script
                END IF
                IF soundmode = 2 OR soundmode = 4 THEN
                    GOSUB sfxtoggle
                    CLS
                    _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
                    LET scriptname$ = "sfxoff"
                    LET mapscript = 5
                    GOSUB script
                END IF
            END IF
            LET choiceno = 0
        END IF
        REM toggles fullscreen and windowed modes
        IF temp15$ = "screentoggle" THEN
            CLS
            _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
            LET scriptname$ = "screenmodetoggle"
            LET mapscript = 5
            GOSUB script
            CLS
            _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
            FOR x = 1 TO 2
                IF x = 1 THEN LET choicename$(x) = "FULLSCREEN"
                IF x = 2 THEN LET choicename$(x) = "WINDOWED"
            NEXT x
            LET choicetotal = 2
            GOSUB choicebannerdraw
            IF choiceno = 1 THEN
                IF screenmode = 1 THEN
                    CLS
                    _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
                    LET scriptname$ = "fullscreenalreadyon"
                    LET mapscript = 5
                    GOSUB script
                END IF
                IF screenmode = 2 THEN
                    GOSUB screentoggle
                    CLS
                    _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
                    LET scriptname$ = "fullscreenon"
                    LET mapscript = 5
                    GOSUB script
                END IF
            END IF
            IF choiceno = 2 THEN
                IF screenmode = 2 THEN
                    CLS
                    _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
                    LET scriptname$ = "windowedalreadyon"
                    LET mapscript = 5
                    GOSUB script
                END IF
                IF screenmode = 1 THEN
                    GOSUB screentoggle
                    CLS
                    _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
                    LET scriptname$ = "windowedon"
                    LET mapscript = 5
                    GOSUB script
                END IF
            END IF
            LET choiceno = 0
        END IF
        REM displays game controls
        IF temp15$ = "displaycontrols" THEN
            CLS
            _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
            GOSUB controlgenerator
            GOSUB textbannerdraw
        END IF
        REM fake options for bants
        IF temp15$ = "spooftoggle" THEN
            CLS
            _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
            LET textspeech$ = spoofoptiontitle$
            GOSUB textbannerdraw
            CLS
            _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
            FOR x = 1 TO 2
                IF x = 1 THEN LET choicename$(x) = spoofoption1$
                IF x = 2 THEN LET choicename$(x) = spoofoption2$
            NEXT x
            LET choicetotal = 2
            GOSUB choicebannerdraw
            CLS
            _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
            IF choiceno = 1 THEN LET textspeech$ = spoofoption1result$
            IF choiceno = 2 THEN LET textspeech$ = spoofoption2result$
            GOSUB textbannerdraw
            REM spoof options have no effect on anything x
        END IF
        REM set music vol
        IF temp15$ = "musicvol" THEN
            IF soundmode = 2 OR soundmode = 3 THEN
                CLS
                _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
                LET scriptname$ = "musicvolumeprompt"
                LET mapscript = 5
                GOSUB script
                CLS
                _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
                FOR x = 1 TO 10
                    IF x = 1 THEN LET choicename$(x) = "10%"
                    IF x = 2 THEN LET choicename$(x) = "20%"
                    IF x = 3 THEN LET choicename$(x) = "30%"
                    IF x = 4 THEN LET choicename$(x) = "40%"
                    IF x = 5 THEN LET choicename$(x) = "50%"
                    IF x = 6 THEN LET choicename$(x) = "60%"
                    IF x = 7 THEN LET choicename$(x) = "70%"
                    IF x = 8 THEN LET choicename$(x) = "80%"
                    IF x = 9 THEN LET choicename$(x) = "90%"
                    IF x = 10 THEN LET choicename$(x) = "100%"
                NEXT x
                LET choicetotal = 10
                GOSUB choicebannerdraw
                LET musicvol = choiceno / 10
                GOSUB musicvol
                CLS
                _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
                LET scriptname$ = "musicvolumeset"
                LET mapscript = 5
                GOSUB script
                LET choiceno = 0
            ELSE
                REM if music is switched off
                CLS
                _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
                LET scriptname$ = "musicvolumeoff"
                LET mapscript = 5
                GOSUB script
            END IF
        END IF
        REM set sfx vol
        IF temp15$ = "sfxvol" THEN
            IF soundmode = 2 OR soundmode = 4 THEN
                CLS
                _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
                LET scriptname$ = "sfxvolumeprompt"
                LET mapscript = 5
                GOSUB script
                CLS
                _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
                FOR x = 1 TO 10
                    IF x = 1 THEN LET choicename$(x) = "10%"
                    IF x = 2 THEN LET choicename$(x) = "20%"
                    IF x = 3 THEN LET choicename$(x) = "30%"
                    IF x = 4 THEN LET choicename$(x) = "40%"
                    IF x = 5 THEN LET choicename$(x) = "50%"
                    IF x = 6 THEN LET choicename$(x) = "60%"
                    IF x = 7 THEN LET choicename$(x) = "70%"
                    IF x = 8 THEN LET choicename$(x) = "80%"
                    IF x = 9 THEN LET choicename$(x) = "90%"
                    IF x = 10 THEN LET choicename$(x) = "100%"
                NEXT x
                LET choicetotal = 10
                GOSUB choicebannerdraw
                LET sfxvol = choiceno / 10
                GOSUB sfxvol
                CLS
                _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
                LET scriptname$ = "sfxvolumeset"
                LET mapscript = 5
                GOSUB script
                LET choiceno = 0
            ELSE
                REM is sfx are turned off
                CLS
                _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
                LET scriptname$ = "sfxvolumeoff"
                LET mapscript = 5
                GOSUB script
            END IF
        END IF
        REM displays developer console
        IF temp15$ = "displayconsole" THEN
            GOSUB displayconsole
        END IF
        REM displays mod menu
        IF temp15$ = "loadmod" THEN
            CLS
            GOSUB modmenu
            CLS
            REM console dump
            LET eventtitle$ = "MENU LOADED:"
            LET eventdata$ = menu$
            LET eventnumber = 0
            GOSUB consoleprinter
        END IF
        REM displays restore old save menu
        IF temp15$ = "restoresave" THEN
            CLS
            GOSUB saverestore
            CLS
            REM console dump
            LET eventtitle$ = "MENU LOADED:"
            LET eventdata$ = menu$
            LET eventnumber = 0
            GOSUB consoleprinter
        END IF
    ELSE
        REM executes playgame command
        CLS
        _FREEIMAGE menubackdrop
        LET menu$ = ""
        COLOR 0, 0
        LET mainmenu = 0: LET temp76 = 1: LET temp77 = 0: LET temp78 = 0: LET findmenu% = 0: LET oldobjecttype$ = "": LET d$ = "": LET temp15$ = "": LET temp16$ = "": LET temp17$ = "": LET temp29$ = "": REM scrubs temp values
        RETURN
    END IF
    CLS
    _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop: REM redraws meny background
    LET temp15$ = ""
LOOP
RETURN

endgamemenu:
REM asks player if they're sure they'd like to quit
LET scriptname$ = "quitconfirm"
LET mapscript = 5
GOSUB script
IF mainmenu = 1 THEN
    REM draws menu if needed
    CLS
    _PUTIMAGE (0, 0)-(resx - 1, resy - 1), menubackdrop
END IF
FOR x = 1 TO 2
    IF x = 1 THEN LET choicename$(x) = "YES"
    IF x = 2 THEN LET choicename$(x) = "NO"
NEXT x
LET choicetotal = 2
GOSUB choicebannerdraw
IF choiceno = 1 THEN
    IF mainmenu = 1 THEN
        REM fade out for main menu
        LET temp206 = fadespeed
        FOR i% = 0 TO 255 STEP temp206
            _LIMIT hertz: REM sets framerate
            LINE (0, 0)-(resx, resy), _RGBA(0, 0, 0, i%), BF: REM slowly empties black box from screen
            _DISPLAY
        NEXT
        _AUTODISPLAY
    END IF
    GOTO endgame
END IF
LET choiceno = 0
RETURN

modmenu:
REM loads a mod or DLC
REM generates list of potential mod locations
IF ros$ = "win" THEN SHELL _HIDE "dir /ad /b > " + dloc$ + "modlist.tmp"
IF ros$ = "lnx" OR ros$ = "mac" THEN SHELL _HIDE "ls -d */ > " + dloc$ + "modlist.tmp"
REM finds mods
OPEN dloc$ + "modlist.tmp" FOR INPUT AS #42
LET modamount = 0: LET temp50$ = "": LET temp51$ = ""
DO
    INPUT #42, temp48$
    REM removes slashes
    FOR i = 1 TO LEN(temp48$)
        LET temp50$ = MID$(temp48$, i, 1)
        IF temp50$ <> "/" AND temp50$ <> "\" THEN LET temp51$ = temp51$ + temp50$
    NEXT i
    LET temp48$ = temp51$
    LET temp50$ = "": LET temp51$ = ""
    IF temp48$ <> "data" THEN IF _FILEEXISTS(temp48$ + "/engine.ddf") THEN LET modamount = modamount + 1
LOOP UNTIL EOF(42) OR modamount = 9
CLOSE #42
REM return for if no mods are found
IF modamount = 0 THEN
    LET scriptname$ = "nomodsfound"
    LET mapscript = 5
    GOSUB script
    LET temp48$ = "": LET temp50$ = "": LET temp51$ = "": REM scrub temp values
    IF ros$ = "win" THEN SHELL _HIDE "del " + dloc$ + "modlist.tmp"
    IF ros$ = "lnx" OR ros$ = "mac" THEN SHELL _HIDE "rm " + dloc$ + "modlist.tmp"
    RETURN
END IF
REM tells console
LET eventtitle$ = "MENU LOADED:"
LET eventdata$ = "mod load menu"
LET eventnumber = 0
GOSUB consoleprinter
REM loads backdrop
LET modmenubackdrop$ = "modmenu"
LET modmenubackdrop = _LOADIMAGE(menuloc$ + modmenubackdrop$ + ".png")
REM displays available mods to screen
LET x = 1
LET xx = 1
LET temp50$ = ""
LET temp51$ = ""
DO
    CLS
    _PUTIMAGE (0, 0)-(resx - 1, resy - 1), modmenubackdrop
    OPEN dloc$ + "modlist.tmp" FOR INPUT AS #42
    COLOR _RGBA(letmenudefaultcolourr, letmenudefaultcolourg, letmenudefaultcolourb, letmenudefaultcoloura), _RGBA(bgmenudefaultcolourr, bgmenudefaultcolourg, bgmenudefaultcolourb, bgmenudefaultcoloura)
    IF modrunning = 0 THEN
        PRINT "NO " + moddingname$ + " LOADED."
    ELSE
        PRINT moddingname$ + " LOADED: " + modname$
    END IF
    PRINT "SELECT A " + moddingname$ + " TO LOAD:"
    PRINT
    IF x = xx THEN
        COLOR _RGBA(letmenuselectcolourr, letmenuselectcolourg, letmenuselectcolourb, letmenuselectcoloura), _RGBA(bgmenuselectcolourr, bgmenuselectcolourg, bgmenuselectcolourb, bgmenuselectcoloura)
    ELSE
        COLOR _RGBA(letmenudefaultcolourr, letmenudefaultcolourg, letmenudefaultcolourb, letmenudefaultcoloura), _RGBA(bgmenudefaultcolourr, bgmenudefaultcolourg, bgmenudefaultcolourb, bgmenudefaultcoloura)
    END IF
    PRINT "BACK"
    DO
        INPUT #42, temp48$
        REM removes slashes
        FOR i = 1 TO LEN(temp48$)
            LET temp50$ = MID$(temp48$, i, 1)
            IF temp50$ <> "/" AND temp50$ <> "\" THEN LET temp51$ = temp51$ + temp50$
        NEXT i
        LET temp48$ = temp51$
        LET temp50$ = "": LET temp51$ = ""
        IF temp48$ <> "data" THEN
            IF _FILEEXISTS(temp48$ + "/engine.ddf") THEN
                LET x = x + 1
                REM sets colour
                IF x = xx THEN
                    COLOR _RGBA(letmenuselectcolourr, letmenuselectcolourg, letmenuselectcolourb, letmenuselectcoloura), _RGBA(bgmenuselectcolourr, bgmenuselectcolourg, bgmenuselectcolourb, bgmenuselectcoloura)
                ELSE
                    COLOR _RGBA(letmenudefaultcolourr, letmenudefaultcolourg, letmenudefaultcolourb, letmenudefaultcoloura), _RGBA(bgmenudefaultcolourr, bgmenudefaultcolourg, bgmenudefaultcolourb, bgmenudefaultcoloura)
                END IF
                REM prints name
                PRINT temp48$
            END IF
        END IF
    LOOP UNTIL EOF(42) OR x = 10 OR x = modamount + 1
    CLOSE #42
    REM input loop
    DO
        LET dsr = _KEYHIT
        _LIMIT hertz
        GOSUB musicfadeout
        GOSUB musicfadein
    LOOP UNTIL dsr = ucontrolcode1 OR dsr = ucontrolcode2 OR dsr = ucontrolcode3 OR dsr = ucontrolcode4 OR dsr = dcontrolcode1 OR dsr = dcontrolcode2 OR dsr = dcontrolcode3 OR dsr = dcontrolcode4 OR dsr = scontrolcode1 OR dsr = scontrolcode2 OR dsr = scontrolcode3 OR dsr = scontrolcode4
    REM decides results from input
    REM up
    IF dsr = ucontrolcode1 OR dsr = ucontrolcode2 OR dsr = ucontrolcode3 OR dsr = ucontrolcode4 THEN
        LET xx = xx - 1
        IF xx < 1 THEN
            LET xx = 1
        ELSE
            LET playsfx$ = "move"
            GOSUB sfxplay
        END IF
    END IF
    REM down
    IF dsr = dcontrolcode1 OR dsr = dcontrolcode2 OR dsr = dcontrolcode3 OR dsr = dcontrolcode4 THEN
        LET xx = xx + 1
        IF xx > 10 OR xx > x THEN
            LET xx = x
        ELSE
            LET playsfx$ = "move"
            GOSUB sfxplay
        END IF
    END IF
    REM select
    IF dsr = scontrolcode1 OR dsr = scontrolcode2 OR dsr = scontrolcode3 OR dsr = scontrolcode4 THEN
        REM plays sound
        LET playsfx$ = "select"
        GOSUB sfxplay
        REM back
        IF xx = 1 THEN LET xxx = 1
        REM loads mod
        IF xx > 1 THEN
            REM detects which mod is selected
            OPEN dloc$ + "modlist.tmp" FOR INPUT AS #42
            LET x = 0
            DO
                INPUT #42, temp48$
                REM removes slashes
                FOR i = 1 TO LEN(temp48$)
                    LET temp50$ = MID$(temp48$, i, 1)
                    IF temp50$ <> "/" AND temp50$ <> "\" THEN LET temp51$ = temp51$ + temp50$
                NEXT i
                LET temp48$ = temp51$
                IF temp51$ <> "data" THEN IF _FILEEXISTS(temp51$ + "/engine.ddf") THEN LET x = x + 1
                LET temp50$ = "": LET temp51$ = ""
            LOOP UNTIL x = xx - 1
            CLOSE #42
            CLS
            _PUTIMAGE (0, 0)-(resx - 1, resy - 1), modmenubackdrop: REM redraws meny background
            LET scriptname$ = "modloadprompt"
            LET mapscript = 5
            GOSUB script
            CLS
            _PUTIMAGE (0, 0)-(resx - 1, resy - 1), modmenubackdrop: REM redraws meny background
            FOR x = 1 TO 2
                IF x = 1 THEN LET choicename$(x) = "YES"
                IF x = 2 THEN LET choicename$(x) = "NO"
            NEXT x
            LET choicetotal = 2
            GOSUB choicebannerdraw
            LET choicetotal = 0
            IF choiceno = 1 THEN
                LET requestedmod$ = temp48$
                REM tells console
                LET eventtitle$ = "MOD REQUESTED:"
                LET eventdata$ = requestedmod$
                LET eventnumber = 0
                GOSUB consoleprinter
                IF ros$ = "win" THEN SHELL _HIDE "del " + dloc$ + "modlist.tmp"
                IF ros$ = "lnx" OR ros$ = "mac" THEN SHELL _HIDE "rm " + dloc$ + "modlist.tmp"
                LET temp48$ = "": LET temp50$ = "": LET temp51$ = ""
                LET temp164 = 1
                LET x = 0: LET xx = 0: LET xxx = 0: LET temp50$ = "": LET temp51$ = ""
                GOTO endgame
            END IF
        END IF
    END IF
    LET x = 1: LET temp50$ = "": LET temp51$ = ""
LOOP UNTIL xxx = 1
IF ros$ = "win" THEN SHELL _HIDE "del " + dloc$ + "modlist.tmp"
IF ros$ = "lnx" OR ros$ = "mac" THEN SHELL _HIDE "rm " + dloc$ + "modlist.tmp"
LET x = 0: LET xx = 0: LET xxx = 0: LET temp48$ = "": LET temp50$ = "": LET temp51$ = "": REM scrub temp values
_FREEIMAGE modmenubackdrop
RETURN

awardmenu:
REM displays awards
IF awardmenuno = 0 THEN LET awardmenuno = 1
REM tells console
LET eventtitle$ = "MENU LOADED:"
LET eventdata$ = "award display menu"
LET eventnumber = 0
GOSUB consoleprinter
DO
    DO
        REM menu loop
        _LIMIT hertz
        LET ami = _KEYHIT
        REM displays text
        COLOR _RGBA(letmenuselectcolourr, letmenuselectcolourg, letmenuselectcolourb, letmenuselectcoloura), _RGBA(bgmenuselectcolourr, bgmenuselectcolourg, bgmenuselectcolourb, bgmenuselectcoloura)
        LET centretext$ = "Player " + awardtitle$
        GOSUB centretext
        _PRINTSTRING ((resx / 2) - (centreno / 2), fontsize), "Player " + awardtitle$
        COLOR _RGBA(letmenudefaultcolourr, letmenudefaultcolourg, letmenudefaultcolourb, letmenudefaultcoloura), _RGBA(bgmenudefaultcolourr, bgmenudefaultcolourg, bgmenudefaultcolourb, bgmenudefaultcoloura)
        LET centretext$ = awardname$(awardmenuno)
        GOSUB centretext
        _PRINTSTRING ((resx / 2) - (centreno / 2), (fontsize * 3)), awardname$(awardmenuno)
        LET centretext$ = awarddescription$(awardmenuno)
        GOSUB centretext
        _PRINTSTRING ((resx / 2) - (centreno / 2), (fontsize * 4)), awarddescription$(awardmenuno)
        REM displays arrows
        IF awardmenuno = 1 THEN
            REM draw unavailable arrow
            '_PUTIMAGE (1, (resy / 2) - (pocketarrowresy / 2)), awardarrowlu
        ELSE
            REM draw normal arrow
            _PUTIMAGE (1, (resy / 2) - (pocketarrowresy / 2)), awardarrowl
        END IF
        IF awardmenuno = totalawards THEN
            REM draw unavailable arrow
            '_PUTIMAGE ((resx - pocketarrowresx) - 1, (resy / 2) - (pocketarrowresy / 2)), awardarrowru
        ELSE
            REM draw normal arrow
            _PUTIMAGE ((resx - pocketarrowresx) - 1, (resy / 2) - (pocketarrowresy / 2)), awardarrowr
        END IF
        REM display award image (or none)
        IF awardvalue(awardmenuno) = 1 THEN
            REM award granted, show image + display text
            _PUTIMAGE ((resx / 2) - (awarditemresx / 2), resy / 2), awardsprite(awardmenuno)
            LET centretext$ = awardnotification$
            GOSUB centretext
            COLOR _RGBA(letmenuselectcolourr, letmenuselectcolourg, letmenuselectcolourb, letmenuselectcoloura), _RGBA(bgmenuselectcolourr, bgmenuselectcolourg, bgmenuselectcolourb, bgmenuselectcoloura)
            _PRINTSTRING ((resx / 2) - (centreno / 2), (resy / 2) + (awarditemresy + fontsize)), awardnotification$
        ELSE
            REM award locked, show none image
            _PUTIMAGE ((resx / 2) - (awarditemresx / 2), resy / 2), awardnone
        END IF
        GOSUB musicfadeout
        GOSUB musicfadein
    LOOP UNTIL ami = bcontrolcode1 OR ami = bcontrolcode2 OR ami = bcontrolcode3 OR ami = bcontrolcode4 OR ami = lcontrolcode1 OR ami = lcontrolcode2 OR ami = lcontrolcode3 OR ami = lcontrolcode4 OR ami = rcontrolcode1 OR ami = rcontrolcode2 OR ami = rcontrolcode3 OR ami = rcontrolcode4
    REM processes inputs
    IF ami = bcontrolcode1 OR ami = bcontrolcode2 OR ami = bcontrolcode3 OR ami = bcontrolcode4 THEN
        REM exit menu
        _KEYCLEAR
        RETURN
    END IF
    IF ami = lcontrolcode1 OR ami = lcontrolcode2 OR ami = lcontrolcode3 OR ami = lcontrolcode4 THEN
        REM go left
        IF awardmenuno <> 1 THEN
            LET playsfx$ = "move"
            GOSUB sfxplay
            _PUTIMAGE (1, (resy / 2) - (pocketarrowresy / 2)), awardarrowls
            _DELAY 0.1
            LET awardmenuno = awardmenuno - 1
            CLS
        END IF
    END IF
    IF ami = rcontrolcode1 OR ami = rcontrolcode2 OR ami = rcontrolcode3 OR ami = rcontrolcode4 THEN
        REM go right
        IF awardmenuno <> totalawards THEN
            LET playsfx$ = "move"
            GOSUB sfxplay
            _PUTIMAGE ((resx - pocketarrowresx) - 1, (resy / 2) - (pocketarrowresy / 2)), awardarrowrs
            _DELAY 0.1
            LET awardmenuno = awardmenuno + 1
            CLS
        END IF
    END IF
    _KEYCLEAR
LOOP
RETURN

saverestore:
REM restores an old save
REM checks if save controls are enabled
IF nosave = 1 THEN LET textspeech$ = nosaveprompt$: GOSUB textbannerdraw: RETURN
REM generates list of old saves
IF ros$ = "win" THEN SHELL _HIDE "dir /b " + CHR$(34) + sloc$ + CHR$(34) + " > " + dloc$ + "oldsaves.tmp"
IF ros$ = "lnx" OR ros$ = "mac" THEN SHELL _HIDE "ls " + sloc$ + " > " + dloc$ + "oldsaves.tmp"
REM checks for old save amount and removes expired saves
OPEN dloc$ + "oldsaves.tmp" FOR INPUT AS #42
LET oldsaveamount = 0
DO
    INPUT #42, temp48$
    LET findoldsave% = INSTR(findoldsave% + 1, temp48$, ".old")
    IF findoldsave% THEN LET oldsaveamount = oldsaveamount + 1
    LET findoldsave% = 0
LOOP UNTIL EOF(42)
CLOSE #42
IF oldsaveamount = 0 THEN
    REM if no old saves are found
    LET scriptname$ = "nooldsaves"
    LET mapscript = 5
    GOSUB script
    LET temp48$ = ""
    IF ros$ = "win" THEN SHELL _HIDE "del " + dloc$ + "oldsaves.tmp"
    IF ros$ = "lnx" OR ros$ = "mac" THEN SHELL _HIDE "rm " + dloc$ + "oldsaves.tmp"
    RETURN
END IF
IF oldsaveamount > 9 THEN
    REM removes saves deemed too old
    LET temp162 = oldsaveamount - 9
    LET x = 0
    OPEN dloc$ + "oldsaves.tmp" FOR INPUT AS #42
    DO
        INPUT #42, temp48$
        LET findoldsave% = INSTR(findoldsave% + 1, temp48$, ".old")
        IF findoldsave% THEN
            LET x = x + 1
            IF ros$ = "win" THEN SHELL _HIDE "del " + sloc$ + temp48$
            IF ros$ = "lnx" OR ros$ = "mac" THEN SHELL _HIDE "rm " + sloc$ + temp48$
            REM tells console
            LET eventtitle$ = "LEGACY SAVE REMOVED:"
            LET eventdata$ = sloc$ + temp48$
            LET eventnumber = x
            GOSUB consoleprinter
        END IF
        LET findoldsave% = 0
    LOOP UNTIL x = temp162
    CLOSE #42
    REM scrubs values
    LET x = 0
    LET temp162 = 0
    REM removes list file
    IF ros$ = "win" THEN SHELL _HIDE "del " + dloc$ + "oldsaves.tmp"
    IF ros$ = "lnx" OR ros$ = "mac" THEN SHELL _HIDE "rm " + dloc$ + "oldsaves.tmp"
    GOTO saverestore: REM loops back to start
END IF
REM tells console
LET eventtitle$ = "MENU LOADED:"
LET eventdata$ = "save restore menu"
LET eventnumber = 0
GOSUB consoleprinter
REM loads menu backdrop
LET restoremenubackdrop$ = "restoremenu"
LET restoremenubackdrop = _LOADIMAGE(menuloc$ + restoremenubackdrop$ + ".png")
REM displays save restore menu
LET x = 1
LET xx = 1
LET restoremenu = 1
DO
    CLS
    _PUTIMAGE (0, 0)-(resx - 1, resy - 1), restoremenubackdrop
    OPEN dloc$ + "oldsaves.tmp" FOR INPUT AS #42
    COLOR _RGBA(letmenudefaultcolourr, letmenudefaultcolourg, letmenudefaultcolourb, letmenudefaultcoloura), _RGBA(bgmenudefaultcolourr, bgmenudefaultcolourg, bgmenudefaultcolourb, bgmenudefaultcoloura)
    PRINT "SELECT SAVE TO RESTORE:": PRINT
    IF x = xx THEN
        COLOR _RGBA(letmenuselectcolourr, letmenuselectcolourg, letmenuselectcolourb, letmenuselectcoloura), _RGBA(bgmenuselectcolourr, bgmenuselectcolourg, bgmenuselectcolourb, bgmenuselectcoloura)
    ELSE
        COLOR _RGBA(letmenudefaultcolourr, letmenudefaultcolourg, letmenudefaultcolourb, letmenudefaultcoloura), _RGBA(bgmenudefaultcolourr, bgmenudefaultcolourg, bgmenudefaultcolourb, bgmenudefaultcoloura)
    END IF
    PRINT "BACK"
    DO
        INPUT #42, temp48$
        LET findoldsave% = INSTR(findoldsave% + 1, temp48$, ".old")
        IF findoldsave% THEN
            REM seperates date from old save
            LET x = x + 1
            LET oldsavename$ = MID$(temp48$, 9, LEN(temp48$) - 12)
            REM sets colour
            IF x = xx THEN
                COLOR _RGBA(letmenuselectcolourr, letmenuselectcolourg, letmenuselectcolourb, letmenuselectcoloura), _RGBA(bgmenuselectcolourr, bgmenuselectcolourg, bgmenuselectcolourb, bgmenuselectcoloura)
            ELSE
                COLOR _RGBA(letmenudefaultcolourr, letmenudefaultcolourg, letmenudefaultcolourb, letmenudefaultcoloura), _RGBA(bgmenudefaultcolourr, bgmenudefaultcolourg, bgmenudefaultcolourb, bgmenudefaultcoloura)
            END IF
            REM prints name
            PRINT oldsavename$
        END IF
        LET findoldsave% = 0
    LOOP UNTIL EOF(42) OR x = 10
    CLOSE #42
    REM input loop
    DO
        LET dsr = _KEYHIT
        _LIMIT hertz
        GOSUB musicfadeout
        GOSUB musicfadein
    LOOP UNTIL dsr = ucontrolcode1 OR dsr = ucontrolcode2 OR dsr = ucontrolcode3 OR dsr = ucontrolcode4 OR dsr = dcontrolcode1 OR dsr = dcontrolcode2 OR dsr = dcontrolcode3 OR dsr = dcontrolcode4 OR dsr = scontrolcode1 OR dsr = scontrolcode2 OR dsr = scontrolcode3 OR dsr = scontrolcode4
    REM decides results from input
    REM up
    IF dsr = ucontrolcode1 OR dsr = ucontrolcode2 OR dsr = ucontrolcode3 OR dsr = ucontrolcode4 THEN
        LET xx = xx - 1
        IF xx < 1 THEN
            LET xx = 1
        ELSE
            LET playsfx$ = "move"
            GOSUB sfxplay
        END IF
    END IF
    REM down
    IF dsr = dcontrolcode1 OR dsr = dcontrolcode2 OR dsr = dcontrolcode3 OR dsr = dcontrolcode4 THEN
        LET xx = xx + 1
        IF xx > 10 OR xx > x THEN
            LET xx = x
        ELSE
            LET playsfx$ = "move"
            GOSUB sfxplay
        END IF
    END IF
    REM select
    IF dsr = scontrolcode1 OR dsr = scontrolcode2 OR dsr = scontrolcode3 OR dsr = scontrolcode4 THEN
        REM plays sound
        LET playsfx$ = "select"
        GOSUB sfxplay
        REM back
        IF xx = 1 THEN LET xxx = 1
        REM save restore
        IF xx > 1 THEN
            CLS
            _PUTIMAGE (0, 0)-(resx - 1, resy - 1), modmenubackdrop: REM redraws meny background
            LET scriptname$ = "restoreoldsave"
            LET mapscript = 5
            GOSUB script
            CLS
            _PUTIMAGE (0, 0)-(resx - 1, resy - 1), modmenubackdrop: REM redraws meny background
            FOR x = 1 TO 2
                IF x = 1 THEN LET choicename$(x) = "YES"
                IF x = 2 THEN LET choicename$(x) = "NO"
            NEXT x
            LET choicetotal = 2
            GOSUB choicebannerdraw
            LET choicetotal = 0
            IF choiceno = 1 THEN
                LET xxxx = 1
                REM show loading icon
                CLS
                _PUTIMAGE (1, 1)-((loadiconresx), loadiconresy), loadicon
                OPEN dloc$ + "oldsaves.tmp" FOR INPUT AS #42
                DO
                    REM detects selected save
                    INPUT #42, temp48$
                    LET findoldsave% = INSTR(findoldsave% + 1, temp48$, ".old")
                    IF findoldsave% THEN
                        LET xxxx = xxxx + 1
                    END IF
                    LET findoldsave% = 0
                LOOP UNTIL xxxx = xx
                CLOSE #42
                GOSUB savetime: REM updates time played in save file
                REM halt any timed scripts
                LET scripttimer = 0
                LET iscripttimer = 0
                LET scripttimername$ = ""
                REM erases save then restores old one
                IF ros$ = "win" THEN
                    IF _FILEEXISTS(sloc$ + "savedata" + DATE$ + ".old") THEN
                        LET x = 0
                        LET y = 0
                        DO
                            LET x = x + 1
                            IF _FILEEXISTS(sloc$ + "savedata" + DATE$ + "-" + LTRIM$(STR$(x)) + ".old") THEN
                                LET y = 0
                            ELSE
                                LET y = 1
                            END IF
                        LOOP UNTIL y = 1
                        SHELL _HIDE "copy " + sloc$ + "savedata.ddf " + sloc$ + "savedata" + DATE$ + "-" + LTRIM$(STR$(x)) + ".old"
                        LET x = 0
                        LET y = 0
                    ELSE
                        SHELL _HIDE "copy " + sloc$ + "savedata.ddf " + sloc$ + "savedata" + DATE$ + ".old"
                    END IF
                    SHELL _HIDE "del " + sloc$ + "savedata.ddf"
                    SHELL _HIDE "copy " + sloc$ + temp48$ + " " + sloc$ + "savedata.ddf"
                END IF
                IF ros$ = "lnx" OR ros$ = "mac" THEN
                    IF _FILEEXISTS(sloc$ + "savedata" + DATE$ + ".old") THEN
                        LET x = 0
                        LET y = 0
                        DO
                            LET x = x + 1
                            IF _FILEEXISTS(sloc$ + "savedata" + DATE$ + "-" + LTRIM$(STR$(x)) + ".old") THEN
                                LET y = 0
                            ELSE
                                LET y = 1
                            END IF
                        LOOP UNTIL y = 1
                        SHELL _HIDE "cp " + sloc$ + "savedata.ddf " + sloc$ + "savedata" + DATE$ + "-" + LTRIM$(STR$(x)) + ".old"
                        LET x = 0
                        LET y = 0
                    ELSE
                        SHELL _HIDE "cp " + sloc$ + "savedata.ddf " + sloc$ + "savedata" + DATE$ + ".old"
                    END IF
                    SHELL _HIDE "rm " + sloc$ + "savedata.ddf"
                    SHELL _HIDE "cp " + sloc$ + temp48$ + " " + sloc$ + "savedata.ddf"
                END IF
                REM tells console
                LET eventtitle$ = "SAVE RESTORED:"
                LET eventdata$ = sloc$ + temp48$
                LET eventnumber = 0
                GOSUB consoleprinter
                CLS
                IF setupboot = 0 THEN LET oldmapno = mapno: LET oldmplayermodel$ = mplayermodel$
                GOSUB saveload: REM loads new save data
                IF setupboot = 0 THEN GOSUB mainplayerload: GOSUB mapload
                LET scriptname$ = "saverestored"
                LET mapscript = 5
                GOSUB script
                REM re-enable any disabled controls
                LET ucontrol = 1
                LET dcontrol = 1
                LET lcontrol = 1
                LET rcontrol = 1
                LET scontrol = 1
                LET bcontrol = 1
                LET pcontrol = 1
                REM reset save time values
                LET sitime = TIMER
                LET stime = 0
                LET gametime = 0
                REM removes temp files
                IF ros$ = "win" THEN SHELL _HIDE "del " + dloc$ + "oldsaves.tmp"
                IF ros$ = "lnx" OR ros$ = "mac" THEN SHELL _HIDE "rm " + dloc$ + "oldsaves.tmp"
                LET restoremenu = 0
                LET x = 0: LET xx = 0: LET xxx = 0: LET xxxx = 0: LET dsr = 0: LET temp48$ = "": LET oldsaveamount = 0: LET oldsavename$ = "": REM scrub temp values
                RETURN
            END IF
        END IF
    END IF
    LET x = 1
LOOP UNTIL xxx = 1
REM removes temp files
IF ros$ = "win" THEN SHELL _HIDE "del " + dloc$ + "oldsaves.tmp"
IF ros$ = "lnx" OR ros$ = "mac" THEN SHELL _HIDE "rm " + dloc$ + "oldsaves.tmp"
LET restoremenu = 0
LET x = 0: LET xx = 0: LET xxx = 0: LET xxxx = 0: LET dsr = 0: LET temp161 = 0: LET temp48$ = "": LET oldsaveamount = 0: LET oldsavename$ = "": REM scrub temp values
_FREEIMAGE restoremenubackdrop
RETURN

displayconsole:
REM displays developer console
IF displayconsole = 0 THEN
    _CONSOLE ON
    _CONSOLETITLE title$ + " Console"
    LET displayconsole = 1
    LET scriptname$ = "devconsoleon"
    LET mapscript = 5
    GOSUB script
    RETURN
END IF
IF displayconsole = 1 THEN
    _CONSOLE OFF
    LET displayconsole = 0
    LET scriptname$ = "devconsoleoff"
    LET mapscript = 5
    GOSUB script
    RETURN
END IF
RETURN

sfxtoggle:
REM toggles sfx
IF liteload = 1 THEN RETURN
REM turn sfx on
IF soundmode = 1 THEN
    LET soundmode = 4
    LET eventtitle$ = "SOUND MODE SET:"
    LET eventdata$ = "sfx on"
    LET eventnumber = soundmode
    GOSUB consoleprinter
    GOSUB optionsave
    RETURN
END IF
IF soundmode = 3 THEN
    LET soundmode = 2
    LET eventtitle$ = "SOUND MODE SET:"
    LET eventdata$ = "sfx on"
    LET eventnumber = soundmode
    GOSUB consoleprinter
    GOSUB optionsave
    RETURN
END IF
REM turn sfx off
IF soundmode = 2 THEN
    LET soundmode = 3
    LET eventtitle$ = "SOUND MODE SET:"
    LET eventdata$ = "sfx off"
    LET eventnumber = soundmode
    GOSUB consoleprinter
    GOSUB optionsave
    RETURN
END IF
IF soundmode = 4 THEN
    LET soundmode = 1
    LET eventtitle$ = "SOUND MODE SET:"
    LET eventdata$ = "sfx off"
    LET eventnumber = soundmode
    GOSUB consoleprinter
    GOSUB optionsave
    RETURN
END IF
RETURN

musictoggle:
REM toggles music
IF liteload = 1 THEN RETURN
REM turn music on
IF soundmode = 1 THEN
    LET soundmode = 3
    GOSUB musicplay
    LET eventtitle$ = "SOUND MODE SET:"
    LET eventdata$ = "music on"
    LET eventnumber = soundmode
    GOSUB consoleprinter
    GOSUB optionsave
    RETURN
END IF
IF soundmode = 4 THEN
    LET soundmode = 2
    GOSUB musicplay
    LET eventtitle$ = "SOUND MODE SET:"
    LET eventdata$ = "music on"
    LET eventnumber = soundmode
    GOSUB consoleprinter
    GOSUB optionsave
    RETURN
END IF
REM turn music off
IF soundmode = 2 THEN
    GOSUB musicstop
    LET soundmode = 4
    LET eventtitle$ = "SOUND MODE SET:"
    LET eventdata$ = "music off"
    LET eventnumber = soundmode
    GOSUB consoleprinter
    GOSUB optionsave
    RETURN
END IF
IF soundmode = 3 THEN
    GOSUB musicstop
    LET soundmode = 1
    LET eventtitle$ = "SOUND MODE SET:"
    LET eventdata$ = "music off"
    LET eventnumber = soundmode
    GOSUB consoleprinter
    GOSUB optionsave
    RETURN
END IF
RETURN

screentoggle:
REM toggles screen modes
REM switch to window
IF screenmode = 1 THEN
    _FULLSCREEN _OFF
    LET screenmode = 2
    LET eventtitle$ = "SCREEN MODE SET:"
    LET eventdata$ = "windowed"
    LET eventnumber = screenmode
    GOSUB consoleprinter
    GOSUB optionsave
    RETURN
END IF
REM switch to fullscreen
IF screenmode = 2 THEN
    _FULLSCREEN _SQUAREPIXELS
    LET screenmode = 1
    LET eventtitle$ = "SCREEN MODE SET:"
    LET eventdata$ = "fullscreen"
    LET eventnumber = screenmode
    GOSUB consoleprinter
    GOSUB optionsave
    RETURN
END IF
RETURN

effectdraw:
REM draws special map effects
IF disablefade = 1 THEN RETURN: REM return for if effects are disabled
IF effectani = 1 THEN RETURN: REM return for if animation is playing
IF mapeffect = 1 THEN
    REM dark
    LINE (0, 0)-(resx, resy), _RGBA(0, 0, 0, (255 / 2)), BF
END IF
IF mapeffect = 2 THEN
    REM rain
    REM setup values
    LET rainspread = resx + (resy / 2)
    IF rainx1 = 0 THEN LET rainx1 = INT(RND * rainspread): LET rainy1 = INT(RND * resy)
    IF rainx2 = 0 THEN LET rainx2 = INT(RND * rainspread): LET rainy2 = INT(RND * resy)
    IF rainx3 = 0 THEN LET rainx3 = INT(RND * rainspread): LET rainy3 = INT(RND * resy)
    IF rainx4 = 0 THEN LET rainx4 = INT(RND * rainspread): LET rainy4 = INT(RND * resy)
    IF rainx5 = 0 THEN LET rainx5 = INT(RND * rainspread): LET rainy5 = INT(RND * resy)
    IF rainx6 = 0 THEN LET rainx6 = INT(RND * rainspread): LET rainy6 = INT(RND * resy)
    IF rainx7 = 0 THEN LET rainx7 = INT(RND * rainspread): LET rainy7 = INT(RND * resy)
    IF rainx8 = 0 THEN LET rainx8 = INT(RND * rainspread): LET rainy8 = INT(RND * resy)
    IF rainx9 = 0 THEN LET rainx9 = INT(RND * rainspread): LET rainy9 = INT(RND * resy)
    IF rainx10 = 0 THEN LET rainx10 = INT(RND * rainspread): LET rainy10 = INT(RND * resy)
    REM draws slight dark
    LINE (0, 0)-(resx, resy), _RGBA(0, 0, 0, 20), BF
    REM draws raindrops
    LINE (rainx1, rainy1)-(rainx1 - 2, rainy1 + 3), _RGBA(0, 89, 255, (255 / 2))
    LINE (rainx2, rainy2)-(rainx2 - 2, rainy2 + 3), _RGBA(0, 89, 255, (255 / 2))
    LINE (rainx3, rainy3)-(rainx3 - 2, rainy3 + 3), _RGBA(0, 89, 255, (255 / 2))
    LINE (rainx4, rainy4)-(rainx4 - 2, rainy4 + 3), _RGBA(0, 89, 255, (255 / 2))
    LINE (rainx5, rainy5)-(rainx5 - 2, rainy5 + 3), _RGBA(0, 89, 255, (255 / 2))
    LINE (rainx6, rainy6)-(rainx6 - 2, rainy6 + 3), _RGBA(0, 89, 255, (255 / 2))
    LINE (rainx7, rainy7)-(rainx7 - 2, rainy7 + 3), _RGBA(0, 89, 255, (255 / 2))
    LINE (rainx8, rainy8)-(rainx8 - 2, rainy8 + 3), _RGBA(0, 89, 255, (255 / 2))
    LINE (rainx9, rainy9)-(rainx9 - 2, rainy9 + 3), _RGBA(0, 89, 255, (255 / 2))
    LINE (rainx10, rainy10)-(rainx10 - 2, rainy10 + 3), _RGBA(0, 89, 255, (255 / 2))
    REM calculates movement
    IF rainy1 < resy / 4 THEN
        LET rainy1 = rainy1 + 4
        LET rainx1 = rainx1 - 2
    ELSE
        LET rainy1 = rainy1 + 8
        LET rainx1 = rainx1 - 4
    END IF
    IF rainy2 < resy / 4 THEN
        LET rainy2 = rainy2 + 4
        LET rainx2 = rainx2 - 2
    ELSE
        LET rainy2 = rainy2 + 8
        LET rainx2 = rainx2 - 4
    END IF
    IF rainy3 < resy / 4 THEN
        LET rainy3 = rainy3 + 4
        LET rainx3 = rainx3 - 2
    ELSE
        LET rainy3 = rainy3 + 8
        LET rainx3 = rainx3 - 4
    END IF
    IF rainy4 < resy / 4 THEN
        LET rainy4 = rainy4 + 4
        LET rainx4 = rainx4 - 2
    ELSE
        LET rainy4 = rainy4 + 8
        LET rainx4 = rainx4 - 4
    END IF
    IF rainy5 < resy / 4 THEN
        LET rainy5 = rainy5 + 4
        LET rainx5 = rainx5 - 2
    ELSE
        LET rainy5 = rainy5 + 8
        LET rainx5 = rainx5 - 4
    END IF
    IF rainy6 < resy / 4 THEN
        LET rainy6 = rainy6 + 4
        LET rainx6 = rainx6 - 2
    ELSE
        LET rainy6 = rainy6 + 8
        LET rainx6 = rainx6 - 4
    END IF
    IF rainy7 < resy / 4 THEN
        LET rainy7 = rainy7 + 4
        LET rainx7 = rainx7 - 2
    ELSE
        LET rainy7 = rainy7 + 8
        LET rainx7 = rainx7 - 4
    END IF
    IF rainy8 < resy / 4 THEN
        LET rainy8 = rainy8 + 4
        LET rainx8 = rainx8 - 2
    ELSE
        LET rainy8 = rainy8 + 8
        LET rainx8 = rainx8 - 4
    END IF
    IF rainy9 < resy / 4 THEN
        LET rainy9 = rainy9 + 4
        LET rainx9 = rainx9 - 2
    ELSE
        LET rainy9 = rainy9 + 8
        LET rainx9 = rainx9 - 4
    END IF
    IF rainy10 < resy / 4 THEN
        LET rainy10 = rainy10 + 4
        LET rainx10 = rainx10 - 2
    ELSE
        LET rainy10 = rainy10 + 8
        LET rainx10 = rainx10 - 4
    END IF
    REM resets rain drops
    IF rainy1 > resy THEN LET rainy1 = 0: LET rainx1 = INT(RND * rainspread)
    IF rainy2 > resy THEN LET rainy2 = 0: LET rainx2 = INT(RND * rainspread)
    IF rainy3 > resy THEN LET rainy3 = 0: LET rainx3 = INT(RND * rainspread)
    IF rainy4 > resy THEN LET rainy4 = 0: LET rainx4 = INT(RND * rainspread)
    IF rainy5 > resy THEN LET rainy5 = 0: LET rainx5 = INT(RND * rainspread)
    IF rainy6 > resy THEN LET rainy6 = 0: LET rainx6 = INT(RND * rainspread)
    IF rainy7 > resy THEN LET rainy7 = 0: LET rainx7 = INT(RND * rainspread)
    IF rainy8 > resy THEN LET rainy8 = 0: LET rainx8 = INT(RND * rainspread)
    IF rainy9 > resy THEN LET rainy9 = 0: LET rainx9 = INT(RND * rainspread)
    IF rainy10 > resy THEN LET rainy10 = 0: LET rainx10 = INT(RND * rainspread)
END IF
IF mapeffect = 3 THEN
    REM storm
    REM setup values
    LET rainspread = resx + (resy / 2)
    IF temp97 = 0 THEN LET temp97 = INT(RND * 60) + ctime
    IF rainx1 = 0 THEN LET rainx1 = INT(RND * rainspread): LET rainy1 = INT(RND * resy)
    IF rainx2 = 0 THEN LET rainx2 = INT(RND * rainspread): LET rainy2 = INT(RND * resy)
    IF rainx3 = 0 THEN LET rainx3 = INT(RND * rainspread): LET rainy3 = INT(RND * resy)
    IF rainx4 = 0 THEN LET rainx4 = INT(RND * rainspread): LET rainy4 = INT(RND * resy)
    IF rainx5 = 0 THEN LET rainx5 = INT(RND * rainspread): LET rainy5 = INT(RND * resy)
    IF rainx6 = 0 THEN LET rainx6 = INT(RND * rainspread): LET rainy6 = INT(RND * resy)
    IF rainx7 = 0 THEN LET rainx7 = INT(RND * rainspread): LET rainy7 = INT(RND * resy)
    IF rainx8 = 0 THEN LET rainx8 = INT(RND * rainspread): LET rainy8 = INT(RND * resy)
    IF rainx9 = 0 THEN LET rainx9 = INT(RND * rainspread): LET rainy9 = INT(RND * resy)
    IF rainx10 = 0 THEN LET rainx10 = INT(RND * rainspread): LET rainy10 = INT(RND * resy)
    IF rainx11 = 0 THEN LET rainx11 = INT(RND * rainspread): LET rainy11 = INT(RND * resy)
    IF rainx12 = 0 THEN LET rainx12 = INT(RND * rainspread): LET rainy12 = INT(RND * resy)
    IF rainx13 = 0 THEN LET rainx13 = INT(RND * rainspread): LET rainy13 = INT(RND * resy)
    IF rainx14 = 0 THEN LET rainx14 = INT(RND * rainspread): LET rainy14 = INT(RND * resy)
    IF rainx15 = 0 THEN LET rainx15 = INT(RND * rainspread): LET rainy15 = INT(RND * resy)
    IF rainx16 = 0 THEN LET rainx16 = INT(RND * rainspread): LET rainy16 = INT(RND * resy)
    IF rainx17 = 0 THEN LET rainx17 = INT(RND * rainspread): LET rainy17 = INT(RND * resy)
    IF rainx18 = 0 THEN LET rainx18 = INT(RND * rainspread): LET rainy18 = INT(RND * resy)
    IF rainx19 = 0 THEN LET rainx19 = INT(RND * rainspread): LET rainy19 = INT(RND * resy)
    IF rainx20 = 0 THEN LET rainx20 = INT(RND * rainspread): LET rainy20 = INT(RND * resy)
    REM draws dark
    IF temp97 > ctime THEN
        LINE (0, 0)-(resx, resy), _RGBA(0, 0, 0, (255 / 2)), BF
    ELSE
        LINE (0, 0)-(resx, resy), _RGBA(0, 0, 0, 20), BF
        LET temp98 = temp98 + 1
        IF temp98 > hertz THEN LET playsfx$ = "lightning": GOSUB sfxplay: LET temp98 = 0: LET temp97 = 0
    END IF
    REM draws raindrops
    LINE (rainx1, rainy1)-(rainx1 - 2, rainy1 + 3), _RGBA(0, 89, 255, 255)
    LINE (rainx2, rainy2)-(rainx2 - 2, rainy2 + 3), _RGBA(0, 89, 255, 255)
    LINE (rainx3, rainy3)-(rainx3 - 2, rainy3 + 3), _RGBA(0, 89, 255, 255)
    LINE (rainx4, rainy4)-(rainx4 - 2, rainy4 + 3), _RGBA(0, 89, 255, 255)
    LINE (rainx5, rainy5)-(rainx5 - 2, rainy5 + 3), _RGBA(0, 89, 255, 255)
    LINE (rainx6, rainy6)-(rainx6 - 2, rainy6 + 3), _RGBA(0, 89, 255, 255)
    LINE (rainx7, rainy7)-(rainx7 - 2, rainy7 + 3), _RGBA(0, 89, 255, 255)
    LINE (rainx8, rainy8)-(rainx8 - 2, rainy8 + 3), _RGBA(0, 89, 255, 255)
    LINE (rainx9, rainy9)-(rainx9 - 2, rainy9 + 3), _RGBA(0, 89, 255, 255)
    LINE (rainx10, rainy10)-(rainx10 - 2, rainy10 + 3), _RGBA(0, 89, 255, 255)
    LINE (rainx11, rainy11)-(rainx11 - 2, rainy11 + 3), _RGBA(0, 89, 255, 255)
    LINE (rainx12, rainy12)-(rainx12 - 2, rainy12 + 3), _RGBA(0, 89, 255, 255)
    LINE (rainx13, rainy13)-(rainx13 - 2, rainy13 + 3), _RGBA(0, 89, 255, 255)
    LINE (rainx14, rainy14)-(rainx14 - 2, rainy14 + 3), _RGBA(0, 89, 255, 255)
    LINE (rainx15, rainy15)-(rainx15 - 2, rainy15 + 3), _RGBA(0, 89, 255, 255)
    LINE (rainx16, rainy16)-(rainx16 - 2, rainy16 + 3), _RGBA(0, 89, 255, 255)
    LINE (rainx17, rainy17)-(rainx17 - 2, rainy17 + 3), _RGBA(0, 89, 255, 255)
    LINE (rainx18, rainy18)-(rainx18 - 2, rainy18 + 3), _RGBA(0, 89, 255, 255)
    LINE (rainx19, rainy19)-(rainx19 - 2, rainy19 + 3), _RGBA(0, 89, 255, 255)
    LINE (rainx20, rainy20)-(rainx20 - 2, rainy20 + 3), _RGBA(0, 89, 255, 255)
    REM calculates movement
    IF rainy1 < resy / 4 THEN
        LET rainy1 = rainy1 + 4
        LET rainx1 = rainx1 - 2
    ELSE
        LET rainy1 = rainy1 + 8
        LET rainx1 = rainx1 - 4
    END IF
    IF rainy2 < resy / 4 THEN
        LET rainy2 = rainy2 + 4
        LET rainx2 = rainx2 - 2
    ELSE
        LET rainy2 = rainy2 + 8
        LET rainx2 = rainx2 - 4
    END IF
    IF rainy3 < resy / 4 THEN
        LET rainy3 = rainy3 + 4
        LET rainx3 = rainx3 - 2
    ELSE
        LET rainy3 = rainy3 + 8
        LET rainx3 = rainx3 - 4
    END IF
    IF rainy4 < resy / 4 THEN
        LET rainy4 = rainy4 + 4
        LET rainx4 = rainx4 - 2
    ELSE
        LET rainy4 = rainy4 + 8
        LET rainx4 = rainx4 - 4
    END IF
    IF rainy5 < resy / 4 THEN
        LET rainy5 = rainy5 + 4
        LET rainx5 = rainx5 - 2
    ELSE
        LET rainy5 = rainy5 + 8
        LET rainx5 = rainx5 - 4
    END IF
    IF rainy6 < resy / 4 THEN
        LET rainy6 = rainy6 + 4
        LET rainx6 = rainx6 - 2
    ELSE
        LET rainy6 = rainy6 + 8
        LET rainx6 = rainx6 - 4
    END IF
    IF rainy7 < resy / 4 THEN
        LET rainy7 = rainy7 + 4
        LET rainx7 = rainx7 - 2
    ELSE
        LET rainy7 = rainy7 + 8
        LET rainx7 = rainx7 - 4
    END IF
    IF rainy8 < resy / 4 THEN
        LET rainy8 = rainy8 + 4
        LET rainx8 = rainx8 - 2
    ELSE
        LET rainy8 = rainy8 + 8
        LET rainx8 = rainx8 - 4
    END IF
    IF rainy9 < resy / 4 THEN
        LET rainy9 = rainy9 + 4
        LET rainx9 = rainx9 - 2
    ELSE
        LET rainy9 = rainy9 + 8
        LET rainx9 = rainx9 - 4
    END IF
    IF rainy10 < resy / 4 THEN
        LET rainy10 = rainy10 + 4
        LET rainx10 = rainx10 - 2
    ELSE
        LET rainy10 = rainy10 + 8
        LET rainx10 = rainx10 - 4
    END IF
    IF rainy11 < resy / 4 THEN
        LET rainy11 = rainy11 + 4
        LET rainx11 = rainx11 - 2
    ELSE
        LET rainy11 = rainy11 + 8
        LET rainx11 = rainx11 - 4
    END IF
    IF rainy12 < resy / 4 THEN
        LET rainy12 = rainy12 + 4
        LET rainx12 = rainx12 - 2
    ELSE
        LET rainy12 = rainy12 + 8
        LET rainx12 = rainx12 - 4
    END IF
    IF rainy13 < resy / 4 THEN
        LET rainy13 = rainy13 + 4
        LET rainx13 = rainx13 - 2
    ELSE
        LET rainy13 = rainy13 + 8
        LET rainx13 = rainx13 - 4
    END IF
    IF rainy14 < resy / 4 THEN
        LET rainy14 = rainy14 + 4
        LET rainx14 = rainx14 - 2
    ELSE
        LET rainy14 = rainy14 + 8
        LET rainx14 = rainx14 - 4
    END IF
    IF rainy15 < resy / 4 THEN
        LET rainy15 = rainy15 + 4
        LET rainx15 = rainx15 - 2
    ELSE
        LET rainy15 = rainy15 + 8
        LET rainx15 = rainx15 - 4
    END IF
    IF rainy16 < resy / 4 THEN
        LET rainy16 = rainy16 + 4
        LET rainx16 = rainx16 - 2
    ELSE
        LET rainy16 = rainy16 + 8
        LET rainx16 = rainx16 - 4
    END IF
    IF rainy17 < resy / 4 THEN
        LET rainy17 = rainy17 + 4
        LET rainx17 = rainx17 - 2
    ELSE
        LET rainy17 = rainy17 + 8
        LET rainx17 = rainx17 - 4
    END IF
    IF rainy18 < resy / 4 THEN
        LET rainy18 = rainy18 + 4
        LET rainx18 = rainx18 - 2
    ELSE
        LET rainy18 = rainy18 + 8
        LET rainx18 = rainx18 - 4
    END IF
    IF rainy19 < resy / 4 THEN
        LET rainy19 = rainy19 + 4
        LET rainx19 = rainx19 - 2
    ELSE
        LET rainy19 = rainy19 + 8
        LET rainx19 = rainx19 - 4
    END IF
    IF rainy20 < resy / 4 THEN
        LET rainy20 = rainy20 + 4
        LET rainx20 = rainx20 - 2
    ELSE
        LET rainy20 = rainy20 + 8
        LET rainx20 = rainx20 - 4
    END IF
    REM resets rain drops
    IF rainy1 > resy THEN LET rainy1 = 0: LET rainx1 = INT(RND * rainspread)
    IF rainy2 > resy THEN LET rainy2 = 0: LET rainx2 = INT(RND * rainspread)
    IF rainy3 > resy THEN LET rainy3 = 0: LET rainx3 = INT(RND * rainspread)
    IF rainy4 > resy THEN LET rainy4 = 0: LET rainx4 = INT(RND * rainspread)
    IF rainy5 > resy THEN LET rainy5 = 0: LET rainx5 = INT(RND * rainspread)
    IF rainy6 > resy THEN LET rainy6 = 0: LET rainx6 = INT(RND * rainspread)
    IF rainy7 > resy THEN LET rainy7 = 0: LET rainx7 = INT(RND * rainspread)
    IF rainy8 > resy THEN LET rainy8 = 0: LET rainx8 = INT(RND * rainspread)
    IF rainy9 > resy THEN LET rainy9 = 0: LET rainx9 = INT(RND * rainspread)
    IF rainy10 > resy THEN LET rainy10 = 0: LET rainx10 = INT(RND * rainspread)
    IF rainy11 > resy THEN LET rainy11 = 0: LET rainx11 = INT(RND * rainspread)
    IF rainy12 > resy THEN LET rainy12 = 0: LET rainx12 = INT(RND * rainspread)
    IF rainy13 > resy THEN LET rainy13 = 0: LET rainx13 = INT(RND * rainspread)
    IF rainy14 > resy THEN LET rainy14 = 0: LET rainx14 = INT(RND * rainspread)
    IF rainy15 > resy THEN LET rainy15 = 0: LET rainx15 = INT(RND * rainspread)
    IF rainy16 > resy THEN LET rainy16 = 0: LET rainx16 = INT(RND * rainspread)
    IF rainy17 > resy THEN LET rainy17 = 0: LET rainx17 = INT(RND * rainspread)
    IF rainy18 > resy THEN LET rainy18 = 0: LET rainx18 = INT(RND * rainspread)
    IF rainy19 > resy THEN LET rainy19 = 0: LET rainx19 = INT(RND * rainspread)
    IF rainy20 > resy THEN LET rainy20 = 0: LET rainx20 = INT(RND * rainspread)
END IF
IF mapeffect = 4 THEN
    REM torch effect
    _PUTIMAGE (0, 0)-(resx, resy), torcheffect
END IF
IF mapeffect = 5 THEN
    REM sunset/dark fade (right)
    LET temp123 = (((resx / 2) - posx) / mapx) * (255 / 2)
    LINE (0, 0)-(resx, resy), _RGBA(0, 0, 0, temp123), BF
END IF
IF mapeffect = 6 THEN
    REM sunset/dark fade (left)
    LET temp123 = (((resx / 2) - posx) / mapx) * (255 / 2)
    LET temp124 = (255 / 2) - temp123
    LINE (0, 0)-(resx, resy), _RGBA(0, 0, 0, temp124), BF
END IF
IF mapeffect = 7 THEN
    REM sunset/dark fade (down)
    LET temp123 = (((resy / 2) - posy) / mapy) * (255 / 2)
    LINE (0, 0)-(resx, resy), _RGBA(0, 0, 0, temp123), BF
END IF
IF mapeffect = 8 THEN
    REM sunset/dark fade (up)
    LET temp123 = (((resy / 2) - posy) / mapy) * (255 / 2)
    LET temp124 = (255 / 2) - temp123
    LINE (0, 0)-(resx, resy), _RGBA(0, 0, 0, temp124), BF
END IF
IF mapeffect = 9 THEN
    REM pitch black
    LINE (0, 0)-(resx, resy), _RGBA(0, 0, 0, 255), BF
END IF
RETURN

scriptnametrim:
REM trims script name as required by the script 'if' commands
IF temp201 = 1 THEN LET scriptnametrim = 14: REM ifcheckpoint
IF temp201 = 2 THEN LET scriptnametrim = 12: REM ifcurrency
IF temp201 = 3 THEN LET scriptnametrim = 13: REM ifdirection
IF temp201 = 4 THEN LET scriptnametrim = 10: REM ifpocket
IF temp201 = 5 THEN LET scriptnametrim = 11: REM ifholding
IF temp201 = 6 THEN LET scriptnametrim = 9: REM ifmodel
IF temp201 = 7 THEN LET scriptnametrim = 9: REM ifmapno
IF temp201 = 8 THEN LET scriptnametrim = 8: REM ifgone
IF temp201 = 9 THEN LET scriptnametrim = 10: REM ifrandom
IF temp201 = 10 THEN LET scriptnametrim = 9: REM ifvalue
IF temp201 = 11 THEN LET scriptnametrim = 9: REM ifaward
RETURN

erasesave:
REM erases save data
REM checks if save controls are enabled
IF nosave = 1 THEN
    LET textspeech$ = "Save controls are disabled!"
    GOSUB textbannerdraw
    CLS
    RETURN
END IF
LET erasesave = 1
GOSUB savetime: REM updates time played in save file
REM checks default save file exists
IF _FILEEXISTS(sloc$ + "defaultsave.ddf") THEN
    REM nothing
ELSE
    ERROR 422
END IF
REM show loading icon
CLS
_PUTIMAGE (1, 1)-((loadiconresx), loadiconresy), loadicon
REM halt any timed scripts
LET scripttimer = 0
LET iscripttimer = 0
LET scripttimername$ = ""
REM Linux
IF ros$ = "lnx" OR ros$ = "mac" THEN
    IF _FILEEXISTS(sloc$ + "savedata" + DATE$ + ".old") THEN
        LET x = 0
        LET y = 0
        DO
            LET x = x + 1
            IF _FILEEXISTS(sloc$ + "savedata" + DATE$ + "-" + LTRIM$(STR$(x)) + ".old") THEN
                LET y = 0
            ELSE
                LET y = 1
            END IF
        LOOP UNTIL y = 1
        SHELL _HIDE "cp " + sloc$ + "savedata.ddf " + sloc$ + "savedata" + DATE$ + "-" + LTRIM$(STR$(x)) + ".old"
        LET x = 0
        LET y = 0
    ELSE
        SHELL _HIDE "cp " + sloc$ + "savedata.ddf " + sloc$ + "savedata" + DATE$ + ".old"
    END IF
    SHELL _HIDE "rm " + sloc$ + "savedata.ddf"
    SHELL _HIDE "cp " + sloc$ + "defaultsave.ddf " + sloc$ + "savedata.ddf"
END IF
REM windows
IF ros$ = "win" THEN
    IF _FILEEXISTS(sloc$ + "savedata" + DATE$ + ".old") THEN
        LET x = 0
        LET y = 0
        DO
            LET x = x + 1
            IF _FILEEXISTS(sloc$ + "savedata" + DATE$ + "-" + LTRIM$(STR$(x)) + ".old") THEN
                LET y = 0
            ELSE
                LET y = 1
            END IF
        LOOP UNTIL y = 1
        SHELL _HIDE "copy " + sloc$ + "savedata.ddf " + sloc$ + "savedata" + DATE$ + "-" + LTRIM$(STR$(x)) + ".old"
        LET x = 0
        LET y = 0
    ELSE
        SHELL _HIDE "copy " + sloc$ + "savedata.ddf " + sloc$ + "savedata" + DATE$ + ".old"
    END IF
    SHELL _HIDE "del " + sloc$ + "savedata.ddf"
    SHELL _HIDE "copy " + sloc$ + "defaultsave.ddf " + sloc$ + "savedata.ddf"
END IF
REM tells console
LET eventtitle$ = "SAVEDATA ERASED:"
LET eventdata$ = sloc$ + "savedata.ddf"
LET eventnumber = 0
GOSUB consoleprinter
CLS
IF setupboot = 0 THEN LET oldmapno = mapno: LET oldmplayermodel$ = mplayermodel$
GOSUB saveload: REM loads new save data
IF setupboot = 0 THEN GOSUB mainplayerload: GOSUB mapload
LET scriptname$ = "saveerased"
LET mapscript = 5
GOSUB script
REM reset save time values
LET sitime = TIMER
LET stime = 0
LET gametime = 0
LET erasesave = 0
RETURN

mapload:
REM loads map data
REM unload divert if map has changed and if system is not booting
IF setupboot = 0 THEN IF mapno <> oldmapno THEN GOSUB playerunload: GOSUB objectunload: GOSUB mapunload
IF setupboot = 0 AND oldmapno = mapno THEN RETURN: REM divert for if mapno hasn't actually changed
REM sets path location data of map metadata
LET mapfile$ = "map" + LTRIM$(STR$(mapno))
LET mapdir$ = "m" + LTRIM$(STR$(mapno)) + "/"
REM loads metadata
OPEN mloc$ + "/" + mapdir$ + "/" + mapfile$ + ".ddf" FOR INPUT AS #1
INPUT #1, mapname$, playmusic$, mapeffect, parallaxmode, mapx, mapy, mapobjectno, mapplayerno, maptriggerno
REM loads map bitmaps
LET mapa = _LOADIMAGE(mloc$ + mapdir$ + mapfile$ + "a.png")
LET mapb = _LOADIMAGE(mloc$ + mapdir$ + mapfile$ + "b.png")
IF parallaxmode > 0 THEN LET mapp1 = _LOADIMAGE(mloc$ + mapdir$ + mapfile$ + "p1.png"): LET mapp2 = _LOADIMAGE(mloc$ + mapdir$ + mapfile$ + "p2.png"): REM loads optional parallax map
REM loads objects
LET x = 0
DO
    LET x = x + 1
    INPUT #1, objectname(x), objectx(x), objecty(x)
LOOP UNTIL x >= totalobjects
REM loads NPCs
LET x = 0
DO
    LET x = x + 1
    INPUT #1, playername(x), playerx(x), playery(x), mplayerx(x), mplayery(x), playergrace(x), playerdefault(x)
LOOP UNTIL x >= totalplayers
REM loads triggers
LET x = 0
DO
    LET x = x + 1
    INPUT #1, triggername(x), triggerx1(x), triggery1(x), triggerx2(x), triggery2(x)
LOOP UNTIL x >= totaltriggers
LET x = 0
CLOSE #1
REM console printer
LET eventtitle$ = "MAP LOADED: "
LET eventdata$ = mapname$
LET eventnumber = mapno
GOSUB consoleprinter
REM diverts to object loader if required
IF mapobjectno > 0 THEN
    GOSUB objectload
ELSE
    LET eventtitle$ = "NO OBJECTS ATTACHED TO MAP"
    LET eventdata$ = ""
    LET eventnumber = 0
    GOSUB consoleprinter
END IF
REM diverts to NPC loader if required
IF mapplayerno > 0 THEN
    GOSUB playerload
    IF carryvalues = 1 THEN GOSUB carryplayervalues
ELSE
    LET eventtitle$ = "NO PLAYERS ATTACHED TO MAP"
    LET eventdata$ = ""
    LET eventnumber = 0
    GOSUB consoleprinter
END IF
REM generates animation offsets
GOSUB generateoffsets
REM sets all triggers as on and unactive
LET x = 0
DO
    LET x = x + 1
    LET triggerd(x) = 1
    LET triggera(x) = 0
LOOP UNTIL x >= maptriggerno
REM plays music
IF playmusic$ <> "" THEN GOSUB musicplay
REM fades in
IF setupboot = 0 AND scriptrun = 0 THEN GOSUB fadein
RETURN

carryplayervalues:
REM carries storied player values into new map
LET x = 0
DO
    LET x = x + 1
    LET playerx(x) = carryplayerx(x): LET playery(x) = carryplayery(x)
    LET playerd(x) = carryplayerx(x): LET playerjourney(x) = carryplayerjourney(x)
    LET playerlayer(x) = carryplayerlayer(x): LET playerperiod(x) = carryplayerperiod(x)
    LET carryplayerx(x) = 0: LET carryplayery(x) = 0
    LET carryplayerd(x) = 0: LET carryplayerjourney(x) = 0
    LET carryplayerlayer(x) = 0: LET carryplayerperiod(x) = 0
LOOP UNTIL x >= totalplayers
LET carryvalues = 0: REM turns off value carrying
LET eventtitle$ = "PLAYER LOCATION VALUES CARRIED!"
LET eventdata$ = ""
LET eventnumber = 0
GOSUB consoleprinter
LET x = 0
RETURN

objectunload:
REM unloads all map objects
IF mapobjectno > 0 THEN
    REM unloads objects if map has any
    DO
        LET temp14 = temp14 + 1
        IF objectname(temp14) <> "[COLLISIONONLY]" THEN _FREEIMAGE objecta(temp14): _FREEIMAGE objectb(temp14): LET temp11$ = objectname(temp14)
        REM prints to console
        IF temp11$ = "" THEN LET temp11$ = "[COLLISIONONLY]"
        LET eventtitle$ = "OBJECT UNLOADED:"
        LET eventdata$ = temp11$
        LET eventnumber = temp14
        GOSUB consoleprinter
    LOOP UNTIL temp14 >= mapobjectno
ELSE
    REM prints to console that map has no objects to unload
    LET eventtitle$ = "NO OBJECTS ATTACHED TO MAP"
    LET eventdata$ = ""
    LET eventnumber = 0
    GOSUB consoleprinter
END IF
LET temp14 = 0: LET temp11$ = "": REM scrub temp values
RETURN

playerload:
REM loads any NPCs into memory
DO
    REM loads sprites and metadata
    LET temp39 = temp39 + 1
    LET temp13$ = playername(temp39): LET temp40 = playerx(temp39): LET temp41 = playery(temp39)
    OPEN ploc$ + temp13$ + "/" + temp13$ + ".ddf" FOR INPUT AS #1
    INPUT #1, playerlongname$(temp39), playerresx(temp39), playerresy(temp39), players(temp39), playernote1(temp39), playernote2(temp39), playerlayer2(temp39), playerspeed(temp39), playercollision(temp39)
    LET playerf(temp39) = _LOADIMAGE(ploc$ + "/" + temp13$ + "/" + temp13$ + "-f.png")
    LET playerb(temp39) = _LOADIMAGE(ploc$ + "/" + temp13$ + "/" + temp13$ + "-b.png")
    LET playerl(temp39) = _LOADIMAGE(ploc$ + "/" + temp13$ + "/" + temp13$ + "-l.png")
    LET playerr(temp39) = _LOADIMAGE(ploc$ + "/" + temp13$ + "/" + temp13$ + "-r.png")
    LET playerfl(temp39) = _LOADIMAGE(ploc$ + "/" + temp13$ + "/" + temp13$ + "-fl.png")
    LET playerfr(temp39) = _LOADIMAGE(ploc$ + "/" + temp13$ + "/" + temp13$ + "-fr.png")
    LET playerbl(temp39) = _LOADIMAGE(ploc$ + "/" + temp13$ + "/" + temp13$ + "-bl.png")
    LET playerbr(temp39) = _LOADIMAGE(ploc$ + "/" + temp13$ + "/" + temp13$ + "-br.png")
    LET playerrl(temp39) = _LOADIMAGE(ploc$ + "/" + temp13$ + "/" + temp13$ + "-rl.png")
    LET playerrr(temp39) = _LOADIMAGE(ploc$ + "/" + temp13$ + "/" + temp13$ + "-rr.png")
    LET playerll(temp39) = _LOADIMAGE(ploc$ + "/" + temp13$ + "/" + temp13$ + "-ll.png")
    LET playerlr(temp39) = _LOADIMAGE(ploc$ + "/" + temp13$ + "/" + temp13$ + "-lr.png")
    LET playerfi1(temp39) = _LOADIMAGE(ploc$ + "/" + temp13$ + "/" + temp13$ + "-fi1.png")
    LET playerfi2(temp39) = _LOADIMAGE(ploc$ + "/" + temp13$ + "/" + temp13$ + "-fi2.png")
    LET playerbi1(temp39) = _LOADIMAGE(ploc$ + "/" + temp13$ + "/" + temp13$ + "-bi1.png")
    LET playerbi2(temp39) = _LOADIMAGE(ploc$ + "/" + temp13$ + "/" + temp13$ + "-bi2.png")
    LET playerli1(temp39) = _LOADIMAGE(ploc$ + "/" + temp13$ + "/" + temp13$ + "-li1.png")
    LET playerli2(temp39) = _LOADIMAGE(ploc$ + "/" + temp13$ + "/" + temp13$ + "-li2.png")
    LET playerri1(temp39) = _LOADIMAGE(ploc$ + "/" + temp13$ + "/" + temp13$ + "-ri1.png")
    LET playerri2(temp39) = _LOADIMAGE(ploc$ + "/" + temp13$ + "/" + temp13$ + "-ri2.png")
    LET playerface1(temp39) = _LOADIMAGE(ploc$ + "/" + temp13$ + "/" + temp13$ + "-face1.png")
    LET playerface2(temp39) = _LOADIMAGE(ploc$ + "/" + temp13$ + "/" + temp13$ + "-face2.png")
    CLOSE #1: REM closes metadata
    REM wipes walking and direction values to default
    LET playerwalking(temp39) = 0
    LET playerd(temp39) = playerdefault(temp39)
    LET playerperiod(temp39) = playergrace(temp39) + INT(ctime)
    LET dplayerx(temp39) = playerx(temp39)
    LET dplayery(temp39) = playery(temp39)
    LET playerjourney(temp39) = 1
    LET pfoot(temp39) = 1
    LET playerscript(temp39) = 0
    REM checks for culling options
    LET findculling% = 0
    LET findculling% = INSTR(findculling% + 1, playername$(temp39), "(nocull)")
    IF findculling% THEN
        LET autoplayercull(temp39) = 0
    ELSE
        LET autoplayercull(temp39) = 1
    END IF
    REM console printer
    LET eventtitle$ = "PLAYER LOADED:"
    LET eventdata$ = temp13$
    LET eventnumber = temp39
    GOSUB consoleprinter
LOOP UNTIL temp39 >= mapplayerno
LET temp39 = 0: LET temp13$ = "": LET temp40 = 0: LET temp14$ = "": LET temp41 = 0: REM scrub temp values
RETURN

playerunload:
REM unloads all NPCs
IF scriptrun = 0 AND mainmenu = 0 THEN GOSUB fadeout: REM fades out
IF userquit = 1 THEN _PUTIMAGE (1, 1)-((loadiconresx), loadiconresy), loadicon
IF mapplayerno > 0 THEN
    REM unloads players if map has any
    DO
        LET temp41 = temp41 + 1
        _FREEIMAGE playerf(temp41)
        _FREEIMAGE playerb(temp41)
        _FREEIMAGE playerr(temp41)
        _FREEIMAGE playerl(temp41)
        _FREEIMAGE playerfr(temp41)
        _FREEIMAGE playerfl(temp41)
        _FREEIMAGE playerbr(temp41)
        _FREEIMAGE playerbl(temp41)
        _FREEIMAGE playerlr(temp41)
        _FREEIMAGE playerll(temp41)
        _FREEIMAGE playerrr(temp41)
        _FREEIMAGE playerrl(temp41)
        _FREEIMAGE playerfi1(temp41)
        _FREEIMAGE playerfi2(temp41)
        _FREEIMAGE playerbi1(temp41)
        _FREEIMAGE playerbi2(temp41)
        _FREEIMAGE playerli1(temp41)
        _FREEIMAGE playerli2(temp41)
        _FREEIMAGE playerri1(temp41)
        _FREEIMAGE playerri2(temp41)
        _FREEIMAGE playerface1(temp41)
        _FREEIMAGE playerface2(temp41)
        LET temp14$ = playername$(temp41)
        REM prints to console
        LET eventtitle$ = "PLAYER UNLOADED:"
        LET eventdata$ = temp14$
        LET eventnumber = temp41
        GOSUB consoleprinter
    LOOP UNTIL temp41 >= mapplayerno
ELSE
    REM prints to console that map has no NPCs to unload
    LET eventtitle$ = "NO PLAYERS ATTACHED TO MAP"
    LET eventdata$ = ""
    LET eventnumber = 0
    GOSUB consoleprinter
END IF
LET temp41 = 0: LET temp14$ = "": REM scrub temp values
RETURN

collisionconverter:
REM converts map data into collision data
LET temp141 = objectx(temp10): LET temp142 = objecty(temp10)
REM converts values
LET temp36$ = STR$(temp141)
LET temp37$ = STR$(temp142)
REM first X + Y
LET temp38$ = LEFT$(temp36$, INSTR(temp36$, ".") - 1)
LET temp39$ = MID$(temp36$, INSTR(temp36$, ".") + 1)
LET temp143 = VAL(temp38$)
LET temp144 = VAL(temp39$)
REM second X + Y
LET temp40$ = LEFT$(temp37$, INSTR(temp37$, ".") - 1)
LET temp41$ = MID$(temp37$, INSTR(temp37$, ".") + 1)
LET temp145 = VAL(temp40$)
LET temp146 = VAL(temp41$)
REM tells console
LET eventtitle$ = "COLLISION MAPPED:"
LET eventdata$ = "x1:" + STR$(temp143) + " y1:" + STR$(temp144) + " x2:" + STR$(temp145 + temp143) + " y2:" + STR$(temp146 + temp144)
LET eventnumber = temp10
GOSUB consoleprinter
REM applies values
LET objectx(temp10) = temp143: LET objecty(temp10) = temp144: LET objectresx(temp10) = temp145: LET objectresy(temp10) = temp146: LET objects(temp10) = collisionstep
LET temp141 = 0: LET temp142 = 0: LET temp143 = 0: LET temp144 = 0: LET temp145 = 0: LET temp146 = 0: LET temp36$ = "": LET temp37$ = "": LET temp38$ = "": LET temp39$ = "": LET temp40$ = "": LET temp41$ = "": REM scrub temp values
RETURN

objectload:
REM loads any map objects into memory
DO
    LET temp10 = temp10 + 1
    LET temp10$ = objectname(temp10): LET temp11 = objectx(temp10): LET temp12 = objecty(temp10)
    IF objectname(temp10) <> "[COLLISIONONLY]" THEN
        OPEN oloc$ + temp10$ + "/" + temp10$ + ".ddf" FOR INPUT AS #1
        INPUT #1, objectlongname$(temp10), objectresx(temp10), objectresy(temp10), objects(temp10), objectlayer(temp10), objectspeed(temp10), objectcollision(temp10): LET objecta(temp10) = _LOADIMAGE(oloc$ + temp10$ + "/" + temp10$ + "a.png"): LET objectb(temp10) = _LOADIMAGE(oloc$ + temp10$ + "/" + temp10$ + "b.png")
        CLOSE #1
    ELSE
        GOSUB collisionconverter
    END IF
    REM checks for culling options
    LET findculling% = 0
    LET findculling% = INSTR(findculling% + 1, objectname$(temp10), "(nocull)")
    IF findculling% THEN
        LET autoobjectcull(temp10) = 0
    ELSE
        LET autoobjectcull(temp10) = 1
    END IF
    REM console printer
    LET eventtitle$ = "OBJECT LOADED:"
    LET eventdata$ = temp10$
    LET eventnumber = temp10
    GOSUB consoleprinter
LOOP UNTIL temp10 >= mapobjectno
LET temp10 = 0: LET temp10$ = "": LET temp11 = 0: LET temp11$ = "": LET temp12 = 0: REM scrub temp values
RETURN

timeframecounter:
REM time + frame counter
IF scriptrun = 0 THEN IF _EXIT THEN GOSUB endgamemenu: REM ends game on window
LET missingasset = 0: LET asset$ = "": REM scrubs missing asset error reporting values
IF TIMER < 0 OR ctime < 0 THEN
    REM resets timer when value wraparound occurs
    RANDOMIZE TIMER
    LET itime = TIMER
    IF ctime > 0 THEN
        LET eventtitle$ = "TIMER RESET:"
    ELSE
        LET eventtitle$ = "COUNTER RESET:"
    END IF
    LET eventdata$ = TIME$
    LET eventnumber = frames
    GOSUB consoleprinter
    REM resets script timer if required
    IF scripttimer > 0 THEN
        LET ctime = (TIMER - itime)
        LET iscripttimer = INT(ctime)
        LET eventtitle$ = "SCRIPT TIMER RESET:"
        LET eventdata$ = scripttimername$
        LET eventnumber = scripttimer
        GOSUB consoleprinter
    END IF
END IF
LET ctime = (TIMER - itime): REM time keeper
REM save time keeper
LET stime = (TIMER - sitime)
LET gametime = (gametime + (stime - gametime)) + igametime
REM calculates full save time
LET savetimehour = INT(gametime) \ 3600
LET savetimemin = (INT(gametime) - (3600 * savetimehour)) \ 60
LET savetimesec = (INT(gametime) - (3600 * savetimehour)) - (savetimemin * 60)
LET frames = frames + 1: REM frame counter
REM calculate fps
LET temp7 = temp7 + 1
IF temp8 + 1 < ctime THEN
    LET fps = temp7
    LET temp7 = 0: REM scrub temp values
    LET temp8 = ctime: REM reset temp values
END IF
REM keep track of script timer
LET temp209 = ifcurrencyno + ifdirectionno + ifpocketno + ifholdingno + ifmodelno + ifmapnono + ifgoneno + ifrandomno + ifvalueno + ifcheckpointno + ifmodelno + iftimedno + ifawardno
IF scripttimer > 0 AND temp209 = 0 AND runterminal = 0 AND pocketon = 0 AND scriptrun = 0 THEN
    REM sets values depending on gameplay type
    LET temp9989 = ctime
    IF INT(temp9989) >= INT(iscripttimer) + INT(scripttimer) THEN
        REM once timer is reached
        IF scriptrun = 1 THEN
            REM do nothing whilst a script or terminal runs
        ELSE
            REM run spoof trigger when no script or terminal is running
            LET eventtitle$ = "SCRIPT TIMER COMPLETE:"
            LET eventdata$ = scripttimername$
            LET eventnumber = scripttimer
            GOSUB consoleprinter
            LET scripttimer = 0
            LET iscripttimer = 0
            LET scripttime = 0
            LET triggerspoofa = 1
            LET triggerspoofname$ = scripttimername$
            LET nextmapscript = 4
            LET scripttimername$ = ""
        END IF
    END IF
END IF
REM music fades
GOSUB musicfadeout
GOSUB musicfadein
RETURN

game:
REM Main engine loop (BETWEEN DO AND LOOP)
REM lets console know main loop active
LET eventtitle$ = "ENGINE LOOP: "
LET eventdata$ = "active!"
LET eventnumber = 0
GOSUB consoleprinter
REM fadein
GOSUB fadein
LET temp8 = ctime: REM for fps counter
REM engine loop
DO
    REM value modifyers
    LET xxit = _EXIT: REM sets game exit value
    LET a = _KEYHIT: REM user input
    REM engine loop subs
    GOSUB inputter: REM player input
    GOSUB collision: REM collision sub
    GOSUB footchanger: REM calculates when players foot needs changing
    GOSUB playermove: REM calculates NPC movement
    GOSUB screendraw: REM calls for a screen draw
    GOSUB triggerchecker: REM checks to see if any triggers have been activated
    GOSUB terminaldraw: REM displays a terminal if required
    REM post loop commands + subs
    IF hertz > 0 THEN _LIMIT hertz: REM sets engine loops per second if needed
    GOSUB timeframecounter: REM diverts to time tracker and frame counter
LOOP

gameloop:
REM continues game loop for scripts
IF hertz > 0 THEN _LIMIT hertz: REM sets engine loops per second if needed
IF allowscriptcontrol = 1 THEN GOSUB inputter
GOSUB collision
GOSUB footchanger
GOSUB playermove
GOSUB screendraw
GOSUB timeframecounter
RETURN

hideitem:
REM hides item from pockets
OPEN pocketloc$ + "pocketfiles.ddf" FOR INPUT AS #1
REM seaches for item in pocketfiles
DO
    LET temp63 = temp63 + 1
    INPUT #1, pocketfile$
LOOP UNTIL pocketfile$ = hideitem$ OR EOF(1)
CLOSE #1
IF pocketfile$ <> hideitem$ THEN
    REM if search finds nothing or currency is attempted to be removed
    REM prints to console
    LET eventtitle$ = "INVALID POCKET ITEM:"
    LET eventdata$ = hideitem$
    LET eventnumber = 0
    GOSUB consoleprinter
    LET temp63 = 0
    RETURN
END IF
REM hides item
LET x = 0
DO
    LET x = x + 1
    IF temp63 = x THEN LET pocketvisible(x) = 0
LOOP UNTIL x >= pocketnos
LET x = 0
REM prints to console
LET eventtitle$ = "POCKET ITEM HIDDEN:"
LET eventdata$ = hideitem$
LET eventnumber = temp63
GOSUB consoleprinter
LET temp63 = 0: LET temp68 = 0: REM scrub temp values
RETURN

showitem:
REM shows item from pockets
OPEN pocketloc$ + "pocketfiles.ddf" FOR INPUT AS #1
REM seaches for item in pocketfiles
DO
    LET temp63 = temp63 + 1
    INPUT #1, pocketfile$
LOOP UNTIL pocketfile$ = showitem$ OR EOF(1)
CLOSE #1
IF pocketfile$ <> showitem$ THEN
    REM if search finds nothing or currency is attempted to be removed
    REM prints to console
    LET eventtitle$ = "INVALID POCKET ITEM:"
    LET eventdata$ = showitem$
    LET eventnumber = 0
    GOSUB consoleprinter
    LET temp63 = 0
    RETURN
END IF
REM shows item
LET x = 0
DO
    LET x = x + 1
    IF temp63 = x THEN LET pocketvisible(x) = 1
LOOP UNTIL x >= pocketnos
LET x = 0
REM prints to console
LET eventtitle$ = "POCKET ITEM VISIBLE:"
LET eventdata$ = showitem$
LET eventnumber = temp63
GOSUB consoleprinter
LET temp63 = 0: LET temp68 = 0: REM scrub temp values
RETURN

giveitem:
REM gives item to mainplayer
OPEN pocketloc$ + "pocketfiles.ddf" FOR INPUT AS #1
REM seaches for item in pocketfiles
DO
    LET temp63 = temp63 + 1
    INPUT #1, pocketfile$
LOOP UNTIL pocketfile$ = giveitem$ OR EOF(1)
CLOSE #1
IF pocketfile$ <> giveitem$ THEN
    REM if search finds nothing or currency is attempted to be removed
    REM prints to console
    LET eventtitle$ = "INVALID POCKET ITEM:"
    LET eventdata$ = giveitem$
    LET eventnumber = 0
    GOSUB consoleprinter
    LET temp63 = 0
    RETURN
END IF
REM assigns item
LET x = 0
DO
    LET x = x + 1
    IF temp63 = x THEN LET pocketitem(x) = 1
LOOP UNTIL x >= pocketnos
LET x = 0
REM prints to console
LET eventtitle$ = "POCKET ITEM GIVEN:"
LET eventdata$ = giveitem$
LET eventnumber = temp63
GOSUB consoleprinter
REM recounts total number of pocket items
LET pocketcarry = 0: LET x = 0
DO
    LET x = x + 1
    IF pocketitem(x) = 1 THEN LET pocketcarry = pocketcarry + 1
LOOP UNTIL x >= pocketnos
IF silentgive = 0 THEN
    REM displays animation
    GOSUB slightfadeout
    DO
        REM pockets scroll in
        IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN IF skipallowed = 1 THEN LET scriptskip = 1
        _LIMIT pockethudanispeed
        _PUTIMAGE (0, (0 - temp68))-(pockethudresx - 1, temp68 - 1), pockethud
        LET temp68 = temp68 + 1
    LOOP UNTIL temp68 >= pockethudresy OR scriptskip = 1
    LET temp68 = (0 - pocketspriteresx)
    DO
        REM Pocket item scrolls in
        LET temp68 = temp68 + 1
        IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN IF skipallowed = 1 THEN LET scriptskip = 1
        _LIMIT pockethudanispeed
        _PUTIMAGE (0, 0)-(pockethudresx - 1, pockethudresy - 1), pockethud
        _PUTIMAGE (temp68, pocketspritey)-((temp68 + pocketspriteresx) - 1, (pocketspritey + pocketspriteresy) - 1), pocketsprite(temp63)
    LOOP UNTIL temp68 >= pocketspritex OR scriptskip = 1
    REM plays sound effect
    LET playsfx$ = "pickup"
    GOSUB sfxplay
    IF scriptskip = 0 THEN _DELAY 0.5
    GOSUB slightfadein
END IF
LET temp63 = 0: LET temp68 = 0: LET silentgive = 0: REM scrub temp values
RETURN

takeitem:
REM takes item from mainplayer
OPEN pocketloc$ + "pocketfiles.ddf" FOR INPUT AS #1
REM seaches for item in pocketfiles
DO
    LET temp65 = temp65 + 1
    INPUT #1, pocketfile$
LOOP UNTIL pocketfile$ = takeitem$ OR EOF(1)
CLOSE #1
IF pocketfile$ <> takeitem$ THEN
    REM if search finds nothing or currency is attempted to be removed
    REM prints to console
    LET eventtitle$ = "INVALID POCKET ITEM:"
    LET eventdata$ = takeitem$
    LET eventnumber = 0
    GOSUB consoleprinter
    LET temp65 = 0
    RETURN
END IF
REM assigns item
LET x = 0
DO
    LET x = x + 1
    IF temp65 = x THEN LET pocketitem(x) = 0
LOOP UNTIL x >= pocketnos
LET x = 0
REM prints to console
LET eventtitle$ = "POCKET ITEM TAKEN:"
LET eventdata$ = takeitem$
LET eventnumber = temp65
GOSUB consoleprinter
REM recounts total number of pocket items
LET pocketcarry = 0: LET x = 0
DO
    LET x = x + 1
    IF pocketitem(x) = 1 THEN LET pocketcarry = pocketcarry + 1
LOOP UNTIL x >= pocketnos
IF silenttake = 0 THEN
    REM displays animation
    GOSUB slightfadeout
    LET temp205 = (pocketspritey - pockethudresy) - 1
    DO
        REM pockets scroll in
        IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN IF skipallowed = 1 THEN LET scriptskip = 1
        _LIMIT pockethudanispeed
        _PUTIMAGE (0, (0 - temp69))-(pockethudresx - 1, temp69 - 1), pockethud
        _PUTIMAGE (pocketspritex, temp205)-(((pocketspritex + pocketspriteresx) - 1), ((pocketspriteresy - 1) + temp205)), pocketsprite(temp65)
        LET temp69 = temp69 + 1
        LET temp205 = temp205 + 1
    LOOP UNTIL temp69 >= pockethudresy OR scriptskip = 1
    LET temp69 = pocketspritex
    DO
        REM Pocket item scrolls out
        IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN IF skipallowed = 1 THEN LET scriptskip = 1
        _LIMIT pockethudanispeed
        _PUTIMAGE (0, 0)-(pockethudresx - 1, pockethudresy), pockethud
        _PUTIMAGE (temp69, pocketspritey)-((temp69 + pocketspriteresx) - 1, (pocketspritey + pocketspriteresy) - 1), pocketsprite(temp65)
        LET temp69 = temp69 + 1
    LOOP UNTIL temp69 >= (resx + 1) OR scriptskip = 1
    REM plays sound effect
    LET playsfx$ = "drop"
    GOSUB sfxplay
    IF scriptskip = 0 THEN _DELAY 0.5
    GOSUB slightfadein
END IF
LET temp65 = 0: LET temp69 = 0: LET temp205 = 0: LET silenttake = 0: REM scrub temp values
RETURN

markgone:
REM marks pocket item as "gone forever"
OPEN pocketloc$ + "pocketfiles.ddf" FOR INPUT AS #1
REM seaches for item in pocketfiles
DO
    LET temp95 = temp95 + 1
    INPUT #1, pocketfile$
LOOP UNTIL pocketfile$ = takeitem$ OR EOF(1)
CLOSE #1
IF pocketfile$ <> takeitem$ OR pocketfile$ = "currency" THEN
    REM if search finds nothing or currency is attempted to be removed
    REM prints to console
    LET eventtitle$ = "INVALID POCKET ITEM:"
    LET eventdata$ = takeitem$
    LET eventnumber = 0
    GOSUB consoleprinter
    LET temp95 = 0
    RETURN
END IF
REM assigns item
LET x = 0
DO
    LET x = x + 1
    IF temp95 = x THEN LET pocketitem(x) = 2
LOOP UNTIL x >= pocketnos
REM recounts total number of pocket items
LET pocketcarry = 0: LET x = 0
DO
    LET x = x + 1
    IF pocketitem(x) = 1 THEN LET pocketcarry = pocketcarry + 1
LOOP UNTIL x >= pocketnos
LET x = 0
REM prints to console
LET eventtitle$ = "POCKET ITEM FULLY TAKEN:"
LET eventdata$ = takeitem$
LET eventnumber = temp65
GOSUB consoleprinter
LET temp95 = 0: REM scrubs temp values
RETURN

ifholding:
REM checks players hand for item
IF runterminal = 1 THEN
    REM if terminal is running
    IF ifholding$ = terminalhold$ THEN LET ifholding = 1
ELSE
    REM if terminal isnt running
    IF ifholding$ = currentpocketshort$ THEN LET ifholding = 1
END IF
RETURN

ifmodel:
REM checks if player is using certain character sprite
IF ifmodel$ = mplayermodel$ THEN
    LET ifmodel = 1
ELSE
    LET ifmodel = 0
END IF
RETURN

ifmapno:
REM checks if player is on a certain map
IF ifmapno = mapno THEN
    LET ifmapnoresult = 1
ELSE
    LET ifmapnoresult = 0
END IF
RETURN

ifgone:
REM checks for pocket item
OPEN pocketloc$ + "pocketfiles.ddf" FOR INPUT AS #1
REM seaches for item in pocketfiles
DO
    LET temp122 = temp122 + 1
    INPUT #1, pocketfile$
LOOP UNTIL pocketfile$ = ifgone$ OR EOF(1)
CLOSE #1
IF pocketfile$ <> ifgone$ THEN
    REM if search finds nothing
    REM prints to console
    LET eventtitle$ = "INVALID POCKET ITEM:"
    LET eventdata$ = ifgone$
    LET eventnumber = 0
    GOSUB consoleprinter
    LET temp122 = 0
    RETURN
END IF
REM assigns item
LET x = 0
DO
    LET x = x + 1
    IF temp122 = x THEN LET ifgone = pocketitem(x)
LOOP UNTIL x >= pocketnos
LET x = 0
LET temp122 = 0: REM scrub temp values
RETURN

ifaward:
IF awardvalue(ifaward) = 1 THEN
    LET ifawardresult = 1
ELSE
    LET ifawardresult = 0
END IF
LET ifaward = 0
RETURN

ifpocket:
REM checks for if pocket item has been marked "gone forever"
OPEN pocketloc$ + "pocketfiles.ddf" FOR INPUT AS #1
REM seaches for item in pocketfiles
DO
    LET temp85 = temp85 + 1
    INPUT #1, pocketfile$
LOOP UNTIL pocketfile$ = ifpocket$ OR EOF(1)
CLOSE #1
IF pocketfile$ <> ifpocket$ THEN
    REM if search finds nothing
    REM prints to console
    LET eventtitle$ = "INVALID POCKET ITEM:"
    LET eventdata$ = ifpocket$
    LET eventnumber = 0
    GOSUB consoleprinter
    LET temp85 = 0
    RETURN
END IF
REM assigns item
LET x = 0
DO
    LET x = x + 1
    IF temp85 = x THEN LET ifpocket = pocketitem(x)
LOOP UNTIL x >= pocketnos
LET x = 0
LET temp85 = 0: REM scrub temp values
RETURN

terminalload:
REM loads terminal data
LET tani1 = _LOADIMAGE(tloc$ + "tani1.png")
LET tani2 = _LOADIMAGE(tloc$ + "tani2.png")
LET tani3 = _LOADIMAGE(tloc$ + "tani3.png")
LET tani4 = _LOADIMAGE(tloc$ + "tani4.png")
LET tfile = _LOADIMAGE(tloc$ + "file.png")
LET tdir = _LOADIMAGE(tloc$ + "dir.png")
LET tno = _LOADIMAGE(tloc$ + "nodata.png")
LET tapp = _LOADIMAGE(tloc$ + "app.png")
LET tselectn = _LOADIMAGE(tloc$ + "selectn.png")
LET tselectd = _LOADIMAGE(tloc$ + "selectd.png")
LET tselectf = _LOADIMAGE(tloc$ + "selectf.png")
LET sysok = _LOADIMAGE(tloc$ + "sysok.png")
LET sysbusy = _LOADIMAGE(tloc$ + "sysbusy.png")
LET syserr = _LOADIMAGE(tloc$ + "syserr.png")
REM prints to terminal
LET eventtitle$ = "TERMINAL ITEMS LOADED"
LET eventdata$ = ""
LET eventnumber = 0
GOSUB consoleprinter
IF setupboot = 1 THEN
    LET temp125 = temp125 + loadbarsize
    GOSUB loadbar
END IF
RETURN

terminalunload:
REM unloads terminal data
_FREEIMAGE tani1
_FREEIMAGE tani2
_FREEIMAGE tani3
_FREEIMAGE tani4
_FREEIMAGE tfile
_FREEIMAGE tdir
_FREEIMAGE tno
_FREEIMAGE tapp
_FREEIMAGE tselectn
_FREEIMAGE tselectd
_FREEIMAGE tselectf
_FREEIMAGE sysok
_FREEIMAGE sysbusy
_FREEIMAGE syserr
REM prints to terminal
LET eventtitle$ = "TERMINAL ITEMS UNLOADED"
LET eventdata$ = ""
LET eventnumber = 0
GOSUB consoleprinter
RETURN

terminaldraw:
REM displays terminal
IF runterminal = 0 THEN RETURN
REM checks if terminal file exists
IF _FILEEXISTS(tloc$ + runterminal$ + "\" + runterminal$ + ".ddf") THEN
    REM nothing
ELSE
    ERROR 425
    LET runterminal = 0
    RETURN
END IF
REM fade out if needed
IF terminalnoboot = 0 AND terminaldir = 0 THEN GOSUB fadeout
IF terminalnoboot = 1 THEN LET fadestatus = 1
REM transfers values
LET temp87 = tdelay
LET temp88 = stposx
LET temp89 = stposy
REM loads terminal data
OPEN tloc$ + runterminal$ + "\" + runterminal$ + ".ddf" FOR INPUT AS #1
INPUT #1, ct1, cn1$, ct2, cn2$, ct3, cn3$, ct4, cn4$, ct5, cn5$, ct6, cn6$, parentdir$
CLOSE #1
REM tells console
LET eventtitle$ = "TERMINAL LAUNCHED:"
LET eventdata$ = runterminal$
LET eventnumber = 0
GOSUB consoleprinter
LET awarddisplay = 0
REM display terminal open animation (if directory isnt open)
IF terminaldir = 0 AND terminalnoboot = 0 THEN
    LET playsfx$ = "terminalon": GOSUB sfxplay: REM plays sound efffect
    FOR x = 1 TO 5
        IF x = 1 THEN _PUTIMAGE (1, 1)-(resx, resy), tani1
        IF x = 2 THEN _PUTIMAGE (1, 1)-(resx, resy), tani2
        IF x = 3 THEN _PUTIMAGE (1, 1)-(resx, resy), tani3
        IF x = 4 THEN _PUTIMAGE (1, 1)-(resx, resy), tani4
        GOSUB timeframecounter
        _DELAY tanidelay
    NEXT x
END IF
CLS
termloop:
COLOR _RGBA(letterminalcolourr, letterminalcolourg, letterminalcolourb, letterminalcoloura), _RGBA(bgterminalcolourr, bgterminalcolourg, bgterminalcolourb, bgterminalcoloura)
PRINT tos$
IF terminalnoboot = 1 THEN _AUTODISPLAY: LET terminalnoboot = 0: REM re-enables drawing for when boot gui is skipped
REM display terminal files animation
IF temp147 <> 1 THEN _PUTIMAGE (terminalfacex, terminalfacey), sysbusy
IF ct1 = 0 THEN _PUTIMAGE (terminalcol1, terminalrow1), tno
IF ct1 = 1 THEN _PUTIMAGE (terminalcol1, terminalrow1), tfile
IF ct1 = 2 THEN _PUTIMAGE (terminalcol1, terminalrow1), tdir
IF ct1 = 3 THEN _PUTIMAGE (terminalcol1, terminalrow1), tapp
_DELAY temp87: LET temp87 = temp87 / 2
IF ct2 = 0 THEN _PUTIMAGE (terminalcol2, terminalrow1), tno
IF ct2 = 1 THEN _PUTIMAGE (terminalcol2, terminalrow1), tfile
IF ct2 = 2 THEN _PUTIMAGE (terminalcol2, terminalrow1), tdir
IF ct2 = 3 THEN _PUTIMAGE (terminalcol2, terminalrow1), tapp
_DELAY temp87: LET temp87 = temp87 / 2
IF ct3 = 0 THEN _PUTIMAGE (terminalcol3, terminalrow1), tno
IF ct3 = 1 THEN _PUTIMAGE (terminalcol3, terminalrow1), tfile
IF ct3 = 2 THEN _PUTIMAGE (terminalcol3, terminalrow1), tdir
IF ct3 = 3 THEN _PUTIMAGE (terminalcol3, terminalrow1), tapp
_DELAY temp87: LET temp87 = temp87 / 2
IF ct4 = 0 THEN _PUTIMAGE (terminalcol1, terminalrow2), tno
IF ct4 = 1 THEN _PUTIMAGE (terminalcol1, terminalrow2), tfile
IF ct4 = 2 THEN _PUTIMAGE (terminalcol1, terminalrow2), tdir
IF ct4 = 3 THEN _PUTIMAGE (terminalcol1, terminalrow2), tapp
_DELAY temp87: LET temp87 = temp87 / 2
IF ct5 = 0 THEN _PUTIMAGE (terminalcol2, terminalrow2), tno
IF ct5 = 1 THEN _PUTIMAGE (terminalcol2, terminalrow2), tfile
IF ct5 = 2 THEN _PUTIMAGE (terminalcol2, terminalrow2), tdir
IF ct5 = 3 THEN _PUTIMAGE (terminalcol2, terminalrow2), tapp
_DELAY temp87: LET temp87 = temp87 / 2
IF ct6 = 0 THEN _PUTIMAGE (terminalcol3, terminalrow2), tno
IF ct6 = 1 THEN _PUTIMAGE (terminalcol3, terminalrow2), tfile
IF ct6 = 2 THEN _PUTIMAGE (terminalcol3, terminalrow2), tdir
IF ct6 = 3 THEN _PUTIMAGE (terminalcol3, terminalrow2), tapp
_DELAY temp87
_PUTIMAGE (terminalfacex, terminalfacey), sysok
COLOR _RGBA(letterminalcolourr, letterminalcolourg, letterminalcolourb, letterminalcoloura), _RGBA(bgterminalcolourr, bgterminalcolourg, bgterminalcolourb, bgterminalcoloura)
IF temp88 = terminalcol1 AND temp89 = terminalrow1 THEN LET ttype = ct1: LET tselect$ = cn1$
IF temp88 = terminalcol2 AND temp89 = terminalrow1 THEN LET ttype = ct2: LET tselect$ = cn2$
IF temp88 = terminalcol3 AND temp89 = terminalrow1 THEN LET ttype = ct3: LET tselect$ = cn3$
IF temp88 = terminalcol1 AND temp89 = terminalrow2 THEN LET ttype = ct4: LET tselect$ = cn4$
IF temp88 = terminalcol2 AND temp89 = terminalrow2 THEN LET ttype = ct5: LET tselect$ = cn5$
IF temp88 = terminalcol3 AND temp89 = terminalrow2 THEN LET ttype = ct6: LET tselect$ = cn6$
IF ttype = 1 THEN PRINT "file - "; tselect$: _PUTIMAGE (temp88 - 1, temp89 - 1), tselectf
IF ttype = 2 THEN PRINT "folder - "; tselect$: _PUTIMAGE (temp88 - 1, temp89 - 1), tselectd
IF ttype = 3 THEN PRINT "app - "; tselect$: _PUTIMAGE (temp88 - 1, temp89 - 1), tselectf
IF ttype = 0 THEN PRINT "no data": _PUTIMAGE (temp88 - 1, temp89 - 1), tselectn
LET temp147 = 1
REM input loop
_KEYCLEAR
DO
    _LIMIT extrahertz
    LET t = _KEYHIT
    GOSUB timeframecounter
    IF t = ucontrolcode1 OR t = ucontrolcode2 OR t = ucontrolcode3 OR t = ucontrolcode4 THEN
        REM up
        _KEYCLEAR
        IF temp89 <> terminalrow1 THEN
            LET temp89 = terminalrow1
            LET playsfx$ = "terminalmove"
            GOSUB sfxplay
            CLS
            GOTO termloop
        END IF
    END IF
    IF t = dcontrolcode1 OR t = dcontrolcode2 OR t = dcontrolcode3 OR t = dcontrolcode4 THEN
        REM down
        _KEYCLEAR
        IF temp89 <> terminalrow2 THEN
            LET temp89 = terminalrow2
            LET playsfx$ = "terminalmove"
            GOSUB sfxplay
            CLS
            GOTO termloop
        END IF
    END IF
    REM left
    IF t = lcontrolcode1 OR t = lcontrolcode2 OR t = lcontrolcode3 OR t = lcontrolcode4 THEN
        _KEYCLEAR
        IF temp88 <> terminalcol1 THEN
            LET playsfx$ = "terminalmove"
            GOSUB sfxplay
        END IF
        IF temp88 = terminalcol1 THEN LET temp88 = terminalcol1: CLS: GOTO termloop
        IF temp88 = terminalcol2 THEN LET temp88 = terminalcol1: CLS: GOTO termloop
        IF temp88 = terminalcol3 THEN LET temp88 = terminalcol2: CLS: GOTO termloop
    END IF
    REM right
    IF t = rcontrolcode1 OR t = rcontrolcode2 OR t = rcontrolcode3 OR t = rcontrolcode4 THEN
        IF temp88 <> terminalcol3 THEN
            LET playsfx$ = "terminalmove"
            GOSUB sfxplay
        END IF
        IF temp88 = terminalcol1 THEN LET temp88 = terminalcol2: CLS: GOTO termloop
        IF temp88 = terminalcol2 THEN LET temp88 = terminalcol3: CLS: GOTO termloop
        IF temp88 = terminalcol3 THEN LET temp88 = terminalcol3: CLS: GOTO termloop
    END IF
    IF t = scontrolcode1 OR t = scontrolcode2 OR t = scontrolcode3 OR t = scontrolcode4 THEN
        _KEYCLEAR
        REM file type
        IF ttype = 1 THEN
            LET playsfx$ = "terminalselect"
            GOSUB sfxplay
            GOSUB readtxt
            LET temp88 = terminalcol1
            LET temp89 = terminalrow1
            LET temp147 = 0
            LET temp87 = tdelay
            CLS
            GOTO termloop
        END IF
        REM directory type
        IF ttype = 2 THEN
            LET playsfx$ = "terminalselect"
            GOSUB sfxplay
            CLS
            LET runterminal$ = tselect$
            LET terminaldir = 1
            LET temp147 = 0
            GOTO terminaldraw
        END IF
        REM app type
        IF ttype = 3 THEN
            IF tselect$ = "exit" THEN GOTO endterm: REM quits terminal
            IF tselect$ = "back" THEN
                REM goes back a directory
                LET playsfx$ = "terminalselect"
                GOSUB sfxplay
                CLS
                LET runterminal$ = parentdir$
                LET terminaldir = 2
                LET temp147 = 0
                GOTO terminaldraw
            END IF
            REM runs script
            LET playsfx$ = "terminalselect"
            GOSUB sfxplay
            LET nextmapscript = 1
            LET triggerspoofa = 1
            LET nodraw = 1
            LET triggerspoofname$ = tselect$
            LET oldscript$ = ""
            IF scripttimer > 0 THEN LET scriptrun = 1
            GOSUB endterm
            RETURN
        END IF
    END IF
LOOP
endterm:
IF tselect$ = "exit" THEN
    REM plays sound
    LET playsfx$ = "terminaloff"
    GOSUB sfxplay
END IF
COLOR 0, 0
REM tells console
LET eventtitle$ = "TERMINAL STOPPED:"
LET eventdata$ = runterminal$
LET eventnumber = 0
GOSUB consoleprinter
REM return to game
IF tselect$ = "exit" THEN LET fadestatus = 1: GOSUB fadein
LET runterminal = 0: LET temp87 = 0: LET temp88 = 0: LET temp89 = 0: LET temp147 = 0: LET terminaldir = 0: LET terminalhold$ = "": REM scub temp values
RETURN

ifcurrency:
REM checks to see if player has enough currency
IF currency >= ifcurrencyamount THEN
    LET ifcurrencyresult = 1
ELSE
    LET ifcurrencyresult = 0
END IF
RETURN

readtxt:
REM terminal file opener
CLS
_AUTODISPLAY
COLOR _RGBA(letterminalcolourr, letterminalcolourg, letterminalcolourb, letterminalcoloura), _RGBA(bgterminalcolourr, bgterminalcolourg, bgterminalcolourb, bgterminalcoloura)
LET temp90 = tdelay
_PUTIMAGE (terminalfacex, terminalfacey), sysbusy
IF scriptrun <> 1 THEN
    OPEN tloc$ + runterminal$ + "\" + tselect$ + ".ddf" FOR INPUT AS #1
    INPUT #1, txtfile1$, txtfile2$, txtfile3$, txtfile4$, txtfile5$, txtfile6$, sysstat
    CLOSE #1
END IF
REM find any script variable values and injects them into the terminal file
FOR inj = 1 TO 6
    IF inj = 1 THEN LET textspeech$ = txtfile1$
    IF inj = 2 THEN LET textspeech$ = txtfile2$
    IF inj = 3 THEN LET textspeech$ = txtfile3$
    IF inj = 4 THEN LET textspeech$ = txtfile4$
    IF inj = 5 THEN LET textspeech$ = txtfile5$
    IF inj = 6 THEN LET textspeech$ = txtfile6$
    GOSUB variablevalueinjector
    IF inj = 1 THEN LET txtfile1$ = textspeech$
    IF inj = 2 THEN LET txtfile2$ = textspeech$
    IF inj = 3 THEN LET txtfile3$ = textspeech$
    IF inj = 4 THEN LET txtfile4$ = textspeech$
    IF inj = 5 THEN LET txtfile5$ = textspeech$
    IF inj = 6 THEN LET txtfile6$ = textspeech$
    LET textspeech$ = ""
NEXT inj
PRINT tos$
PRINT
PRINT txtfile1$
COLOR _RGBA(letterminalcolourr, letterminalcolourg, letterminalcolourb, letterminalcoloura), _RGBA(bgterminalcolourr, bgterminalcolourg, bgterminalcolourb, bgterminalcoloura)
_DELAY temp90: LET temp90 = temp90 / 2
PRINT txtfile2$
COLOR _RGBA(letterminalcolourr, letterminalcolourg, letterminalcolourb, letterminalcoloura), _RGBA(bgterminalcolourr, bgterminalcolourg, bgterminalcolourb, bgterminalcoloura)
_DELAY temp90: LET temp90 = temp90 / 2
PRINT txtfile3$
COLOR _RGBA(letterminalcolourr, letterminalcolourg, letterminalcolourb, letterminalcoloura), _RGBA(bgterminalcolourr, bgterminalcolourg, bgterminalcolourb, bgterminalcoloura)
_DELAY temp90: LET temp90 = temp90 / 2
PRINT txtfile4$
COLOR _RGBA(letterminalcolourr, letterminalcolourg, letterminalcolourb, letterminalcoloura), _RGBA(bgterminalcolourr, bgterminalcolourg, bgterminalcolourb, bgterminalcoloura)
_DELAY temp90: LET temp90 = temp90 / 2
PRINT txtfile5$
COLOR _RGBA(letterminalcolourr, letterminalcolourg, letterminalcolourb, letterminalcoloura), _RGBA(bgterminalcolourr, bgterminalcolourg, bgterminalcolourb, bgterminalcoloura)
_DELAY temp90: LET temp90 = temp90 / 2
PRINT txtfile6$
COLOR _RGBA(letterminalcolourr, letterminalcolourg, letterminalcolourb, letterminalcoloura), _RGBA(bgterminalcolourr, bgterminalcolourg, bgterminalcolourb, bgterminalcoloura)
PRINT: PRINT
PRINT "..."
REM print to console
IF scriptrun = 0 THEN
    LET eventtitle$ = "TERMINAL FILE OPEN:"
    LET eventdata$ = tselect$
ELSE
    LET eventtitle$ = "SPOOF TERMINAL FILE OPEN"
    LET eventdata$ = ""
END IF
LET eventnumber = 0
GOSUB consoleprinter
IF sysstat = 1 THEN _PUTIMAGE (terminalfacex, terminalfacey), sysok
IF sysstat = 2 THEN _PUTIMAGE (terminalfacex, terminalfacey), sysbusy
IF sysstat = 3 THEN _PUTIMAGE (terminalfacex, terminalfacey), syserr
_KEYCLEAR
DO
    IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN IF skipallowed = 1 THEN LET scriptskip = 1
    LET tt = _KEYHIT
    _LIMIT extrahertz
    GOSUB timeframecounter
LOOP UNTIL tt = scontrolcode1 OR tt = scontrolcode2 OR scriptskip = 1
_KEYCLEAR
LET playsfx$ = "terminalselect"
GOSUB sfxplay
LET tselect$ = "": LET temp90 = 0: REM scrub temp values
CLS
RETURN

showimage:
REM displays an image on screen
REM loads values
LET fullscreenimage = _LOADIMAGE(uiloc$ + showimage$ + ".png")
LET eventtitle$ = "FULLSCREEN IMAGE LOADED:"
LET eventdata$ = showimage$
LET eventnumber = 0
GOSUB consoleprinter
REM fades out game
GOSUB fadeout
REM fades in with image
LET temp206 = (fadespeed - fadespeed) - fadespeed
FOR i% = 255 TO 0 STEP temp206
    IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN IF skipallowed = 1 THEN LET scriptskip = 1
    IF scriptskip = 1 THEN LET i% = 0
    _LIMIT hertz: REM sets framerate
    _PUTIMAGE (0, 0)-(resx - 1, resy - 1), fullscreenimage
    LINE (0, 0)-(resx, resy), _RGBA(0, 0, 0, i%), BF: REM slowly fills screen with black box
    GOSUB timeframecounter: REM timer function
    _DISPLAY
NEXT
_AUTODISPLAY
_PUTIMAGE (0, 0)-(resx - 1, resy - 1), fullscreenimage: REM displays image
LET eventtitle$ = "FULLSCREEN IMAGE DISPLAYED:"
LET eventdata$ = showimage$
LET eventnumber = 0
GOSUB consoleprinter
_KEYCLEAR
DO
    IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN IF skipallowed = 1 THEN LET scriptskip = 1
    LET ss = _KEYHIT
    GOSUB timeframecounter
    _LIMIT hertz
LOOP UNTIL ss = scontrolcode1 OR ss = scontrolcode2 OR ss = scontrolcode3 OR ss = scontrolcode4 OR scriptskip = 1
_KEYCLEAR
REM fade out with image
LET temp206 = fadespeed
FOR i% = 0 TO 255 STEP temp206
    IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN IF skipallowed = 1 THEN LET scriptskip = 1
    IF scriptskip = 1 THEN LET i% = 255
    _LIMIT hertz: REM sets framerate
    _PUTIMAGE (0, 0)-(resx - 1, resy - 1), fullscreenimage
    LINE (0, 0)-(resx, resy), _RGBA(0, 0, 0, i%), BF: REM slowly empties black box from screen
    GOSUB timeframecounter
    _DISPLAY
NEXT
_AUTODISPLAY
REM fade in game
GOSUB fadein
REM free image
_FREEIMAGE fullscreenimage
LET eventtitle$ = "FULLSCREEN IMAGE UNLOADED:"
LET eventdata$ = showimage$
LET eventnumber = 0
GOSUB consoleprinter
RETURN

variablevalueinjector:
REM injects variable values into scripts
DO
    LET temp204 = 0
    LET findhelditem1% = INSTR(findhelditem1% + 1, textspeech$, "[helditem1]")
    LET findhelditem2% = INSTR(findhelditem2% + 1, textspeech$, "[helditem2]")
    LET findselectobject% = INSTR(findselectobject% + 1, textspeech$, "[selectobject]")
    LET findros% = INSTR(findros% + 1, textspeech$, "[ros]")
    LET findtos% = INSTR(findtos% + 1, textspeech$, "[tos]")
    LET findgametitle% = INSTR(findgametitle% + 1, textspeech$, "[gametitle]")
    LET findmusicvol% = INSTR(findmusicvol% + 1, textspeech$, "[musicvol]")
    LET findsfxvol% = INSTR(findsfxvol% + 1, textspeech$, "[sfxvol]")
    LET findproposedmod% = INSTR(findproposedmod% + 1, textspeech$, "[proposedmod]")
    LET findmoddingname% = INSTR(findmoddingname% + 1, textspeech$, "[moddingname]")
    LET findgametime% = INSTR(findgametime% + 1, textspeech$, "[gametime]")
    LET findrandom% = INSTR(findrandom% + 1, textspeech$, "[random]")
    LET findscriptvalue% = INSTR(findscriptvalue% + 1, textspeech$, "[value]-")
    IF temp204 = 0 THEN IF findhelditem1% THEN LET variablevalue$ = "[helditem1]": LET temp204 = 1
    IF temp204 = 0 THEN IF findhelditem2% THEN LET variablevalue$ = "[helditem2]": LET temp204 = 1
    IF temp204 = 0 THEN IF findselectobject% THEN LET variablevalue$ = "[selectobject]": LET temp204 = 1
    IF temp204 = 0 THEN IF findros% THEN LET variablevalue$ = "[ros]": LET temp204 = 1
    IF temp204 = 0 THEN IF findtos% THEN LET variablevalue$ = "[tos]": LET temp204 = 1
    IF temp204 = 0 THEN IF findgametitle% THEN LET variablevalue$ = "[gametitle]": LET temp204 = 1
    IF temp204 = 0 THEN IF findmusicvol% THEN LET variablevalue$ = "[musicvol]": LET temp204 = 1
    IF temp204 = 0 THEN IF findsfxvol% THEN LET variablevalue$ = "[sfxvol]": LET temp204 = 1
    IF temp204 = 0 THEN IF findproposedmod% THEN LET variablevalue$ = "[proposedmod]": LET temp204 = 1
    IF temp204 = 0 THEN IF findmoddingname% THEN LET variablevalue$ = "[moddingname]": LET temp204 = 1
    IF temp204 = 0 THEN IF findgametime% THEN LET variablevalue$ = "[gametime]": LET temp204 = 1
    IF temp204 = 0 THEN IF findrandom% THEN LET variablevalue$ = "[random]": LET temp204 = 1
    IF temp204 = 0 THEN IF findscriptvalue% THEN LET variablevalue$ = "[value]-": LET temp204 = 1
    IF temp204 = 1 THEN
        REM value marker found! finds and replaces!
        LET variablelength = LEN(variablevalue$)
        LET temp202 = 0
        DO
            LET temp202 = temp202 + 1
            LET bannertemp$(temp202) = MID$(textspeech$, temp202, 1)
            IF temp202 >= variablelength THEN
                REM scours for variable command
                FOR varloop = (variablelength - 1) TO 0 STEP -1
                    LET varworkingtemp$ = varworkingtemp$ + bannertemp$(temp202 - varloop)
                NEXT varloop
                IF varworkingtemp$ = variablevalue$ THEN
                    REM found variable command! inject value!
                    LET texttemp1$ = LEFT$(textspeech$, (temp202 - variablelength))
                    LET texttemp2$ = MID$(textspeech$, temp202 + 1, (LEN(textspeech$) - (LEN(texttemp1$) + variablelength)))
                    IF variablevalue$ = "[helditem1]" THEN LET textspeech$ = texttemp1$ + pocketdisplayname$ + texttemp2$
                    IF variablevalue$ = "[helditem2]" THEN LET textspeech$ = texttemp1$ + temp19$ + texttemp2$
                    IF variablevalue$ = "[selectobject]" THEN
                        IF selectobject$ = "mainplayer" THEN
                            LET textspeech$ = texttemp1$ + temp61$ + texttemp2$
                        ELSE
                            LET textspeech$ = texttemp1$ + selectobjectlong$ + texttemp2$
                        END IF
                    END IF
                    IF variablevalue$ = "[ros]" THEN LET textspeech$ = texttemp1$ + ros$ + texttemp2$
                    IF variablevalue$ = "[tos]" THEN LET textspeech$ = texttemp1$ + tos$ + texttemp2$
                    IF variablevalue$ = "[gametitle]" THEN LET textspeech$ = texttemp1$ + title$ + texttemp2$
                    IF variablevalue$ = "[musicvol]" THEN LET textspeech$ = texttemp1$ + LTRIM$(STR$(musicvol * 100)) + texttemp2$
                    IF variablevalue$ = "[sfxvol]" THEN LET textspeech$ = texttemp1$ + LTRIM$(STR$(sfxvol * 100)) + texttemp2$
                    IF variablevalue$ = "[proposedmod]" THEN LET textspeech$ = texttemp1$ + LTRIM$(temp48$) + texttemp2$
                    IF variablevalue$ = "[moddingname]" THEN LET textspeech$ = texttemp1$ + moddingname$ + texttemp2$
                    IF variablevalue$ = "[gametime]" THEN
                        IF savetimehour >= 10 AND savetimemin >= 10 AND savetimesec >= 10 THEN LET textspeech$ = texttemp1$ + LTRIM$(STR$(savetimehour)) + ":" + LTRIM$(STR$(savetimemin)) + ":" + LTRIM$(STR$(savetimesec)) + texttemp2$: GOTO injectend1
                        IF savetimehour >= 10 AND savetimemin >= 10 THEN LET textspeech$ = texttemp1$ + LTRIM$(STR$(savetimehour)) + ":" + LTRIM$(STR$(savetimemin)) + ":" + "0" + LTRIM$(STR$(savetimesec)) + texttemp2$: GOTO injectend1
                        IF savetimemin >= 10 AND savetimesec >= 10 THEN LET textspeech$ = texttemp1$ + "0" + LTRIM$(STR$(savetimehour)) + ":" + LTRIM$(STR$(savetimemin)) + ":" + LTRIM$(STR$(savetimesec)) + texttemp2$: GOTO injectend1
                        IF savetimehour >= 10 THEN LET textspeech$ = texttemp1$ + LTRIM$(STR$(savetimehour)) + ":" + "0" + LTRIM$(STR$(savetimemin)) + ":" + "0" + LTRIM$(STR$(savetimesec)) + texttemp2$: GOTO injectend1
                        IF savetimesec >= 10 THEN LET textspeech$ = texttemp1$ + "0" + LTRIM$(STR$(savetimehour)) + ":" + "0" + LTRIM$(STR$(savetimemin)) + ":" + LTRIM$(STR$(savetimesec)) + texttemp2$: GOTO injectend1
                        IF savetimemin >= 10 THEN LET textspeech$ = texttemp1$ + "0" + LTRIM$(STR$(savetimehour)) + ":" + LTRIM$(STR$(savetimemin)) + ":" + "0" + LTRIM$(STR$(savetimesec)) + texttemp2$: GOTO injectend1
                        LET textspeech$ = texttemp1$ + "0" + LTRIM$(STR$(savetimehour)) + ":" + "0" + LTRIM$(STR$(savetimemin)) + ":" + "0" + LTRIM$(STR$(savetimesec)) + texttemp2$
                        injectend1:
                    END IF
                    IF variablevalue$ = "[random]" THEN LET textspeech$ = texttemp1$ + LTRIM$(STR$(randomscriptvalue)) + texttemp2$
                    IF variablevalue$ = "[value]-" THEN
                        LET temp63$ = MID$(textspeech$, INSTR(textspeech$, "-") + 1)
                        LET temp208 = VAL(temp63$)
                        LET texttemp2$ = RIGHT$(texttemp2$, INSTR(texttemp2$, " "))
                        LET textspeech$ = texttemp1$ + LTRIM$(STR$(scriptvalue(temp208))) + " " + texttemp2$
                        LET temp63$ = ""
                        LET temp208 = 0
                    END IF
                    REM scrub values
                    LET texttemp1$ = ""
                    LET texttemp2$ = ""
                    LET varworkingtemp$ = ""
                    LET findhelditem1% = 0
                    LET findhelditem2% = 0
                    LET findselectobject% = 0
                    LET findros% = 0
                    LET findtos% = 0
                    LET findmsucivol% = 0
                    LET findsfxvol% = 0
                    LET findproposedmod% = 0
                    LET findmoddingname% = 0
                    LET findgametime% = 0
                    LET findrandom% = 0
                    LET findscriptvalue% = 0
                    LET temp203 = 0
                    ERASE bannertemp$
                END IF
                LET varworkingtemp$ = ""
            END IF
        LOOP UNTIL temp202 >= LEN(textspeech$)
    ELSE
        REM nothing found! move on!
        LET temp203 = 1
    END IF
LOOP UNTIL temp203 = 1
LET temp203 = 0: LET temp202 = 0: LET temp204 = 0: ERASE bannertemp$: REM scrub temp values
RETURN

scriptvaluefetcher:
REM fetches script values for script commands
LET fetchedvalue = 0
LET temp62$ = RIGHT$(scriptline$, LEN(scriptline$) - INSTR(scriptline$, "usevalue-") - 8)
LET temp207 = VAL(temp62$)
LET fetchedvalue = scriptvalue(temp207)
REM tells console
LET eventtitle$ = "VALUE " + LTRIM$(STR$(temp207)) + " LOOKUP:"
LET eventdata$ = LTRIM$(STR$(fetchedvalue))
LET eventnumber = 0
GOSUB consoleprinter
LET temp207 = 0: LET temp62$ = "": REM scrubs temp values
RETURN

seperatecommand:
REM seperates all script commands into seperate values
LET seperate1$ = LEFT$(scriptline$, INSTR(scriptline$, " ") - 1)
LET seperate2$ = MID$(scriptline$, LEN(temps$(1)) + 1)
LET seperateval2 = 1
DO
    LET seperateval1 = seperateval1 + 1
    LET seperate3$ = MID$(seperate2$, seperateval1, 1)
    IF seperate3$ <> " " THEN
        LET temps$(seperateval2) = temps$(seperateval2) + seperate3$
    ELSE
        LET seperateval2 = seperateval2 + 1
    END IF
LOOP UNTIL seperateval1 >= LEN(seperate2$)
LET seperate2$ = MID$(seperate2$, INSTR(seperate2$, " "))
LET seperate2$ = LTRIM$(seperate2$)
LET seperate2$ = RTRIM$(seperate2$)
LET x = 0
DO
    LET x = x + 1
    LET tempn(x) = VAL(temps$(x))
LOOP UNTIL temps$(x) = ""
RETURN
_DEST _CONSOLE
LET x = 0
DO
    LET x = x + 1
    PRINT LTRIM$(STR$(x)) + ": " + temps$(x) + " " + LTRIM$(STR$(tempn(x)))
LOOP UNTIL temps$(x) = ""
LET x = 0
_DEST 0
RETURN

scriptsaycmd:
REM display text in text banner
LET x = 1
LET textspeech$ = ""
DO
    LET x = x + 1
    LET textspeech$ = textspeech$ + temps$(x) + " "
LOOP UNTIL temps$(x) = ""
LET textspeech$ = RTRIM$(textspeech$)
REM checks for any system values in the text banner and replaces them with the value they are
GOSUB variablevalueinjector
REM draws text banner
IF scriptskip = 0 THEN GOSUB textbannerdraw
LET temp26 = 1
LET x = 0
RETURN

scriptmakevaluecmd:
REM assigns a number to a value slot to be saved
IF finduserandom% THEN LET tempn(3) = randomscriptvalue
LET scriptvalue(tempn(2)) = tempn(3)
REM tells console
LET eventtitle$ = "VALUE " + temps$(2) + " SET:"
LET eventdata$ = "="
LET eventnumber = scriptvalue(tempn(2))
GOSUB consoleprinter
LET temp26 = 1
RETURN

scriptmodvaluecmd:
REM modifies a script value
IF finduserandom% THEN LET tempn(4) = randomscriptvalue
IF findadd% THEN
    REM adds amount
    LET scriptvalue(tempn(2)) = scriptvalue(tempn(2)) + tempn(4)
    LET eventtitle$ = "VALUE " + temps$(2) + " MOD:"
    LET eventdata$ = "+" + temps$(4)
    LET eventnumber = scriptvalue(tempn(2))
    GOSUB consoleprinter
    LET temp26 = 1
END IF
IF findtakeaway% THEN
    REM minus amount
    LET scriptvalue(tempn(2)) = scriptvalue(tempn(2)) - tempn(4)
    LET eventtitle$ = "VALUE " + temps$(2) + " MOD:"
    LET eventdata$ = "-" + temps$(4)
    LET eventnumber = scriptvalue(tempn(2))
    GOSUB consoleprinter
    LET temp26 = 1
END IF
IF findtimes% THEN
    REM multiply amount
    LET scriptvalue(tempn(2)) = scriptvalue(tempn(2)) * tempn(4)
    LET eventtitle$ = "VALUE " + temps$(2) + " MOD:"
    LET eventdata$ = "*" + temps$(4)
    LET eventnumber = scriptvalue(tempn(2))
    GOSUB consoleprinter
    LET temp26 = 1
END IF
IF finddivide% THEN
    REM divide amount
    REM prevent divide by zero
    IF tempn(4) > 0 THEN
        LET scriptvalue(tempn(2)) = scriptvalue(tempn(2)) / tempn(4)
        LET eventtitle$ = "VALUE " + temps$(2) + " MOD:"
        LET eventdata$ = "/" + temps$(4)
        LET eventnumber = scriptvalue(tempn(2))
        GOSUB consoleprinter
        LET temp26 = 1
    ELSE
        ERROR 436
    END IF
END IF
RETURN

scriptmakerandomcmd:
REM tells console
LET eventtitle$ = "RANDOM NUMBER REQUESTED:"
LET eventdata$ = "low: " + temps$(2) + " high: " + temps$(3)
LET eventnumber = 0
GOSUB consoleprinter
REM generates random number between the defined range
LET temp153 = INT(RND * 1000000)
LET temp154 = 0
LET temp155 = 0
LET temp156 = 0
DO
    IF temp154 < tempn(2) THEN LET temp154 = tempn(3)
    IF temp154 > tempn(3) THEN LET temp154 = tempn(2)
    LET temp155 = temp154
    LET temp154 = temp154 + 1
    LET temp156 = temp156 + 1
LOOP UNTIL temp156 >= temp153
LET temp27 = temp155
REM tells console
LET eventtitle$ = "RANDOM NUMBER GENERATED:"
LET eventdata$ = ""
LET eventnumber = temp27
GOSUB consoleprinter
LET randomscriptvalue = temp27
LET temp26 = 1
RETURN

scriptcarryvaluescmd:
REM copies NPC location values into memory to be copied to the next map
LET x = 0
DO
    LET x = x + 1
    LET carryplayerx(x) = playerx(x): LET carryplayery(x) = playery(x)
    LET carryplayerd(x) = playerd(x): LET carryplayerjourney(x) = playerjourney(x)
    LET carryplayerlayer(x) = playerlayer(x): LET carryplayerperiod(x) = playerperiod(x)
LOOP UNTIL x >= mapplayerno
LET x = 0
LET carryvalues = 1
LET temp26 = 1
REM tells console
LET eventtitle$ = "PLAYER LOCATION VALUES COPIED"
LET eventdata$ = ""
LET eventnumber = 0
GOSUB consoleprinter
RETURN

scripthalttimedcmd:
REM cancels a timed script
IF scripttimer = 0 THEN
    REM no script timer acitive
    LET eventtitle$ = "SCRIPT TIMER NOT ACTIVE:"
    LET eventdata$ = "no timed script to cancel"
    LET eventnumber = 0
    GOSUB consoleprinter
ELSE
    REM cancels script timer
    LET eventtitle$ = "SCRIPT TIMER STOPPED:"
    LET eventdata$ = scripttimername$
    LET eventnumber = scripttimer
    GOSUB consoleprinter
    LET scripttimer = 0
    LET scripttimername$ = ""
    LET iscripttimer = 0
    LET temp26 = 1
END IF
RETURN

scriptiftimedcmd:
REM asks engine if a timed script is active
IF scripttimer = 0 THEN
    REM no script timer active
    LET eventtitle$ = "SCRIPT TIMER NOT ACTIVE"
    LET eventdata$ = ""
    LET eventnumber = 0
    GOSUB consoleprinter
ELSE
    REM script timer active - forwards to new script
    LET eventtitle$ = "SCRIPT TIMER IS ACTIVE:"
    LET eventdata$ = scripttimername$
    LET eventnumber = scripttimer
    GOSUB consoleprinter
    LET temp26 = 2
    REM enables a spoof trigger to run a script
    LET triggerspoofa = 1
    LET nextmapscript = mapscript
    LET nodraw = 1
    LET triggerspoofname$ = scriptname$ + "-iftimed"
    LET temp33 = 2
END IF
RETURN

scripttimedscriptcmd:
REM Sets a timed script to be launched
IF finduserandom% THEN LET tempn(3) = randomscriptvalue
REM checks if script timer already active
IF scripttimer > 0 THEN
    REM if a timer is active - reject the request
    LET eventtitle$ = "SCRIPT TIMER ALREADY ACTIVE:"
    LET eventdata$ = scripttimername$
    LET eventnumber = scripttimer
    GOSUB consoleprinter
    LET temp26 = 1
ELSE
    REM sets script timer values
    LET scripttimer = tempn(3)
    LET scripttimername$ = temps$(2)
    LET iscripttimer = INT(ctime)
    REM tells console
    LET eventtitle$ = "SCRIPT TIMER SET:"
    LET eventdata$ = scripttimername$
    LET eventnumber = scripttimer
    GOSUB consoleprinter
    LET temp26 = 1
END IF
RETURN

scriptterminaltextcmd:
REM displays a terminal text screen with the command parameters
LET txtfile1$ = LEFT$(seperate2$, INSTR(seperate2$, ",") - 1)
LET seperate2$ = RIGHT$(seperate2$, LEN(seperate2$) - (LEN(txtfile1$) + 2))
LET txtfile2$ = LEFT$(seperate2$, INSTR(seperate2$, ",") - 1)
LET seperate2$ = RIGHT$(seperate2$, LEN(seperate2$) - (LEN(txtfile2$) + 2))
LET txtfile3$ = LEFT$(seperate2$, INSTR(seperate2$, ",") - 1)
LET seperate2$ = RIGHT$(seperate2$, LEN(seperate2$) - (LEN(txtfile3$) + 2))
LET txtfile4$ = LEFT$(seperate2$, INSTR(seperate2$, ",") - 1)
LET seperate2$ = RIGHT$(seperate2$, LEN(seperate2$) - (LEN(txtfile4$) + 2))
LET txtfile5$ = LEFT$(seperate2$, INSTR(seperate2$, ",") - 1)
LET seperate2$ = RIGHT$(seperate2$, LEN(seperate2$) - (LEN(txtfile5$) + 2))
LET txtfile6$ = LEFT$(seperate2$, INSTR(seperate2$, ",") - 1)
LET seperate2$ = RIGHT$(seperate2$, LEN(seperate2$) - (LEN(txtfile6$) + 2))
LET sysstat = VAL(seperate2$)
IF scriptskip = 0 THEN GOSUB readtxt
LET temp26 = 1
RETURN

scriptshelllnxcmd:
REM executes a shell command for linux clients
IF ros$ = "lnx" OR ros$ = "mac" THEN
    SHELL _HIDE seperate2$
    REM tells console
    LET eventtitle$ = "SHELL COMMAND:"
    LET eventdata$ = seperate2$
    LET eventnumber = 0
    GOSUB consoleprinter
    LET temp26 = 1
ELSE
    LET eventtitle$ = "INCOMPATIBLE SHELL COMMAND:"
    LET eventdata$ = seperate2$
    LET eventnumber = 0
    GOSUB consoleprinter
    LET temp26 = 0
END IF
RETURN

scriptshellwincmd:
REM executes a shell command for windows clients
IF ros$ = "win" THEN
    SHELL _HIDE seperate2$
    REM tells console
    LET eventtitle$ = "SHELL COMMAND:"
    LET eventdata$ = seperate2$
    LET eventnumber = 0
    GOSUB consoleprinter
    LET temp26 = 1
ELSE
    LET eventtitle$ = "INCOMPATIBLE SHELL COMMAND:"
    LET eventdata$ = seperate2$
    LET eventnumber = 0
    GOSUB consoleprinter
    LET temp26 = 0
END IF
RETURN

scriptchoicecmd:
REM displays a player choice
LET x = 0
DO
    LET x = x + 1
    LET choicename$(x) = LEFT$(seperate2$, INSTR(seperate2$, ",") - 1)
    LET seperate2$ = RIGHT$(seperate2$, LEN(seperate2$) - (LEN(choicename$(x)) + 2))
LOOP UNTIL INSTR(seperate2$, ",") = 0
LET choicename$(x + 1) = seperate2$
LET choicetotal = x + 1
LET x = 1
REM if choices exist then go to choice drawing sub , if not then clear values and return
IF choicename$(x) = "" OR choicename$(x) = " " THEN
    REM clear values and return
    LET x = 0
    DO
        LET x = x + 1
        LET choicename$(x) = ""
    LOOP UNTIL x >= choicetotal
    LET x = 0
    LET choicetotal = 0
ELSE
    REM go to choice drawing sub, clear values, divert to choice
    LET x = 0
    IF allowskip = 1 THEN LET allowskip = 0
    IF scriptskip = 1 THEN
        REM halt a script skip and present choice on screen
        LET scriptskip = 0
        IF fadestatus = 1 THEN GOSUB fadein
        GOSUB screendraw
    END IF
    GOSUB choicebannerdraw
    LET temp26 = 2
    REM enables a spoof trigger to run a script
    LET triggerspoofa = 1
    LET nextmapscript = mapscript
    LET nodraw = 1
    IF findbackchoice% THEN
        REM script in previous chain
        LET findchoiceno% = 0
        LET x = 0
        DO
            LET findchoiceno% = INSTR(findchoiceno% + 1, scriptname$, "-ifchoice")
            IF findchoiceno% THEN LET x = x + 1
        LOOP UNTIL findchoiceno% = 0
        LET i = 0: LET y = 0: LET z = 0: LET nn = 0
        DO
            REM seperates script letters
            LET i = i + 1
            LET temps$(1) = MID$(scriptname$, i, 1)
            LET temps$(2) = temps$(2) + temps$(1)
            REM searches for last ifchoice
            DO
                LET findchoiceno% = INSTR(findchoiceno% + 1, temps$(2), "-ifchoice")
                IF findchoiceno% THEN IF nn < findchoiceno% THEN LET z = z + 1: LET nn = findchoiceno%
            LOOP UNTIL findchoiceno% = 0
            IF z > 0 THEN
                REM finds a choice
                IF z = x THEN LET y = 1
            END IF
        LOOP UNTIL i >= LEN(scriptname$) OR y = 1
        LET x = 0: LET i = 0: LET y = 0: LET z = 0: LET findchoiceno% = 0: LET nn = 0
        LET triggerspoofname$ = temp57$ + LTRIM$(STR$(choiceno))
        LET choicescriptloop = 1
    ELSE
        REM new script
        LET triggerspoofname$ = scriptname$ + "-ifchoice" + LTRIM$(STR$(choiceno))
    END IF
    LET temp33 = 2
    LET choiceno = 0
END IF
RETURN

scriptcontrolcmd:
REM enables or disables a player input
IF findup% THEN
    REM enables or disables up control
    IF findon% THEN LET ucontrol = 1: LET eventdata$ = "up control enabled": LET temp26 = 1
    IF findoff% THEN LET ucontrol = 0: LET eventdata$ = "up control disabled": LET temp26 = 1
END IF
IF finddown% THEN
    REM enables or disables down control
    IF findon% THEN LET dcontrol = 1: LET eventdata$ = "down control enabled": LET temp26 = 1
    IF findoff% THEN LET dcontrol = 0: LET eventdata$ = "down control disabled": LET temp26 = 1
END IF
IF findleft% THEN
    REM enables or disables left control
    IF findon% THEN LET lcontrol = 1: LET eventdata$ = "left control enabled": LET temp26 = 1
    IF findoff% THEN LET lcontrol = 0: LET eventdata$ = "left control disabled": LET temp26 = 1
END IF
IF findright% THEN
    REM enables or disables right control
    IF findon% THEN LET rcontrol = 1: LET eventdata$ = "right control enabled": LET temp26 = 1
    IF findoff% THEN LET rcontrol = 0: LET eventdata$ = "right control disabled": LET temp26 = 1
END IF
IF findselect% THEN
    REM enables or disables select control
    IF findon% THEN LET scontrol = 1: LET eventdata$ = "select control enabled": LET temp26 = 1
    IF findoff% THEN LET scontrol = 0: LET eventdata$ = "select control disabled": LET temp26 = 1
END IF
IF findpockets% THEN
    REM enables or disables up control
    IF findon% THEN LET pcontrol = 1: LET eventdata$ = "pocket control enabled": LET temp26 = 1
    IF findoff% THEN LET pcontrol = 0: LET eventdata$ = "pocket control disabled": LET temp26 = 1
END IF
IF findback% THEN
    REM enables or disables up control
    IF findon% THEN LET bcontrol = 1: LET eventdata$ = "back control enabled": LET temp26 = 1
    IF findoff% THEN LET bcontrol = 0: LET eventdata$ = "back control disabled": LET temp26 = 1
END IF
IF temp26 = 1 THEN
    REM prints to console
    LET eventtitle$ = "INPUT CONTROL:"
    LET eventnumber = 0
    GOSUB consoleprinter
END IF
RETURN

scriptruncmd:
REM launches external application
CLS
REM tells console
LET eventtitle$ = "EXTERNAL APP:"
LET eventdata$ = "Attempting to run " + seperate2$ + "..."
LET eventnumber = 0
GOSUB consoleprinter
REM saves game
IF exitsave = 1 THEN GOSUB savesave
REM disables music if needed
GOSUB musicstop
REM copies options file
IF ros$ = "lnx" OR ros$ = "mac" THEN SHELL _HIDE "cp " + sloc$ + "options.ddf " + dloc$ + "utility/options.ddf"
IF ros$ = "win" THEN SHELL _HIDE "copy " + sloc$ + "options.ddf " + dloc$ + "utility\options.ddf"
REM hides window
IF screenmode <> 1 THEN
    _SCREENHIDE
ELSE
    _FULLSCREEN _OFF
END IF
REM assigns permissions (linux + mac only)
IF ros$ = "lnx" THEN SHELL "chmod +x " + dloc$ + "utility/" + seperate2$ + "_linux"
IF ros$ = "mac" THEN SHELL "chmod +x " + dloc$ + "utility/" + seperate2$ + "_macos"
REM runs app
IF ros$ = "lnx" THEN SHELL "./" + dloc$ + "utility/" + seperate2$ + "_linux"
IF ros$ = "mac" THEN SHELL "./" + dloc$ + "utility/" + seperate2$ + "_macos"
IF ros$ = "win" THEN SHELL dloc$ + "utility\" + seperate2$ + "_win.exe"
REM deletes options file
IF ros$ = "lnx" OR ros$ = "mac" THEN SHELL _HIDE "rm " + dloc$ + "utility/options.ddf"
IF ros$ = "win" THEN SHELL _HIDE "del " + dloc$ + "utility\options.ddf"
REM shows window
IF screennode <> 1 THEN
    _SCREENSHOW
ELSE
    _FULLSCREEN _SQUAREPIXELS
END IF
REM enables sound
GOSUB musicplay
REM tells console
LET eventtitle$ = "EXTERNAL APP:"
LET eventdata$ = seperate2$ + " closed!"
LET eventnumber = 0
GOSUB consoleprinter
LET temp26 = 1
COLOR 0, 0
RETURN

scriptpilotcmd:
REM sets an NPC for script control
IF findon% THEN
    LET x = 0
    DO
        LET x = x + 1
        IF findplayer(x) THEN LET playerscript(x) = 1: LET playerwalking(x) = 0: LET playerperiod(x) = 0: LET temp26 = 1
    LOOP UNTIL x >= mapplayerno
    LET x = 0
END IF
IF findoff% THEN
    LET x = 0
    DO
        LET x = x + 1
        IF findplayer(x) THEN LET playerscript(x) = 0: LET playerperiod(x) = INT(ctime): LET temp26 = 1
    LOOP UNTIL x >= mapplayerno
    LET x = 0
END IF
RETURN

scripttriggercmd:
REM enables or disables a trigger
IF finduserandom% THEN LET tempn(2) = randomscriptvalue
IF findusevalue% THEN GOSUB scriptvaluefetcher: LET tempn(2) = fetchedvalue
IF findon% THEN
    REM trigger on
    LET triggerd(tempn(2)) = 1
    LET eventtitle$ = "TRIGGER CHANGE:"
    LET eventdata$ = "on"
    LET eventnumber = tempn(2)
    GOSUB consoleprinter
    LET temp26 = 1
END IF
IF findoff% THEN
    REM trigger off
    LET triggerd(tempn(2)) = 0
    LET eventtitle$ = "TRIGGER CHANGE:"
    LET eventdata$ = "off"
    LET eventnumber = tempn(2)
    GOSUB consoleprinter
    LET temp26 = 1
END IF
RETURN

scriptmapeffectcmd:
REM map effects
IF findoff% THEN
    LET mapeffect = 0
    LET temp26 = 1
    LET eventtitle$ = "MAP EFFECT:"
    LET eventdata$ = "off"
    LET eventnumber = mapeffect
    GOSUB consoleprinter
END IF
IF finddark% THEN
    LET mapeffect = 1
    LET temp26 = 1
    LET eventtitle$ = "MAP EFFECT:"
    LET eventdata$ = "dark"
    LET eventnumber = mapeffect
    GOSUB consoleprinter
END IF
IF findrain% THEN
    LET mapeffect = 2
    LET temp26 = 1
    LET eventtitle$ = "MAP EFFECT:"
    LET eventdata$ = "rain"
    LET eventnumber = mapeffect
    GOSUB consoleprinter
END IF
IF findstorm% THEN
    LET mapeffect = 3
    LET temp26 = 1
    LET eventtitle$ = "MAP EFFECT:"
    LET eventdata$ = "storm"
    LET eventnumber = mapeffect
    GOSUB consoleprinter
END IF
IF findtorch% THEN
    LET mapeffect = 4
    LET temp26 = 1
    LET eventtitle$ = "MAP EFFECT:"
    LET eventdata$ = "torch"
    LET eventnumber = mapeffect
    GOSUB consoleprinter
END IF
IF findsunsetright% THEN
    LET mapeffect = 5
    LET temp26 = 1
    LET eventtitle$ = "MAP EFFECT:"
    LET eventdata$ = "sunset (right)"
    LET eventnumber = mapeffect
    GOSUB consoleprinter
END IF
IF findsunsetleft% THEN
    LET mapeffect = 6
    LET temp26 = 1
    LET eventtitle$ = "MAP EFFECT:"
    LET eventdata$ = "sunset (left)"
    LET eventnumber = mapeffect
    GOSUB consoleprinter
END IF
IF findsunsetdown% THEN
    LET mapeffect = 7
    LET temp26 = 1
    LET eventtitle$ = "MAP EFFECT:"
    LET eventdata$ = "sunset (down)"
    LET eventnumber = mapeffect
    GOSUB consoleprinter
END IF
IF findsunsetup% THEN
    LET mapeffect = 8
    LET temp26 = 1
    LET eventtitle$ = "MAP EFFECT:"
    LET eventdata$ = "sunset (up)"
    LET eventnumber = mapeffect
    GOSUB consoleprinter
END IF
IF findpitchblack% THEN
    LET mapeffect = 9
    LET temp26 = 1
    LET eventtitle$ = "MAP EFFECT:"
    LET eventdata$ = "pitch black"
    LET eventnumber = mapeffect
    GOSUB consoleprinter
END IF
RETURN

scriptgivecurrencycmd:
REM gives player currency
LET currencychange = VAL(seperate2$)
IF finduserandom% THEN LET currencychange = randomscriptvalue
IF findusevalue% THEN GOSUB scriptvaluefetcher: LET currencychange = fetchedvalue
IF findsilentgivecurrency% THEN LET silentgive = 1
IF scriptskip = 1 THEN LET silentgive = 1
GOSUB givecurrency
LET temp26 = 1
RETURN

scripttakecurrencycmd:
REM takes player currency
LET currencychange = VAL(seperate2$)
IF finduserandom% THEN LET currencychange = randomscriptvalue
IF findusevalue% THEN GOSUB scriptvaluefetcher: LET currencychange = fetchedvalue
IF findsilenttakecurrency% THEN LET silenttake = 1
IF scriptskip = 1 THEN LET silenttake = 1
GOSUB takecurrency
LET temp26 = 1
RETURN

scriptspeakercmd:
REM sets speaker for text banner
LET temp86 = 1
LET temp23$ = selectobject$
LET temp61$ = selectobjectlong$
LET selectobject$ = seperate2$
LET objecttype$ = "NPC"
IF seperate2$ = "mainplayer" THEN LET objecttype$ = "OBJ"
IF seperate2$ = "nobody" THEN LET objecttype$ = "NON"
LET temp26 = 1
RETURN

scriptgiveawardcmd:
REM gives out an award, sets award to display if new.
IF awardvalue(tempn(2)) = 0 THEN
    REM grant award, set engine to display
    LET awardvalue(tempn(2)) = 1
    LET awarddisplay = tempn(2)
    REM saves award change to file
    GOSUB savetime
    REM prints to console
    LET eventtitle$ = "AWARD GRANTED:"
    LET eventdata$ = awardname$(tempn(2))
    LET eventnumber = tempn(2)
    GOSUB consoleprinter
    LET temp26 = 1
END IF
RETURN

scriptcheckpointcmd:
REM sets checkpoints
IF finduserandom% THEN LET tempn(2) = randomscriptvalue
IF findusevalue% THEN GOSUB scriptvaluefetcher: LET tempn(2) = fetchedvalue
IF findon% THEN
    REM set checkpoint on
    IF findall% THEN
        REM change all checkpoints
        FOR x = 1 TO totalcheckpoints
            LET checkpoint(x) = 1
        NEXT x
        LET temp26 = 1
    ELSE
        REM change single checkpoint
        LET checkpoint(tempn(2)) = 1: LET temp26 = 1
    END IF
    LET eventtitle$ = "CHECKPOINT CHANGE:"
    IF findall% THEN
        LET eventdata$ = "all on"
    ELSE
        LET eventdata$ = "on"
    END IF
    LET eventnumber = tempn(2)
    GOSUB consoleprinter
END IF
IF findoff% THEN
    REM set checkpoint off
    IF findall% THEN
        REM change all checkpoints
        FOR x = 1 TO totalcheckpoints
            LET checkpoint(x) = 0
        NEXT x
        LET temp26 = 1
    ELSE
        REM change single checkpoint
        LET checkpoint(tempn(2)) = 0: LET temp26 = 1
    END IF
    LET eventtitle$ = "CHECKPOINT CHANGE:"
    IF findall% THEN
        LET eventdata$ = "all off"
    ELSE
        LET eventdata$ = "off"
    END IF
    LET eventnumber = tempn(2)
    GOSUB consoleprinter
END IF
RETURN

scriptifvaluecmd:
REM checks script values
LET ifvalueresult = 0
IF findabove% THEN
    REM above
    IF scriptvalue(tempn(2)) > tempn(4) THEN LET ifvalueresult = 1
END IF
IF findbelow% THEN
    REM below
    IF scriptvalue(tempn(2)) < tempn(4) THEN LET ifvalueresult = 1
END IF
IF findequal% THEN
    REM equal
    IF scriptvalue(tempn(2)) = tempn(4) THEN LET ifvalueresult = 1
END IF
IF ifvalueresult = 1 THEN
    REM conditions met! divert to new script!
    LET temp26 = 2
    REM enables a spoof trigger to run a script
    LET triggerspoofa = 1
    LET nextmapscript = mapscript
    LET nodraw = 1
    REM calculates how many values to take from the script filename
    IF temp201 <> 0 THEN
        GOSUB scriptnametrim
    ELSE
        LET scriptnametrim = 9
    END IF
    REM checks how many times ifvalue has been run
    IF temp200 <> 1 THEN LET ifvalueno = ifvalueno + 1
    IF ifvalueno > 1 THEN
        IF temp201 = 10 THEN
            IF ifvalueno <= 10 THEN LET scriptname$ = LEFT$(scriptname$, LEN(scriptname$) - scriptnametrim)
            IF ifvalueno > 10 THEN LET scriptname$ = LEFT$(scriptname$, LEN(scriptname$) - (scriptnametrim + 1))
        END IF
    END IF
    LET triggerspoofname$ = scriptname$ + "-ifvalue" + LTRIM$(STR$(ifvalueno))
    LET temp33 = 2
    LET temp200 = 10
    LET temp201 = temp200
END IF
RETURN

scriptifrandomcmd:
REM checks random numbers
LET ifrandomresult = 0
IF findabove% THEN
    REM above
    IF randomscriptvalue > tempn(3) THEN LET ifrandomresult = 1
END IF
IF findbelow% THEN
    REM below
    IF randomscriptvalue < tempn(3) THEN LET ifrandomresult = 1
END IF
IF findequal% THEN
    REM equal
    IF randomscriptvalue = tempn(3) THEN LET ifrandomresult = 1
END IF
IF ifrandomresult = 1 THEN
    REM conditions met! divert to new script!
    LET temp26 = 2
    REM enables a spoof trigger to run a script
    LET triggerspoofa = 1
    LET nextmapscript = mapscript
    LET nodraw = 1
    REM calculates how many values to take from the script filename
    IF temp201 <> 0 THEN
        GOSUB scriptnametrim
    ELSE
        LET scriptnametrim = 10
    END IF
    REM checks how many times ifrandom has been run
    IF temp200 <> 1 THEN LET ifrandomno = ifrandomno + 1
    IF ifrandomno > 1 THEN
        IF temp201 = 9 THEN
            IF ifrandomno <= 10 THEN LET scriptname$ = LEFT$(scriptname$, LEN(scriptname$) - scriptnametrim)
            IF ifrandomno > 10 THEN LET scriptname$ = LEFT$(scriptname$, LEN(scriptname$) - (scriptnametrim + 1))
        END IF
    END IF
    LET triggerspoofname$ = scriptname$ + "-ifrandom" + LTRIM$(STR$(ifrandomno))
    LET temp33 = 2
    LET temp200 = 9
    LET temp201 = temp200
END IF
RETURN

scriptifcheckpointcmd:
REM checks checkpoints
IF finduserandom% THEN LET tempn(2) = randomscriptvalue
IF findusevalue% THEN GOSUB scriptvaluefetcher: LET tempn(2) = fetchedvalue
LET ifcheckpointresult = 0
IF checkpoint(tempn(2)) = 1 THEN LET ifcheckpointresult = 1
IF ifcheckpointresult = 1 THEN
    REM diverts script if requested checkpoint is active
    LET temp26 = 2
    REM enables a spoof trigger to run a script
    LET triggerspoofa = 1
    LET nextmapscript = mapscript
    LET nodraw = 1
    REM calculates how many values to take from the script filename
    IF temp201 <> 0 THEN
        GOSUB scriptnametrim
    ELSE
        LET scriptnametrim = 14
    END IF
    REM checks how many times ifcheckpoint has been run
    IF temp200 <> 1 THEN LET ifcheckpointno = ifcheckpointno + 1
    IF ifcheckpointno > 1 THEN
        IF temp201 = 1 THEN
            IF ifcheckpointno <= 10 THEN LET scriptname$ = LEFT$(scriptname$, LEN(scriptname$) - scriptnametrim)
            IF ifcheckpointno > 10 THEN LET scriptname$ = LEFT$(scriptname$, LEN(scriptname$) - (scriptnametrim + 1))
        END IF
    END IF
    LET triggerspoofname$ = scriptname$ + "-ifcheckpoint" + LTRIM$(STR$(ifcheckpointno))
    LET temp33 = 2
    LET temp200 = 1
    LET temp201 = temp200
END IF
RETURN

scriptifcurrencycmd:
REM checks pocket for currency amount
LET ifcurrencyamount = tempn(2)
IF finduserandom% THEN LET ifcurrencyamount = randomscriptvalue
IF findusevalue% THEN GOSUB scriptvaluefetcher: LET ifcurrencyamount = fetchedvalue
LET ifcurrencyresult = 0
GOSUB ifcurrency
LET temp26 = 1
IF ifcurrencyresult = 1 THEN
    REM diverts script if player has enough currency
    LET temp26 = 2
    REM enables a spoof trigger to run a script
    LET triggerspoofa = 1
    LET nextmapscript = mapscript
    LET nodraw = 1
    REM calculates how many values to take from the script filename
    IF temp201 <> 0 THEN
        GOSUB scriptnametrim
    ELSE
        LET scriptnametrim = 12
    END IF
    REM checks how many times ifcurrency has been run
    IF temp200 <> 2 THEN LET ifcurrencyno = ifcurrencyno + 1
    IF ifcurrencyno > 1 THEN
        IF temp201 = 2 THEN
            IF ifcurrencyno <= 10 THEN LET scriptname$ = LEFT$(scriptname$, LEN(scriptname$) - scriptnametrim)
            IF ifcurrencyno > 10 THEN LET scriptname$ = LEFT$(scriptname$, LEN(scriptname$) - (scriptnametrim + 1))
        END IF
    END IF
    LET triggerspoofname$ = scriptname$ + "-ifcurrency" + LTRIM$(STR$(ifcurrencyno))
    LET temp33 = 2
    LET temp200 = 2
    LET temp201 = temp200
END IF
RETURN

scriptifdirectioncmd:
REM checks if mainplayer is standing in certain direction
IF finduserandom% THEN LET tempn(2) = randomscriptvalue
IF findusevalue% THEN GOSUB scriptvaluefetcher: LET tempn(2) = fetchedvalue
LET temp26 = 1
IF direction = tempn(2) THEN
    REM diverts script if direction matches check
    LET temp26 = 2
    LET temp140 = 0
    REM enables a spoof trigger to run a script
    LET triggerspoofa = 1
    LET nextmapscript = mapscript
    LET nodraw = 1
    REM calculates how many values to take from the script filename
    IF temp201 <> 0 THEN
        GOSUB scriptnametrim
    ELSE
        LET scriptnametrim = 13
    END IF
    REM checks how many times ifdirection has been run
    IF temp200 <> 3 THEN LET ifdirectionno = ifdirectionno + 1
    IF ifdirectionno > 1 THEN
        IF temp201 = 3 THEN
            IF ifdirectionno <= 10 THEN LET scriptname$ = LEFT$(scriptname$, LEN(scriptname$) - scriptnametrim)
            IF ifdirectionno > 10 THEN LET scriptname$ = LEFT$(scriptname$, LEN(scriptname$) - (scriptnametrim + 1))
        END IF
    END IF
    LET triggerspoofname$ = scriptname$ + "-ifdirection" + LTRIM$(STR$(ifdirectionno))
    LET temp33 = 2
    LET temp200 = 3
    LET temp201 = temp200
END IF
RETURN

scriptifawardcmd:
REM checks if award has been granted
LET ifaward = tempn(2)
LET ifawardresult = 0
GOSUB ifaward
LET temp26 = 1
IF ifawardresult = 1 THEN
    REM diverts script if award is granted
    LET temp26 = 2
    LET triggerspoofa = 1
    LET nextmapscript = mapscript
    LET nodraw = 1
    REM calculates how many values to take from the script filename
    IF temp201 <> 0 THEN
        GOSUB scriptnametrim
    ELSE
        LET scriptnametrim = 9
    END IF
    REM checks how many times ifaward has been run
    IF temp200 <> 11 THEN LET ifawardno = ifawardno + 1
    IF ifawardno > 1 THEN
        IF temp201 = 11 THEN
            IF ifawardno <= 9 THEN LET scriptname$ = LEFT$(scriptname$, LEN(scriptname$) - scriptnametrim)
            IF ifawardno > 9 THEN LET scriptname$ = LEFT$(scriptname$, LEN(scriptname$) - (scriptnametrim + 1))
        END IF
    END IF
    LET triggerspoofname$ = scriptname$ + "-ifaward" + LTRIM$(STR$(ifawardno))
    LET temp33 = 2
    LET temp200 = 11
    LET temp201 = temp200
END IF
RETURN

scriptifpocketcmd:
REM checks pocket for item
LET ifpocket$ = temps$(2)
LET ifpocket = 0
GOSUB ifpocket
LET temp26 = 1
IF ifpocket = 1 OR ifpocket = 2 THEN
    REM diverts script if item is in pocket or is gone forever
    LET temp26 = 2
    REM enables a spoof trigger to run a script
    LET triggerspoofa = 1
    LET nextmapscript = mapscript
    LET nodraw = 1
    REM calculates how many values to take from the script filename
    IF temp201 <> 0 THEN
        GOSUB scriptnametrim
    ELSE
        LET scriptnametrim = 10
    END IF
    REM checks how many times ifpocket has been run
    IF temp200 <> 4 THEN LET ifpocketno = ifpocketno + 1
    IF ifpocketno > 1 THEN
        IF temp201 = 4 THEN
            IF ifpocketno <= 10 THEN LET scriptname$ = LEFT$(scriptname$, LEN(scriptname$) - scriptnametrim)
            IF ifpocketno > 10 THEN LET scriptname$ = LEFT$(scriptname$, LEN(scriptname$) - (scriptnametrim + 1))
        END IF
    END IF
    LET triggerspoofname$ = scriptname$ + "-ifpocket" + LTRIM$(STR$(ifpocketno))
    LET temp33 = 2
    LET temp200 = 4
    LET temp201 = temp200
END IF
RETURN

scriptifholdingcmd:
REM checks players hand for item
LET ifholding$ = temps$(2)
LET ifholding = 0
GOSUB ifholding
LET temp26 = 1
IF ifholding = 1 THEN
    REM diverts script if item is in hand
    LET temp26 = 2
    REM enables a spoof trigger to run a script
    LET triggerspoofa = 1
    LET nextmapscript = mapscript
    LET nodraw = 1
    REM calculates how many values to take from the script filename
    IF temp201 <> 0 THEN
        GOSUB scriptnametrim
    ELSE
        LET scriptnametrim = 1
    END IF
    REM checks how many times ifholding has been run
    IF temp200 <> 5 THEN LET ifholdingno = ifholdingno + 1
    IF ifholdingno > 1 THEN
        IF temp201 = 5 THEN
            IF ifholdingno <= 10 THEN LET scriptname$ = LEFT$(scriptname$, LEN(scriptname$) - scriptnametrim)
            IF ifholdingno > 10 THEN LET scriptname$ = LEFT$(scriptname$, LEN(scriptname$) - (scriptnametrim + 1))
        END IF
    END IF
    LET triggerspoofname$ = scriptname$ + "-ifholding" + LTRIM$(STR$(ifholdingno))
    LET temp33 = 2
    LET temp200 = 5
    LET temp201 = temp200
END IF
RETURN

scriptifmodelcmd:
REM checks to see if player is using a certain sprite model
LET ifmodel = 0
LET ifmodel$ = temps$(2)
GOSUB ifmodel
LET temp26 = 1
IF ifmodel = 1 THEN
    REM diverts script if player model is correct
    LET temp26 = 2
    REM enables a spoof trigger to run a script
    LET triggerspoofa = 1
    LET nextmapscript = mapscript
    LET nodraw = 1
    REM calculates how many values to take from the script filename
    IF temp201 <> 0 THEN
        GOSUB scriptnametrim
    ELSE
        LET scriptnametrim = 9
    END IF
    REM checks how many times ifmodel has been run
    IF temp200 <> 6 THEN LET ifmodelno = ifmodelno + 1
    IF ifmodelno > 1 THEN
        IF temp201 = 6 THEN
            IF ifmodelno <= 10 THEN LET scriptname$ = LEFT$(scriptname$, LEN(scriptname$) - scriptnametrim)
            IF ifmodelno > 10 THEN LET scriptname$ = LEFT$(scriptname$, LEN(scriptname$) - (scriptnametrim + 1))
        END IF
    END IF
    LET triggerspoofname$ = scriptname$ + "-ifmodel" + LTRIM$(STR$(ifmodelno))
    LET temp33 = 2
    LET temp200 = 6
    LET temp201 = temp200
END IF
RETURN

scriptifmapnocmd:
REM checks to see if player is on a certain map
LET ifmapno = tempn(2)
IF finduserandom% THEN LET ifmapno = randomscriptvalue
IF findusevalue% THEN GOSUB scriptvaluefetcher: LET ifmapno = fetchedvalue
LET ifmapnoresult = 0
GOSUB ifmapno
LET temp26 = 1
IF ifmapnoresult = 1 THEN
    REM diverts script if map number is correct
    LET temp26 = 2
    REM enables a spoof trigger to run a script
    LET triggerspoofa = 1
    LET nextmapscript = mapscript
    LET nodraw = 1
    REM calculates how many values to take from the script filename
    IF temp201 <> 0 THEN
        GOSUB scriptnametrim
    ELSE
        LET scriptnametrim = 9
    END IF
    REM checks how many times ifmapno has been run
    IF temp200 <> 7 THEN LET ifmapnono = ifmapnono + 1
    IF ifmapnono > 1 THEN
        IF temp201 = 7 THEN
            IF ifmapnono <= 10 THEN LET scriptname$ = LEFT$(scriptname$, LEN(scriptname$) - scriptnametrim)
            IF ifmapnono > 10 THEN LET scriptname$ = LEFT$(scriptname$, LEN(scriptname$) - (scriptnametrim + 1))
        END IF
    END IF
    LET triggerspoofname$ = scriptname$ + "-ifmapno" + LTRIM$(STR$(ifmapnono))
    LET temp33 = 2
    LET temp200 = 7
    LET temp201 = temp200
END IF
RETURN

scriptifgonecmd:
REM checks pocket item to see if it has been marked "gone forever"
LET ifgone$ = temps$(2)
LET ifgone = 0
GOSUB ifgone
LET temp26 = 1
IF ifgone = 2 THEN
    REM diverts script if item is in hand
    LET temp26 = 2
    REM enables a spoof trigger to run a script
    LET triggerspoofa = 1
    LET nextmapscript = mapscript
    LET nodraw = 1
    REM calculates how many values to take from the script filename
    IF temp201 <> 0 THEN
        GOSUB scriptnametrim
    ELSE
        LET scriptnametrim = 8
    END IF
    REM checks how many times ifgone has been run
    IF temp200 <> 7 THEN LET ifgoneno = ifgoneno + 1
    IF ifgoneno > 1 THEN
        IF temp201 = 8 THEN
            IF ifgoneno <= 10 THEN LET scriptname$ = LEFT$(scriptname$, LEN(scriptname$) - scriptnametrim)
            IF ifgoneno > 10 THEN LET scriptname$ = LEFT$(scriptname$, LEN(scriptname$) - (scriptnametrim + 1))
        END IF
    END IF
    LET triggerspoofname$ = scriptname$ + "-ifgone" + LTRIM$(STR$(ifgoneno))
    LET temp33 = 2
    LET temp200 = 8
    LET temp201 = temp200
END IF
RETURN

scriptgivecmd:
REM gives main player an item
LET giveitem$ = temps$(2)
IF findall% THEN
    FOR temp140 = 1 TO pocketnos
        IF pocketitem(temp140) = 0 THEN LET pocketitem(temp140) = 1: LET pocketcarry = pocketcarry + 1
    NEXT temp140
    LET eventtitle$ = "POCKET ITEM GIVEN:"
    LET eventdata$ = "all items"
    LET eventnumber = pocketnos
    GOSUB consoleprinter
    LET temp26 = 1
ELSE
    IF findsilentgive% THEN LET silentgive = 1
    IF scriptskip = 1 THEN LET silentgive = 1
    GOSUB giveitem
    IF pocketfile$ = giveitem$ THEN LET temp26 = 1
END IF
RETURN

scripthidecmd:
REM hides item
LET hideitem$ = temps$(2)
IF findall% THEN
    REM hides all pocket items
    FOR temp140 = 1 TO totalpockets
        LET pocketvisible(temp140) = 0
    NEXT temp140
    LET eventtitle$ = "POCKET ITEM HIDDEN:"
    LET eventdata$ = "all items"
    LET eventnumber = pocketnos
    GOSUB consoleprinter
    LET temp26 = 1
ELSE
    REM hides one pocket item
    GOSUB hideitem
    IF pocketfile$ = hideitem$ THEN LET temp26 = 1
END IF
RETURN

scriptshowcmd:
REM shows a pocket item
LET showitem$ = temps$(2)
IF findall% THEN
    REM shows all pocket items
    FOR temp140 = 1 TO totalpockets
        LET pocketvisible(temp140) = 1
    NEXT temp140
    LET eventtitle$ = "POCKET ITEM VISIBLE:"
    LET eventdata$ = "all items"
    LET eventnumber = pocketnos
    GOSUB consoleprinter
    LET temp26 = 1
ELSE
    REM shows one pocket items
    GOSUB showitem
    IF pocketfile$ = showitem$ THEN LET temp26 = 1
END IF
RETURN

scripttakecmd:
REM takes item off main player
LET takeitem$ = temps$(2)
IF findall% THEN
    FOR temp140 = 1 TO pocketnos
        IF pocketitem(temp140) = 1 THEN LET pocketitem(temp140) = 0: LET pocketcarry = pocketcarry - 1
    NEXT temp140
    LET eventtitle$ = "POCKET ITEM TAKEN:"
    LET eventdata$ = "all items"
    LET eventnumber = pocketnos
    GOSUB consoleprinter
    LET temp26 = 1
ELSE
    IF findsilenttake% THEN LET silenttake = 1
    IF scriptskip = 1 THEN LET silenttake = 1
    GOSUB takeitem
    IF pocketfile$ = takeitem$ THEN LET temp26 = 1
END IF
RETURN

scriptwaitcmd:
REM waits
IF finduserandom% THEN LET tempn(2) = randomscriptvalue
IF findusevalue% THEN GOSUB scriptvaluefetcher: LET tempn(2) = fetchedvalue
GOSUB timeframecounter
LET scriptwaittime = ctime + tempn(2)
IF scriptskip = 1 THEN LET scriptwaittime = 0
DO
    IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN IF skipallowed = 1 THEN LET scriptskip = 1: LET scriptwaittime = 0
    GOSUB gameloop
LOOP UNTIL ctime >= scriptwaittime
LET scriptwaittime = 0
LET temp26 = 1
RETURN

scripthaltcmd:
REM halts engine
IF finduserandom% THEN LET tempn(2) = randomscriptvalue
IF findusevalue% THEN GOSUB scriptvaluefetcher: LET tempn(2) = fetchedvalue
GOSUB timeframecounter
LET scriptwaittime = ctime + tempn(2)
DO
    _LIMIT hertz
    GOSUB timeframecounter
LOOP UNTIL ctime >= scriptwaittime
LET scriptwaittime = 0
LET temp26 = 1
RETURN

scriptmapcmd:
REM map change
REM copies old values
LET oldmapno = mapno
LET oldmapname$ = mapname$
REM if requested map is random
IF finduserandom% THEN LET tempn(2) = randomscriptvalue
IF findusevalue% THEN GOSUB scriptvaluefetcher: LET tempn(2) = fetchedvalue
LET mapno = tempn(2)
GOSUB mapload
LET temp26 = 1
RETURN

scriptwarpcmd:
REM warps players and objects
IF findmainplayer% THEN
    REM main player
    IF finduserandom% THEN LET tempn(4) = randomscriptvalue
    IF findusevalue% THEN GOSUB scriptvaluefetcher: LET tempn(4) = fetchedvalue
    IF findminus% AND tempn(4) >= 1000 THEN LET tempn(4) = (tempn(4) - tempn(4)) - tempn(4)
    IF findx% THEN LET posx = ((resx / 2) - tempn(4)): LET temp26 = 1
    IF findy% THEN LET posy = ((resy / 2) - tempn(4)): LET temp26 = 1
END IF
IF findobject% THEN
    IF finduserandom% THEN LET tempn(5) = randomscriptvalue
    IF findusevalue% THEN GOSUB scriptvaluefetcher: LET tempn(5) = fetchedvalue
    IF findminus% AND tempn(5) >= 1000 THEN LET tempn(5) = (tempn(5) - tempn(5)) - tempn(5)
    LET x = 0
    DO
        LET x = x + 1
        IF findobject(x) THEN
            IF findx% THEN LET objectx(x) = tempn(5): LET temp26 = 1
            IF findy% THEN LET objecty(x) = tempn(5): LET temp26 = 1
        END IF
    LOOP UNTIL x >= mapobjectno
    LET x = 0
END IF
IF findplayer% THEN
    IF finduserandom% THEN LET tempn(5) = randomscriptvalue
    IF findusevalue% THEN GOSUB scriptvaluefetcher: LET tempn(5) = fetchedvalue
    IF findminus% AND tempn(5) >= 1000 THEN LET tempn(5) = (tempn(5) - tempn(5)) - tempn(5)
    LET x = 0
    DO
        LET x = x + 1
        IF findplayer(x) THEN
            IF findx% THEN LET playerx(x) = tempn(5): LET temp26 = 1
            IF findy% THEN LET playery(x) = tempn(5): LET temp26 = 1
        END IF
    LOOP UNTIL x >= mapplayerno
    LET x = 0
END IF
RETURN

scriptmusiccmd:
REM changes music
IF findcontrol% THEN
    IF findfade% = 0 AND findcut% = 0 THEN
        REM plays or stops music
        IF findplay% THEN
            IF musicpause = 0 THEN
                LET playmusic$ = oldmusic$: GOSUB musicplay: LET temp26 = 1
            ELSE
                GOSUB musicplay: LET temp26 = 1
            END IF
        END IF
        IF findstop% THEN GOSUB musicstop: LET temp26 = 1
        IF findpause% THEN GOSUB musicpause: LET temp26 = 1
    END IF
    IF findfade% THEN
        IF findoff% THEN
            LET tempmusicfade = 0
            LET temp26 = 1
        END IF
        IF findon% THEN
            LET tempmusicfade = 1
            LET temp26 = 1
            IF tempmusiccut = 1 THEN LET tempmusiccut = 0
        END IF
    END IF
    IF findcut% THEN
        IF findoff% THEN
            LET tempmusiccut = 0
            LET temp26 = 1
        END IF
        IF findon% THEN
            LET tempmusiccut = 1
            LET temp26 = 1
            IF tempmusicfade = 1 THEN LET tempmusicfade = 0
        END IF
    END IF
END IF
IF findfile% THEN
    REM changes current music files and plays (and stops previous music)
    LET playmusic$ = temps$(3)
    GOSUB musicplay
    LET temp26 = 1
END IF
RETURN

scriptscriptcmd:
REM runs script
LET temp26 = 2
LET temp200 = 999
REM enables a spoof trigger to run a script
LET triggerspoofa = 1
LET triggerspoofname$ = temps$(2)
LET temp33 = 2
LET nextmapscript = 1
LET eventtitle$ = "SCRIPT DIVERT:"
LET eventdata$ = triggerspoofname$
LET eventnumber = scriptline
GOSUB consoleprinter
RETURN

scriptanimatecmd:
IF findmainplayer% THEN
    REM animates mainplayer
    IF scriptskip = 0 THEN LET anisprite$ = "mainplayer"
    LET anifile$ = temps$(3)
    IF scriptskip = 0 THEN GOSUB animation
    LET temp26 = 1
END IF
IF findplayer% THEN
    LET x = 0
    DO
        LET x = x + 1
        IF findplayer(x) THEN
            REM animates NPC
            IF scriptskip = 0 THEN LET anisprite$ = playername(x)
            LET anifile$ = temps$(4)
            IF scriptskip = 0 THEN GOSUB animation
            LET temp26 = 1
            RETURN
        END IF
    LOOP UNTIL x >= mapplayerno
    LET x = 0
END IF
IF findobject% THEN
    LET x = 0
    DO
        LET x = x + 1
        IF findobject(x) THEN
            REM animates object
            IF scriptskip = 0 THEN LET anisprite$ = objectname(x)
            LET anifile$ = temps$(4)
            IF scriptskip = 0 THEN GOSUB animation
            LET temp26 = 1
            RETURN
        END IF
    LOOP UNTIL x >= mapobjectno
    LET x = 0
END IF
RETURN

scriptmovecmd:
REM moves a player or object
REM sets move speed
IF findmove% THEN
	IF findmainplayer% THEN 
		LET temp131 = (pace / playerwalkdivide)
	ELSE
		LET temp131 = (pace / playerwalkdivide)
	END IF
ELSE
	IF findmainplayer% THEN
		LET temp131 = pace
	ELSE
		LET temp131 = pace
	END IF
END IF
IF findmainplayer% THEN
	IF finduserandom% THEN LET tempn(4) = randomscriptvalue
	IF findusevalue% THEN GOSUB scriptvaluefetcher: LET tempn(4) = fetchedvalue
	IF findminus% AND tempn(4) >= 1000 THEN LET tempn(4) = (tempn(4) - tempn(4)) - tempn(4)
ELSE
	IF finduserandom% THEN LET tempn(5) = randomscriptvalue
	IF findusevalue% THEN GOSUB scriptvaluefetcher: LET tempn(5) = fetchedvalue
	IF findminus% AND tempn(5) >= 1000 THEN LET tempn(5) = (tempn(5) - tempn(5)) - tempn(5)
END IF
IF findobject% THEN
    REM object
    IF findx% THEN
        REM X
        LET x = 0
        DO
            LET x = x + 1
            IF findobject(x) AND objectx(x) <> tempn(5) THEN
                IF scriptskip = 1 THEN LET objectx(x) = tempn(5): LET temp56 = 1
                DO
                    IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN IF skipallowed = 1 THEN LET scriptskip = 1: LET objectx(x) = tempn(5): LET temp56 = 1
                    IF objectx(x) > tempn(5) THEN
                        LET objectx(x) = objectx(x) - (temp131 * objectspeed(x))
                        IF objectx(x) <= tempn(5) THEN LET temp56 = 1
                    END IF
                    IF objectx(x) < tempn(5) THEN
                        LET objectx(x) = objectx(x) + (temp131 * objectspeed(x))
                        IF objectx(x) >= tempn(5) THEN LET temp56 = 1
                    END IF
                    GOSUB gameloop
                LOOP UNTIL temp56 = 1
                IF objectx(x) <> tempn(5) THEN LET objectx(x) = tempn(5)
                LET temp26 = 1
            END IF
        LOOP UNTIL x >= mapobjectno
        LET x = 0
    END IF
    IF findy% THEN
        REM Y
        LET x = 0
        DO
            LET x = x + 1
            IF findobject(x) AND objecty(x) <> tempn(5) THEN
                IF scriptskip = 1 THEN LET objecty(x) = tempn(5): LET temp56 = 1
                DO
                    IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN IF skipallowed = 1 THEN LET scriptskip = 1: LET objecty(x) = tempn(5): LET temp56 = 1
                    IF objecty(x) > tempn(5) THEN
                        LET objecty(x) = objecty(x) - (temp131 * objectspeed(x))
                        IF objecty(x) <= tempn(5) THEN LET temp56 = 1
                    END IF
                    IF objecty(x) < tempn(5) THEN
                        LET objecty(x) = objecty(x) + (temp131 * objectspeed(x))
                        IF objecty(x) >= tempn(5) THEN LET temp56 = 1
                    END IF
                    GOSUB gameloop
                LOOP UNTIL temp56 = 1
                IF objecty(x) <> tempn(5) THEN LET objecty(x) = tempn(5)
                LET temp26 = 1
            END IF
        LOOP UNTIL x >= mapobjectno
        LET x = 0
    END IF
    RETURN
END IF
IF findmainplayer% THEN
    REM mainplayer
    REM sets movement value
    IF findx% THEN
        IF scriptskip = 1 THEN LET posx = ((resx / 2) - tempn(4))
        IF ((resx / 2) - posx) > tempn(4) THEN
            IF findback% THEN
                LET direction = 3
            ELSE
                LET direction = 4
            END IF
            LET temp26 = 1
            LET mpwalking = 1
            DO
                IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN IF skipallowed = 1 THEN LET scriptskip = 1: LET posx = ((resx / 2) - tempn(4))
                LET posx = posx + (temp131)
                IF posx = INT(posx) THEN GOSUB gameloop
            LOOP UNTIL ((resx / 2) - posx) <= tempn(4)
            LET mpwalking = 0
        END IF
        IF ((resx / 2) - posx) < tempn(4) THEN
            IF findback% THEN
                LET direction = 4
            ELSE
                LET direction = 3
            END IF
            LET temp26 = 1
            LET mpwalking = 1
            DO
                IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN IF skipallowed = 1 THEN LET scriptskip = 1: LET posx = ((resx / 2) - tempn(4))
                LET posx = posx - (temp131)
                IF posx = INT(posx) THEN GOSUB gameloop
            LOOP UNTIL ((resx / 2) - posx) >= tempn(4)
            LET mpwalking = 0
        END IF
    END IF
    IF findy% THEN
        IF scriptskip = 1 THEN LET posy = ((resy / 2) - tempn(4))
        IF ((resy / 2) - posy) > tempn(4) THEN
            IF findback% THEN
                LET direction = 2
            ELSE
                LET direction = 1
            END IF
            LET temp26 = 1
            LET mpwalking = 1
            DO
                IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN IF skipallowed = 1 THEN LET scriptskip = 1: LET posy = ((resy / 2) - tempn(4))
                LET posy = posy + (temp131)
                IF posy = INT(posy) THEN GOSUB gameloop
            LOOP UNTIL ((resy / 2) - posy) <= tempn(4)
            LET mpwalking = 0
        END IF
        IF ((resy / 2) - posy) < tempn(4) THEN
            IF findback% THEN
                LET direction = 1
            ELSE
                LET direction = 2
            END IF
            LET temp26 = 1
            LET mpwalking = 1
            DO
                IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN IF skipallowed = 1 THEN LET scriptskip = 1: LET posy = ((resy / 2) - tempn(4))
                LET posy = posy - (temp131)
                IF posy = INT(posy) THEN GOSUB gameloop
            LOOP UNTIL ((resy / 2) - posy) >= tempn(4)
            LET mpwalking = 0
        END IF
    END IF
    RETURN
END IF
IF findplayer% THEN
    REM NPC
    IF findx% THEN
        REM X
        LET x = 0
        DO
            LET x = x + 1
            IF findplayer(x) AND playerx(x) <> tempn(5) THEN
                LET playerwalking(x) = 1
                IF scriptskip = 1 THEN LET playerx(x) = tempn(5): LET temp56 = 1
                DO
                    IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN IF skipallowed = 1 THEN LET scriptskip = 1: LET playerx(x) = tempn(5): LET temp56 = 1
                    IF playerx(x) > tempn(5) THEN
                        LET playerx(x) = playerx(x) - (temp131 * playerspeed(x))
                        IF findback% THEN
                            LET playerd(x) = 3
                        ELSE
                            LET playerd(x) = 4
                        END IF
                        IF playerx(x) <= tempn(5) THEN LET temp56 = 1
                    END IF
                    IF playerx(x) < tempn(5) THEN
                        LET playerx(x) = playerx(x) + (temp131 * playerspeed(x))
                        IF findback% THEN
                            LET playerd(x) = 4
                        ELSE
                            LET playerd(x) = 3
                        END IF
                        IF playerx(x) >= tempn(5) THEN LET temp56 = 1
                    END IF
                    GOSUB gameloop
                LOOP UNTIL temp56 = 1
                IF playerx(x) <> tempn(5) THEN LET playerx(x) = tempn(5)
                LET playerwalking(x) = 0
                LET temp26 = 1
            END IF
        LOOP UNTIL x >= mapplayerno
        LET x = 0
    END IF
    IF findy% THEN
        REM Y
        LET x = 0
        DO
            LET x = x + 1
            IF findplayer(x) AND playery(x) <> tempn(5) THEN
                IF scriptskip = 1 THEN LET playery(x) = tempn(5): LET temp56 = 1
                LET playerwalking(x) = 1
                DO
                    IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN IF skipallowed = 1 THEN LET scriptskip = 1: LET playery(x) = tempn(5): LET temp56 = 1
                    IF playery(x) > tempn(5) THEN
                        LET playery(x) = playery(x) - (temp131 * playerspeed(x))
                        IF findback% THEN
                            LET playerd(x) = 2
                        ELSE
                            LET playerd(x) = 1
                        END IF
                        IF playery(x) <= tempn(5) THEN LET temp56 = 1
                    END IF
                    IF playery(x) < tempn(5) THEN
                        LET playery(x) = playery(x) + (temp131 * playerspeed(x))
                        IF findback% THEN
                            LET playerd(x) = 1
                        ELSE
                            LET playerd(x) = 2
                        END IF
                        IF playery(x) >= tempn(5) THEN LET temp56 = 1
                    END IF
                    GOSUB gameloop
                LOOP UNTIL temp56 = 1
                IF playery(x) <> tempn(5) THEN LET playery(x) = tempn(5)
                LET playerwalking(x) = 0
                LET temp26 = 1
            END IF
        LOOP UNTIL x >= mapplayerno
        LET x = 0
    END IF
END IF
RETURN

scriptdirectioncmd:
REM changes direction of player
IF findmainplayer% THEN
	REM main player
    IF finduserandom% THEN LET tempn(3) = randomscriptvalue
    IF findusevalue% THEN GOSUB scriptvaluefetcher: LET tempn(3) = fetchedvalue
    LET direction = tempn(3)
    LET temp26 = 1
END IF
IF findplayer% THEN
    IF findfaceplayer% THEN
		IF direction = 1 THEN LET tempn(4) = 2
        IF direction = 2 THEN LET tempn(4) = 1
        IF direction = 3 THEN LET tempn(4) = 4
        IF direction = 4 THEN LET tempn(4) = 3
    ELSE
        IF finduserandom% THEN LET tempn(4) = randomscriptvalue
        IF findusevalue% THEN GOSUB scriptvaluefetcher: LET tempn(4) = fetchedvalue
    END IF
    LET x = 0
    DO
		LET x = x + 1
        IF findplayer(x) THEN LET playerd(x) = tempn(4): LET temp26 = 1
    LOOP UNTIL x >= mapplayerno
    LET x = 0
END IF
RETURN

script:
REM VaME STAGE DIRECTOR SCRIPT UTILITY
IF mapscript = 1 THEN LET mapscriptdir$ = mapdir$
IF mapscript = 2 THEN LET mapscriptdir$ = "combine/"
IF mapscript = 3 THEN LET mapscriptdir$ = "pocket/"
IF mapscript = 4 THEN LET mapscriptdir$ = "timer/"
IF mapscript = 5 THEN LET mapscriptdir$ = "system/"
IF _FILEEXISTS(scriptloc$ + mapscriptdir$ + scriptname$ + ".vsf") THEN
    OPEN scriptloc$ + mapscriptdir$ + scriptname$ + ".vsf" FOR INPUT AS #3
ELSE
    ERROR 423
    LET temp33 = 1
    LET temp26 = 1
    RETURN
END IF
LET scriptrun = 1: REM sets script value to running
LET awarddisplay = 0
LET oldscript$ = scriptname$
IF triggerspoofa = 1 THEN LET triggerspoofa = 0
REM prints to console
LET eventtitle$ = "SCRIPT LAUNCHED:"
LET eventdata$ = scriptname$
LET eventnumber = 0
GOSUB consoleprinter
DO
    LET scriptline = scriptline + 1: REM counts lines of script
    REM inputs a line from script file and searches for key commands and arguments
    INPUT #3, scriptline$
    LET scriptline$ = LCASE$(scriptline$): REM makes script line lower case
    REM allows script control
    IF scriptline$ = "allowcontrol" THEN
        IF allowscriptcontrol = 0 THEN
            LET allowscriptcontrol = 1
            LET temp26 = 1
            LET eventtitle$ = "SCRIPT CONTROLS:"
            LET eventdata$ = "enabled!"
            LET eventnumber = 0
            GOSUB consoleprinter
        ELSE
            LET eventtitle$ = "SCRIPT CONTROLS:"
            LET eventdata$ = "already enabled!"
            LET eventnumber = 0
            GOSUB consoleprinter
        END IF
    END IF
    IF allowscriptcontrol = 0 THEN IF scriptline = 1 THEN LET mpwalking = 0: LET diagonalmove = 1: REM prevents eternal moonwalk
    LET findfade% = INSTR(findfade% + 1, scriptline$, "fade")
    LET findwait% = INSTR(findwait% + 1, scriptline$, "wait")
    LET findmap% = INSTR(findmap% + 1, scriptline$, "map ")
    LET findwarp% = INSTR(findwarp% + 1, scriptline$, "warp")
    LET findmainplayer% = INSTR(findin% + 1, scriptline$, "mainplayer")
    LET findx% = INSTR(findx% + 1, scriptline$, " x ")
    LET findy% = INSTR(findy% + 1, scriptline$, " y ")
    LET findin% = INSTR(findin% + 1, scriptline$, "in")
    LET findout% = INSTR(findout% + 1, scriptline$, "out")
    LET finddirection% = INSTR(finddirection% + 1, scriptline$, "direction")
    LET findmove% = INSTR(findmove% + 1, scriptline$, "move")
    LET findmodel% = INSTR(findmodel% + 1, scriptline$, "model")
    LET findon% = INSTR(findon% + 1, scriptline$, "on")
    LET findoff% = INSTR(findoff% + 1, scriptline$, "off")
    LET findcollision% = INSTR(findcollision% + 1, scriptline$, "collision")
    LET findscript% = INSTR(findscript% + 1, scriptline$, "script")
    LET findmusic% = INSTR(findmusic% + 1, scriptline$, "music")
    LET findcontrol% = INSTR(findcontrol% + 1, scriptline$, "control ")
    LET findplay% = INSTR(findplay% + 1, scriptline$, " play")
    LET findstop% = INSTR(findstop% + 1, scriptline$, " stop")
    LET findfile% = INSTR(findfile% + 1, scriptline$, " file ")
    LET findpause% = INSTR(findpause% + 1, scriptline$, " pause")
    LET findsfx% = INSTR(findsfx% + 1, scriptline$, "sfx ")
    LET findhalt% = INSTR(findhalt% + 1, scriptline$, "halt")
    LET findplayer% = INSTR(findplayer% + 1, scriptline$, " player ")
    LET x = 0
    DO
        LET x = x + 1
        LET findplayer(x) = INSTR(findplayer(x) + 1, scriptline$, playername(x))
    LOOP UNTIL x >= mapplayerno
    LET x = 0
    LET findpilot% = INSTR(findpilot% + 1, scriptline$, "pilot ")
    LET finddim% = INSTR(finddim% + 1, scriptline$, "dim ")
    LET findgive% = INSTR(findgive% + 1, scriptline$, "give ")
    LET findtake% = INSTR(findtake% + 1, scriptline$, "take ")
    LET findsay% = INSTR(findsay% + 1, scriptline$, "say ")
    LET findspeaker% = INSTR(findspeaker% + 1, scriptline$, "speaker ")
    LET findclear% = INSTR(findclear% + 1, scriptline$, "clear")
    LET findeffects% = INSTR(findeffects% + 1, scriptline$, "effects ")
    LET findifpocket% = INSTR(findifpocket% + 1, scriptline$, "ifpocket ")
    LET findterminal% = INSTR(findterminal% + 1, scriptline$, "terminal ")
    LET findgivecurrency% = INSTR(findgivecurrency% + 1, scriptline$, "givecurrency ")
    LET findtakecurrency% = INSTR(findtakecurrency% + 1, scriptline$, "takecurrency ")
    LET findifholding% = INSTR(findifholding% + 1, scriptline$, "ifholding ")
    LET findifcurrency% = INSTR(findifcurrency% + 1, scriptline$, "ifcurrency ")
    LET findmarkgone% = INSTR(findmarkgone% + 1, scriptline$, "markgone ")
    LET findloading% = INSTR(findloading% + 1, scriptline$, "loading")
    LET findmapeffect% = INSTR(findloading% + 1, scriptline$, "mapeffect ")
    LET finddark% = INSTR(finddark% + 1, scriptline$, "dark")
    LET findrain% = INSTR(findrain% + 1, scriptline$, "rain")
    LET findstorm% = INSTR(findstorm% + 1, scriptline$, "storm")
    LET findtorch% = INSTR(findtorch% + 1, scriptline$, "torch")
    LET findsunsetleft% = INSTR(findsunsetleft% + 1, scriptline$, "sunsetleft")
    LET findsunsetright% = INSTR(findsunsetright% + 1, scriptline$, "sunsetright")
    LET findsunsetdown% = INSTR(findsunsetdown% + 1, scriptline$, "sunsetdown")
    LET findsunsetup% = INSTR(findsunsetup% + 1, scriptline$, "sunsetup")
    LET findanimate% = INSTR(findanimate% + 1, scriptline$, "animate ")
    LET findsavegame% = INSTR(findsavegame% + 1, scriptline$, "savegame")
    LET findifgone% = INSTR(findifgone% + 1, scriptline$, "ifgone ")
    LET findsprint% = INSTR(findsprint% + 1, scriptline$, "sprint ")
    LET findshowimage% = INSTR(findshowimage% + 1, scriptline$, "showimage ")
    LET findslowfade% = INSTR(findslowfade% + 1, scriptline$, "slowfade ")
    LET findsilenttake% = INSTR(findsilenttake% + 1, scriptline$, "silenttake ")
    LET findsilentgive% = INSTR(findsilentgive% + 1, scriptline$, "silentgive ")
    LET findsilentgivecurrency% = INSTR(findsilentgivecurrency% + 1, scriptline$, "silentgivecurrency ")
    LET findsilenttakecurrency% = INSTR(findsilenttakecurrency% + 1, scriptline$, "silenttakecurrency ")
    LET findifmapno% = INSTR(findifmapno% + 1, scriptline$, "ifmapno ")
    LET findifmodel% = INSTR(findifmodel% + 1, scriptline$, "ifmodel ")
    LET findfaceplayer% = INSTR(findfaceplayer% + 1, scriptline$, "faceplayer")
    LET findback% = INSTR(findback% + 1, scriptline$, "back")
    LET findrun% = INSTR(findrun% + 1, scriptline$, "run ")
    LET findminus% = INSTR(findminus% + 1, scriptline$, "-")
    LET findifdirection% = INSTR(ifdirection% + 1, scriptline$, "ifdirection ")
    LET findcarryvalues% = INSTR(findcarryvalues% + 1, scriptline$, "carryvalues")
    LET findpitchblack% = INSTR(findpitchblack% + 1, scriptline$, " pitchblack")
    LET findloadgame% = INSTR(findloadgame% + 1, scriptline$, "loadgame")
    LET findobject% = INSTR(findobject% + 1, scriptline$, " object ")
    LET findtrigger% = INSTR(findtrigger% + 1, scriptline$, "trigger ")
    LET x = 0
    DO
        LET x = x + 1
        LET findobject(x) = INSTR(findobject(x) + 1, scriptline$, objectname(x))
    LOOP UNTIL x >= mapobjectno
    LET x = 0
    LET findcheckpoint% = INSTR(findcheckpoint% + 1, scriptline$, "checkpoint ")
    LET findifcheckpoint% = INSTR(findifcheckpoint% + 1, scriptline$, "ifcheckpoint ")
    LET findpockets% = INSTR(findpockets% + 1, scriptline$, " pockets ")
    LET findup% = INSTR(findup% + 1, scriptline$, " up ")
    LET finddown% = INSTR(finddown% + 1, scriptline$, " down ")
    LET findleft% = INSTR(findleft% + 1, scriptline$, " left ")
    LET findright% = INSTR(findright% + 1, scriptline$, " right ")
    LET findselect% = INSTR(findselect% + 1, scriptline$, " select ")
    LET findterminaltext% = INSTR(findterminaltext% + 1, scriptline$, "terminaltext ")
    LET findterminalnoboot% = INSTR(findterminalnoboot% + 1, scriptline$, "terminalnoboot ")
    LET findtimedscript% = INSTR(findtimedscript% + 1, scriptline$, "timedscript ")
    LET findsaving% = INSTR(findsaving% + 1, scriptline$, "saving")
    LET findchoice% = INSTR(findchoice% + 1, scriptline$, "choice ")
    LET findbackchoice% = INSTR(findbackchoice% + 1, scriptline$, "backchoice ")
    LET findhalttimed% = INSTR(findhalttimed% + 1, scriptline$, "halttimed")
    LET findiftimed% = INSTR(findiftimed% + 1, scriptline$, "iftimed")
    LET findshow% = INSTR(findshow% + 1, scriptline$, "show ")
    LET findhide% = INSTR(findhide% + 1, scriptline$, "hide ")
    LET findremark% = INSTR(findremark% + 1, scriptline$, "remark ")
    LET findall% = INSTR(findall% + 1, scriptline$, " all")
    LET findallowskip% = INSTR(findallowskip% + 1, scriptline$, "allowskip")
    LET findmakerandom% = INSTR(findmakerandom% + 1, scriptline$, "makerandom ")
    LET finduserandom% = INSTR(finduserandom% + 1, scriptline$, " userandom")
    LET findabove% = INSTR(findabove% + 1, scriptline$, " above ")
    LET findbelow% = INSTR(findbelow% + 1, scriptline$, " below ")
    LET findequal% = INSTR(findequal% + 1, scriptline$, " equal ")
    LET findifrandom% = INSTR(findifrandom% + 1, scriptline$, "ifrandom ")
    LET findshelllnx% = INSTR(findshelllnx% + 1, scriptline$, "shelllnx ")
    LET findshellwin% = INSTR(findshellwin% + 1, scriptline$, "shellwin ")
    LET findallowcontrol% = INSTR(findallowcontrol% + 1, scriptline$, "allowcontrol")
    LET findmakevalue% = INSTR(findmakevalue% + 1, scriptline$, "makevalue ")
    LET findusevalue% = INSTR(findusevalue% + 1, scriptline$, " usevalue-")
    LET findmodvalue% = INSTR(findmodvalue% + 1, scriptline$, "modvalue ")
    LET findifvalue% = INSTR(findifvalue% + 1, scriptline$, "ifvalue")
    LET findadd% = INSTR(findadd% + 1, scriptline$, " add ")
    LET findtakeaway% = INSTR(findminus% + 1, scriptline$, " minus ")
    LET findtimes% = INSTR(findtimes% + 1, scriptline$, " times ")
    LET finddivide% = INSTR(finddivide% + 1, scriptline$, " divide ")
    LET findgiveaward% = INSTR(findgiveaward% + 1, scriptline$, "giveaward ")
    LET findifaward% = INSTR(findifaward% + 1, scriptline$, "ifaward ")
    LET findsavevalue% = INSTR(findsavevalue% + 1, scriptline$, "savevalue ")
    LET findwhitefade% = INSTR(findwhitefade% + 1, scriptline$, "white ")
    LET findsfxloop% = INSTR(findsfxloop% + 1, scriptline$, "sfxloop ")
    LET findsfxstop% = INSTR(findsfxstop% + 1, scriptline$, "sfxstop")
    LET findcut% = INSTR(findcut% + 1, scriptline$, " cut ")
    LET findresetsavetime% = INSTR(findresetsavetime% + 1, scriptline$, "resetsavetime")
    LET findspecial666% = INSTR(findspecial666% + 1, scriptline$, "special666")
    LET findspecial667% = INSTR(findspecial667% + 1, scriptline$, "special667")
    LET findspecial668% = INSTR(findspecial668% + 1, scriptline$, "special668")
    GOSUB seperatecommand
    IF _KEYDOWN(bcontrolcode1) OR _KEYDOWN(bcontrolcode2) OR _KEYDOWN(bcontrolcode3) OR _KEYDOWN(bcontrolcode4) THEN
        REM request that the script be skipped
        IF mainmenu = 0 AND skipallowed = 1 THEN
            LET scriptskip = 1
            GOSUB sfxstop
            REM tells console
            LET eventtitle$ = "SCRIPT SKIP REQUESTED"
            LET eventdata$ = "line:"
            LET eventnumber = scriptline
            GOSUB consoleprinter
            IF fadestatus = 0 THEN GOSUB fadeout
            IF fadestatus = 2 THEN GOSUB slightfadein: GOSUB fadeout
            _PUTIMAGE (1, 1)-((loadiconresx), loadiconresy), loadicon
        END IF
    END IF
    REM processes a line
    IF findsay% THEN
        GOSUB scriptsaycmd
        GOTO endscriptcmd
    END IF
    IF findremark% THEN
        REM remark command
        LET temp26 = 1
        GOTO endscriptcmd
    END IF
    IF findmakevalue% THEN
        GOSUB scriptmakevaluecmd
        GOTO endscriptcmd
    END IF
    IF findmodvalue% THEN
        GOSUB scriptmodvaluecmd
        GOTO endscriptcmd
    END IF
    IF findmakerandom% THEN
        GOSUB scriptmakerandomcmd
        GOTO endscriptcmd
    END IF
    IF findcarryvalues% THEN
        GOSUB scriptcarryvaluescmd
        GOTO endscriptcmd
    END IF
    IF findhalttimed% THEN
        GOSUB scripthalttimedcmd
        GOTO endscriptcmd
    END IF
    IF findiftimed% THEN
        GOSUB scriptiftimedcmd
        GOTO endscriptcmd
    END IF
    IF findtimedscript% THEN
        GOSUB scripttimedscriptcmd
        GOTO endscriptcmd
    END IF
    IF findterminaltext% THEN
        GOSUB scriptterminaltextcmd
        GOTO endscriptcmd
    END IF
    IF findshelllnx% THEN
        GOSUB scriptshelllnxcmd
        GOTO endscriptcmd
    END IF
    IF findshellwin% THEN
        GOSUB scriptshellwincmd
        GOTO endscriptcmd
    END IF
    IF findchoice% THEN
        GOSUB scriptchoicecmd
        GOTO endscriptcmd
    END IF
    IF findcontrol% THEN
        GOSUB scriptcontrolcmd
        'GOTO endscriptcmd
    END IF
    IF findrun% THEN
        GOSUB scriptruncmd
        GOTO endscriptcmd
    END IF
    IF findpilot% THEN
        GOSUB scriptpilotcmd
        GOTO endscriptcmd
    END IF
    IF findsavegame% THEN
        REM saves game
        GOSUB savesave
        LET temp26 = 1
        'GOTO endscriptcmd
    END IF
    IF findloadgame% THEN
        REM loads previous save
        GOSUB loadgame
        LET temp26 = 1
        GOTO endscriptcmd
    END IF
    IF findtrigger% THEN
        GOSUB scripttriggercmd
        GOTO endscriptcmd
    END IF
    IF findmapeffect% THEN
        GOSUB scriptmapeffectcmd
        GOTO endscriptcmd
    END IF
    IF findgivecurrency% OR findsilentgivecurrency% THEN
        GOSUB scriptgivecurrencycmd
        GOTO endscriptcmd
    END IF
    IF findtakecurrency% OR findsilenttakecurrency% THEN
        GOSUB scripttakecurrencycmd
        GOTO endscriptcmd
    END IF
    IF findsfx% THEN
        REM plays sound effect
        LET playsfx$ = seperate2$
        IF scriptskip = 0 THEN GOSUB sfxplay
        LET temp26 = 1
        GOTO endscriptcmd
    END IF
    IF findsfxloop% THEN
        REM loops a sound effect
        LET playsfx$ = seperate2$
        IF scriptskip = 0 THEN GOSUB sfxloop
        LET temp26 = 1
        GOTO endscriptcmd
    END IF
    IF findsfxstop% THEN
        REM stops all sound effects
        GOSUB sfxstop
        LET temp26 = 1
        GOTO endscriptcmd
    END IF
    IF findeffects% THEN
        REM enables or disables effects
        IF findon% THEN
            LET disablefade = 0
            LET temp26 = 1
        END IF
        IF findoff% THEN
            LET disablefade = 1
            LET temp26 = 1
        END IF
        GOTO endscriptcmd
    END IF
    IF findclear% THEN
        REM clears screen
        LET clearscreen = 1
        GOSUB screendraw
        LET temp26 = 1
        'GOTO endscriptcmd
    END IF
    IF findloading% THEN
        REM displays loading icon
        _PUTIMAGE (1, 1)-((loadiconresx), loadiconresy), loadicon
        LET temp26 = 1
        GOTO endscriptcmd
    END IF
    IF findsaving% THEN
        REM displays saving icon
        _PUTIMAGE (1, 1)-(saveiconresx, saveiconresy), saveicon
        LET temp26 = 1
        GOTO endscriptcmd
    END IF
    IF findspeaker% THEN
        GOSUB scriptspeakercmd
        GOTO endscriptcmd
    END IF
    IF findgiveaward% THEN
        GOSUB scriptgiveawardcmd
        GOTO endscriptcmd
    END IF
    IF findcheckpoint% THEN
        GOSUB scriptcheckpointcmd
        'GOTO endscriptcmd
    END IF
    IF findifvalue% THEN
        GOSUB scriptifvaluecmd
        GOTO endscriptcmd
    END IF
    IF findifrandom% THEN
        GOSUB scriptifrandomcmd
        GOTO endscriptcmd
    END IF
    IF findsavevalue% THEN
        REM saves a specific in-game value to save file
        LET valuesaveno = tempn(2)
        GOSUB savevalue
        LET temp26 = 1
        GOTO endscriptcmd
    END IF
    IF findifcheckpoint% THEN
        GOSUB scriptifcheckpointcmd
        GOTO endscriptcmd
    END IF
    IF findifcurrency% THEN
        GOSUB scriptifcurrencycmd
        GOTO endscriptcmd
    END IF
    IF findifdirection% THEN
        GOSUB scriptifdirectioncmd
        GOTO endscriptcmd
    END IF
    IF findifaward% THEN
        GOSUB scriptifawardcmd
        GOTO endscriptcmd
    END IF
    IF findifpocket% THEN
        GOSUB scriptifpocketcmd
        GOTO endscriptcmd
    END IF
    IF findifholding% THEN
        GOSUB scriptifholdingcmd
        GOTO endscriptcmd
    END IF
    IF findifmodel% THEN
        GOSUB scriptifmodelcmd
        GOTO endscriptcmd
    END IF
    IF findifmapno% THEN
        GOSUB scriptifmapnocmd
        GOTO endscriptcmd
    END IF
    IF findifgone% THEN
        GOSUB scriptifgonecmd
        GOTO endscriptcmd
    END IF
    IF findgive% OR findsilentgive% THEN
        GOSUB scriptgivecmd
        GOTO endscriptcmd
    END IF
    IF findhide% THEN
        GOSUB scripthidecmd
        GOTO endscriptcmd
    END IF
    IF findshow% THEN
        GOSUB scriptshowcmd
        GOTO endscriptcmd
    END IF
    IF findtake% OR findsilenttake% THEN
        GOSUB scripttakecmd
        GOTO endscriptcmd
    END IF
    IF findmarkgone% THEN
        REM marks pocket item as "gone forever"
        LET takeitem$ = temps$(2)
        GOSUB markgone
        IF pocketfile$ = takeitem$ THEN LET temp26 = 1
        GOTO endscriptcmd
    END IF
    IF findslowfade% THEN
        REM slow fade
        IF findin% THEN IF scriptskip = 0 THEN GOSUB slowfadein: LET temp26 = 1
        IF findout% THEN IF scriptskip = 0 THEN GOSUB slowfadeout: LET temp26 = 1
        'GOTO endscriptcmd
    END IF
    IF finddim% THEN
        REM dim
        IF findoff% THEN IF scriptskip = 0 THEN GOSUB slightfadein: LET temp26 = 1
        IF findon% THEN IF scriptskip = 0 THEN GOSUB slightfadeout: LET temp26 = 1
        'GOTO endscriptcmd
    END IF
    IF findfade% THEN
        REM fade
        IF findin% THEN IF scriptskip = 0 THEN GOSUB fadein: LET temp26 = 1
        IF findout% THEN IF scriptskip = 0 THEN GOSUB fadeout: LET temp26 = 1
        'GOTO endscriptcmd
    END IF
    IF findwhitefade% THEN
        REM fade
        IF findin% THEN IF scriptskip = 0 THEN GOSUB whitefadein: LET temp26 = 1
        IF findout% THEN IF scriptskip = 0 THEN GOSUB whitefadeout: LET temp26 = 1
        'GOTO endscriptcmd
    END IF
    IF findwait% THEN
        GOSUB scriptwaitcmd
        GOTO endscriptcmd
    END IF
    IF findhalt% THEN
        GOSUB scripthaltcmd
        GOTO endscriptcmd
    END IF
    IF findmap% THEN
        GOSUB scriptmapcmd
        GOTO endscriptcmd
    END IF
    IF findwarp% THEN
        GOSUB scriptwarpcmd
        GOTO endscriptcmd
    END IF
    IF findmusic% THEN
        GOSUB scriptmusiccmd
        'GOTO endscriptcmd
    END IF
    IF findmodel% THEN
        REM changes player model
        IF findmainplayer% THEN
            REM mainplayer
            LET temp26 = 1
            LET oldmplayermodel$ = mplayermodel$
            LET mplayermodel$ = temps$(3)
            GOSUB mainplayerload
        END IF
        GOTO endscriptcmd
    END IF
    IF findshowimage% THEN
        REM displays image
        IF _FILEEXISTS(uiloc$ + temps$(2) + ".png") THEN
            LET showimage$ = temps$(2)
            IF scriptskip = 0 THEN GOSUB showimage
            LET temp26 = 1
        ELSE
            ERROR 435
        END IF
        GOTO endscriptcmd
    END IF
    IF findcollision% THEN
        REM changes noclip value
        IF findon% THEN LET noclip = 0: GOSUB collision: LET temp26 = 1: REM switches noclip off
        IF findoff% THEN LET noclip = 1: LET temp26 = 1: REM switches noclip on
        GOTO endscriptcmd
    END IF
    IF findscript% THEN
        GOSUB scriptscriptcmd
        GOTO endscriptcmd
    END IF
    IF findterminal% THEN
        REM launches terminal file
        LET runterminal$ = temps$(2)
        LET runterminal = 1
        LET nodraw = 1
        LET temp26 = 2
        GOTO endscriptcmd
    END IF
    IF findterminalnoboot% THEN
        REM launches terminal file with no boot gui
        LET runterminal$ = temps$(2)
        LET runterminal = 1
        LET nodraw = 1
        LET terminalnoboot = 1
        LET temp26 = 2
        GOTO endscriptcmd
    END IF
    IF findanimate% THEN
        GOSUB scriptanimatecmd
        GOTO endscriptcmd
    END IF
    IF findmove% OR findsprint% THEN
        GOSUB scriptmovecmd
        GOTO endscriptcmd
    END IF
    IF finddirection% THEN
        GOSUB scriptdirectioncmd
        GOTO endscriptcmd
    END IF
    IF findallowskip% THEN
        REM allows script to be skipped
        LET skipallowed = 1
        LET temp26 = 1
    END IF
    IF findresetsavetime% THEN
		REM resets save timer back to 0
		LET sitime = TIMER
		LET igametime = 0
		LET stime = 0
		LET gametime = 0
		LET erasesave = 0
		GOSUB savetime
		LET temp26 = 1
		GOTO endscriptcmd
    END IF
    IF findspecial666% THEN
        REM special function (spiderbro 1 completion)
        IF _FILEEXISTS("data/utility/data/saves/savedata.ddf") THEN
            OPEN "data/utility/data/saves/savedata.ddf" FOR INPUT AS #14
            INPUT #14, scriptvalue(39)
            CLOSE #14
            IF scriptvalue(39) = 113 THEN
                LET scriptvalue(39) = 1
            ELSE
                LET scriptvalue(39) = 0
            END IF
            LET temp26 = 1
            REM tells console
            LET eventtitle$ = "SPECIAL FUNCTION 666:"
            LET eventdata$ = "SUCCESS!"
            LET eventnumber = 0
            GOSUB consoleprinter
        END IF
        GOTO endscriptcmd
    END IF
    IF findspecial667% THEN
        REM special function (count number of deaths experienced)
        LET scriptvalue(4) = scriptvalue(10) + scriptvalue(11) + scriptvalue(12) + scriptvalue(13) + scriptvalue(14) + scriptvalue(15) + scriptvalue(16) + scriptvalue(17) + scriptvalue(18) + scriptvalue(19) + scriptvalue(20) + scriptvalue(21) + scriptvalue(22) + scriptvalue(23) + scriptvalue(24) + scriptvalue(25) + scriptvalue(26) + scriptvalue(27) + scriptvalue(28) + scriptvalue(29) + scriptvalue(30) + scriptvalue(31) + scriptvalue(32) + scriptvalue(33) + scriptvalue(34) + scriptvalue(35) + scriptvalue(36) + scriptvalue(37) + scriptvalue(38)
        LET temp26 = 1
        REM tells console
        LET eventtitle$ = "SPECIAL FUNCTION 667:"
        LET eventdata$ = "SUCCESS!"
        LET eventnumber = 0
        GOSUB consoleprinter
        GOTO endscriptcmd
    END IF
    IF findspecial668% THEN
        REM special function (count time! if under 3 hrs)
        IF gametime < 10800 THEN
            LET scriptvalue(41) = 1
            LET temp26 = 1
            REM tells console
            LET eventtitle$ = "SPECIAL FUNCTION 668:"
            LET eventdata$ = "SUCCESS!"
            LET eventnumber = 0
            GOSUB consoleprinter
        END IF
        GOTO endscriptcmd
    END IF
    endscriptcmd:
    REM prints to console upon sucessful script line execution or prints invalid/blank line
    IF temp26 = 1 OR temp26 = 2 THEN
        LET eventtitle$ = "SCRIPT LINE:"
        LET eventdata$ = scriptline$
        LET eventnumber = scriptline
    ELSE
        IF scriptline$ <> "" THEN
            LET eventtitle$ = "INVALID SCRIPT LINE:"
            LET eventdata$ = scriptline$
            LET eventnumber = scriptline
        ELSE
            LET eventtitle$ = "BLANK SCRIPT LINE:"
            LET eventdata$ = "LINE:"
            LET eventnumber = scriptline
        END IF
    END IF
    GOSUB consoleprinter
    REM scrubs search terms and temp values
    IF temp26 = 1 THEN LET temp26 = 0: LET temp157 = 1
    LET seperateval1 = 0
    LET seperateval2 = 0
    LET seperate1$ = ""
    LET seperate2$ = ""
    LET seperate3$ = ""
    LET x = 1
    DO
        LET tempn(x) = 0
        LET temps$(x) = ""
        LET x = x + 1
    LOOP UNTIL temps$(x) = ""
    LET temp27 = 0: LET temp56 = 0: LET temp12$ = "": LET temp13$ = "": LET temp131 = 0: LET findfade% = 0: LET findin% = 0: LET findout% = 0: LET findwait% = 0: LET findmap% = 0: LET findwarp% = 0: LET findx% = 0: LET findy% = 0: LET findmainplayer% = 0: LET finddirection% = 0: LET findmove% = 0: LET findmodel% = 0: LET findon% = 0: LET findoff% = 0: LET findcollision% = 0: LET findscript% = 0: LET findmusic% = 0: LET findcontrol% = 0: LET findplay% = 0: LET findstop% = 0: LET findfile% = 0: LET findpause% = 0: LET findsfx% = 0: LET findhalt% = 0: LET findplayer% = 0: LET findpilot% = 0: LET finddim% = 0: LET findgive% = 0: LET findtake% = 0: LET findsay% = 0: LET findspeaker% = 0: LET findclear% = 0: LET findeffects% = 0: LET findifpocket% = 0: LET findterminal% = 0: LET findgivecurrency% = 0: LET findtakecurrency% = 0: LET findifholding% = 0: LET findifcurrency% = 0: LET findmarkgone% = 0: LET findloading% = 0: LET findmapeffect% = 0: LET finddark% = 0: LET findrain% = 0: LET findstorm% = 0: LET findtorch% = 0: LET findanimate% = 0: LET findsavegame% = 0: LET findifgone% = 0: LET findsunsetup% = 0: LET findsunsetdown% = 0: LET findsunsetleft% = 0: LET findsunsetright% = 0: LET findsprint% = 0: LET findshowimage% = 0: LET findslowfade% = 0: LET findsilenttake% = 0: LET findsilentgive% = 0: LET findsilentgivecurrency% = 0: LET findsilenttakecurrency% = 0: LET findifmapno% = 0: LET findifmodel% = 0: LET findfaceplayer% = 0: LET findback% = 0: LET findrun% = 0: LET findminus% = 0: LET findifdirection% = 0: LET findcarryvalues% = 0: LET findpitchblack% = 0: LET findloadgame% = 0: LET findobject% = 0: LET findcheckpoint% = 0: LET findifcheckpoint% = 0: LET findpockets% = 0: LET findup% = 0: LET finddown% = 0: LET findleft% = 0: LET findright% = 0: LET findselect% = 0: LET findterminaltext% = 0: LET findtimedscript% = 0: LET findsaving% = 0: LET findchoice% = 0: LET findhalttimed% = 0: LET findiftimed% = 0: LET findbackchoice% = 0: LET findshow% = 0: LET findhide% = 0: LET findremark% = 0: LET findall% = 0: LET findtrigger% = 0: LET findallowskip% = 0: LET findmakerandom% = 0: LET finduserandom% = 0: LET findabove% = 0: LET findbelow% = 0: LET findequal% = 0: LET findifrandom% = 0: LET findshelllnx% = 0: LET findshellwin% = 0: LET findmakevalue% = 0: LET findmodvalue% = 0: LET findusevalue% = 0: LET findifvalue% = 0: LET findadd% = 0: LET findtakeaway% = 0: LET findtimes% = 0: LET finddivide% = 0: LET findgiveaward% = 0: LET findifaward% = 0: LET findsavevalue% = 0: LET findwhitefade% = 0: LET findsfxloop% = 0: LET findsfxstop% = 0: LET findcut% = 0: LET findresetsavetime% = 0: LET findspecial666% = 0: LET findspecial667% = 0: LET findspecial668% = 0
    LET x = 0
    DO
        LET x = x + 1
        LET findplayer(x) = 0
    LOOP UNTIL x >= totalplayers
    LET x = 0
    DO
        LET x = x + 1
        LET findobject(x) = 0
    LOOP UNTIL x >= totalobjects
    LET x = 0
    _KEYCLEAR
LOOP UNTIL EOF(3) OR temp26 = 2
CLOSE #3
REM prints to console script has ended
LET eventtitle$ = "SCRIPT ENDED:"
LET eventdata$ = scriptname$
LET eventnumber = 0
GOSUB consoleprinter
REM returns value of selectobject$ if needed
IF temp86 = 1 THEN
    LET selectobject$ = temp23$
    LET temp86 = 0
    LET temp23$ = ""
    LET temp61$ = ""
END IF
IF scriptskip = 1 AND temp200 = 0 THEN GOSUB fadein: REM fade in after a script is skipped
REM resets if counting values
IF temp200 = 0 AND temp200 <> 999 THEN
    LET ifcheckpointno = 0
    LET ifcurrencyno = 0
    LET ifdirectionno = 0
    LET ifpocketno = 0
    LET ifholdingno = 0
    LET ifmodelno = 0
    LET ifmapnono = 0
    LET ifgoneno = 0
    LET ifrandomno = 0
    LET ifvalueno = 0
    LET ifawardno = 0
    LET scriptskip = 0
    LET skipallowed = 0
    LET allowscriptcontrol = 0
END IF
IF temp200 = 999 THEN
    LET ifcheckpointno = 0
    LET ifcurrencyno = 0
    LET ifdirectionno = 0
    LET ifpocketno = 0
    LET ifholdingno = 0
    LET ifmodelno = 0
    LET ifmapnono = 0
    LET ifgoneno = 0
    LET ifrandomno = 0
    LET ifvalueno = 0
    LET ifawardno = 0
    LET allowscriptcontrol = 0
END IF
IF temp200 = 0 AND fadestatus = 1 THEN LET fadestatus = 0: LET clearscreen = 1
IF nodraw = 0 AND temp157 = 0 THEN LET clearscreen = 1: REM calls for a screen clear
IF parallaxmode = 0 THEN IF (resx / 2) - posx <= (resx / 2) OR (resy / 2) - posy <= (resy / 2) THEN LINE (0, 0)-(scriptimageresx, scriptimageresy), _RGBA(1, 1, 1, 255), BF: REM removes eye logo if needed
LET temp200 = 0: LET temp26 = 0: LET temp64 = 0: LET temp157 = 0: LET scriptrun = 0: LET mapscript = 0: LET mapscriptdir$ = "": LET scriptline = 0: LET scriptline$ = "": REM scrub temp values
REM makes sure triggers are cleared
LET x = 0
DO
    LET x = x + 1
    LET triggera(x) = 0
LOOP UNTIL x >= maptriggerno
LET x = 0
RETURN

triggerchecker:
REM checks to see if triggers have been activated and launches required scripts
REM spoof trigger
IF triggerspoofa = 1 THEN
    LET scriptname$ = triggerspoofname$
    LET mapscript = nextmapscript
    LET nextmapscript = 0
    IF choicescriptloop = 1 THEN LET oldscript$ = "": LET choicescriptloop = 0: REM allows for script looping if coming from a player 'backchoice'
    IF scriptname$ <> oldscript$ THEN
        REM prints to consolelog.txt
        LET eventtitle$ = "SPOOF TRIGGER ACTIVE:"
        LET eventdata$ = triggerspoofname$
        LET eventnumber = 0
        GOSUB consoleprinter
        'LET diagonalmove = 1
        GOSUB script
    ELSE
        LET triggerspoofa = 0
        GOTO triggerskip
    END IF
    IF temp33 = 1 OR temp33 = 2 THEN
        IF temp33 = 1 THEN LET triggerspoofa = 0
    ELSE
        LET triggerspoofa = 1
    END IF
    FOR itl = 1 TO maptriggerno
        LET triggera(itl) = 0
    NEXT itl
    LET temp33 = 0: REM scrub temp values
END IF
triggerskip:
IF maptriggerno = 0 THEN RETURN: REM return if map has no triggers attached
LET x = 0
DO
    LET x = x + 1
    IF triggera(x) = 1 THEN
        LET scriptname$ = triggername(x)
        LET mapscript = 1
        'LET diagonalmove = 1
        GOSUB script
        LET triggera(x) = 0
    END IF
LOOP UNTIL x >= maptriggerno
LET x = 0
RETURN

footchanger:
REM changes players foot
REM builds values to keep players feet changing
LET mpfootloop = mpfootloop + 1
DO
    LET temp49 = temp49 + 1
    LET pfootloop(temp49) = pfootloop(temp49) + 1
LOOP UNTIL temp49 >= mapplayerno OR temp49 >= totalplayers
REM changes players foot when walking mainplayer
IF mpfootloop >= footpace THEN
    IF temp2 = 0 THEN IF mpfoot = 1 THEN LET mpfoot = 2: LET mpfootloop = 0: LET temp2 = 1
    IF temp2 = 0 THEN IF mpfoot = 2 THEN LET mpfoot = 1: LET mpfootloop = 0: LET temp2 = 1
END IF
REM changes NPCs feet
LET temp49 = 0
DO
    LET temp49 = temp49 + 1
    IF pfootloop(temp49) >= footpace THEN
        IF temp50 = 0 THEN IF pfoot(temp49) = 1 THEN LET pfoot(temp49) = 2: LET pfootloop(temp49) = 0: LET temp50 = 1
        IF temp50 = 0 THEN IF pfoot(temp49) = 2 THEN LET pfoot(temp49) = 1: LET pfootloop(temp49) = 0: LET temp50 = 1
    END IF
    LET temp50 = 0
LOOP UNTIL temp49 >= mapplayerno OR temp49 >= totalplayers
REM flushes temporary values
LET temp2 = 0: LET temp49 = 0: LET temp50 = 0
RETURN

worlddraw:
REM draws world
LET asset$ = mloc$ + "m" + LTRIM$(STR$(mapno)) + "/map" + LTRIM$(STR$(mapno)) + ".ddf"
IF INT(ctime + mapanioffset) MOD 2 THEN
    _PUTIMAGE (maploc1x, maploc1y)-(maploc2x - 1, maploc2y - 1), mapa
ELSE
    _PUTIMAGE (maploc1x, maploc1y)-(maploc2x - 1, maploc2y - 1), mapb
END IF
IF missingasset = 1 THEN _PUTIMAGE (maploc1x, maploc1y)-(maploc2x - 1, maploc2y - 1), errortexture: LET missingasset = 0
RETURN

parallaxdraw:
REM draws parallax layer
LET asset$ = mloc$ + "m" + LTRIM$(STR$(mapno)) + "/map" + LTRIM$(STR$(mapno)) + ".ddf"
IF parallaxmode = 1 OR parallaxmode = 2 THEN
    IF INT(ctime + parallaxoffset) MOD 2 THEN
        _PUTIMAGE ((INT(maploc1x / 2)) - resx, (INT(maploc1y / 2)) - resy)-((INT(maploc2x / 2)) + resx - 1, (INT(maploc2y / 2)) + resy - 1), mapp1
    ELSE
        _PUTIMAGE ((INT(maploc1x / 2)) - resx, (INT(maploc1y / 2)) - resy)-((INT(maploc2x / 2)) + resx - 1, (INT(maploc2y / 2)) + resy - 1), mapp2
    END IF
    IF missingasset = 1 THEN _PUTIMAGE ((maploc1x / 2) - resx, (maploc1y / 2) - resy)-((maploc2x / 2) + resx - 1, (maploc2y / 2) + resy - 1), errortexture: LET missingasset = 0
END IF
RETURN

mainplayerdraw:
REM draws main player
REM draws main player standing
LET asset$ = ploc$ + mplayermodel$ + "/" + mplayermodel$ + ".ddf"
IF anisprite$ = "mainplayer" THEN RETURN: REM return for if mainplayer animation is playing.
IF mpwalking = 0 THEN
    IF mpidle <= INT(ctime) THEN
        IF direction = 1 THEN
            IF INT(ctime) MOD 2 THEN
                _PUTIMAGE (mpposx, mpposy), mpbi1: REM draws main player standing BACK using IDLE
            ELSE
                _PUTIMAGE (mpposx, mpposy), mpbi2: REM draws main player standing BACK using IDLE
            END IF
        END IF
        IF direction = 2 THEN
            IF INT(ctime) MOD 2 THEN
                _PUTIMAGE (mpposx, mpposy), mpfi1: REM draws main player standing FRONT using IDLE
            ELSE
                _PUTIMAGE (mpposx, mpposy), mpfi2: REM draws main player standing FRONT using IDLE
            END IF
        END IF
        IF direction = 3 THEN
            IF INT(ctime) MOD 2 THEN
                _PUTIMAGE (mpposx, mpposy), mpri1: REM draws main player standing RIGHT using IDLE
            ELSE
                _PUTIMAGE (mpposx, mpposy), mpri2: REM draws main player standing RIGHT using IDLE
            END IF
        END IF
        IF direction = 4 THEN
            IF INT(ctime) MOD 2 THEN
                _PUTIMAGE (mpposx, mpposy), mpli1: REM draws main player standing LEFT using IDLE
            ELSE
                _PUTIMAGE (mpposx, mpposy), mpli2: REM draws main player standing LEFT using IDLE
            END IF
        END IF
    ELSE
        IF direction = 1 THEN _PUTIMAGE (mpposx, mpposy), mpb: REM draws main player standing BACK
        IF direction = 2 THEN _PUTIMAGE (mpposx, mpposy), mpf: REM draws main player standing FRONT
        IF direction = 3 THEN _PUTIMAGE (mpposx, mpposy), mpr: REM draws main player standing RIGHT
        IF direction = 4 THEN _PUTIMAGE (mpposx, mpposy), mpl: REM draws main player standing LEFT
    END IF
END IF
REM draws main player walking
IF mpwalking = 1 THEN
    REM draws main player walking BACK
    IF direction = 1 THEN
        IF mpfoot = 1 THEN _PUTIMAGE (mpposx, mpposy), mpbr: REM draws main player walking BACK (right foot)
        IF mpfoot = 2 THEN _PUTIMAGE (mpposx, mpposy), mpbl: REM draws main player walking BACK (left foot)
    END IF
    REM draws main player walking FRONT
    IF direction = 2 THEN
        IF mpfoot = 1 THEN _PUTIMAGE (mpposx, mpposy), mpfr: REM draws main player walking FRONT (right foot)
        IF mpfoot = 2 THEN _PUTIMAGE (mpposx, mpposy), mpfl: REM draws main player walking FRONT (left foot)
    END IF
    REM draws main player walking RIGHT
    IF direction = 3 THEN
        IF mpfoot = 1 THEN _PUTIMAGE (mpposx, mpposy), mprr: REM draws main player walking RIGHT (right foot)
        IF mpfoot = 2 THEN _PUTIMAGE (mpposx, mpposy), mprl: REM draws main player walking RIGHT (left foot)
    END IF
    REM draws main player walking LEFT
    IF direction = 4 THEN
        IF mpfoot = 1 THEN _PUTIMAGE (mpposx, mpposy), mplr: REM draws main player walking LEFT (right foot)
        IF mpfoot = 2 THEN _PUTIMAGE (mpposx, mpposy), mpll: REM draws main player walking LEFT (left foot)
    END IF
END IF
IF missingasset = 1 THEN _PUTIMAGE (mpposx, mpposy)-(mpposx + mpx, mpposy + mpy), errortexture: LET missingasset = 0
RETURN

playermove:
REM calculates NPC movement
IF mapplayerno = 0 THEN RETURN: REM return for no npcs attached to map
DO
    LET temp48 = temp48 + 1
    IF mplayerx(temp48) <> 0 AND mplayery(temp48) <> 0 THEN GOSUB playermover
LOOP UNTIL temp48 >= mapplayerno OR temp48 >= totalplayers
LET temp48 = 0: REM scrubs temp values
RETURN

playermover:
REM moves NPC
REM Walk away
IF playerscript(temp48) = 1 THEN RETURN
IF playerjourney(temp48) = 1 THEN
    IF INT(ctime) >= playerperiod(temp48) THEN
        LET playerwalking(temp48) = 1
        IF mplayerx(temp48) > playerx(temp48) THEN
            LET playerd(temp48) = 3
            LET playerx(temp48) = playerx(temp48) + ((pace / playerwalkdivide) * playerspeed(temp48))
            IF mplayerx(temp48) < playerx(temp48) THEN LET playerx(temp48) = mplayerx(temp48)
            RETURN
        END IF
        IF mplayerx(temp48) < playerx(temp48) THEN
            LET playerd(temp48) = 4
            LET playerx(temp48) = playerx(temp48) - ((pace / playerwalkdivide) * playerspeed(temp48))
            IF mplayerx(temp48) > playerx(temp48) THEN LET playerx(temp48) = mplayerx(temp48)
            RETURN
        END IF
        IF mplayery(temp48) > playery(temp48) THEN
            LET playerd(temp48) = 2
            LET playery(temp48) = playery(temp48) + ((pace / playerwalkdivide) * playerspeed(temp48))
            IF mplayery(temp48) < playery(temp48) THEN LET playery(temp48) = mplayery(temp48)
            RETURN
        END IF
        IF mplayery(temp48) < playery(temp48) THEN
            LET playerd(temp48) = 1
            LET playery(temp48) = playery(temp48) - ((pace / playerwalkdivide) * playerspeed(temp48))
            IF mplayery(temp48) > playery(temp48) THEN LET playery(temp48) = mplayery(temp48)
            RETURN
        END IF
        IF playerx(temp48) = mplayerx(temp48) AND playery(temp48) = mplayery(temp48) THEN
            IF playergrace(temp48) <> -1 THEN
                REM back and fourth movement
                LET playerjourney(temp48) = 2
                LET playerperiod(temp48) = playergrace(temp48) + INT(ctime)
                LET playerd(temp48) = playerdefault(temp48)
                LET playerwalking(temp48) = 0
            ELSE
                REM snap back to original place
                LET playerjourney(temp48) = 1
                LET playerx(temp48) = dplayerx(temp48)
                LET playery(temp48) = dplayery(temp48)
                LET playerd(temp48) = playerdefault(temp48)
                LET playerwalking(temp48) = 0
            END IF
        END IF
    END IF
END IF
REM walk back
IF playerjourney(temp48) = 2 THEN
    IF INT(ctime) >= playerperiod(temp48) THEN
        LET playerwalking(temp48) = 1
        IF dplayerx(temp48) > playerx(temp48) THEN
            LET playerd(temp48) = 3
            LET playerx(temp48) = playerx(temp48) + ((pace / playerwalkdivide) * playerspeed(temp48))
            IF dplayerx(temp48) < playerx(temp48) THEN LET playerx(temp48) = dplayerx(temp48)
            RETURN
        END IF
        IF dplayerx(temp48) < playerx(temp48) THEN
            LET playerd(temp48) = 4
            LET playerx(temp48) = playerx(temp48) - ((pace / playerwalkdivide) * playerspeed(temp48))
            IF dplayerx(temp48) > playerx(temp48) THEN LET playerx(temp48) = dplayerx(temp48)
            RETURN
        END IF
        IF dplayery(temp48) > playery(temp48) THEN
            LET playerd(temp48) = 2
            LET playery(temp48) = playery(temp48) + ((pace / playerwalkdivide) * playerspeed(temp48))
            IF dplayery(temp48) < playery(temp48) THEN LET playery(temp48) = dplayery(temp48)
            RETURN
        END IF
        IF dplayery(temp48) < playery(temp48) THEN
            LET playerd(temp48) = 1
            LET playery(temp48) = playery(temp48) - ((pace / playerwalkdivide) * playerspeed(temp48))
            IF dplayery(temp48) > playery(temp48) THEN LET playery(temp48) = dplayery(temp48)
            RETURN
        END IF
        IF playerx(temp48) = dplayerx(temp48) AND playery(temp48) = dplayery(temp48) THEN
            IF playergrace(temp48) <> -2 THEN
                REM back and fourth movement
                LET playerjourney(temp48) = 1
                LET playerperiod(temp48) = playergrace(temp48) + INT(ctime)
                LET playerd(temp48) = playerdefault(temp48)
                LET playerwalking(temp48) = 0
            ELSE
                REM snap back to destination co-ordinates
                LET playerjourney(temp48) = 2
                LET playerx(temp48) = mplayerx(temp48)
                LET playery(temp48) = mplayery(temp48)
                LET playerd(temp48) = playerdefault(temp48)
                LET playerwalking(temp48) = 0
            END IF
        END IF
    END IF
END IF
RETURN

playerdraw:
REM draws npcs
DO
    LET temp42 = temp42 + 1
    REM checks if player is on screen
    LET asset$ = ploc$ + playername(temp42) + "/" + playername(temp42) + ".ddf"
    IF playerx(temp42) + playerresx(temp42) > ((resx / 2) - posx) - (resx / 2) AND playerx(temp42) < ((resx / 2) - posx) + (resx / 2) THEN LET drawpass1 = 1
    IF playery(temp42) + playerresy(temp42) > ((resy / 2) - posy) - (resy / 2) AND playery(temp42) < ((resy / 2) - posy) + (resy / 2) THEN LET drawpass2 = 1
    IF autoplayercull(temp42) = 0 THEN LET drawpass1 = 1: LET drawpass2 = 1
    REM draws player
    IF anisprite$ <> playername(temp42) AND objectl = playerlayer(temp42) AND drawpass1 = 1 AND drawpass2 = 1 THEN
        IF playerwalking(temp42) = 0 THEN
            IF playerd(temp42) = 2 THEN
                IF INT(ctime + playeroffset(temp42)) MOD 2 THEN
                    _PUTIMAGE (playerx(temp42) + posx, playery(temp42) + posy), playerfi1(temp42)
                ELSE
                    _PUTIMAGE (playerx(temp42) + posx, playery(temp42) + posy), playerfi2(temp42)
                END IF
            END IF
            IF playerd(temp42) = 1 THEN
                IF INT(ctime + playeroffset(temp42)) MOD 2 THEN
                    _PUTIMAGE (playerx(temp42) + posx, playery(temp42) + posy), playerbi1(temp42)
                ELSE
                    _PUTIMAGE (playerx(temp42) + posx, playery(temp42) + posy), playerbi2(temp42)
                END IF
            END IF
            IF playerd(temp42) = 3 THEN
                IF INT(ctime + playeroffset(temp42)) MOD 2 THEN
                    _PUTIMAGE (playerx(temp42) + posx, playery(temp42) + posy), playerri1(temp42)
                ELSE
                    _PUTIMAGE (playerx(temp42) + posx, playery(temp42) + posy), playerri2(temp42)
                END IF
            END IF
            IF playerd(temp42) = 4 THEN
                IF INT(ctime + playeroffset(temp42)) MOD 2 THEN
                    _PUTIMAGE (playerx(temp42) + posx, playery(temp42) + posy), playerli1(temp42)
                ELSE
                    _PUTIMAGE (playerx(temp42) + posx, playery(temp42) + posy), playerli2(temp42)
                END IF
            END IF
        END IF
        IF playerwalking(temp42) = 1 THEN
            IF playerd(temp42) = 2 THEN
                IF pfoot(temp42) = 1 THEN _PUTIMAGE (playerx(temp42) + posx, playery(temp42) + posy), playerfl(temp42)
                IF pfoot(temp42) = 2 THEN _PUTIMAGE (playerx(temp42) + posx, playery(temp42) + posy), playerfr(temp42)
            END IF
            IF playerd(temp42) = 1 THEN
                IF pfoot(temp42) = 1 THEN _PUTIMAGE (playerx(temp42) + posx, playery(temp42) + posy), playerbl(temp42)
                IF pfoot(temp42) = 2 THEN _PUTIMAGE (playerx(temp42) + posx, playery(temp42) + posy), playerbr(temp42)
            END IF
            IF playerd(temp42) = 3 THEN
                IF pfoot(temp42) = 1 THEN _PUTIMAGE (playerx(temp42) + posx, playery(temp42) + posy), playerrl(temp42)
                IF pfoot(temp42) = 2 THEN _PUTIMAGE (playerx(temp42) + posx, playery(temp42) + posy), playerrr(temp42)
            END IF
            IF playerd(temp42) = 4 THEN
                IF pfoot(temp42) = 1 THEN _PUTIMAGE (playerx(temp42) + posx, playery(temp42) + posy), playerll(temp42)
                IF pfoot(temp42) = 2 THEN _PUTIMAGE (playerx(temp42) + posx, playery(temp42) + posy), playerlr(temp42)
            END IF
        END IF
    END IF
    IF missingasset = 1 THEN _PUTIMAGE (playerx(temp42) + posx, playery(temp42) + posy)-(playerx(temp42) + posx + playerresx(temp42), playery(temp42) + posy + playerresy(temp42)), errortexture: LET missingasset = 0
    LET drawpass1 = 0
    LET drawpass2 = 0
LOOP UNTIL temp42 >= mapplayerno
LET temp42 = 0: LET drawpass1 = 0: LET drawpass2 = 0: REM scrub temp values
RETURN

objectdraw:
REM draws map objects to screen
DO
    LET temp13 = temp13 + 1
    LET asset$ = oloc$ + objectname(temp13) + "/" + objectname(temp13) + ".ddf"
    REM checks to see if object is on screen
    IF objectx(temp13) + objectresx(temp13) > ((resx / 2) - posx) - (resx / 2) AND objectx(temp13) < ((resx / 2) - posx) + (resx / 2) THEN LET drawpass1 = 1
    IF objecty(temp13) + objectresy(temp13) > ((resy / 2) - posy) - (resy / 2) AND objecty(temp13) < ((resy / 2) - posy) + (resy / 2) THEN LET drawpass2 = 1
    IF autoobjectcull(temp13) = 0 THEN LET drawpass1 = 1: LET drawpass2 = 1
    REM draws object
    IF anisprite$ <> objectname(temp13) AND drawpass1 = 1 AND drawpass2 = 1 THEN
        IF objectl = objectl(temp13) AND objectname(temp13) <> "[COLLISIONONLY]" THEN
            IF INT(ctime + objectoffset(temp13)) MOD 2 THEN
                _PUTIMAGE (objectx(temp13) + posx, objecty(temp13) + posy), objecta(temp13)
            ELSE
                _PUTIMAGE (objectx(temp13) + posx, objecty(temp13) + posy), objectb(temp13)
            END IF
            IF missingasset = 1 THEN _PUTIMAGE (objectx(temp13) + posx, objecty(temp13) + posy)-(objectx(temp13) + objectresx(temp13) + posx, objecty(temp13) + objectresy(temp13) + posy), errortexture: LET missingasset = 0
        END IF
    END IF
    LET drawpass1 = 0
    LET drawpass2 = 0
LOOP UNTIL temp13 >= mapobjectno OR temp13 >= totalobjects
LET temp13 = 0: LET drawpass1 = 0: LET drawpass2 = 0: REM scrub temp values
RETURN

layercalc:
REM calculates object and player layers
REM OBJECT LAYER CALC
DO
    LET temp999 = temp999 + 1
    IF objectlayer(temp999) = 0 THEN
        REM automatically set layer
        IF ((resy / 2) - (objectresy(temp999) / 2) + (mpy / 2) - objects(temp999)) - posy > objecty(temp999) THEN
            LET objectl(temp999) = 1
        ELSE
            LET objectl(temp999) = 2
        END IF
    ELSE
        REM force layer
        LET objectl(temp999) = objectlayer(temp999)
    END IF
LOOP UNTIL temp999 >= mapobjectno OR temp999 >= totalobjects
LET temp999 = 0
REM NPC LAYER CALC
DO
    LET temp999 = temp999 + 1
    IF playerlayer2(temp999) = 0 THEN
        REM automatically set layer
        IF ((resy / 2) - (playerresy(temp999) / 2) + (mpy / 2) - players(temp999)) - posy > playery(temp999) THEN
            LET playerlayer(temp999) = 1
        ELSE
            LET playerlayer(temp999) = 2
        END IF
    ELSE
        REM force layer
        LET playerlayer(temp999) = playerlayer2(temp999)
    END IF
LOOP UNTIL temp999 >= mapplayerno OR temp999 >= totalplayers
LET temp999 = 0: REM scrub temp values
RETURN

screendraw:
REM draws game on screen
REM return for if screen draw isn't neeeded
IF nodraw = 1 THEN LET nodraw = 0: RETURN
IF fadestatus = 1 THEN RETURN
IF scriptskip = 1 THEN RETURN
REM clears screen if needed
IF clearscreen = 1 THEN
    CLS
    LET clearscreen = 0
    REM tells console
    LET eventtitle$ = "SCREEN CLEARED!"
    LET eventdata$ = "FRAMES:"
    LET eventnumber = frames
    GOSUB consoleprinter
END IF
REM calculates map location
'IF mpwalking = 0 THEN
	LET posx = INT(posx): REM remove decimals
	LET posy = INT(posy): REM remove decimals
'END IF
LET maploc1x = 0 + posx
LET maploc1y = 0 + posy
LET maploc2x = mapx + posx
LET maploc2y = mapy + posy
REM calulates object draw order
LET objectl = 1: REM resets layer counter
GOSUB layercalc: REM calculates layers
IF parallaxmode = 1 THEN GOSUB parallaxdraw: REM draws background parallax layer
GOSUB worlddraw: REM draws world
IF mapobjectno > 0 THEN GOSUB objectdraw: REM draws map objects (first layer)
IF mapplayerno > 0 THEN GOSUB playerdraw: REM draws NPCs (first layer)
GOSUB mainplayerdraw: REM draws mainplayer
LET objectl = objectl + 1: REM increases layer counter
IF mapobjectno > 0 THEN GOSUB objectdraw: REM draws map objects (second layer)
IF mapplayerno > 0 THEN GOSUB playerdraw: REM draws NPCs (second layer)
IF parallaxmode = 2 AND effectani = 0 THEN GOSUB parallaxdraw: REM draws foreground parallax layer
IF hud <> 0 THEN GOSUB hud: REM calls for developer hud to be drawn if needed
IF mapeffect > 0 THEN GOSUB effectdraw: REM draws special map effects
REM draws cutscene running image
IF scriptrun = 1 AND mainmenu = 0 THEN _PUTIMAGE (1, 1)-(scriptimageresx, scriptimageresy), scriptimage
IF selectobjecthighlight = 1 AND fading = 0 THEN GOSUB selectobjectbanner
IF awarddisplay <> 0 AND fading = 0 THEN GOSUB awarddraw
IF effectani = 0 THEN _DISPLAY
RETURN

awarddraw:
REM draws any recieved awards to screen
IF temp212 = 0 THEN LET temp213 = (awarditemlocy - awardbannerresy) - 1
IF temp212 >= awardbannerresy THEN GOTO awarddraw2
REM banner scrolls in
_PUTIMAGE (awardbannerlocx, (awardbannerlocy - temp212))-(awardbannerlocx + awardbannerresx - 1, awardbannerlocy + temp212 - 1), awardbanner
_PUTIMAGE (awarditemlocx, temp213), awardsprite(awarddisplay)
IF temp212 < awardbannerresy THEN LET temp212 = temp212 + awardspeed: LET temp213 = temp213 + awardspeed: RETURN: REM returns while scrolling animation occurs
awarddraw2:
REM banner hovers for a while
IF temp214 = 0 THEN LET temp214 = ctime + awardgracetime
IF temp217 = 0 THEN
    REM plays sfx
    LET playsfx$ = "awardgranted"
    GOSUB sfxplay
    LET temp217 = 1
END IF
COLOR _RGBA(letpocketdefaultcolourr, letpocketdefaultcolourg, letpocketdefaultcolourb, letpocketdefaultcoloura), _RGBA(bgpocketdefaultcolourr, bgpocketdefaultcolourg, bgpocketdefaultcolourb, bgpocketdefaultcoloura)
_PUTIMAGE (awardbannerlocx, awardbannerlocy)-(awardbannerresx - 1, awardbannerresy - 1), awardbanner
_PUTIMAGE (awarditemlocx, awarditemlocy)-(awarditemlocx + awarditemresx - 1, awarditemlocy + awarditemresy - 1), awardsprite(awarddisplay)
_PRINTSTRING (awardtextlocx, awardtextlocy), awardnotification$
_PRINTSTRING (awardtextlocx, awardtextlocy + fontsize), awardname$(awarddisplay)
IF temp214 <= ctime THEN
    REM end award display
    LET awarddisplay = 0
    LET temp212 = 0
    LET temp213 = 0
    LET temp214 = 0
    LET temp217 = 0
    LET clearscreen = 1
END IF
COLOR 0, 0
RETURN

selectobjectbanner:
REM displays name of selected world object (beta)
IF scriptrun = 1 THEN RETURN: REM return for if script is running
DO
    LET temp215 = temp215 + 1
    LET temp216 = temp216 + objecthighlight(temp215)
LOOP UNTIL temp215 >= mapobjectno
LET temp215 = 0
DO
    LET temp215 = temp215 + 1
    LET temp216 = temp216 + playerhighlight(temp215)
LOOP UNTIL temp215 >= mapplayerno
LET temp215 = 0
IF temp216 = 0 THEN RETURN: REM return for if no object is set to be highlighted.
IF selectobjectlong$ = "" THEN RETURN: REM return for if there is no nearby object
COLOR _RGBA(letselectbannercolourr, letselectbannercolourg, letselectbannercolourb, letselectbannercoloura), _RGBA(bgselectbannercolourr, bgselectbannercolourg, bgselectbannercolourb, bgselectbannercoloura)
LET centretext$ = selectobjectlong$
GOSUB centretext
_PRINTSTRING ((resx / 2) - (centreno / 2), resy - fontsize), selectobjectlong$
COLOR 0, 0
LET temp215 = 0: LET temp216 = 0
RETURN

inputter:
REM input sub
REM figures out which key is beng pressed
REM up
IF ucontrol = 1 THEN IF _KEYDOWN(ucontrolcode1) OR _KEYDOWN(ucontrolcode2) OR _KEYDOWN(ucontrolcode3) OR _KEYDOWN(ucontrolcode4) THEN LET keypressedup = 1
REM down
IF dcontrol = 1 THEN IF _KEYDOWN(dcontrolcode1) OR _KEYDOWN(dcontrolcode2) OR _KEYDOWN(dcontrolcode3) OR _KEYDOWN(dcontrolcode4) THEN LET keypresseddown = 1
REM left
IF lcontrol = 1 THEN IF _KEYDOWN(lcontrolcode1) OR _KEYDOWN(lcontrolcode2) OR _KEYDOWN(lcontrolcode3) OR _KEYDOWN(lcontrolcode4) THEN LET keypressedleft = 1
REM right
IF rcontrol = 1 THEN IF _KEYDOWN(rcontrolcode1) OR _KEYDOWN(rcontrolcode2) OR _KEYDOWN(rcontrolcode3) OR _KEYDOWN(rcontrolcode4) THEN LET keypressedright = 1
REM diagonal move blocker
IF keypressedup = 1 AND keypresseddown = 1 THEN LET diagonalmove = 1
IF keypressedup = 1 AND keypressedleft = 1 THEN LET diagonalmove = 1
IF keypressedup = 1 AND keypressedright = 1 THEN LET diagonalmove = 1
IF keypressedleft = 1 AND keypressedright = 1 THEN LET diagonalmove = 1
IF keypresseddown = 1 AND keypressedleft = 1 THEN LET diagonalmove = 1
IF keypresseddown = 1 AND keypressedright = 1 THEN LET diagonalmove = 1
REM shift blocker
IF _KEYDOWN(LSHIFT&) OR _KEYDOWN(RSHIFT&) THEN LET mpwalking = 0: LET diagonalmove = 1: LET a = 666666: _KEYCLEAR: RETURN
REM other reasons to leave
IF scriptrun = 1 AND allowscriptcontrol = 0 THEN RETURN: REM retrun for if script is running
REM return for if any triggers are active
FOR itl = 1 TO maptriggerno
    IF triggera(itl) = 1 THEN RETURN
NEXT itl
IF triggerspoofa = 1 THEN RETURN: REM return for if spoof trigger is active
IF diagonalmove = 0 THEN
    REM keyboard up
    IF keypressedup = 1 THEN
        LET oposy = posy
        LET posy = posy + pace
        LET direction = 1
        LET selectobject$ = ""
        LET selectobjectlong$ = ""
        LET objecttype$ = ""
        LET mpwalking = 1
    END IF
    REM keyboard down
    IF keypresseddown = 1 THEN
        LET oposy = posy
        LET posy = posy - pace
        LET direction = 2
        LET selectobject$ = ""
        LET selectobjectlong$ = ""
        LET objecttype$ = ""
        LET mpwalking = 1
    END IF
    REM keyboard right
    IF keypressedright = 1 THEN
        LET oposx = posx
        LET posx = posx - pace
        LET direction = 3
        LET selectobject$ = ""
        LET selectobjectlong$ = ""
        LET objecttype$ = ""
        LET mpwalking = 1
    END IF
    REM keyboard left
    IF keypressedleft = 1 THEN
        LET oposx = posx
        LET posx = posx + pace
        LET direction = 4
        LET selectobject$ = ""
        LET selectobjectlong$ = ""
        LET objecttype$ = ""
        LET mpwalking = 1
    END IF
    IF scriptrun = 0 THEN IF devmode = 1 THEN IF a = 92 OR a = 47 THEN _KEYCLEAR: GOSUB prompt: REM developer prompt if developer mode is on
ELSE
    LET mpfootloop = 0: LET mpwalking = 0: REM stops moonwalking bug
END IF
REM walking and idle animation switch
IF keypressedup = 0 THEN LET temp1 = temp1 + 1
IF keypresseddown = 0 THEN LET temp1 = temp1 + 1
IF keypressedleft = 0 THEN LET temp1 = temp1 + 1
IF keypressedright = 0 THEN LET temp1 = temp1 + 1
IF temp1 = 4 THEN
    IF mpwalking = 1 THEN LET mpidle = INT(ctime) + playeridle
    LET mpwalking = 0
END IF
LET diagonalmove = 0
IF scriptrun = 1 THEN _KEYCLEAR: LET temp1 = 0: LET keypressedup = 0: LET keypresseddown = 0: LET keypressedleft = 0: LET keypressedright = 0: RETURN: REM return for if a script is running when allowscriptcontrol is active
IF bcontrol = 1 THEN IF a = bcontrolcode1 OR a = bcontrolcode2 OR a = bcontrolcode3 OR a = bcontrolcode4 THEN _KEYCLEAR: LET awarddisplay = 0: GOSUB fadeout: LET menu$ = "mainmenu": GOSUB menugenerator: GOSUB mapmusicsetter: GOSUB musicplay: GOSUB fadein: REM opens main menu
IF pcontrol = 1 THEN IF a = pcontrolcode1 OR a = pcontrolcode2 OR a = pcontrolcode3 OR a = pcontrolcode4 THEN _KEYCLEAR: GOSUB pocketdraw: REM opens pockets
IF scontrol = 1 THEN IF a = scontrolcode1 OR a = scontrolcode2 OR a = scontrolcode3 OR a = scontrolcode4 THEN _KEYCLEAR: GOSUB useobject: REM interacts world object or player
_KEYCLEAR
REM flush temporary values
LET temp1 = 0: LET keypressedup = 0: LET keypresseddown = 0: LET keypressedleft = 0: LET keypressedright = 0
RETURN

useobject:
REM interacts with real world object or player
IF selectobject$ = "" THEN RETURN: REM return if mainplayer not around any object or player
LET scriptname$ = LCASE$(selectobject$)
IF selectobject$ <> "[COLLISIONONLY]" THEN
    LET mapscript = 1
    GOSUB script
END IF
LET clearscreen = 1
RETURN

mapmusicsetter:
REM sets playmusic$ to music attached to map
OPEN mloc$ + "/" + mapdir$ + "/" + mapfile$ + ".ddf" FOR INPUT AS #1
INPUT #1, dummy$, playmusic$
CLOSE #1
LET dummy$ = ""
RETURN

loadgame:
REM game load sequence whilst in gameplay
REM shifts values for possible mainplayer sprite change
LET oldmplayermodel$ = mplayermodel$
LET oldmapno = mapno
GOSUB saveload
GOSUB mainplayerload
GOSUB mapload
RETURN

prompt:
REM ENGINE COMMAND PROMPT
COLOR _RGBA(letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura), _RGBA(bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura)
DO
    LET temp = 0: REM flush value for loop purposes
    INPUT ">"; prompt$
    IF prompt$ = "" THEN
        COLOR 0, 0
        CLS
        LET temp = 0
        LET temp5 = 0
        LET temp1$ = ""
        LET prompt$ = ""
        LET action$ = ""
        LET value$ = ""
        RETURN
    END IF
    LET action$ = LEFT$(prompt$, INSTR(prompt$, " ") - 1)
    LET value$ = RIGHT$(prompt$, LEN(prompt$) - LEN(action$))
    LET value$ = LTRIM$(value$)
    LET action$ = LCASE$(action$)
    LET value$ = LCASE$(value$)
    REM say
    IF action$ = "save" THEN
        IF value$ = "erase" THEN GOSUB erasesave: PRINT "SAVE ERASED!": LET temp = 1
        IF value$ = "game" THEN GOSUB savesave: PRINT "GAME SAVED!": LET temp = 1
        IF value$ = "load" THEN
            GOSUB loadgame
            PRINT "GAME LOADED!"
            LET temp = 1
        END IF
        IF value$ = "default" THEN GOSUB savedefault: PRINT "SAVE DEFAULT SET!": LET temp = 1
    END IF
    IF action$ = "say" THEN
        LET textspeech$ = value$
        GOSUB variablevalueinjector
        GOSUB textbannerdraw
        COLOR _RGBA(letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura), _RGBA(bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura)
        LET temp = 1
    END IF
    REM mark item as "gone forever"
    IF action$ = "markgone" THEN
        PRINT "WARNING: this will remove the " + value$ + " from the gameplay FOREVER!"
        PRINT "are you sure you want to proceed? (Y/N)"
        INPUT temp24$
        IF UCASE$(temp24$) = "Y" THEN
            LET takeitem$ = value$
            GOSUB markgone
            PRINT value$ + " marked as gone forever"
        END IF
        LET temp = 1
    END IF
    REM recover item
    IF action$ = "markback" THEN
        OPEN pocketloc$ + "pocketfiles.ddf" FOR INPUT AS #1
        REM seaches for item in pocketfiles
        DO
            LET temp96 = temp96 + 1
            INPUT #1, pocketfile$
        LOOP UNTIL pocketfile$ = value$ OR EOF(1)
        CLOSE #1
        IF pocketfile$ <> value$ OR pocketfile$ = "currency" THEN
            REM if search finds nothing or currency is attempted to be removed
            REM prints to console
            LET eventtitle$ = "INVALID ITEM:"
            LET eventdata$ = value$
            LET eventnumber = 0
            GOSUB consoleprinter
        ELSE
            REM assigns item
            LET pocketitem(temp96) = 0
            REM prints to console
            LET eventtitle$ = "ITEM RECOVERED:"
            LET eventdata$ = value$
            LET eventnumber = temp65
            GOSUB consoleprinter
        END IF
        LET temp = 1
        LET temp96 = 0: REM scrubs temp values
    END IF
    REM give currency
    IF action$ = "givecurrency" THEN
        LET currencychange = VAL(value$)
        GOSUB givecurrency
        COLOR _RGBA(letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura), _RGBA(bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura)
        LET temp = 1
    END IF
    REM take currency
    IF action$ = "takecurrency" THEN
        LET currencychange = VAL(value$)
        GOSUB takecurrency
        COLOR _RGBA(letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura), _RGBA(bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura)
        LET temp = 1
    END IF
    REM hide item
    IF action$ = "hideitem" THEN
        LET hideitem$ = value$
        GOSUB hideitem
        IF pocketfile$ = hideitem$ THEN PRINT hideitem$ + " HIDDEN!": LET temp = 1
    END IF
    REM show item
    IF action$ = "showitem" THEN
        LET showitem$ = value$
        GOSUB showitem
        IF pocketfile$ = showitem$ THEN PRINT showitem$ + " VISIBLE!": LET temp = 1
    END IF
    REM give item
    IF action$ = "giveitem" THEN
        LET giveitem$ = value$
        GOSUB giveitem
        IF pocketfile$ = giveitem$ THEN LET temp = 1
    END IF
    REM take item
    IF action$ = "takeitem" THEN
        LET takeitem$ = value$
        GOSUB takeitem
        IF pocketfile$ = takeitem$ THEN LET temp = 1
    END IF
    REM play music
    REM play sound effect
    IF action$ = "sfx" THEN
        LET playsfx$ = value$
        GOSUB sfxplay
        LET temp = 1
    END IF
    REM run script
    IF action$ = "script" THEN
        REM map script
        _KEYCLEAR
        IF _FILEEXISTS(scriptloc$ + mapdir$ + value$ + ".vsf") THEN
            LET scriptname$ = value$: LET mapscript = 1: GOSUB script: LET temp = 1
        ELSE
            REM combination script
            IF _FILEEXISTS(scriptloc$ + "combine/" + value$ + ".vsf") THEN
                LET scriptname$ = value$: LET mapscript = 2: GOSUB script: LET temp = 1
            ELSE
                PRINT "SCRIPT NOT FOUND": LET action$ = "ilovexander": LET temp = 1
            END IF
        END IF
    END IF
    REM simulate errors
    IF action$ = "error" THEN
        ERROR VAL(value$): LET temp = 1
        IF temp = 0 THEN LET temp = 2: REM sets invalid argument error
    END IF
    REM SHELL
    IF action$ = "shell" THEN SHELL value$: LET temp = 1
    REM change  value
    IF action$ = "change" THEN
        IF value$ = "pace" THEN INPUT "INSERT VALUE> "; temp5: LET pace = temp5: LET temp = 1
        IF value$ = "mapno" THEN INPUT "INSERT VALUE> "; temp5: LET oldmapname$ = mapname$: LET oldmapno = mapno: LET mapno = temp5: LET temp = 1
        IF value$ = "direction" THEN INPUT "INSERT VALUE> "; temp5: LET direction = temp5: LET temp = 1
        IF value$ = "mainplayer" THEN PRINT "INSERT VALUE>": INPUT temp1$: LET oldmplayermodel$ = mplayermodel$: LET mplayermodel$ = temp1$: LET temp = 1
        IF value$ = "posx" THEN INPUT "INSERT VALUE> "; temp5: LET posx = temp5: LET temp = 1
        IF value$ = "posy" THEN INPUT "INSERT VALUE> "; temp5: LET posy = temp5: LET temp = 1
        IF value$ = "resx" THEN INPUT "INSERT VALUE> "; temp5: LET resx = temp5: PRINT "VaME requires resolution to be set in "; dloc$; "engine.ddf for object collsion to function.": LET temp = 1
        IF value$ = "resy" THEN INPUT "INSERT VALUE> "; temp5: LET resy = temp5: PRINT "VaME requires resolution to be set in "; dloc$; "engine.ddf for object collsion to function.": LET temp = 1
        IF value$ = "fontsize" THEN INPUT "INSERT VALUE> "; temp5: LET fontsize = temp5: LET temp = 1
        IF value$ = "fontname" THEN PRINT "INSERT VALUE>": INPUT temp1$: LET fontname$ = temp1$: LET temp = 1
        IF value$ = "fontstyle" THEN PRINT "INSERT VALUE>": INPUT temp1$: LET fontstyle$ = temp1$: LET temp = 1
        IF value$ = "noclip" THEN INPUT "INSERT VALUE> "; temp5: LET noclip = temp5: LET temp = 1
        IF value$ = "devmode" THEN INPUT "INSERT VALUE> "; temp5: LET devmode = temp5: LET temp = 1
        IF value$ = "playmusic" THEN INPUT "INSERT VALUE> "; temp1$: LET playmusic$ = temp1$: LET temp = 1
        IF value$ = "soundmode" THEN INPUT "INSERT VALUE> "; temp5: LET soundmode = temp5: LET temp = 1
        IF value$ = "ros" THEN INPUT "INSERT VALUE> "; temp1$: LET ros$ = temp1$: LET temp = 1
        IF value$ = "disablefade" THEN INPUT "INSERT VALUE> "; temp5: LET disablefade = temp5: LET temp = 1
        IF value$ = "currency" THEN INPUT "INSERT VALUE> "; temp5: LET currency = temp5: LET temp = 1
        IF value$ = "mapeffect" THEN INPUT "INSERT VALUE> "; temp5: LET mapeffect = temp5: LET temp = 1
        IF value$ = "versionno" THEN INPUT "INSERT VALUE> "; temp1$: LET versionno$ = temp1$: LET temp = 1
        IF value$ = "musicvol" THEN INPUT "INSERT VALUE> "; temp5: LET musicvol = temp5: GOSUB musicvol: LET temp = 1
        IF value$ = "sfxvol" THEN INPUT "INSERT VALUE> "; temp5: LET sfxvol = temp5: GOSUB sfxvol: LET temp = 1
        IF value$ = "displayconsole" THEN INPUT "INSERT VALUE> "; temp5: LET displayconsole = temp5: LET temp = 1
        IF value$ = "checkpoint" THEN
            INPUT "INSERT VALUE> "; temp5
            IF checkpoint(temp5) = 0 THEN
                LET checkpoint(temp5) = 1
                PRINT "CHECKPOINT" + STR$(temp5) + " IS NOW ON!"
            ELSE
                LET checkpoint(temp5) = 0
                PRINT "CHECKPOINT" + STR$(temp5) + " IS NOW OFF!"
            END IF
            LET temp = 1
        END IF
        IF value$ = "trigger" THEN
            INPUT "INSERT VALUE> "; temp5
            IF triggerd(temp5) = 0 THEN
                LET triggerd(temp5) = 1
                PRINT "TRIGGER" + STR$(temp5) + " IS NOW ON!"
            ELSE
                LET triggerd(temp5) = 0
                PRINT "TRIGGER" + STR$(temp5) + " IS NOW OFF!"
            END IF
            LET temp = 1
        END IF
        IF value$ = "timer" THEN
            RANDOMIZE TIMER
            LET itime = TIMER: REM timer function
            LET ctime = 0: REM timer function
            PRINT "TIMER RESET"
            LET temp = 1
        END IF
        REM prints extra console data confirming value change
        IF temp = 1 THEN
            LET eventtitle$ = "VALUE CHANGE: "
            IF temp5 <> 0 THEN
                LET eventdata$ = value$ + " = "
                LET eventnumber = temp5
            ELSE
                LET eventdata$ = value$ + " = " + temp1$
            END IF
            GOSUB consoleprinter
            LET eventtitle$ = "": LET eventdata$ = "": LET eventnumber = 0
        END IF
        IF temp = 0 THEN LET temp = 2: REM sets invalid argument error
    END IF
    REM Whatis?
    IF action$ = "whatis" THEN
        IF value$ = "noclip" THEN PRINT noclip: LET temp = 1
        IF value$ = "resx" THEN PRINT resx: LET temp = 1
        IF value$ = "resy" THEN PRINT resy: LET temp = 1
        IF value$ = "mapno" THEN PRINT mapno: LET temp = 1
        IF value$ = "frames" THEN PRINT frames: LET temp = 1
        IF value$ = "ros" THEN PRINT ros$: LET temp = 1
        IF value$ = "mplayermodel" THEN PRINT mplayermodel$: LET temp = 1
        IF value$ = "pace" THEN PRINT pace: LET temp = 1
        IF value$ = "ctime" THEN PRINT ctime: LET temp = 1
        IF value$ = "itime" THEN PRINT itime: LET temp = 1
        IF value$ = "location" THEN PRINT "X: "; posx: PRINT "Y: "; posy: LET temp = 1
        IF value$ = "oldlocation" THEN PRINT "oX: "; oposx: PRINT "oY :"; oposy: LET temp = 1
        IF value$ = "direction" THEN PRINT direction: LET temp = 1
        IF value$ = "posx" THEN PRINT posx: LET temp = 1
        IF value$ = "posy" THEN PRINT posy: LET temp = 1
        IF value$ = "oposx" THEN PRINT oposx: LET temp = 1
        IF value$ = "oposy" THEN PRINT oposy: LET temp = 1
        IF value$ = "mapname" THEN PRINT mapname$: LET temp = 1
        IF value$ = "mpx" THEN PRINT mpx: LET temp = 1
        IF value$ = "mpy" THEN PRINT mpy: LET temp = 1
        IF value$ = "mpposx" THEN PRINT mpposx: LET temp = 1
        IF value$ = "mpposy" THEN PRINT mpposy: LET temp = 1
        IF value$ = "mapx" THEN PRINT mapx: LET temp = 1
        IF value$ = "mapy" THEN PRINT mapy: LET temp = 1
        IF value$ = "mpwalking" THEN PRINT mpwalking: LET temp = 1
        IF value$ = "mpfoot" THEN PRINT mpfoot: LET temp = 1
        IF value$ = "mpfootloop" THEN PRINT mpfootloop: LET temp = 1
        IF value$ = "footpace" THEN PRINT footpace: LET temp = 1
        IF value$ = "hud" THEN PRINT hud: LET temp = 1
        IF value$ = "clearscreen" THEN PRINT clearscreen: LET temp = 1
        IF value$ = "errdescription" THEN PRINT errdescription$: LET temp = 1
        IF value$ = "err" THEN PRINT ERR: LET temp = 1
        IF value$ = "errorline" THEN PRINT _ERRORLINE: LET temp = 1
        IF value$ = "date" THEN PRINT DATE$: LET temp = 1
        IF value$ = "time" THEN PRINT TIME$: LET temp = 1
        IF value$ = "fps" THEN PRINT fps: LET temp = 1
        IF value$ = "oldmapno" THEN PRINT oldmapno: LET temp = 1
        IF value$ = "oldmapname" THEN PRINT oldmapname$: LET temp = 1
        IF value$ = "oldmplayermodel" THEN PRINT oldmplayermodel$: LET temp = 1
        IF value$ = "fontname" THEN PRINT fontsname$: LET temp = 1
        IF value$ = "fontstyle" THEN PRINT fontstyle$: LET temp = 1
        IF value$ = "fontsize" THEN PRINT fontsize: LET temp = 1
        IF value$ = "devmode" THEN PRINT devmode: LET temp = 1
        IF value$ = "mapobjectno" THEN PRINT mapobjectno: LET temp = 1
        IF value$ = "maptriggerno" THEN PRINT maptriggerno: LET temp = 1
        IF value$ = "mapplayerno" THEN PRINT mapplayerno: LET temp = 1
        IF value$ = "playmusic" THEN PRINT playmusic$: LET temp = 1
        IF value$ = "currentmusic" THEN PRINT currentmusic$: LET temp = 1
        IF value$ = "oldmusic" THEN PRINT oldmusic$: LET temp = 1
        IF value$ = "soundmode" THEN PRINT soundmode: LET temp = 1
        IF value$ = "mpidle" THEN PRINT mpidle: LET temp = 1
        IF value$ = "playeridle" THEN PRINT playeridle: LET temp = 1
        IF value$ = "pocketnos" THEN PRINT pocketnos: LET temp = 1
        IF value$ = "disablefade" THEN PRINT disablefade: LET temp = 1
        IF value$ = "currency" THEN PRINT currency: LET temp = 1
        IF value$ = "mapeffect" THEN PRINT mapeffect: LET temp = 1
        IF value$ = "pocketcarry" THEN PRINT pocketcarry: LET temp = 1
        IF value$ = "versionno" THEN PRINT versionno$: LET temp = 1
        IF value$ = "timer" THEN PRINT TIMER: LET temp = 1
        IF value$ = "scriptline" THEN PRINT scriptline$: LET temp = 1
        IF value$ = "musicvol" THEN PRINT musicvol: LET temp = 1
        IF value$ = "sfxvol" THEN PRINT sfxvol: LET temp = 1
        IF value$ = "engineversionno" THEN PRINT engineversionno$: LET temp = 1
        IF value$ = "exitsave" THEN PRINT exitsave: LET temp = 1
        IF value$ = "collisionstep" THEN PRINT collisionstep: LET temp = 1
        IF value$ = "mainmenu" THEN PRINT mainmenu: LET temp = 1
        IF value$ = "fadestatus" THEN PRINT fadestatus: LET temp = 1
        IF value$ = "random" THEN PRINT randomscriptvalue: LET temp = 1
        IF value$ = "tempmusiccut" THEN PRINT tempmusiccut: LET temp = 1
        IF value$ = "tempmusicfade" THEN PRINT tempmusicfade: LET temp = 1
        IF value$ = "checkpoint" THEN
            LET temp = 1
            LET x = 0
            DO
                LET x = x + 1
                IF checkpoint(x) <> 0 THEN PRINT STR$(x)
            LOOP UNTIL x >= totalcheckpoints
        END IF
        IF value$ = "objectname" THEN
            LET temp = 1
            IF mapobjectno > 0 THEN
                LET x = 0
                DO
                    LET x = x + 1
                    PRINT objectname(x)
                LOOP UNTIL x >= mapobjectno
                LET x = 0
            ELSE
                PRINT "NO OBJECTS ATTACHED TO MAP"
            END IF
        END IF
        IF value$ = "pocketname" THEN
            LET temp = 1
            IF pocketnos > 0 THEN
                LET x = 0
                DO
                    LET x = x + 1
                    PRINT pocketname(x)
                LOOP UNTIL x >= pocketnos
                LET x = 0
            ELSE
                PRINT "NO POCKET ITEMS LOADED"
            END IF
        END IF
        IF value$ = "triggername" THEN
            LET temp = 1
            IF maptriggerno > 0 THEN
                DO
                    LET temp15 = temp15 + 1
                    PRINT triggername(temp15)
                LOOP UNTIL temp15 >= maptriggerno
                LET temp15 = 0: REM scrub temp values
            ELSE
                PRINT "NO TRIGGERS ATTACHED TO MAP"
            END IF
        END IF
        IF value$ = "playername" THEN
            LET temp = 1
            IF mapplayerno > 0 THEN
                DO
                    LET temp43 = temp43 + 1
                    PRINT playername$(temp43)
                LOOP UNTIL temp43 >= mapplayerno
                LET temp43 = 0: REM scrub temp values
            ELSE
                PRINT "NO PLAYERS ATTACHED TO MAP"
            END IF
        END IF
        IF temp = 0 THEN LET temp = 2: REM sets invalid argument error
    END IF
    REM system (resets or halts system subs)
    IF action$ = "system" THEN
        LET promptquit = 1
        IF value$ = "now" THEN LET temp = 1: COLOR _RGBA(letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura), _RGBA(bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura): PRINT "SYSTEM NOW!": GOSUB consolequit: SYSTEM
        IF value$ = "hang" THEN LET temp = 1: COLOR _RGBA(letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura), _RGBA(bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura): PRINT "SYSTEM HUNG!": GOSUB consolequit: END
        IF value$ = "map" THEN LET temp = 1: GOSUB mapload: COLOR _RGBA(letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura), _RGBA(bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura): PRINT "MAP DATA RELOADED!"
        IF value$ = "mainplayer" THEN LET temp = 1: GOSUB mainplayerload: COLOR _RGBA(letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura), _RGBA(bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura): PRINT "MAINPLAYER DATA RELOADED!": LET temp = 1
        IF value$ = "screen" THEN LET temp = 1: GOSUB screenload: GOSUB fontload: LET clearscreen = 1: COLOR _RGBA(letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura), _RGBA(bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura): PRINT "SCREEN DATA RELOADED!"
        IF value$ = "font" THEN LET temp = 1: GOSUB fontunload: GOSUB fontload: COLOR _RGBA(letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura), _RGBA(bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura): PRINT "FONT DATA RELOADED!"
        IF value$ = "quit" THEN LET temp = 1: COLOR _RGBA(letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura), _RGBA(bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura): PRINT "SYSTEM QUIT!": GOSUB consolequit: GOTO endgame
        IF value$ = "ui" THEN LET temp = 1: GOSUB uiunload: GOSUB uiload: COLOR _RGBA(letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura), _RGBA(bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura): PRINT "UI DATA RELOADED!"
        IF value$ = "pockets" THEN LET temp = 1: GOSUB pocketunload: GOSUB pocketload: COLOR _RGBA(letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura), _RGBA(bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura): PRINT "POCKET DATA RELOADED!"
        IF value$ = "music" THEN LET temp = 1: GOSUB musicunload: GOSUB musicload: COLOR _RGBA(letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura), _RGBA(bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura): PRINT "MUSIC DATA RELOADED!"
        IF value$ = "sfx" THEN LET temp = 1: GOSUB sfxunload: GOSUB sfxload: COLOR _RGBA(letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura), _RGBA(bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura): PRINT "SOUND EFFECT DATA RELOADED!"
        IF value$ = "terminal" THEN LET temp = 1: GOSUB terminalunload: GOSUB terminalload: COLOR _RGBA(letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura), _RGBA(bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura): PRINT "TERMINAL DATA RELOADED!"
        IF value$ = "update" THEN LET temp = 1: GOSUB updatechecker: COLOR _RGBA(letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura), _RGBA(bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura): PRINT "UPDATE CHECK COMPLETE!"
        IF value$ = "fix" THEN LET temp = 1: LET fixvame = 1: GOSUB updatechecker: LET fixvame = 0: COLOR _RGBA(letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura), _RGBA(bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura): PRINT "FIXING COMPLETE!"
        IF value$ = "restart" THEN LET temp = 1: LET temp160 = 1: GOTO endgame
        IF value$ = "colour" THEN
            OPEN "data\colours.ddf" FOR INPUT AS #1
            INPUT #1, letmenuselectcolourr, letmenuselectcolourg, letmenuselectcolourb, letmenuselectcoloura, bgmenuselectcolourr, bgmenuselectcolourg, bgmenuselectcolourb, bgmenuselectcoloura, letmenudefaultcolourr, letmenudefaultcolourg, letmenudefaultcolourb, letmenudefaultcoloura, bgmenudefaultcolourr, bgmenudefaultcolourg, bgmenudefaultcolourb, bgmenudefaultcoloura, letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura, bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura, letpocketselectcolourr, letpocketselectcolourg, letpocketselectcolourb, letpocketselectcoloura, bgpocketselectcolourr, bgpocketselectcolourg, bgpocketselectcolourb, bgpocketselectcoloura, letpocketdefaultcolourr, letpocketdefaultcolourg, letpocketdefaultcolourb, letpocketdefaultcoloura, bgpocketdefaultcolourr, bgpocketdefaultcolourg, bgpocketdefaultcolourb, bgpocketdefaultcoloura, letcurrencycolourr, letcurrencycolourg, letcurrencycolourb, letcurrencycoloura, bgcurrencycolourr, bgcurrencycolourg, bgcurrencycolourb, bgcurrencycoloura, letspeechcolourr, letspeechcolourg, letspeechcolourb, letspeechcoloura, bgspeechcolourr, bgspeechcolourg, bgspeechcolourb, bgspeechcoloura, letterminalcolourr, letterminalcolourg, letterminalcolourb, letterminalcoloura, bgterminalcolourr, bgterminalcolourg, bgterminalcolourb, bgterminalcoloura
            CLOSE #1
            COLOR _RGBA(letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura), _RGBA(bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura)
            PRINT "COLOURS RELOADED!"
            LET temp = 1
        END IF
        IF value$ = "consolelog" THEN
            REM erase consolelog.txt
            OPEN consolelog$ FOR OUTPUT AS #3
            PRINT #3, DATE$, TIME$, "VaME CONSOLE LOG"
            CLOSE #3
            COLOR _RGBA(letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura), _RGBA(bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura)
            PRINT "CONSOLELOG.TXT ERASED"
            LET temp = 1
        END IF
        IF temp = 0 THEN LET temp = 2: REM sets invalid argument error
        LET promptquit = 0
    END IF
    REM hud display
    IF action$ = "display" THEN
        IF value$ = "off" THEN LET hud = 0: LET clearscreen = 1: LET temp = 1
        IF value$ = "location" THEN LET hud = 1: LET temp = 1
        IF value$ = "olocation" THEN LET hud = 2: LET temp = 1
        IF value$ = "time" THEN LET hud = 3: LET temp = 1
        IF value$ = "frames" THEN LET hud = 4: LET temp = 1
        IF value$ = "maplocation" THEN LET hud = 5: LET temp = 1
        IF value$ = "fadein" THEN GOSUB fadein: LET temp = 1
        IF value$ = "fadeout" THEN GOSUB fadeout: LET temp = 1
        IF value$ = "techspecs" THEN LET hud = 6: LET temp = 1
        IF value$ = "layers" THEN LET hud = 7: LET temp = 1
        IF value$ = "mplayerlocation" THEN LET hud = 8: LET temp = 1
        IF value$ = "selectobject" THEN LET hud = 9: LET temp = 1
        IF value$ = "playerlocation" THEN LET hud = 10: LET temp = 1
        IF value$ = "mouselocation" THEN LET hud = 11: LET temp = 1
        IF value$ = "console" THEN GOSUB displayconsole: LET temp = 1
        IF value$ = "miniconsole" THEN LET hud = 12: LET temp = 1
        IF value$ = "checkpoint" THEN LET hud = 13: LET temp = 1
        IF value$ = "gametime" THEN LET hud = 14: LET temp = 1
        IF temp = 0 THEN LET temp = 2: REM sets invalid argument error
    END IF
    REM write console activity to consolelog.txt and display console command results on screen
    OPEN consolelog$ FOR APPEND AS #2
    IF temp = 0 THEN
        IF consolelogging = 1 THEN PRINT #2, DATE$, TIME$, "INVALID PROMPT COMMAND: ", prompt$
        PRINT "INVALID COMMAND - "; prompt$
        IF displayconsole = 1 THEN
            _DEST _CONSOLE
            PRINT DATE$, TIME$, "INVALID PROMPT COMMAND: ", prompt$
            _DEST 0
        END IF
    END IF
    IF temp = 1 THEN
        IF consolelogging = 1 THEN PRINT #2, DATE$, TIME$, "PROMPT COMMAND: ", prompt$
        PRINT "OK!"
        IF displayconsole = 1 THEN
            _DEST _CONSOLE
            PRINT DATE$, TIME$, "PROMPT COMMAND: ", prompt$
            _DEST 0
        END IF
    END IF
    IF temp = 2 THEN
        PRINT #2, DATE$, TIME$, "INVALID PROMPT ARGUMENT: ", prompt$
        PRINT "INVALID ARGUMENT - "; value$
        IF displayconsole = 1 THEN
            _DEST _CONSOLE
            PRINT DATE$, TIME$, "INVALID PROMPT ARGUMENT: ", prompt$
            _DEST 0
        END IF
    END IF
    CLOSE #2
    REM quits prompt if script has been run
    IF action$ = "script" THEN
        REM flush temp values
        LET temp = 0
        LET temp5 = 0
        LET temp1$ = ""
        LET prompt$ = "": LET action$ = "": LET value$ = ""
        REM return to engine loop
        RETURN
    END IF
LOOP
RETURN

consoleboot:
REM writes console boot data to consolelog.txt
IF consolelogging = 1 THEN
    IF _FILEEXISTS(consolelog$) THEN
        REM nothing
    ELSE
        OPEN consolelog$ FOR OUTPUT AS #2
        PRINT #2, DATE$, TIME$, "VaME CONSOLE LOG"
        CLOSE #2
    END IF
    OPEN consolelog$ FOR APPEND AS #2
    PRINT #2, DATE$, TIME$, "=== SYSTEM BOOT ==="
    CLOSE #2
END IF
REM prints to console
IF displayconsole = 1 THEN
    _DEST _CONSOLE
    PRINT DATE$, TIME$, "=== SYSTEM BOOT ==="
    _DEST 0
END IF
RETURN

consolequit:
REM writes console quit data to consolelog.txt
IF consolelogging = 1 THEN
    IF _FILEEXISTS(consolelog$) THEN
        REM nothing
    ELSE
        OPEN consolelog$ FOR OUTPUT AS #2
        PRINT #2, DATE$, TIME$, "VaME CONSOLE LOG"
        CLOSE #2
    END IF
    OPEN consolelog$ FOR APPEND AS #2
    IF errorcrash = 1 THEN LET temp2$ = "=== GURU MEDITATION ==="
    IF userquit = 1 THEN LET temp2$ = "=== SYSTEM QUIT ==="
    IF promptquit = 1 THEN
        IF LCASE$(value$) = "hang" THEN LET temp2$ = "=== SYSTEM HUNG ==="
        IF LCASE$(value$) = "now" THEN LET temp2$ = "=== SYSTEM HALT ==="
        IF LCASE$(value$) = "restart" THEN LET temp2$ = "=== SYSTEM RESTART ==="
    END IF
    PRINT #2, DATE$, TIME$, temp2$
    CLOSE #2
END IF
REM displays on console
IF displayconsole = 1 THEN
    _DEST _CONSOLE
    PRINT DATE$, TIME$, temp2$
    _DEST 0
END IF
REM scrub temp values
LET temp2$ = ""
RETURN

hud:
REM developer hud display
COLOR _RGBA(letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura), _RGBA(bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura)
REM location hud
IF hud = 1 THEN
    LOCATE 1, 1: PRINT "X: "; posx
    LOCATE 2, 1: PRINT "Y: "; posy
    LOCATE 3, 1: PRINT "D: "; direction
END IF
REM old location hud
IF hud = 2 THEN
    LOCATE 1, 1: PRINT "oX: "; oposx
    LOCATE 2, 1: PRINT "oY: "; oposy
END IF
REM time hud
IF hud = 3 THEN
    LOCATE 1, 1: PRINT "ctime: "; ctime
    LOCATE 2, 1: PRINT "frames: "; frames
    LOCATE 3, 1: PRINT "timer: "; TIMER
END IF
REM frames hud
IF hud = 4 THEN
    LOCATE 1, 1: PRINT "frame: "; frames
    LOCATE 2, 1: PRINT "fps: "; fps
END IF
REM map location hud
IF hud = 5 THEN
    LOCATE 1, 1: PRINT "MX1: "; maploc1x; " MY1: "; maploc1y
    LOCATE 2, 1: PRINT "MX2: "; maploc2x; " MY2: "; maploc2y
END IF
REM tech specs
IF hud = 6 THEN
    LOCATE 1, 1: PRINT title$ + " " + versionno$ + " " + engineversionno$
    LOCATE 2, 1: PRINT "MAP:" + LTRIM$(STR$(mapno)) + " OBJ:" + LTRIM$(STR$(mapobjectno)) + " NPC:" + LTRIM$(STR$(mapplayerno)) + " GT:" + LTRIM$(STR$(gametime))
    LOCATE 3, 1: PRINT "CT:" + LTRIM$(STR$(INT(ctime))) + " FPS:" + LTRIM$(STR$(fps)) + " F:" + LTRIM$(STR$(frames))
    LOCATE 4, 1: PRINT "X:" + LTRIM$(STR$((resx / 2) - posx)); " Y:" + LTRIM$(STR$((resx / 2) - posy)) + " D:" + LTRIM$(STR$(direction))
    LOCATE 5, 1: PRINT "RES:" + LTRIM$(STR$(resx)) + "x" + LTRIM$(STR$(resy)) + " OS:" + LTRIM$(ros$)
END IF
REM layers
IF hud = 7 THEN
    IF mapobjectno > 0 THEN
        LET x = 0
        DO
            LET temp16 = temp16 + 1
            LET x = x + 1
            LOCATE temp16, 1: PRINT objectname$(x) + " " + STR$(objectl(x))
        LOOP UNTIL x >= mapobjectno
        LET temp16 = 0
    ELSE
        LOCATE 1, 1: PRINT "No objects attached to map."
    END IF
    IF mapplayerno > 0 THEN
        LET x = 0
        DO
            LET temp16 = temp16 + 1
            LET x = x + 1
            LOCATE temp16, 1: PRINT playername$(x) + " " + STR$(objectl(x))
        LOOP UNTIL x >= mapplayerno
    ELSE
        LET x = x + 1
        LOCATE x, 1: PRINT "No players attached to map."
    END IF
    LET temp16 = 0: REM scrub temp values
END IF
REM main player location
IF hud = 8 THEN
    LOCATE 1, 1: PRINT "X: "; (resx / 2) - posx
    LOCATE 2, 1: PRINT "Y: "; (resy / 2) - posy
    LOCATE 3, 1: PRINT "D: "; direction
END IF
REM selected world object
IF hud = 9 THEN LOCATE 1, 1: PRINT selectobject$
REM NPC location
IF hud = 10 THEN
    IF mapplayerno > 0 THEN
        DO
            LET temp16 = temp16 + 1
            LOCATE temp16, 1: PRINT playername$(temp16) + " X:" + STR$(playerx(temp16)) + " Y:" + STR$(playery(temp16))
        LOOP UNTIL temp16 >= mapplayerno
    ELSE
        LOCATE 1, 1: PRINT "No players attached to map."
    END IF
    LET temp16 = 0: REM scrub temp values
END IF
REM mouse location
IF hud = 11 THEN
    LET mouse = _MOUSEINPUT
    LOCATE 1, 1: PRINT _MOUSEX - maploc1x
    LOCATE 2, 1: PRINT _MOUSEY - maploc1y
END IF
REM last console line
IF hud = 12 THEN LOCATE 1, 1: PRINT lastconsoleline$
REM checkpoints
IF hud = 13 THEN
    LET xxyy = 0
    LET xxxyyy = 1
    DO
        LET xxyy = xxyy + 1
        IF checkpoint(xxyy) <> 0 THEN LOCATE xxxyyy, 1: PRINT STR$(xxyy): LET xxxyyy = xxxyyy + 1
    LOOP UNTIL xxyy >= totalcheckpoints
    LET xxyy = 0
    LET xxxyyy = 0
END IF
REM gametime
IF hud = 14 THEN
    LOCATE 1, 1: PRINT gametime
    LOCATE 2, 1: PRINT LTRIM$(STR$(savetimehour)) + " : " + LTRIM$(STR$(savetimemin)) + " : " + LTRIM$(STR$(savetimesec))
END IF
COLOR 0, 0
RETURN

gamereboots:
REM reboots the game under certain curcumstances
REM request to reboot
IF temp160 = 1 THEN
    IF installtype = 1 THEN
        REM cross platform
        IF modrunning = 0 THEN
            REM no mod running
            IF ros$ = "win" THEN SHELL _DONTWAIT filename$ + "_win.exe"
            IF ros$ = "lnx" THEN SHELL _DONTWAIT "./" + filename$ + "_linux"
            IF ros$ = "mac" THEN SHELL _DONTWAIT "./" + filename$ + "_macos"
        ELSE
            REM mod running
            IF ros$ = "win" THEN SHELL _DONTWAIT filename$ + "_win.exe -mod=" + modname$
            IF ros$ = "lnx" THEN SHELL _DONTWAIT "./" + filename$ + "_linux -mod=" + modname$
            IF ros$ = "mac" THEN SHELL _DONTWAIT "./" + filename$ + "_macos -mod=" + modname$
        END IF
    ELSE
        REM platform specific
        IF modrunning = 0 THEN
            REM no mod running
            IF ros$ = "win" THEN SHELL _DONTWAIT filename$ + ".exe"
            IF ros$ = "lnx" THEN SHELL _DONTWAIT "./" + filename$
            IF ros$ = "mac" THEN SHELL _DONTWAIT "./" + filename$
        ELSE
            REM mod running
            IF ros$ = "win" THEN SHELL _DONTWAIT filename$ + ".exe -mod=" + modname$
            IF ros$ = "lnx" THEN SHELL _DONTWAIT "./" + filename$ + " -mod=" + modname$
            IF ros$ = "mac" THEN SHELL _DONTWAIT "./" + filename$ + " -mod=" + modname$
        END IF
    END IF
END IF
REM loads mod
IF temp164 = 1 THEN
    LET modname$ = requestedmod$
    IF installtype = 1 THEN
        REM cross platform
        IF ros$ = "win" THEN SHELL _DONTWAIT filename$ + "_win.exe -mod=" + modname$
        IF ros$ = "lnx" THEN SHELL _DONTWAIT "./" + filename$ + "_linux -mod=" + modname$
        IF ros$ = "mac" THEN SHELL _DONTWAIT "./" + filename$ + "_macos -mod=" + modname$
    ELSE
        REM platform specific
        IF ros$ = "win" THEN SHELL _DONTWAIT filename$ + ".exe -mod=" + modname$
        IF ros$ = "lnx" THEN SHELL _DONTWAIT "./" + filename$ + " -mod=" + modname$
        IF ros$ = "mac" THEN SHELL _DONTWAIT "./" + filename$ + " -mod=" + modname$
    END IF
END IF
RETURN

endgame:
REM quits game
REM prints user requested quit to console
LET userquit = 1: REM tells engine user has requested a system quit
LET eventtitle$ = "SYSTEM QUIT REQUESTED!"
LET eventdata$ = "FRAMES: "
LET eventnumber = frames
GOSUB consoleprinter
REM saves game, unloads data and fades out game
IF mainmenu = 1 THEN _PUTIMAGE (1, 1)-((loadiconresx), loadiconresy), loadicon
REM if game is running
IF setupboot = 0 THEN
    IF temp82 <> 1 AND temp159 <> 1 AND runupdate <> 1 AND exitsave = 1 THEN
        GOSUB savesave
    ELSE
        GOSUB savetime
    END IF
    GOSUB optionsave
    GOSUB playerunload
    GOSUB objectunload
    GOSUB mapunload
    GOSUB mainplayerunload
    GOSUB musicstop
    GOSUB sfxunload
    GOSUB musicunload
    GOSUB pocketunload
    GOSUB awardunload
    GOSUB terminalunload
    GOSUB uiunload
    GOSUB fontunload
END IF
REM if game isn't running (main menu)
IF setupboot = 1 THEN
    GOSUB optionsave
    GOSUB musicstop
    GOSUB sfxunload
    GOSUB musicunload
    GOSUB pocketunload
    GOSUB awardunload
    GOSUB terminalunload
    GOSUB uiunload
    GOSUB fontunload
END IF
GOSUB consolequit: REM writes quit to consolelog.txt
CLS
IF runupdate = 1 THEN RETURN: REM return to continue update process if needed
GOSUB gamereboots: REM reboots the game if required
SYSTEM
