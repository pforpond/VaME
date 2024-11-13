REM VaME Limit Converter
REM By Danielle Pond

setup:
ON ERROR GOTO errorhandler: REM error handler
REM check os
IF INSTR(_OS$, "[WINDOWS]") THEN LET ros$ = "win"
IF INSTR(_OS$, "[LINUX]") THEN LET ros$ = "lnx"
IF INSTR(_OS$, "[MACOSX]") THEN LET ros$ = "mac"
REM setup for converter
CLS
COLOR 15
REM checks game folder and files exist, exits if not
IF _DIREXISTS("data") THEN
	REM nothing
ELSE
	ERROR 420
END IF
IF _FILEEXISTS("data/engine.ddf") THEN
	REM nothing
ELSE
	ERROR 421
END IF
REM opens and reads engine metadata
OPEN "data/engine.ddf" FOR INPUT AS #1
INPUT #1, devmode, consolelogging, displayconsole, autoupdate, installtype, devlogono, selectobjecthighlight, musictransitionmode, musicfadechange, title$, filename$, totalobjects, totalplayers, totaltriggers, totalpockets, totalcheckpoints, totalframes, totalsfxs, totalmusics, totalscriptvalues, totalawards, resx, resy, hertz, extrahertz, exitsave, autotxtsfx, ucontrol, dcontrol, lcontrol, rcontrol, scontrol, pcontrol, bcontrol, ucontrolcode1, ucontrolcode2, ucontrolcode3, ucontrolcode4, dcontrolcode1, dcontrolcode2, dcontrolcode3, dcontrolcode4, lcontrolcode1, lcontrolcode2, lcontrolcode3, locontrolcode4, rcontrolcode1, rcontrolcode2, rcontrolcode3, rcontrolcode4, scontrolcode1, scontrolcode2, scontrolcode3, scontrolcode4, pcontrolcode1, pcontrolcode2, pcontrolcode3, pcontrolcode4, bcontrolcode1, bcontrolcode2, bcontrolcode3, bcontrolcode4, moveupgamepad$, movedowngamepad$, moveleftgamepad$, moverightgamepad$, selectgamepad$, pocketgamepad$, backgamepad$, enableobjectoffsets, enableplayeroffsets, enablemapoffsets, fadespeed, pace, objectstep, collisionstep, playeridle, footpace, fontname$, fontsize, fontstyle$, fontbuffer, imode, playerwalkdivide, scriptwalkdivide, scriptimage$, scriptimageresx, scriptimageresy, pockethudimage$, pockethudresx, pockethudresy, pocketarrowright$, pocketarrowleft$, pocketarrowselectright$, pocketarrowselectleft$, pocketarrowunavailableright$, pocketarrowunavailableleft$, pocketarrowresx, pocketarrowresy, pockethudanispeed, pocketarrowrlocx, pocketarrowrlocy, pocketarrowllocx, pocketarrowllocy, pocketspritex, pocketspritey, pocketspriteresx, pocketspriteresy, pocketbanner$, pocketbannerresx, pocketbannerresy, textbannersound, textbanner$, textbannername$, textbannerresx, textbannerresy, pocketselect$, pocketselectx, pocketselecty, pocketselectresx, pocketselectresy, lookaction$, lookx, useaction$, giveaction$, combineaction$, usex, givex, combinex, textbannerfacey, textbannerfaceresx, textbannerfaceresy, choicebanner$, choicearrowl, choicearrowr, currencyname$, loadicon$, loadiconresx, loadiconresy, saveicon$, saveiconresx, saveiconresy, downloadicon$, downloadiconresx, downloadiconresy, torcheffectfile$, loadbar$, devlogo$, devlogomode, awardbanner$, awardbannerresx, awardbannerresy, awardbannerlocx, awardbannerlocy, awarditemresx, awarditemresy, awarditemlocx, awarditemlocy, awardtextlocx, awardtextlocy, awardgracetime, awardtitle$, awardnotification$, awardspeed, awardnone$, awardarrowleft$, awardarrowright$, awardarrowselectleft$, awardarrowselectright$, versionno$, engineversionno$, updatelink$, updatekey$, letmenuselectcolourr, letmenuselectcolourg, letmenuselectcolourb, letmenuselectcoloura, bgmenuselectcolourr, bgmenuselectcolourg, bgmenuselectcolourb, bgmenuselectcoloura, letmenudefaultcolourr, letmenudefaultcolourg, letmenudefaultcolourb, letmenudefaultcoloura, bgmenudefaultcolourr, bgmenudefaultcolourg, bgmenudefaultcolourb, bgmenudefaultcoloura, letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura, bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura, letpocketselectcolourr, letpocketselectcolourg, letpocketselectcolourb, letpocketselectcoloura, bgpocketselectcolourr, bgpocketselectcolourg, bgpocketselectcolourb, bgpocketselectcoloura, letpocketdefaultcolourr, letpocketdefaultcolourg, letpocketdefaultcolourb, letpocketdefaultcoloura, bgpocketdefaultcolourr, bgpocketdefaultcolourg, bgpocketdefaultcolourb, bgpocketdefaultcoloura, letcurrencycolourr, letcurrencycolourg, letcurrencycolourb, letcurrencycoloura, bgcurrencycolourr, bgcurrencycolourg, bgcurrencycolourb, bgcurrencycoloura, letspeechcolourr, letspeechcolourg, letspeechcolourb, letspeechcoloura, bgspeechcolourr, bgspeechcolourg, bgspeechcolourb, bgspeechcoloura, letterminalcolourr, letterminalcolourg, letterminalcolourb, letterminalcoloura, bgterminalcolourr, bgterminalcolourg, bgterminalcolourb, bgterminalcoloura, letselectbannercolourr, letselectbannercolourg, letselectbannercolourb, letselectbannercoloura, bgselectbannercolourr, bgselectbannercolourg, bgselectbannercolourb, bgselectbannercoloura, spoofoptiontitle$, spoofoption1$, spoofoption2$, spoofoption1result$, spoofoption2result$, moddingname$
CLOSE #1
REM opens and reads engine paths
OPEN "data/fileloc.ddf" FOR INPUT AS #1
IF ros$ = "win" THEN INPUT #1, dloc$, mloc$, ploc$, floc$, sloc$, oloc$, scriptloc$, museloc$, sfxloc$, pocketloc$, uiloc$, tloc$, aloc$, menuloc$, awardloc$
IF ros$ = "lnx" OR ros$ = "mac" THEN INPUT #1, temp47$, temp47$, temp47$, temp47$, temp47$, temp47$, temp47$, temp47$, temp47$, temp47$, temp47$, temp47$, temp47$, temp47$, temp47$, dloc$, mloc$, ploc$, floc$, sloc$, oloc$, scriptloc$, museloc$, sfxloc$, pocketloc$, uiloc$, tloc$, aloc$, menuloc$, awardloc$: LET temp47$ = ""
CLOSE #1
REM converts engine limit values
LET oldobjectlimit = totalobjects
LET oldplayerlimit = totalplayers
LET oldtriggerlimit = totaltriggers
LET oldpocketlimit = totalpockets
LET oldcheckpointlimit = totalcheckpoints
LET oldframelimit = totalframes
LET oldsfxlimit = totalsfxs
LET oldmusiclimit = totalmusics
LET oldscriptvaluelimit = totalscriptvalues
LET oldawardlimit = totalawards
REM checks save data
IF _FILEEXISTS(sloc$ + "defaultsave.ddf") THEN
	REM nothing
