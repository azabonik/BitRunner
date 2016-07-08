library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my.all;
 
 
ENTITY SYNC IS
PORT(
CLK: IN STD_LOGIC;
HSYNC,VSYNC: OUT STD_LOGIC;
R,G,B : OUT STD_LOGIC_VECTOR(3 downto 0);
KEYS: IN STD_LOGIC_VECTOR(3 downto 0);
RST: IN STD_LOGIC
);
END SYNC;

ARCHITECTURE MAIN OF SYNC IS
SIGNAL RGB: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL DRAW1,DRAW2, DRAW3, DRAW4, DRAW5, DRAW6, DRAW7: STD_LOGIC; --square select
SIGNAL SQ_X1:INTEGER RANGE 0 TO 1688:=0;
SIGNAL SQ_Y1:INTEGER RANGE 0 TO 1688:=300; --car 1 start y
SIGNAL SQ_X2:INTEGER RANGE 0 TO 1688:=0;
SIGNAL SQ_Y2:INTEGER RANGE 0 TO 1688:=380; --car 2 start y
SIGNAL SQ_X3:INTEGER RANGE 0 TO 1688:=0;
SIGNAL SQ_Y3:INTEGER RANGE 0 TO 1688:=460; --car 3 start y
SIGNAL SQ_X4:INTEGER RANGE 0 TO 1688:=0;
SIGNAL SQ_Y4:INTEGER RANGE 0 TO 1688:=620; --car 4 start y

SIGNAL SQ_X5:INTEGER RANGE 0 TO 1688:=600; --frog start x
SIGNAL SQ_Y5:INTEGER RANGE 0 TO 1688:=100; --frog start y

SIGNAL SQ_X6:INTEGER RANGE 0 TO 1688:=0;
SIGNAL SQ_Y6:INTEGER RANGE 0 TO 1688:=700; --car 5 start y
SIGNAL SQ_X7:INTEGER RANGE 0 TO 1688:=0;
SIGNAL SQ_Y7:INTEGER RANGE 0 TO 1688:=780; --car 6 start y


SIGNAL HPOS: INTEGER RANGE 0 TO 1688:=0;
SIGNAL VPOS: INTEGER RANGE 0 TO 1066:=0;

SIGNAL DIRECTION: STD_LOGIC_VECTOR(3 DOWNTO 0):= KEYS;

BEGIN

SQ(HPOS,VPOS,SQ_X1,SQ_Y1,RGB,DRAW1); --square 1
SQ(HPOS,VPOS,SQ_X2 ,SQ_Y2,RGB,DRAW2); --square 2
SQ(HPOS,VPOS,SQ_X3 ,SQ_Y3,RGB,DRAW3); --square 3
SQ(HPOS,VPOS,SQ_X4 ,SQ_Y4,RGB,DRAW4); --square 4
SQ(HPOS,VPOS,SQ_X5 ,SQ_Y5,RGB,DRAW5); --square 5 (frog)
SQ(HPOS,VPOS,SQ_X6 ,SQ_Y6,RGB,DRAW6); --square 6
SQ(HPOS,VPOS,SQ_X7 ,SQ_Y7,RGB,DRAW7); --square 7

