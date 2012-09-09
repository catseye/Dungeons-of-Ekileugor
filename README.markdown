Dungeons of Ekileugor
=====================

_Dungeons of Ekileugor_ is a little roguelike game for the **unexpanded**
Commodore VIC-20.  Despite the limitations of this architecture, it supports
a respectable subset of the usual "dungeon furniture":

*   random generation of reasonable dungeon levels, with rooms and passages
*   the contents of rooms are not visible until entered
*   levels populated with monsters, treasure, potions, traps, and stairwells
*   monsters persue the hero and engage in combat with hit points
*   experience points for victory in combat, experience levels
*   queued status messages
*   progressively more difficult dungeon levels
*   whatever else I can squeeze in: see TODO, below.

Dungeons of Ekileugor is written in BASIC.  It makes use of colour and the
Commodore graphics characters, but not of sound effects or a custom character
set.

Playing the Game
----------------

Use the following keys:

*   `I` - go (or attack) north
*   `J` - go (or attack) west
*   `L` - go (or attack) east
*   `K` - go (or attack) south
*   `R` - rest (allow monsters to move)

The status bar shows your current hit points, out of your maximum hit points,
followed by the dungeon level you are on, followed by your gold.

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

You will notice that, the first time you play after starting the VIC-20
(or your emulator), the first dungeon level is always the same one.
However, things will quickly get more random as the game progresses.

You will also notice that the game ends rather abruptly when you die.  If
you would like to see your final score (to see if you have beaten your
personal record, for example), after the game ends, type:

    ?au,dl,xl

This will display the amount of gold you accumulated, the dungeon level
you died on, the experience points you accumulated, and the experience level
you achieved.

Building
--------

To build the `PRG` file from the `BAS` file, run `make.sh`.  The following
tools are required:

*   `yucca` from the [yucca distribution][]
*   `petcat` from the [VICE][] distribution

Run `make.sh test` to start the game in `xvic` immediately after building.
Run `MINI=yes make.sh` to build the MINI version of the game.

[yucca distribution]: http://catseye.tc/projects/yucca/
[VICE]: http://vice-emu.sourceforge.net/

TODO
----

*   Potions should have more effect on deeper levels (yes, do this)
*   Snakes should not hit as frequently on shallower levels
*   Experience level should increase your ability to hit/damage?

Discussion
----------

There are some things you might expect from a roguelike that you won't find
in Dungeons of Elikeugor, due to the limitations of the unexpanded VIC;
you'll have to wait for _Dungeons of Ekileugor II_ (assuming it ever
materializes) which will require at least 3K memory expansion:

*   more than one kind of monster
*   character generation with three stats (strength, intelligence, and
    dexterity)
*   multiple weapons and armor (although probably not a real inventory)
*   chests and secret doors

At one point the plan was to generate MINI and FULL versions of the game
from the same program source, but this soon began to seem like a fool's
errand; testing that the MINI version still works on an unexpanded VIC after
adding features for the FULL version was tricky and cumbersome.  Since the
MINI version was what was the more impressive, and hardly large enough to
justify the sharing of a code base with another version of the program, I
decided to concentrate on it, and save the FULL version for some potentially
mythical sequel.

Really, this project was undertaken mostly just as an excuse to use the word
"Ekileugor" in the title (have you figured it out yet?)
