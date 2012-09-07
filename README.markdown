Dungeons of Ekileugor
=====================

_Dungeons of Ekileugor_ is a little roguelike game for the Commodore VIC-20.

Despite the limitations of this architecture, its goal is to support a
relatively rich set of "dungeon furniture":

*   random generation of reasonable dungeon levels, with rooms and passages
*   the contents of rooms and passages are not visible until entered
*   levels populated with monsters, traps, treasure, and stairwells
*   character generation with at least three stats (strength, intelligence,
    and hit points)
*   multiple weapons and armor (although probably not a real inventory)

It will probably eventually require a memory expansion module.  It does
not currently, but that's only because there's barely anything there so far.

No sound effects or custom character set is planned.

The game will be written in BASIC, possibly with some routines coded in
6502 assembly language, using the Ophis 2.0 assembler.

I'm using the VICE VIC-20 emulator to test it.

It's not unlikely that I will never finish this project.

Playing the Game
----------------

Use the following keys:

*   `I` - go north
*   `J` - go west
*   `L` - go east
*   `K` - go south
*   space - toggle status bar view

Building
--------

To build the `PRG` file from the `BAS` file, run `make.sh`.  `petcat`
from the VICE distribution and `yucca` from the [yucca distribution][]
are required.

[yucca distribution]: http://catseye.tc/projects/yucca/