ELSE
	ERROR 422
END IF
REM sets window title
IF title$ = "" THEN
	LET wtitle$ = "VaME Limit Converter"
ELSE
	LET wtitle$ = title$ + " Limit Converter"
END IF
_TITLE wtitle$
PRINT "GAME FOUND: " + title$
PRINT "Version: " + versionno$
PRINT "Engine: " + engineversionno$
PRINT
REM asks user for values
PRINT "INSERT NEW MAP OBJECT LIMIT (current =" + STR$(oldobjectlimit) + ") >"
INPUT newobjectlimit
PRINT "INSERT NEW MAP PLAYER LIMIT (current =" + STR$(oldplayerlimit) + ") >"
INPUT newplayerlimit
PRINT "INSERT NEW MAP TRIGGER LIMIT (current =" + STR$(oldtriggerlimit) + ") >"
INPUT newtriggerlimit
PRINT "INSERT NEW POCKET ITEM LIMIT (current =" + STR$(oldpocketlimit) + ") >"
INPUT newpocketlimit
PRINT "INSERT NEW GAME CHECKPOINT LIMIT (current =" + STR$(oldcheckpointlimit) + ") >"
INPUT newcheckpointlimit
PRINT "INSERT NEW ANIMATION FRAME LIMIT (current =" + STR$(oldframelimit) + ") >"
INPUT newframelimit
PRINT "INSERT NEW GAME SOUND EFFECT LIMIT (current =" + STR$(oldsfxlimit) + ") >"
INPUT newsfxlimit
PRINT "INSERT NEW GAME MUSIC TRACK LIMIT (current =" + STR$(oldmusiclimit) + ") >"
INPUT newmusiclimit
PRINT "INSERT NEW SCRIPT VALUE LIMIT (current =" + STR$(oldscriptvaluelimit) + ") >"
INPUT newscriptvaluelimit
PRINT "INSERT NEW AWARD VALUE LIMIT (current =" + STR$(oldawardlimit) + ") >"
INPUT newawardlimit
PRINT "ARE THESE FIGURES CORRECT?"
10 INPUT "Y/N"; a$
IF UCASE$(a$) = "Y" THEN GOTO dimmer
IF UCASE$(a$) = "N" THEN GOTO setup
GOTO 10

errorhandler:
REM handles errors
IF ERR < 420 THEN PRINT "ERROR: " + STR$(ERR) + " LINE: " + STR$(_ERRORLINE) + " " + _ERRORMESSAGE$
IF ERR = 420 THEN PRINT "NO GAME DATA FOLDER FOUND!"
IF ERR = 421 THEN PRINT "NO GAME METADATA FOUND!"
IF ERR = 422 THEN PRINT "NO DEFAULT SAVE FOUND!"
IF ERR = 423 THEN PRINT "UNKNOWN / UNSUPPORTED OPERATING SYSTEM!"
END

