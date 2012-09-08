Dungeons of Ekileugor
=====================

_Dungeons of Ekileugor_ is a little roguelike game for the Commodore VIC-20.

Despite the limitations of this architecture, its goal is to support a
relatively rich set of "dungeon furniture", listed below.

There are actually two versions of the game; a FULL version, which requires
some amount of memory expansion, and a MINI version, which runs on an
unexpanded VIC-20.  With the MINI version, you get:

*   random generation of reasonable dungeon levels, with rooms and passages
*   the contents of rooms and passages are not visible until entered
*   levels populated with monsters, treasure, and stairwells
*   (possibly more, if I can squeeze it in)

With the FULL version, you will, one day, get:

*   more than one kind of monster
*   character generation with three stats (strength, intelligence, and
    dexterity) and hit points
*   experience points and experience levels
*   multiple weapons and armor (although not a real inventory)
*   chests and traps
*   some kind of magic items, possibly potions

Colour and the Commodore graphics characters are used, but no sound effects
or custom character set is planned.

The game is written in BASIC.  It's possible some routines coded in 6502
assembly language, using the Ophis 2.0 assembler, will be added at some
point.

I'm using the [VICE][] VIC-20 emulator to test it.

It's not unlikely that I will never finish this project.

Playing the Game
----------------

Use the following keys:

*   `I` - go (or attack) north
*   `J` - go (or attack) west
*   `L` - go (or attack) east
*   `K` - go (or attack) south
*   `R` - rest
*   F1  - toggle status bar view

If something notable happened during the turn, a message about it will
replace the status bar at the beginning of the next turn.  You can press
any non-action key after that to show the stats in the status bar again.

If more than one notable thing happened during the turn, each message
(except the last), after being displayed, will prompt you to press any key
to see the next message, by displaying a diamond symbol in the upper-left
corner.

We suggest that, if you are playing in an emulator in WARP mode, you do
not press space to dismiss status messages, as the space bar repeats on
the VIC-20.  Just press any key not assigned to an action, perhaps `Z`.

Building
--------

To build the `PRG` file from the `BAS` file, run `make.sh`.  The following
tools are required:

*   `cpp` from any C compiler distribution, e.g. `gcc`
*   `yucca` from the [yucca distribution][]
*   `petcat` from the VICE distribution

Run `make.sh test` to start the game in `xvic` immediately after building.
Run `MINI=yes make.sh` to build the MINI version of the game.

[yucca distribution]: http://catseye.tc/projects/yucca/
[VICE]: http://vice-emu.sourceforge.net/
