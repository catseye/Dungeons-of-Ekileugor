rem dungeons of ekileugor

rem i         : temporary (loops)

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
rem dl        : dungeon level

rem r%(#,p)   : room matrix: first dimension is room number, second:
rem           :   0 = room x (nw corner)
rem           :   1 = room y (nw corner)
rem           :   2 = room width minus one
rem           :   3 = room height minus one
rem dr        : destination room during dungeon level creation & revealing
rem rs        : room with stairs (picked during level creation)

10 gosub 8000:goto100

rem short, frequently-called routines

rem compute screen offset with delta and read char there

20 o=(y+dy)*22+x+dx:c=peek(sc+o):return

rem erase char at x,y: falls through to line 40

30 c=32:co=0

rem write char c with color co at x,y

40 o=y*22+x:pokecm+o,co:pokesc+o,c:return

rem get random unoccupied x,y in room dr

60 x=int(rnd(1)*(r%(dr,2)+1))+r%(dr,0):y=int(rnd(1)*(r%(dr,3)+1))+r%(dr,1)
61 dx=0:dy=0:gosub20:ifc<>32then60
62 return

rem main loop

100 gosub1000:mu=0
102 dx=0:dy=0
105 getk$:if k$=""then105
110 ifk$="i"thendy=-1:goto 500
120 ifk$="j"thendx=-1:goto 500
130 ifk$="k"thendy=1:goto 500
140 ifk$="l"thendx=1:goto 500
160 ifk$="r"then400
180 goto100

rem monsters move

400 formn=0to7
405 ifm%(mn,2)<=0then490
410 x=m%(mn,0):y=m%(mn,1):dx=sgn(hx-x):dy=sgn(hy-y)
420 gosub20
430 ifc=81thengosub800:goto490
435 ifc=32orc=86then460
440 ifrnd(1)<.3thendx=0:goto420
450 ifrnd(1)<.3thendy=0:goto420
455 goto490
460 gosub30
470 x=x+dx:y=y+dy:c=19:co=2:gosub40
480 m%(mn,0)=x:m%(mn,1)=y
490 next

499 goto100

rem hero can (and does) move

500 x=hx:y=hy:gosub 20
510 ifc=19thengosub700:goto400
520 ifc=28thenau=au+int(rnd(1)*20)+1:c=32
530 ifc=65thenhp=hp+int(rnd(1)*6)+1:c=32
540 ifc=233thendl=dl+1:gosub7000:goto100
550 ifc=102thengosub6000:goto500
560 ifc=86thenm$="dart trap!":gosub840:c=32
570 ifc<>32then400
580 gosub30:x=x+dx:y=y+dy:c=81:co=6:gosub40:hx=x:hy=y
585 ifhp>mhthenhp=mh
590 goto400

rem hero attack monster!
rem ... first, find monster

700 mn=0
705 ifm%(mn,0)=hx+dxandm%(mn,1)=hy+dythen720
710 mn=mn+1:ifmn<=7then705

rem ... SOMETHING IS WRONG.
rem 715 stop

rem ... see if hit. simple for now.

720 mv=-1:ifint(rnd(1)*6)<3then730
725 m$="you miss":gosub4000:return
730 dm=int(rnd(1)*6)+1:mv=dm
735 m$="you hit for":gosub4000
740 m%(mn,2)=m%(mn,2)-dm
745 ifm%(mn,2)>0thenreturn
750 mv=-1:m$="you killed snake":gosub4000
760 x=m%(mn,0):y=m%(mn,1):gosub30
765 m%(mn,0)=-1:m%(mn,1)=-1:m%(mn,2)=0
780 x=hx:y=hy
790 return

rem monster attack hero!

800 mv=-1:ifrnd(1)*(7-dl/4)<2then830
820 m$="snake misses":gosub4000:return
830 m$="snake hits for"

rem ... also an entry point (trap)

840 dm=int(rnd(1)*4)+1:mv=dm:gosub4000
850 hp=hp-dm:ifhp>0thenreturn
860 goto9000

rem status

1000 ifmu<>0thenreturn
1010 print"{home}{blk}{rvs on}"hp"{left}/"mh"{left},"dl"{left},"au"{left} ";

rem ... this is also an entry point

1020 fori=pos(0)to21:print" ";:next:return

rem display message

4000 ifmu<>0thengosub4100
4010 print"{home}{blk}{rvs on} "m$;
4015 ifmv>0thenprintmv"{left} ";
4020 gosub1020:mu=1:return

rem wait for keypress

4100 print"{home}Z";
4102 getkk$:ifkk$=""thendr=rnd(1):goto4102
4104 return

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

6100 forx=r%(dr,0)tor%(dr,0)+r%(dr,2)
6110 fory=r%(dr,1)tor%(dr,1)+r%(dr,3)
6120 gosub30:next:next

rem populate room dr

rem ... here thar be monsters

6200 m=int(rnd(1)*4):ifm>0thenforj=1tom:gosub60:gosub6500:next

rem ... and gold and traps and potions

6300 j=int(rnd(1)*3):ifj>0thenfori=1toj:gosub60:c=28:co=7:gosub40:next
6302 ifrnd(1)>.3thengosub60:c=86:co=1:gosub40
6304 ifrnd(1)>.5thengosub60:c=65:co=4:gosub40

rem ... and stairs, if this is that room

6310 ifdr=rsthengosub60:c=233:co=0:gosub40

6390 return

rem allocate monster at x,y

6500 mn=-1:fori=0to7:ifm%(i,2)=0thenmn=i:i=10
6510 next
6520 ifmn=-1thenreturn
6530 m%(mn,0)=x:m%(mn,1)=y:m%(mn,2)=rnd(1)*6+dl:c=19:co=2:gosub40
6550 return

rem init level

rem ... first clear the screen

7000 print"{blk}{clr}{rvs on}";
7010 fory=0to20
7020 print"                      ";
7030 next
7040 print"{rvs off}"
7050 co=0:c=160:y=21:forx=0to21:gosub40:next
7055 y=22:forx=0to21:gosub40:next

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

7430 gosub30
7440 ify<>rytheny=y+sgn(ry-y):goto7430

rem ... tunnel east or west as appropriate.

7450 gosub30
7460 ifx<>r%(dr,0)thenx=x+sgn(r%(dr,0)-x):goto7450

rem ... tunnel complete.  (next room, please)

7490 next

rem ... now shadow in the rooms

7500 co=0:c=102
7502 fori=0to4
7505 forx=r%(i,0)tor%(i,0)+r%(i,2)
7510 fory=r%(i,1)tor%(i,1)+r%(i,3)
7515 gosub40
7520 next
7525 next
7527 next

rem ... and pick which room has the stairs

7900 rs=int(rnd(1)*5)

rem ... place hero.  pick a room and reveal it.  then put him in it, dammit.

7910 dr=int(rnd(1)*5):gosub6100:gosub60
7920 hx=x:hy=y:c=81:co=6:gosub40

7995 return

rem init

8000 dimm%(7,2),r%(4,3)
8005 sc=7680:cm=38400:mh=31:hp=mh:dl=1:print"{clr}"
8015 m$="hit any key to begin":gosub4000:gosub4000

rem ... tricky! tricky! tail call! ok, not *that* tricky.

8020 goto7000

rem died

9000 gosub4000:print"{clr}level"dl"gold"au