PROCESS(CLK)
BEGIN
IF(CLK'EVENT AND CLK='1')THEN
	IF(DRAW1='1')THEN --square 1 red
		 R<=(OTHERS=>'1');
		 G<=(OTHERS=>'0');
		 B<=(OTHERS=>'0');
	END IF;
	IF(DRAW2='1')THEN --square 2 yellow
		 R<=(OTHERS=>'1');
		 G<=(OTHERS=>'1');
		 B<=(OTHERS=>'0');
	END IF;
	IF(DRAW3='1')THEN --square 3 blue
		 R<=(OTHERS=>'0');
		 G<=(OTHERS=>'0');
		 B<=(OTHERS=>'1');
	END IF;
	IF(DRAW4='1')THEN --square 4 magenta
		 R<=(OTHERS=>'1');
		 G<=(OTHERS=>'0');
		 B<=(OTHERS=>'1');
	END IF;
	IF(DRAW5='1')THEN --square 5 (FROG) green
		 R<=(OTHERS=>'0');
		 G<=(OTHERS=>'1');
		 B<=(OTHERS=>'0');
	END IF;
	IF(DRAW6='1')THEN --square 6 cyan
		 R<=(OTHERS=>'0');
		 G<=(OTHERS=>'1');
		 B<=(OTHERS=>'1');
	END IF;
	IF(DRAW7='1')THEN --square 7 white
		 R<=(OTHERS=>'1');
		 G<=(OTHERS=>'1');
		 B<=(OTHERS=>'1');
	END IF;	
	IF(DRAW1='0' AND DRAW2='0' AND DRAW3='0' AND DRAW4='0' AND DRAW5='0' AND DRAW6='0' AND DRAW7='0')THEN --remove old location
	   R<=(OTHERS=>'0');
      G<=(OTHERS=>'0');
	   B<=(OTHERS=>'0');
	end if;
	IF(HPOS<1688)THEN
		HPOS<=HPOS+1;
	ELSE
		HPOS<=0;
	IF(VPOS<1066)THEN
		VPOS<=VPOS+1;
	ELSE
		IF (RST = '1') THEN
			SQ_X1<=SQ_X1+10; --car one, speed of 10, right
			SQ_X2<=SQ_X2+40;--car two, speed of 40, right
			SQ_X3<=SQ_X3+65;--car three, speed of 65, right
			SQ_X4<=SQ_X4-20;--car four, speed of 20, left
			SQ_X6<=SQ_X6-55;--car six, speed of 55, left
			SQ_X7<=SQ_X7-75;--car seven, speed of 75, left
		ELSE
			SQ_X1<=SQ_X1;
			SQ_X2<=SQ_X2;
			SQ_X3<=SQ_X3;
			SQ_X4<=SQ_X4;
			SQ_X6<=SQ_X6;
			SQ_X7<=SQ_X7;
		END IF;
		
		------------------------------movement of frog controlled by keyboard
		IF(DIRECTION(0)='0')THEN
			SQ_X5<=SQ_X5+10;
		END IF;
		IF(DIRECTION(1)='0')THEN
			SQ_X5<=SQ_X5-10;
		END IF;
		IF(DIRECTION(2)='0')THEN
			SQ_Y5<=SQ_Y5+10;
		END IF;
		IF(DIRECTION(3)='0')THEN
			SQ_Y5<=SQ_Y5-10;
		END IF;
		IF(DIRECTION = "1111")THEN
			SQ_Y5<=SQ_Y5;
			SQ_X5<=SQ_X5;
		END IF;
		IF (SQ_Y5 > 1000 OR SQ_Y5 < 0) THEN --street = crossed, LEDS turn on, frog teleported back to other side
			SQ_Y5<= 50;
		END IF;
		IF (SQ_X5 < 350) THEN
			SQ_X5<= 400;
		END IF;
		IF (SQ_X5 > 1650) THEN
			SQ_X5<= 1600;
		END IF;
		-----------------------------------------
		
		VPOS<=0;
		END IF;
		IF ((SQ_Y5 < SQ_Y1 + 80) AND (SQ_Y5 > SQ_Y1-80)) AND ((SQ_X5 < SQ_X1+80) AND (SQ_X5 > SQ_X1-80)) THEN --SQUARE 1 HIT
			SQ_Y5 <= 100;
		END IF;
		IF ((SQ_Y5 < SQ_Y2 + 80) AND (SQ_Y5 > SQ_Y2-80)) AND ((SQ_X5 < SQ_X2+80) AND (SQ_X5 > SQ_X2-80)) THEN --SQUARE 2 HIT
			SQ_Y5 <= 100;
		END IF;
		IF ((SQ_Y5 < SQ_Y3 + 80) AND (SQ_Y5 > SQ_Y3-80)) AND ((SQ_X5 < SQ_X3+80) AND (SQ_X5 > SQ_X3-80)) THEN --SQUARE 3 HIT
			SQ_Y5 <= 100;
		END IF;
		IF ((SQ_Y5 < SQ_Y4 + 80) AND (SQ_Y5 > SQ_Y4-80)) AND ((SQ_X5 < SQ_X4+80) AND (SQ_X5 > SQ_X4-80)) THEN --SQUARE 4 HIT
			SQ_Y5 <= 100;
		END IF;
		IF ((SQ_Y5 < SQ_Y6 + 80) AND (SQ_Y5 > SQ_Y6-80)) AND ((SQ_X5 < SQ_X6+80) AND (SQ_X5 > SQ_X6-80)) THEN --SQUARE 6 HIT
			SQ_Y5 <= 100;
		END IF;
		IF ((SQ_Y5 < SQ_Y7 + 80) AND (SQ_Y5 > SQ_Y7-80)) AND ((SQ_X5 < SQ_X7+80) AND (SQ_X5 > SQ_X7-80)) THEN --SQUARE 7 HIT
			SQ_Y5 <= 100;
		END IF;

	END IF;
	IF(HPOS>48 AND HPOS<160)THEN
		HSYNC<='0';
	ELSE
		HSYNC<='1';
	END IF;
	IF(VPOS>0 AND VPOS<4)THEN
    VSYNC<='0';
	ELSE
		VSYNC<='1';
  END IF;
  IF((HPOS>0 AND HPOS<408)OR(VPOS>0 AND VPOS<42))THEN 
		R<=(OTHERS=>'0');
		G<=(OTHERS=>'0');
		B<=(OTHERS=>'0');
	END IF;
END IF;
END PROCESS;
END MAIN;