dimmer:
REM sets up array values
REM old object values
DIM oldobjectname(newobjectlimit) AS STRING
DIM oldobjectx(newobjectlimit) AS DOUBLE
DIM oldobjecty(newobjectlimit) AS DOUBLE
REM new object values
DIM newobjectname(newobjectlimit) AS STRING
DIM newobjectx(newobjectlimit) AS DOUBLE
DIM newobjecty(newobjectlimit) AS DOUBLE
REM old player values
DIM oldplayername(newplayerlimit) AS STRING
DIM oldplayerx(newplayerlimit) AS DOUBLE
DIM oldplayery(newplayerlimit) AS DOUBLE
DIM oldmplayerx(newplayerlimit) AS INTEGER
DIM oldmplayery(newplayerlimit) AS INTEGER
DIM oldplayergrace(newplayerlimit) AS INTEGER
DIM oldplayerdefault(newplayerlimit) AS INTEGER
REM new player values
DIM newplayername(newplayerlimit) AS STRING
DIM newplayerx(newplayerlimit) AS DOUBLE
DIM newplayery(newplayerlimit) AS DOUBLE
DIM newmplayerx(newplayerlimit) AS INTEGER
DIM newmplayery(newplayerlimit) AS INTEGER
DIM newplayergrace(newplayerlimit) AS INTEGER
DIM newplayerdefault(newplayerlimit) AS INTEGER
REM old trigger values
DIM oldtriggername(newtriggerlimit) AS STRING
DIM oldtriggerx1(newtriggerlimit) AS INTEGER
DIM oldtriggery1(newtriggerlimit) AS INTEGER
DIM oldtriggerx2(newtriggerlimit) AS INTEGER
DIM oldtriggery2(newtriggerlimit) AS INTEGER
DIM oldtriggerexit(newtriggerlimit) AS INTEGER
REM new trigger values
DIM newtriggername(newtriggerlimit) AS STRING
DIM newtriggerx1(newtriggerlimit) AS INTEGER
DIM newtriggery1(newtriggerlimit) AS INTEGER
DIM newtriggerx2(newtriggerlimit) AS INTEGER
DIM newtriggery2(newtriggerlimit) AS INTEGER
DIM newtriggerexit(newtriggerlimit) AS INTEGER
REM old checkpoint values
DIM oldcheckpoint(newcheckpointlimit) AS INTEGER
REM new checkpoint values
DIM newcheckpoint(newcheckpointlimit) AS INTEGER
REM old animation values
DIM oldframe(newframelimit) AS INTEGER
REM new animation values
DIM newframe(newframelimit) AS INTEGER
REM old pocket values
DIM oldpocketitem(newpocketlimit) AS INTEGER
DIM oldpocketvisible(newpocketlimit) AS INTEGER
DIM oldpocketslot(newpocketlimit) AS INTEGER
REM new pocket values
DIM newpocketitem(newpocketlimit) AS INTEGER
DIM newpocketvisible(newpocketlimit) AS INTEGER
DIM newpocketslot(newpocketlimit) AS INTEGER
REM new extra values
DIM oldscriptvalue(newscriptvaluelimit) AS INTEGER
DIM newscriptvalue(newscriptvaluelimit) AS INTEGER
REM new award values
DIM oldawardvalue(newawardlimit) AS INTEGER
DIM newawardvalue(newawardlimit) AS INTEGER
DIM oldawardname(newawardlimit) AS STRING
DIM newawardname(newawardlimit) AS STRING
DIM oldawarddesc(newawardlimit) AS STRING
DIM newawarddesc(newawardlimit) AS STRING
GOTO gatherfiles

gatherfiles:
REM collates locations of files may require changes
REM make external list of map folders
IF ros$ = "lnx" THEN SHELL _HIDE "ls " + mloc$ + " > maplist.ddf"
IF ros$ = "win" THEN SHELL _HIDE "dir /b " + CHR$(34) + mloc$ + CHR$(34) + " > maplist.ddf"
OPEN "maplist.ddf" FOR INPUT AS #1: REM open list
LET mapcount = 0
DO
	LET mapcount = mapcount + 1
	INPUT #1, zz$
LOOP UNTIL EOF(1)
CLOSE #1
REM make external list of frame folders
IF ros$ = "lnx" THEN SHELL _HIDE "ls " + aloc$ + " > framelist.ddf"
IF ros$ = "win" THEN SHELL _HIDE "dir /b " + CHR$(34) + aloc$ + CHR$(34) + " > framelist.ddf"
OPEN "framelist.ddf" FOR INPUT AS #1: REM open list
LET framecount = 0
DO
	LET framecount = framecount + 1
	INPUT #1, zz$
LOOP UNTIL EOF(1)
CLOSE #1
REM calculates number of files to be converted
LET filecount = 0: LET mapchange = 0: LET savechange = 0: LET framechange = 0: LET enginechange = 0
IF newobjectlimit > 0 AND newobjectlimit <> oldobjectlimit AND mapchange = 0 THEN LET filecount = filecount + mapcount: LET mapchange = 1
IF newplayerlimit > 0 AND newplayerlimit <> oldplayerlimit AND mapchange = 0 THEN LET filecount = filecount + mapcount: LET mapchange = 1
IF newtriggerlimit > 0 AND newtriggerlimit <> oldtriggerlimit AND mapchange = 0 THEN LET filecount = filecount + mapcount: LET mapchange = 1
IF newpocketlimit > 0 AND newpocketlimit <> oldpocketlimit AND savechange = 0 THEN LET filecount = filecount + 1: LET savechange = 1
IF newcheckpointlimit > 0 AND newcheckpointlimit <> oldcheckpointlimit AND savechange = 0 THEN LET filecount = filecount + 1: LET savechange = 1
IF newframelimit > 0 AND newframelimit <> oldframelimit AND framechange = 0 THEN LET filecount = filecount + framecount: LET framechange = 1
IF newscriptvaluelimit > 0 AND newscriptvaluelimit <> oldscriptvaluelimit AND savechange = 0 THEN LET filecount = filecount + 1: LET savechange = 1
IF newawardlimit > 0 AND newawardlimit <> oldawardlimit AND awardchange = 0 THEN LET filecount = filecount + 1: LET awardchange = 1
IF filecount > 0 THEN
	LET filecount = filecount + 1: LET enginechange = 1
