rem dungeons of ekileugor
rem conceived august 2012, chris pressey, cat's eye technologies

rem i,j       : temporaries (loops)

rem x,y       : temporary position (used by all)
rem dx,dy     : delta for move (used by all)
rem sc        : screen memory (constant)
rem cm        : color memory (constant)
rem o         : temporary screen offset
rem c         : temporary screen contents (to write or to read)
rem co        : temporary character colour (to write)

rem m$        : message to print
rem mv        : number to print after message (if not -1)
rem mu        : message-up flag

rem hx,hy     : hero's position
rem mn        : current monster number
rem m%(#,p)   : monster matrix: first dimension is mn, second is:
rem           :   0 = x position
rem           :   1 = y position
rem           :   2 = monster hp

rem dm        : damage done during combat

rem hp        : hit points
rem mh        : max hit points
rem au        : gold
rem pt        : health potions
rem dl        : dungeon level
rem xp        : experience points
rem xg        : experience goal for next level
rem xl        : experience level

rem r%(#,p)   : room matrix: first dimension is room number, second:
rem           :   0 = room x (nw corner)
rem           :   1 = room y (nw corner)
rem           :   2 = room width minus one
rem           :   3 = room height minus one
rem dr        : destination room during dungeon level creation & revealing
rem rs        : room with stairs (picked during level creation)

1 dimm%(7,2),r%(4,3):sc=7680:cm=38400:mh=19:xg=10:hp=mh:dl=1:print"{clr}":gosub7000:goto10

rem short, frequently-called routines

rem compute screen offset with delta and read char there

2 o=(y+dy)*22+x+dx:c=peek(sc+o):return

rem erase char at x,y: falls through to line 4

3 c=32:co=0

rem write char c with color co at x,y

4 o=y*22+x:pokecm+o,co:pokesc+o,c:return

rem get random unoccupied x,y in room dr

5 x=int(rnd(1)*(r%(dr,2)+1))+r%(dr,0):y=int(rnd(1)*(r%(dr,3)+1))+r%(dr,1)
6 dx=0:dy=0:gosub2:ifc<>32then5
7 return

rem main loop

10 gosub900:mu=0:dx=0:dy=0
11 getk$:ifk$=""then11
12 ifk$="i"thendy=-1:goto 500
13 ifk$="j"thendx=-1:goto 500
14 ifk$="k"thendy=1:goto 500
15 ifk$="l"thendx=1:goto 500
16 ifk$="r"then400
17 ifk$="q"andpt>0thenpt=pt-1:hp=hp+int(rnd(1)*6)+2:goto400
18 goto10

rem monsters move

400 formn=0to7
405 ifm%(mn,2)<=0then490
410 x=m%(mn,0):y=m%(mn,1):dx=sgn(hx-x):dy=sgn(hy-y)
420 gosub2:ifc=81thengosub600:goto490
430 ifc=32orc=86then460
440 ifrnd(1)<.3thendx=0:goto420
450 ifrnd(1)<.3thendy=0:goto420
455 goto490
460 gosub3:x=x+dx:y=y+dy:c=19:co=2:gosub4
480 m%(mn,0)=x:m%(mn,1)=y
490 next:goto10

rem hero can (and does) move

500 x=hx:y=hy:gosub2:ifc=19thengosub700:goto400
520 ifc=28thenau=au+int(rnd(1)*20)+1:c=32
530 ifc=65thenpt=pt+1:c=32
540 ifc=233thendl=dl+1:gosub7000:goto10
550 ifc=102thengosub6000:goto500
560 ifc=86thenm$="dart trap!":gosub640:c=32
570 ifc<>32then400
580 gosub3:x=x+dx:y=y+dy:c=81:co=6:gosub4:hx=x:hy=y
585 ifhp>mhthenhp=mh
590 goto400

rem monster attack hero!

600 mv=-1:ifrnd(1)*(7-dl/4)<2then630
620 m$="snake misses":gosub800:return
630 m$="snake hits for"

rem ... also an entry point (trap)

640 dm=int(rnd(1)*4)+1:mv=dm:gosub800
650 hp=hp-dm:ifhp>0thenreturn

rem ... died

660 print"{clr}":end

rem hero attack monster!
rem ... first, find monster

700 mn=0
705 ifm%(mn,0)=hx+dxandm%(mn,1)=hy+dythen720
710 mn=mn+1:ifmn<=7then705

rem ... SOMETHING IS WRONG.
rem 715 stop

rem ... see if hit. simple for now.

720 mv=-1:ifint(rnd(1)*6)<3then730
725 m$="you miss":gosub800:return
730 dm=int(rnd(1)*6)+1:mv=dm
735 m$="you hit for":gosub800
740 m%(mn,2)=m%(mn,2)-dm:xp=xp+int(rnd(1)*3)*dl+1
743 ifxp>xgthenxl=xl+1:xg=xg*2:mh=mh+int(rnd(1)*8)+2:hp=mh:m$="gain exp,level":mv=xl:gosub800:goto743
745 ifm%(mn,2)>0thenreturn
750 mv=-1:m$="you killed snake":gosub800
760 x=m%(mn,0):y=m%(mn,1):gosub3
765 m%(mn,0)=-1:m%(mn,1)=-1:m%(mn,2)=0
780 x=hx:y=hy:return

rem display message

800 ifmu<>0thengosub850
810 print"{home}{blk}{rvs on} "m$;
820 ifmv>0thenprintmv"{left} ";
830 gosub920:mu=1:return

rem wait for keypress

850 print"{home}Z";
855 getkk$:ifkk$=""thendr=rnd(1):goto855
860 return

rem status

900 ifmu<>0thenreturn
910 print"{home}{blk}{rvs on}"hp"{left}/"mh"{left},"au"{left},"pt"{left} ";

rem ... this is also an entry point

920 fori=pos(0)to21:print" ";:next:return

rem figure out which room x+dx,y+dy is in

6000 dr=-1:fori=0to4
6010 ifx+dx<r%(i,0)then6070
6020 ifx+dx>r%(i,0)+r%(i,2)then6070
6030 ify+dy<r%(i,1)then6070
6040 ify+dy>r%(i,1)+r%(i,3)then6070
6050 dr=i:i=4
6070 next

rem ... if dr still=-1, SOMETHING IS WRONG, it will crash below.
rem ... reveal room dr (NOTE: this is also an entry point to this subroutine)

6100 forx=r%(dr,0)tor%(dr,0)+r%(dr,2):fory=r%(dr,1)tor%(dr,1)+r%(dr,3):gosub3:next:next

rem populate room dr

rem ... here thar be monsters

6200 m=int(rnd(1)*4):ifm>0thenforj=1tom:gosub5:gosub6500:next

rem ... and gold and traps and potions

6300 j=int(rnd(1)*3):ifj>0thenfori=1toj:gosub5:c=28:co=7:gosub4:next
6302 ifrnd(1)>.3thengosub5:c=86:co=1:gosub4
6304 ifrnd(1)>.5thengosub5:c=65:co=4:gosub4

rem ... and stairs, if this is that room

6310 ifdr=rsthengosub5:c=233:co=0:gosub4

6390 return

rem allocate monster at x,y

6500 fori=0to7:ifm%(i,2)=0thengoto6530
6510 next:return
rem ... tail call!
6530 m%(i,0)=x:m%(i,1)=y:m%(i,2)=rnd(1)*6+dl:c=19:co=2:goto4

rem init level

rem ... first clear the screen

7000 print"{blk}{clr}{rvs on}";
7010 fory=0to20
7020 print"                      ";
7030 next
7040 print"{rvs off}"
7050 co=0:c=160:y=21:forx=0to21:gosub4:next
7055 y=22:forx=0to21:gosub4:next

rem ... clear the monster table

7060 fori=0to7:m%(i,2)=0:next

rem ... then make some rooms

7100 fori=0to4
7110 r%(i,2)=int(rnd(1)*3)*2+2:r%(i,3)=int(rnd(1)*3)*2+2
7120 r%(i,0)=int(rnd(1)*(20-r%(i,2))/2)*2+1
7125 r%(i,1)=int(rnd(1)*(20-r%(i,3))/2)*2+1

rem ... if this is the first room, no checking or tunnel is needed.

7130 ifi=0then7490

rem ... check that room does not overlap other rooms

7140 ol%=0:forj=0toi-1
7150 ifr%(i,0)>r%(j,0)+r%(j,2)then7295
7160 ifr%(j,0)>r%(i,0)+r%(i,2)then7295
7170 ifr%(i,1)>r%(j,1)+r%(j,3)then7295
7180 ifr%(j,1)>r%(i,1)+r%(i,3)then7295
7190 ol%=1:j=i
7295 next
7300 ifol%=1then7110

rem ... now draw a tunnel.  pick a room dr < i,

7400 dr=int(rnd(1)*i)

rem ... pick a random location on room i's north wall

7405 rx=int(rnd(1)*r%(i,2))+r%(i,0)

rem ... pick a random location on room dr's west wall

7410 ry=int(rnd(1)*r%(dr,3))+r%(dr,1)

rem ... tunnel north or south as appropriate...

7420 x=rx:y=r%(i,1)

7430 gosub3:ify<>rytheny=y+sgn(ry-y):goto7430

rem ... tunnel east or west as appropriate.

7450 gosub3:ifx<>r%(dr,0)thenx=x+sgn(r%(dr,0)-x):goto7450

rem ... tunnel complete.  (next room, please)

7490 next

rem ... now shadow in the rooms

7500 co=0:c=102:fori=0to4:forx=r%(i,0)tor%(i,0)+r%(i,2):fory=r%(i,1)tor%(i,1)+r%(i,3):gosub4:next:next:next

rem ... and pick which room has the stairs

7900 rs=int(rnd(1)*5)

rem ... display dungeon level at bottom

7905 c=dl:co=0:x=0:y=22:gosub4

rem ... place hero.  pick a room and reveal it.  then put him in it, dammit.
rem ... tail call!

7910 dr=int(rnd(1)*5):gosub6100:gosub5:hx=x:hy=y:c=81:co=6:goto4
