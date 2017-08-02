Dungeons of Ekileugor
=====================

Version 1.0

![Screenshot of Dungeons of Ekileugor](https://raw.github.com/catseye/Dungeons-of-Ekileugor/master/images/dungeons-of-ekileugor.png)

_Dungeons of Ekileugor_ is a little roguelike game for the **unexpanded**
Commodore VIC-20.  Despite the limitations of this architecture, it supports
a respectable subset of the usual "dungeon furniture":

*   random generation of reasonable dungeon levels, with rooms and passages
*   the contents of rooms are not visible until entered
*   levels populated with monsters, treasure, potions, chests, traps, and
    stairwells
*   monsters persue the hero and engage in combat with hit points
*   health potions can be collected and quaffed later
*   experience points for victory in combat, experience levels
*   queued status messages
*   progressively more difficult dungeon levels

Dungeons of Ekileugor is written in Commodore BASIC 2.0.  It makes use of
colour and the Commodore graphics characters, but not of sound effects or a
custom character set.

Playing the Game
----------------

Use the following keys:

*   `I` - go (or attack) north
*   `J` - go (or attack) west
*   `L` - go (or attack) east
*   `K` - go (or attack) south
*   `R` - rest (allow monsters to move)
*   `Q` - quaff a health potion

The status bar shows your current hit points, out of your maximum hit points,
followed by the amount of gold you have, followed by the number of health
potions you have, followed by your experience level.

The dungeon level you are currently on is shown in the lower left; level A is
the shallowest level, B is the next deepest, and so on.

You start at experience level zero, because, well, welcome to computer-dom.

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

    ?au,dl,xp,xl

This will display the amount of gold you accumulated, the dungeon level
you died on, the experience points you accumulated, and the experience level
you achieved.

Building
--------

To build the `PRG` file from the `BAS` file, run `make.sh ekileugor`.
The following tools are required:

*   `yucca` from the [yucca distribution][] (optional)
*   A `petcat`-compatible Commodore BASIC 2.0 tokenizer
    (`petcat` itself, from the [VICE][] distribution, or
     `hatoucan` from the [hatoucan distribution][])

`yucca` is only used to remove the `REM` statements, and to statically check
that the program is not jumping to an undefined line number.  If it is not
found on the executable search path, `grep` will instead be used to remove
the `REM`s and blank lines.

Run `run.sh ekileugor` to start the game in `xvic` immediately after building.

[yucca distribution]: http://catseye.tc/node/yucca
[hatoucan distribution]: http://catseye.tc/node/hatoucan
[VICE]: http://vice-emu.sourceforge.net/

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
*   detecting traps and secret doors

At one point the plan was to generate MINI and FULL versions of the game
from the same program source, but this soon began to seem like a fool's
errand; testing that the MINI version still works on an unexpanded VIC after
adding features for the FULL version was tricky and cumbersome.  Since the
MINI version was what was the more impressive, and hardly large enough to
justify the sharing of a code base with another version of the program, I
decided to concentrate on it, and save the FULL version for some potentially
mythical sequel.

So, yeah, basically this game turned out to be "how much of a classic
roguelike can I stuff into an unexpanded VIC-20?"  I was originally thinking
of writing it in assembly, with the Ophis assembler, but I suspected that
that would not be much more space-efficient, and run speed was not a primary
concern.  Some parts of the code could probably be done in less space with
strategic machine code, but I don't know if it would shave enough off the
size to permit adding any new, significant features.  (Currently, after the
program has ended, `?FRE(0)` will report that there are around 14 bytes of
free memory available, which is pretty darn close to nothing.)

But really, this project was undertaken mostly just as an excuse to use the
word "Ekileugor" in the title (have you figured it out yet?)