ELSE
	IF newsfxlimit > 0 AND newsfxlimit <> oldsfxlimit AND enginechange = 0 THEN LET filecount = filecount + 1: LET enginechange = 1
	IF newmusiclimit > 0 AND newmusiclimit <> oldmusiclimit AND enginechange = 0 THEN LET filecount = filecount + 1: LET enginechange = 1
END IF
GOTO finalalert

finalalert:
REM final alert before conversion begins
CLS
PRINT "WARNING! CHANGES ARE NOT REVERSABLE! BACKUP BEFORE YOU PROCEED!"
PRINT "please note that the all save files will be removed"
PRINT
PRINT "VaME LIMIT CONVERTER WILL APPLY THE FOLLOWING CHANGES:"
IF newobjectlimit > 0 AND newobjectlimit <> oldobjectlimit THEN PRINT "* OLD MAP OBJECT LIMIT: " + STR$(oldobjectlimit) + " NEW MAP OBJECT LIMIT: " + STR$(newobjectlimit)
IF newplayerlimit > 0 AND newplayerlimit <> oldplayerlimit THEN PRINT "* OLD MAP PLAYER LIMIT: " + STR$(oldplayerlimit) + " NEW MAP PLAYER LIMIT: " + STR$(newplayerlimit)
IF newtriggerlimit > 0 AND newtriggerlimit <> oldtriggerlimit THEN PRINT "* OLD MAP TRIGGER LIMIT: " + STR$(oldtriggerlimit) + " NEW MAP TRIGGER LIMIT: " + STR$(newtriggerlimit)
IF newpocketlimit > 0 AND newpocketlimit <> oldpocketlimit THEN PRINT "* OLD POCKET ITEM LIMIT: " + STR$(oldpocketlimit) + " NEW POCKET ITEM LIMIT: " + STR$(newpocketlimit)
IF newcheckpointlimit > 0 AND newcheckpointlimit <> oldcheckpointlimit THEN PRINT "* OLD CHECKPOINT LIMIT: " + STR$(oldcheckpointlimit) + " NEW CHECKPOINT LIMIT: " + STR$(newcheckpointlimit)
IF newframelimit > 0 AND newframelimit <> oldframelimit THEN PRINT "* OLD ANIMATION FRAME LIMIT: " + STR$(oldframelimit) + " NEW ANIMATION FRAME LIMIT: " + STR$(newframelimit)
IF newsfxlimit > 0 AND newsfxlimit <> oldsfxlimit THEN PRINT "* OLD GAME SOUND EFFECT LIMIT: " + STR$(oldsfxlimit) + " NEW GAME SOUND EFFECT LIMIT: " + STR$(newsfxlimit)
IF newmusiclimit > 0 AND newmusiclimit <> oldmusiclimit THEN PRINT "* OLD GAME MUSIC TRACK LIMIT: " + STR$(oldmusiclimit) + " NEW GAME MUSIC TRACK LIMIT: " + STR$(newmusiclimit)
IF newscriptvaluelimit > 0 AND newscriptvaluelimit <> oldscriptvaluelimit THEN PRINT "* OLD SCRIPT VALUE LIMIT: " + STR$(oldscriptvaluelimit) + " NEW SCRIPT VALUE LIMIT: " + STR$(newscriptvaluelimit)
IF newawardlimit > 0 AND newawardlimit <> oldawardlimit THEN PRINT "* OLD AWARD LIMIT: " + STR$(oldawardlimit) + " NEW AWARD LIMIT: " + STR$(newawardlimit)
PRINT
IF filecount = 0 THEN
	REM if no changes are needed
	PRINT "NO CHANGES NEEDED!"
	END
END IF
PRINT "APPLY CHANGES TO " + STR$(filecount) " GAME FILES?"
20 INPUT "Y/N"; a$
IF UCASE$(a$) = "Y" THEN GOTO convertmanager
IF UCASE$(a$) = "N" THEN PRINT "CONVERSION ABORTED!": END
GOTO 20

convertmanager:
REM manages the conversion of game files
PRINT "CONVERTING..."
PRINT
IF enginechange = 1 THEN PRINT "* CONVERTING ENGINE FILE...": GOSUB engineconvert
IF mapchange = 1 THEN PRINT "* CONVERTING MAP FILES...": GOSUB mapconvert
IF framechange = 1 THEN PRINT "* CONVERTING FRAME FILES...": GOSUB frameconvert
IF savechange = 1 THEN PRINT "* CONVERTING DEFAULT SAVE DATA...": GOSUB saveconvert
IF awardchange = 1 THEN PRINT "* CONVERTING AWARD DATA...": GOSUB awardconvert
PRINT "...CONVERT COMPLETE!"
IF ros$ = "lnx" THEN SHELL _HIDE "rm maplist.ddf": SHELL _HIDE "rm framelist.ddf"
IF ros$ = "win" THEN SHELL _HIDE "del maplist.ddf": SHELL _HIDE "del framelist.ddf"
END

