10 gosub 8000

rem main loop

100 gosub 1000
102 dx=0:dy=0
105 get k$:if k$="" then 105
110 if k$="i" then dy=-1:goto 500
120 if k$="j" then dx=-1:goto 500
130 if k$="k" then dy=1:goto 500
140 if k$="l" then dx=1:goto 500
150 if k$=" " then gosub1100:goto 100

rem monsters move

400 for i = 1 to m
410 dx=0:ifhx<mx(i)thendx=-1
420 ifhx>mx(i)thendx=+1
430 dy=0:ifhy<my(i)thendy=-1
440 ifhy>my(i)thendy=+1
450 o=((my(i)+dy)*22)+(mx(i)+dx):th=peek(sc+o)
455 if th<>32then490
460 o=(my(i)*22)+mx(i):pokesc+o,32
470 mx(i)=mx(i)+dx:my(i)=my(i)+dy
480 o=(my(i)*22)+mx(i):pokesc+o,19:pokecm+o,2
490 next

499 goto 100

rem hero can (and does) move

500 o=((hy+dy)*22)+(hx+dx):th=peek(sc+o)
505 if th<>32then400
507 gosub720
510 hx=hx+dx:hy=hy+dy:gosub700
520 goto400

rem draw hero

700 o=(hy*22)+hx:pokesc+o,81:pokecm+o,6
710 return

rem erase hero

720 o=(hy*22)+hx:pokesc+o,32
710 return

rem status

1000 print"{home}{blk}{rvs on} ";
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

rem hx,hy     : hero's position
rem m         : number of monsters
rem mx(),my() : monster position
rem dx,dy     : delta for move (both hero and monsters)

rem sg        : strength
rem in        : intelligence
rem de        : dexterity
rem hp        : hit points
rem mh        : max hit points
rem au        : gold
rem pt        : health potions

rem sc        : screen memory
rem cm        : color memory
rem sb        : status bar mode
rem i         : temporary (loops)
rem o         : temporary (screen pos)
rem th        : temporary (screen contents)

8000 dim mx(10),my(10)
8005 hx=11:hy=11:m=1
8007 sg=10:in=11:de=12:mh=31:hp=mh:au=0:pt=0
8010 sc=7680:cm=38400:sb=0
8020 print"{clr}"
8025 gosub 2000
8030 gosub 700
8040 gosub 7000
8999 return
