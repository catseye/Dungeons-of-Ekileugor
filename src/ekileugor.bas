rem dungeons of ekileugor

rem i         : temporary (loops)

rem x,y       : temporary position (used by all)
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
rem mx(),my() : monster position
rem dx,dy     : delta for move (both hero and monsters)

rem sg        : strength
rem in        : intelligence
rem de        : dexterity
rem hp        : hit points
rem mh        : max hit points
rem au        : gold
rem pt        : health potions

10 gosub 8000:goto 100

rem short, frequently-called routines

rem compute screen offset with delta and read char there

20 o=(y+dy)*22+x+dx:th=peek(sc+o):return

rem erase char at x,y: falls through to line 40

30 ch=32:co=0

rem write char ch with color co at x,y

40 o=y*22+x:pokesc+o,ch:pokecm+o,co:return

rem main loop

100 gosub 1000:mu=0
102 dx=0:dy=0
105 get k$:if k$="" then 105
110 if k$="i" then dy=-1:goto 500
120 if k$="j" then dx=-1:goto 500
130 if k$="k" then dy=1:goto 500
140 if k$="l" then dx=1:goto 500
150 if k$=" " then gosub1100:goto 100

rem monsters move

400 for mn = 1 to m
410 x=mx(mn):y=my(mn):dx=sgn(hx-x):dy=sgn(hy-y)
420 gosub 20
430 if th=81thengosub800
455 if th<>32then490
460 gosub 30
470 x=x+dx:y=y+dy:ch=19:co=2:gosub40
480 mx(mn)=x:my(mn)=y
490 next

499 goto 100

rem hero can (and does) move

500 x=hx:y=hy:gosub 20
505 if th<>32then400
510 gosub30:x=x+dx:y=y+dy:ch=81:co=6:gosub40:hx=x:hy=y
520 goto400

rem monster attack

800 m$="snake misses":gosub4000
890 return

rem status

1000 ifmu<>0thenreturn
1002 print"{home}{blk}{rvs on} ";
1005 ifsb=0thenprint"hp";hp;"/";mh;
1010 ifsb=1thenprint"gold";au;
1012 ifsb=2thenprint"potion";pt;
1015 ifsb=3thenprint"str";sg;"int";in;"dex";de;
1085 fori=pos(0)to22:print" ";:next
1090 print"{rvs off}";:return

rem toggle status

1100 print"{home}{blk}{rvs on}                      ";
1105 sb=sb+1:ifsb>3thensb=0
1110 return

rem draw border

2000 forx=0to21
2010 pokesc+x,160:pokecm+x,0
2020 pokesc+484+x,160:pokecm+484+x,0
2030 next
2040 fory=0to22
2050 pokesc+y*22,160:pokecm+y*22,0
2060 pokesc+21+y*22,160:pokecm+21+y*22,0
2070 next
2080 return

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

7000 m=5
7010 fori=1tom
7015 mx(i)=int(rnd(1)*20)+2:my(i)=int(rnd(1)*20)+2
7020 o=my(i)*22+mx(i):th=peek(sc+o)
7025 if th<>32 then 7015
7030 pokesc+o,19:pokecm+o,2
7040 next
7090 return

rem init

8000 dim mx(10),my(10)
8005 hx=11:hy=11:m=1
8007 sg=10:in=11:de=12:mh=31:hp=mh:au=0:pt=0
8010 sc=7680:cm=38400:sb=0:mu=0
8020 print"{clr}"
8025 gosub 2000
8030 x=hx:y=hy:ch=81:co=6:gosub40
8040 gosub 7000
8999 return