awardconvert:
REM converts awards.ddf to new requirements
REM loads award data
OPEN awardloc$ + "awards.ddf" FOR INPUT AS #1
FOR x = 1 TO oldawardlimit
	INPUT #1, oldawardname$(x)
    INPUT #1, oldawarddesc$(x)
NEXT x
CLOSE #1
REM converts award values
FOR x = 1 TO newawardlimit
	LET newawardname$(x) = oldawardname$(x)
	LET newawarddesc$(x) = oldawarddesc$(x)
NEXT x
REM saves to file 
OPEN awardloc$ + "awards.ddf" FOR OUTPUT AS #1
FOR x = 1 TO newawardlimit
	WRITE #1, newawardname$(x)
	WRITE #1, newawarddesc$(x)
NEXT x
CLOSE #1
RETURN

saveconvert:
REM converts defaultsave.ddf to new requirements
IF newpocketlimit = 0 THEN LET newpocketlimit = oldpocketlimit
IF newcheckpointlimit = 0 THEN LET newcheckpointlimit = oldcheckpointlimit
IF newawardlimit = 0 THEN LET newawardlimit = oldawardlimit
OPEN sloc$ + "defaultsave.ddf" FOR INPUT AS #1
INPUT #1, mapno, currency, posx, posy, direction, igametime, pocketcarry, pocketslot, huntmode, huntmap
REM loads pocket items
FOR x = 1 TO oldpocketlimit
    INPUT #1, oldpocketitem(x)
NEXT x
REM loads visible pocket data
FOR x = 1 TO oldpocketlimit
	INPUT #1, oldpocketvisible(x)
NEXT x
REM loads pocket slot data
FOR x = 1 TO oldpocketlimit
	INPUT #1, oldpocketslot(x)
NEXT x
REM loads checkpoints
FOR x = 1 TO oldcheckpointlimit
	INPUT #1, oldcheckpoint(x)
NEXT x
REM loads script values
FOR x = 1 TO oldscriptvaluelimit
	INPUT #1, oldscriptvalue(x)
NEXT x
REM loads award values
FOR x = 1 TO oldawardlimit
	INPUT #1, oldawardvalue(x)
NEXT x
REM loads main player and terminal os
DO
	INPUT #1, mplayermodel$, tosfile$
LOOP UNTIL tosfile$ <> "0" AND tosfile$ <> "1" OR EOF(1)
CLOSE #1
REM converts values
FOR x = 1 TO newpocketlimit
	LET newpocketitem(x) = oldpocketitem(x)
NEXT x
FOR x = 1 TO newpocketlimit
	LET newpocketvisible(x) = oldpocketvisible(x)
	LET newpocketslot(x) = oldpocketslot(x)
NEXT x
FOR x = 1 TO newcheckpointlimit
	LET newcheckpoint(x) = oldcheckpoint(x)
NEXT x
FOR x = 1 TO newscriptvaluelimit
	LET newscriptvalue(x) = oldscriptvalue(x)
NEXT x
FOR x = 1 TO newawardlimit
	LET newawardvalue(x) = oldawardvalue(x)
NEXT x 
REM writes converted data
OPEN sloc$ + "defaultsave.ddf" FOR OUTPUT AS #1
WRITE #1, mapno, currency, posx, posy, direction, igametime, pocketcarry, pocketslot, huntmode, huntmap
REM writes pocket items
FOR x = 1 TO newpocketlimit
    WRITE #1, newpocketitem(x)
NEXT x
REM writes extra pocket data
FOR x = 1 TO newpocketlimit
	WRITE #1, newpocketvisible(x)
NEXT x
FOR x = 1 TO newpocketlimit
	WRITE #1, newpocketslot(x)
NEXT x
REM writes checkpoints
FOR x = 1 TO newcheckpointlimit
    WRITE #1, newcheckpoint(x)
NEXT x
REM writes script values
FOR x = 1 TO newscriptvaluelimit
	WRITE #1, newscriptvalue(x)
NEXT x
REM writes award values
FOR x = 1 TO newawardlimit
	WRITE #1, newawardvalue(x)
NEXT x
REM writes main player
WRITE #1, mplayermodel$, tosfile$
CLOSE #1
REM removes old saves
IF ros$ = "lnx" THEN SHELL _HIDE "rm " + sloc$ + "savedata.ddf": SHELL _HIDE "rm " + sloc$ + "*.old"
IF ros$ = "win" THEN SHELL _HIDE "del " + sloc$ + "savedata.ddf": SHELL _HIDE "del "+ sloc$ + "*.old"
RETURN

engineconvert:
REM converts engine.ddf to new requirements
REM chooses which object limit to use
IF newobjectlimit > 0 AND newobjectlimit <> oldobjectlimit THEN
	LET printobjectlimit = newobjectlimit
ELSE
	LET printobjectlimit = oldobjectlimit
END IF
REM chooses which player limit to use
IF newplayerlimit > 0 AND newplayerlimt <> oldplayerlimit THEN
	LET printplayerlimit = newplayerlimit
