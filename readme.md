# Variable Map Engine

A 2D adventure puzzle game engine written in QBasic!

## How to Install
### Windows + Linux
Download VaME.zip and extract to a place of your choosing Binaries for both platforms are included. Linux users may have to mark vame_linux as executable before it will run.

### macOS
Download VaME.zip and extract into a place of your choosing. Use [QB64](https://github.com/QB64Official/qb64) to compile [vame.bas](https://github.com/pforpond/VaME/blob/main/vame.bas) and place alongside the data folder.

## Default Hardware Requirements
* 64bit CPU  
* 70mb Disk Space  
* 500mb RAM  
Hardware requirements are dependant on game content. 32bit users must compile [vame.bas](https://github.com/pforpond/VaME/blob/main/vame.bas) with [QB64](https://github.com/QB64Official/qb64)

## Default Software Requirements
* Windows 10 or 11 (64bit)  
* Linux (64bit)  
* Other platforms must compile [vame.bas](https://github.com/pforpond/VaME/blob/main/vame.bas) with [QB64](https://github.com/QB64Official/qb64)

## Default Controls
* ARROW KEYS = move character  
* SPACE BAR = select / use  
* P = open pockets  
* ESC = back / pause

## What?
Idk you downloaded this. The engine comes with an example game, showcasing most of the engines features. To make your own game, you must replace assets, learn the map, object and player file formats, learn the Stage Director scripting language and learn the chaotic mess that is the engine.ddf file. [vame.pdf](https://github.com/pforpond/VaME/blob/main/vame.pdf) will help with this endeavour as it contains information all aspects of the engine including values, strings, script commands, file formats and prompt commands.

## Blocking Updates
Making games is hard enough without me pushing updates that make your work incompatible. VaME has several ways to block updates.  

* Launch with parameter -noupdate  
* Set the autoupdate value (found in engine.ddf) to 0  
* Set the updatelink$ string (found in engine.ddf) to be blank (or set it to your own update servers)  
* Add DEV to the end of the versionno$ string (found in engine.ddf)  

## Games powered by VaME
* [Spiderbro](https://studiopond.co.uk/spiderbro)  
* [Spiderbro 2](https://studiopond.co.uk/spiderbro-2)  