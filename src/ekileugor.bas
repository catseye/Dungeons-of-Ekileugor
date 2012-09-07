rem dungeons of ekileugor

rem i         : temporary (loops)

rem x,y       : temporary position (used by all)
rem dx,dy     : delta for move (used by all)
rem ch        : temporary char to write (screen code)
rem co        : temporary colour to assign
rem sc        : screen memory (constant)
rem cm        : color memory (constant)
rem o         : temporary screen offset
rem th        : temporary screen contents

rem sb        : status bar mode
rem mu        : message-up flag

rem hx,hy     : hero's position
rem m         : number of monsters
rem mn        : current monster number
rem m%(#,p)   : monster matrix: first dimension is mn, second is:
rem           :   0 = x position
rem           :   1 = y position
rem           :   2 = monster type (= screen code)
rem           :   3 = monster hp

rem dm        : damage done during combat

rem sg        : strength
rem in        : intelligence
rem de        : dexterity
rem hp        : hit points
rem mh        : max hit points
rem au        : gold
rem pt        : health potions

rem r%(#,p)   : room matrix: first dimension is room number, second:
rem           :   0 = room x (nw corner)
rem           :   1 = room y (nw corner)
rem           :   2 = room width
rem           :   3 = room height
rem dr        : destination room during dungeon level creation

10 gosub 8000:goto 100

rem short, frequently-called routines

rem compute screen offset with delta and read char there

20 o=(y+dy)*22+x+dx:th=peek(sc+o):return

rem erase char at x,y: falls through to line 40

30 ch=32:co=0

rem write char ch with color co at x,y

40 o=y*22+x:pokesc+o,ch:pokecm+o,co:return

rem get random unoccupied x,y

50 x=int(rnd(1)*20)+2:y=int(rnd(1)*20)+2:dx=0:dy=0:gosub20
51 ifth<>32then50
52 return

rem main loop

100 gosub 1000:mu=0
102 dx=0:dy=0
105 getk$:if k$=""then105
110 if k$="i" then dy=-1:goto 500
120 if k$="j" then dx=-1:goto 500
130 if k$="k" then dy=1:goto 500
140 if k$="l" then dx=1:goto 500
150 if k$="{f1}"thensb=sb+1:gosub1100
160 if k$="r"then400
180 goto 100

rem monsters move

400 for mn = 1 to m
405 ifm%(mn,3)<=0then490
410 x=m%(mn,0):y=m%(mn,1):dx=sgn(hx-x):dy=sgn(hy-y)
420 gosub 20
430 if th=81thengosub800
455 if th<>32then490
460 gosub 30
470 x=x+dx:y=y+dy:ch=19:co=2:gosub40
480 m%(mn,0)=x:m%(mn,1)=y
490 next

499 goto 100

rem hero can (and does) move

500 x=hx:y=hy:gosub 20
510 ifth=19thengosub700
520 ifth=28thenau=au+int(rnd(1)*20)+1:th=32
530 if th<>32then400
540 gosub30:x=x+dx:y=y+dy:ch=81:co=6:gosub40:hx=x:hy=y
550 goto400

rem hero attack monster!
rem ... first, find monster

700 mn=1
705 ifm%(mn,0)=hx+dxandm%(mn,1)=hy+dythen720
710 mn=mn+1:ifmn<=mthen705
715 stop:rem something is wrong

rem ... see if hit. simple for now.

720 if int(rnd(1)*6)<3 then 730
725 m$="you miss":gosub4000:return
730 dm=int(rnd(1)*6)+1
735 m$="you hit for"+str$(dm):gosub4000
740 m%(mn,3)=m%(mn,3)-dm
745 ifm%(mn,3)>0thenreturn
750 m$="you killed snake":gosub4000
760 x=m%(mn,0):y=m%(mn,1):gosub30
765 m%(mn,0)=-1:m%(mn,1)=-1:m%(mn,3)=0
780 x=hx:y=hy
790 return

rem monster attack hero!

800 if int(rnd(1)*6)<2 then 830
820 m$="snake misses":gosub4000:return
830 dm=int(rnd(1)*4)+1
835 m$="snake hits for"+str$(dm):gosub4000
840 hp=hp-dm:ifhp>0thenreturn
850 goto 9000

rem status

1000 ifmu<>0thenreturn
1002 print"{home}{blk}{rvs on} ";
1005 ifsb=0thenprint"hp";hp;"/";mh;
1010 ifsb=1thenprint"gold";au;
1012 ifsb=2thenprint"potion";pt;
1015 ifsb=3thenprint"str";sg;"int";in;"dex";de;
1085 fori=pos(0)to22:print" ";:next
1090 print"{rvs off}";:return

rem erase status

1100 print"{home}{blk}{rvs on}                      ";
1105 ifsb>3thensb=0
1110 return

rem display message

4000 ifmu<>0thengosub4100
4010 print"{home}{blk}{rvs on} ";m$;
4020 fori=pos(0)to22:print" ";:next
4030 mu=1
4040 return

rem wait for keypress

4100 print "{home}Z";
4102 getkk$:ifkk$=""then4102
4104 return

rem init level

rem ... first clear the screen

7000 print"{blk}{clr}{rvs on}";
7010 fory=0to20
7020 print"                      ";
7030 next
7040 print"{rvs off}"
7050 co=0:ch=160:y=21:forx=0to21:gosub40:next
7055 y=22:forx=0to21:gosub40:next

rem ... then make some rooms
rem ... (this part isn't as clever as it should be)

7100 fori=0to4
7110 r%(i,0)=int(rnd(1)*15)+2:r%(i,1)=int(rnd(1)*15)+2
7120 r%(i,2)=int(rnd(1)*5)+1:r%(i,3)=int(rnd(1)*5)+1
7135 co=0:ch=32
7140 forx=r%(i,0)tor%(i,0)+r%(i,2)
7150 fory=r%(i,1)tor%(i,1)+r%(i,3)
7155 gosub40
7160 next
7170 next

rem ... now, for each room i > 0,

7180 ifi=0then7290

rem ... pick a room dr < i,

7190 dr=int(rnd(1)*i)

rem ... and draw a tunnel to it, as follows:
rem ... pick a random location on room i's north wall

7200 rx=int(rnd(1)*r%(i,2))+r%(i,0)

rem ... pick a random location on room dr's west wall

7210 ry=int(rnd(1)*r%(dr,3))+r%(dr,1)

rem ... tunnel north or south as appropriate...

7220 x=rx:y=r%(i,1)

rem 7230 ch=14:co=4:gosub40
7230 gosub30
7240 ify<>rytheny=y+sgn(ry-y):goto7230

rem ... tunnel east or west as appropriate.

rem ch=5:co=5:gosub40
7250 gosub30
7260 ifx<>r%(dr,0)thenx=x+sgn(r%(dr,0)-x):goto7250

rem ... tunnel complete.

7290 next

rem ... here thar be monsters

7300 m=5
7310 fori=1tom
7320 gosub50:ch=19:co=2:gosub40
7325 m%(i,0)=x:m%(i,1)=y:m%(i,2)=19:m%(i,3)=rnd(1)*6+1
7330 next

rem ... and gold

7400 fori=1to10:gosub50:ch=28:co=7:gosub40:next

rem ... and you!

7500 gosub50:hx=x:hy=y:ch=81:co=6:gosub40

7900 return

rem init

8000 dim m%(10,5),r%(4,4)
8005 sg=10:in=11:de=12:mh=31:hp=mh:au=0:pt=0
8010 sc=7680:cm=38400:sb=0:mu=0
8040 gosub 7000
8999 return

rem died

9000 m$="you have died":gosub4000
9010 m$="on dungeon level"+str$(dl):gosub4000
9020 m$="with"+str$(au)+"gold":gosub4000:gosub4000
9030 print "{clr}"