ELSE
	LET printplayerlimit = oldplayerlimit
END IF
REM chooses which trigger limit to use
IF newtriggerlimit > 0 AND newtriggerlimit <> oldtriggerlimit THEN
	LET printtriggerlimit = newtriggerlimit
ELSE
	LET printtriggerlimit = oldplayerlimit
END IF
REM chooses which pocket limit to use
IF newpocketlimit > 0 AND newpocketlimit <> oldpocketlimit THEN
	LET printpocketlimit = newpocketlimit
ELSE
	LET printpocketlimit = oldpocketlimit
END IF
REM chooses which checkpoint limit to use
IF newcheckpointlimit > 0 AND newcheckpointlimit <> oldcheckpointlimit THEN
	LET printcheckpointlimit = newcheckpointlimit
ELSE
	LET printcheckpointlimit = oldcheckpointlimit
END IF
REM chooses which frame limit to use
IF newframelimit > 0 AND newframelimit <> oldframelimit THEN
	LET printframelimit = newframelimit
ELSE
	LET printframelimit = oldframelimit
END IF
REM chooses which sfx limit to use
IF newsfxlimit > 0 AND newsfxlimit <> oldsfxlimit THEN
	LET printsfxlimit = newsfxlimit
ELSE
	LET printsfxlimit = oldsfxlimit
END IF
REM chooses which music limit to use
IF newmusiclimit > 0 AND newmusiclimit <> oldmusiclimit THEN
	LET printmusiclimit = newmusiclimit
ELSE
	LET printmusiclimit = oldmusiclimit
END IF
REM chooses which script value limit to use
IF newscriptvaluelimit > 0 AND newscriptvaluelimit <> oldscriptvaluelimit THEN
	LET printscriptvaluelimit = newscriptvaluelimit
ELSE
	LET printscriptvaluelimit = oldscriptvaluelimit
END IF
REM chooses which award limit to use
IF newawardlimit > 0 AND newawardlimit <> oldawardlimit THEN
	LET printawardlimit = newawardlimit
ELSE
	LET printawardlimit = oldawardlimit
END IF
REM converts values
LET totalobjects = printobjectlimit
LET totalplayers = printplayerlimit
LET totaltriggers = printtriggerlimit
LET totalpockets = printpocketlimit
LET totalcheckpoints = printcheckpointlimit
LET totalframes = printframelimit
LET totalsfxs = printsfxlimit
LET totalmusics = printmusiclimit
LET totalscriptvalues = printscriptvaluelimit
LET totalawards = printawardlimit
REM writes changes to engine file
OPEN dloc$ + "engine.ddf" FOR OUTPUT AS #1
WRITE #1, devmode, consolelogging, displayconsole, autoupdate, installtype, devlogono, selectobjecthighlight, musictransitionmode, musicfadechange, title$, filename$, totalobjects, totalplayers, totaltriggers, totalpockets, totalcheckpoints, totalframes, totalsfxs, totalmusics, totalscriptvalues, totalawards, resx, resy, hertz, extrahertz, exitsave, autotxtsfx, ucontrol, dcontrol, lcontrol, rcontrol, scontrol, pcontrol, bcontrol, ucontrolcode1, ucontrolcode2, ucontrolcode3, ucontrolcode4, dcontrolcode1, dcontrolcode2, dcontrolcode3, dcontrolcode4, lcontrolcode1, lcontrolcode2, lcontrolcode3, locontrolcode4, rcontrolcode1, rcontrolcode2, rcontrolcode3, rcontrolcode4, scontrolcode1, scontrolcode2, scontrolcode3, scontrolcode4, pcontrolcode1, pcontrolcode2, pcontrolcode3, pcontrolcode4, bcontrolcode1, bcontrolcode2, bcontrolcode3, bcontrolcode4, enableobjectoffsets, enableplayeroffsets, enablemapoffsets, fadespeed, pace, objectstep, collisionstep, playeridle, footpace, fontname$, fontsize, fontstyle$, fontbuffer, imode, playerwalkdivide, scriptwalkdivide, scriptimage$, scriptimageresx, scriptimageresy, pockethudimage$, pockethudresx, pockethudresy, pocketarrowright$, pocketarrowleft$, pocketarrowselectright$, pocketarrowselectleft$, pocketarrowunavailableright$, pocketarrowunavailableleft$, pocketarrowresx, pocketarrowresy, pockethudanispeed, pocketarrowrlocx, pocketarrowrlocy, pocketarrowllocx, pocketarrowllocy, pocketspritex, pocketspritey, pocketspriteresx, pocketspriteresy, pocketbanner$, pocketbannerresx, pocketbannerresy, textbannersound, textbanner$, textbannername$, textbannerresx, textbannerresy, pocketselect$, pocketselectx, pocketselecty, pocketselectresx, pocketselectresy, lookaction$, lookx, useaction$, giveaction$, combineaction$, usex, givex, combinex, textbannerfacey, textbannerfaceresx, textbannerfaceresy, choicebanner$, choicearrowl, choicearrowr, currencyname$, loadicon$, loadiconresx, loadiconresy, saveicon$, saveiconresx, saveiconresy, downloadicon$, downloadiconresx, downloadiconresy, torcheffectfile$, loadbar$, devlogo$, devlogomode, awardbanner$, awardbannerresx, awardbannerresy, awardbannerlocx, awardbannerlocy, awarditemresx, awarditemresy, awarditemlocx, awarditemlocy, awardtextlocx, awardtextlocy, awardgracetime, awardtitle$, awardnotification$, awardspeed, awardnone$, awardarrowleft$, awardarrowright$, awardarrowselectleft$, awardarrowselectright$, versionno$, engineversionno$, updatelink$, updatekey$, letmenuselectcolourr, letmenuselectcolourg, letmenuselectcolourb, letmenuselectcoloura, bgmenuselectcolourr, bgmenuselectcolourg, bgmenuselectcolourb, bgmenuselectcoloura, letmenudefaultcolourr, letmenudefaultcolourg, letmenudefaultcolourb, letmenudefaultcoloura, bgmenudefaultcolourr, bgmenudefaultcolourg, bgmenudefaultcolourb, bgmenudefaultcoloura, letpromptcolourr, letpromptcolourg, letpromptcolourb, letpromptcoloura, bgpromptcolourr, bgpromptcolourg, bgpromptcolourb, bgpromptcoloura, letpocketselectcolourr, letpocketselectcolourg, letpocketselectcolourb, letpocketselectcoloura, bgpocketselectcolourr, bgpocketselectcolourg, bgpocketselectcolourb, bgpocketselectcoloura, letpocketdefaultcolourr, letpocketdefaultcolourg, letpocketdefaultcolourb, letpocketdefaultcoloura, bgpocketdefaultcolourr, bgpocketdefaultcolourg, bgpocketdefaultcolourb, bgpocketdefaultcoloura, letcurrencycolourr, letcurrencycolourg, letcurrencycolourb, letcurrencycoloura, bgcurrencycolourr, bgcurrencycolourg, bgcurrencycolourb, bgcurrencycoloura, letspeechcolourr, letspeechcolourg, letspeechcolourb, letspeechcoloura, bgspeechcolourr, bgspeechcolourg, bgspeechcolourb, bgspeechcoloura, letterminalcolourr, letterminalcolourg, letterminalcolourb, letterminalcoloura, bgterminalcolourr, bgterminalcolourg, bgterminalcolourb, bgterminalcoloura, letselectbannercolourr, letselectbannercolourg, letselectbannercolourb, letselectbannercoloura, bgselectbannercolourr, bgselectbannercolourg, bgselectbannercolourb, bgselectbannercoloura, spoofoptiontitle$, spoofoption1$, spoofoption2$, spoofoption1result$, spoofoption2result$, moddingname$
CLOSE #1
RETURN

frameconvert:
REM converts animation frame files
OPEN "framelist.ddf" FOR INPUT AS #1
LET progress = 0
IF newframelimit = 0 THEN LET newframelimit = oldframelimit
DO
	LET progress = progress + 1: REM adds to progress counter
	INPUT #1, x$: REM pulls name of next frame folder to be converted
	IF _FILEEXISTS(aloc$ + x$ + "/" + x$ + ".ddf") THEN
		REM reads frame metadata
		OPEN aloc$ + x$ + "/" + x$ + ".ddf" FOR INPUT AS #2
		INPUT #2, aniframes
		FOR x = 1 TO oldframelimit
			INPUT #2, oldframe(x)
		NEXT x
		CLOSE #2
		REM convert values
		FOR x = 1 TO newframelimit
			LET newframe(x) = oldframe(x)
		NEXT x
		REM save converted values
		OPEN aloc$ + x$ + "/" + x$ + ".ddf" FOR OUTPUT AS #2
		PRINT #2, aniframes
		FOR x = 1 TO newframelimit
			WRITE #2, newframe(x)
		NEXT x
		CLOSE #2
		REM redim array
		REM old animation values
		REDIM oldframe(newframelimit) AS INTEGER
		REM new animation values
		REDIM newframe(newframelimit) AS INTEGER
	ELSE	
		PRINT "expected animation file missing: " + aloc$ + x$ + "/" + x$ + ".ddf"
	END IF
LOOP UNTIL EOF(1)
CLOSE #1
RETURN

mapconvert:
REM converts map files
OPEN "maplist.ddf" FOR INPUT AS #1
LET progress = 0
IF newobjectlimit = 0 THEN LET newobjectlimit = oldobjectlimit
IF newplayerlimit = 0 THEN LET newplayerlimit = oldplayerlimit
IF newtriggerlimit = 0 THEN LET newtriggerlimit = oldtriggerlimit
DO
	LET progress = progress + 1: REM adds to progress counter
	INPUT #1, x$: REM pulls name of next map folder to be converted
	REM checks map folder for data file
	LET mapno = 0
	FOR x = 1 TO 1000
		IF _FILEEXISTS(mloc$ + x$ + "/map" + LTRIM$(STR$(x)) + ".ddf") THEN LET mapno = x: REM checks for existence of map metadata
	NEXT x
	IF mapno <> 0 THEN
		OPEN mloc$ + x$ + "/map" + LTRIM$(STR$(mapno)) + ".ddf" FOR INPUT AS #2: REM opens map file to be converted
		INPUT #2, mapname$, playmusic$, mapeffect, parallaxmode, mapx, mapy, mapobjectno, mapplayerno, maptriggerno: REM reads old initial map values
		REM reads old object values
		FOR x = 1 TO oldobjectlimit
			INPUT #2, oldobjectname(x), oldobjectx(x), oldobjecty(x)
		NEXT x
		REM reads old player values
		FOR x = 1 TO oldplayerlimit
			INPUT #2, oldplayername(x), oldplayerx(x), oldplayery(x), oldmplayerx(x), oldmplayery(x), oldplayergrace(x), oldplayerdefault(x)
		NEXT x
		REM reads old trigger values
		FOR x = 1 TO oldtriggerlimit
			INPUT #2, oldtriggername(x), oldtriggerx1(x), oldtriggery1(x), oldtriggerx2(x), oldtriggery2(x), oldtriggerexit(x)
		NEXT x
		CLOSE #2
		REM converts object values
		FOR x = 1 TO oldobjectlimit
			LET newobjectname(x) = oldobjectname(x)
			LET newobjectx(x) = oldobjectx(x)
			LET newobjecty(x) = oldobjecty(x)
		NEXT x
		REM converts player values
		FOR x = 1 TO oldplayerlimit
			LET newplayername(x) = oldplayername(x)
			LET newplayerx(x) = oldplayerx(x)
			LET newplayery(x) = oldplayery(x)
			LET newmplayerx(x) = oldmplayerx(x)
			LET newmplayery(x) = oldmplayery(x)
			LET newplayergrace(x) = oldplayergrace(x)
			LET newplayerdefault(x) = oldplayerdefault(x)
		NEXT x
		REM converts trigger values
		FOR x = 1 TO oldtriggerlimit
			LET newtriggername(x) = oldtriggername(x)
			LET newtriggerx1(x) = oldtriggerx1(x)
			LET newtriggery1(x) = oldtriggery1(x)
			LET newtriggerx2(x) = oldtriggerx2(x)
			LET newtriggery2(x) = oldtriggery2(x)
			LET newtriggerexit(x) = oldtriggerexit(x)
		NEXT x
		OPEN mloc$ + x$ + "/map" + LTRIM$(STR$(mapno)) + ".ddf" FOR OUTPUT AS #3: REM opens map file to write
		WRITE #3, mapname$, playmusic$, mapeffect, parallaxmode, mapx, mapy, mapobjectno, mapplayerno, maptriggerno: REM saves converted map values
		REM saves converted object values
		FOR x = 1 TO newobjectlimit
			WRITE #3, newobjectname(x), newobjectx(x), newobjecty(x)
		NEXT x
		REM saves converted player values
		FOR x = 1 TO newplayerlimit
			WRITE #3, newplayername(x), newplayerx(x), newplayery(x), newmplayerx(x), newmplayery(x), newplayergrace(x), newplayerdefault(x)
		NEXT x
		REM saves converted trigger values
		FOR x = 1 TO newtriggerlimit
			WRITE #3, newtriggername(x), newtriggerx1(x), newtriggery1(x), newtriggerx2(x), newtriggery2(x), newtriggerexit(x)
		NEXT x
		CLOSE #3
		REM wipes values
		REM old object values
		REDIM oldobjectname(newobjectlimit) AS STRING
		REDIM oldobjectx(newobjectlimit) AS DOUBLE
		REDIM oldobjecty(newobjectlimit) AS DOUBLE
		REM new object values
		REDIM newobjectname(newobjectlimit) AS STRING
		REDIM newobjectx(newobjectlimit) AS DOUBLE
		REDIM newobjecty(newobjectlimit) AS DOUBLE
		REM old player values
		REDIM oldplayername(newplayerlimit) AS STRING
		REDIM oldplayerx(newplayerlimit) AS DOUBLE
		REDIM oldplayery(newplayerlimit) AS DOUBLE
		REDIM oldmplayerx(newplayerlimit) AS INTEGER
		REDIM oldmplayery(newplayerlimit) AS INTEGER
		REDIM oldplayergrace(newplayerlimit) AS INTEGER
		REDIM oldplayerdefault(newplayerlimit) AS INTEGER
		REM new player values
		REDIM newplayername(newplayerlimit) AS STRING
		REDIM newplayerx(newplayerlimit) AS DOUBLE
		REDIM newplayery(newplayerlimit) AS DOUBLE
		REDIM newmplayerx(newplayerlimit) AS INTEGER
		REDIM newmplayery(newplayerlimit) AS INTEGER
		REDIM newplayergrace(newplayerlimit) AS INTEGER
		REDIM newplayerdefault(newplayerlimit) AS INTEGER
		REM old trigger values
		REDIM oldtriggername(newtriggerlimit) AS STRING
		REDIM oldtriggerx1(newtriggerlimit) AS INTEGER
		REDIM oldtriggery1(newtriggerlimit) AS INTEGER
		REDIM oldtriggerx2(newtriggerlimit) AS INTEGER
		REDIM oldtriggery2(newtriggerlimit) AS INTEGER
		REM new trigger values
		REDIM newtriggername(newtriggerlimit) AS STRING
		REDIM newtriggerx1(newtriggerlimit) AS INTEGER
		REDIM newtriggery1(newtriggerlimit) AS INTEGER
		REDIM newtriggerx2(newtriggerlimit) AS INTEGER
		REDIM newtriggery2(newtriggerlimit) AS INTEGER 
	ELSE
		PRINT "expected map file missing: " + mloc$ + x$ + "/map(x).ddf"
	END IF
LOOP UNTIL EOF(1)
CLOSE #1: REM closes list file
RETURN
