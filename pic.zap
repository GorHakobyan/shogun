
	.SEGMENT "0"


	.FUNCT	YCEILING:ANY:1:1,Y
	ADD	Y,FONT-Y
	ADD	STACK,-1 >Y
	MOD	Y,FONT-Y
	SUB	Y,STACK
	RSTACK	


	.FUNCT	XCEILING:ANY:1:1,X
	ADD	X,FONT-X
	ADD	STACK,-1 >X
	MOD	X,FONT-X
	SUB	X,STACK
	RSTACK	

	.ENDSEG

	.SEGMENT "STARTUP"


	.FUNCT	TITLE-SCREEN:ANY:0:0
	CLEAR	S-FULL
	PICINF	P-TITLE,YX-TBL \?CND1
	ICALL1	CURSOR-OFF
	SCREEN	S-FULL
	DISPLAY	P-TITLE,1,1
	WINGET	S-TEXT,WHIGH
	CURSET	STACK,1
	ZERO?	DEMO-VERSION? /?CCL5
	ICALL2	INPUT-DEMO,1
	JUMP	?CND3
?CCL5:	INPUT	1
?CND3:	CLEAR	S-FULL
	ICALL1	CURSOR-ON
?CND1:	EQUAL?	MACHINE,APPLE-2E,APPLE-2C,APPLE-2GS /?CCL8
	ICALL2	DISPLAY-BORDER,P-BORDER
	JUMP	?CND6
?CCL8:	DISPLAY	P-BORDER,1,1
	WINGET	S-FULL,WHIGH
	SUB	STACK,BORDER-HEIGHT
	ADD	1,STACK
	DISPLAY	P-BORDER,STACK,1
?CND6:	CALL2	V-VERSION,TRUE-VALUE
	RSTACK	

	.ENDSEG

	.SEGMENT "0"


	.FUNCT	DISPLAY-BORDER:ANY:0:2,B,CH?,Y,?TMP1
	ASSIGNED?	'B /?CND1
	SET	'B,CURRENT-BORDER
?CND1:	ASSIGNED?	'CH? /?CND3
	SET	'CH?,TRUE-VALUE
?CND3:	EQUAL?	MACHINE,APPLE-2E,APPLE-2C,APPLE-2GS \?CCL7
	SCREEN	S-BORDER
	JUMP	?CND5
?CCL7:	PICINF	B,YX-TBL \?CND5
	SCREEN	S-FULL
?CND5:	DISPLAY	B,1,1
	ZERO?	CH? /?CND9
	SET	'CURRENT-BORDER,B
?CND9:	EQUAL?	MACHINE,IBM \?CND11
	SET	'Y,1
	EQUAL?	B,P-HINT-BORDER \?CND13
	GET	YX-TBL,0 >Y
	PICINF	P-HINT-BORDER-L,YX-TBL \?CND13
	ADD	1,Y
	DISPLAY	P-HINT-BORDER-L,STACK,1
?CND13:	EQUAL?	B,P-BORDER \?CCL19
	SET	'B,P-BORDER-R
	JUMP	?CND17
?CCL19:	EQUAL?	B,P-BORDER2 \?CCL21
	SET	'B,P-BORDER2-R
	JUMP	?CND17
?CCL21:	EQUAL?	B,P-HINT-BORDER \?CND17
	SET	'B,P-HINT-BORDER-R
?CND17:	PICINF	B,YX-TBL \?CND11
	WINGET	S-FULL,WWIDE >?TMP1
	GET	YX-TBL,1
	SUB	?TMP1,STACK
	ADD	1,STACK
	DISPLAY	B,Y,STACK
?CND11:	SCREEN	S-TEXT
	RTRUE	


	.FUNCT	CENTER-PIC-X:ANY:1:1,P,X,Y,?TMP1
	PICINF	P,YX-TBL \FALSE
	ICALL1	FLUSH-OLD-PICTURE
	GET	YX-TBL,0
	CALL2	YCEILING,STACK >Y
	ICALL2	MAKE-ROOM-FOR,Y
	WINGET	-3,WWIDE >?TMP1
	GET	YX-TBL,1
	SUB	?TMP1,STACK >X
	GRTR?	X,1 \?CCL6
	DIV	X,2 >X
	JUMP	?CND4
?CCL6:	SET	'X,1
?CND4:	DISPLAY	P,0,X
	DIV	Y,FONT-Y
	ICALL2	N-CRLF,STACK
	RTRUE	


	.FUNCT	CENTER-PIC:ANY:1:1,P,X,Y,?TMP1
	PICINF	P,YX-TBL \FALSE
	WINGET	-3,WHIGH >?TMP1
	GET	YX-TBL,0
	SUB	?TMP1,STACK >Y
	WINGET	-3,WWIDE >?TMP1
	GET	YX-TBL,1
	SUB	?TMP1,STACK >X
	GRTR?	Y,1 \?CCL6
	DIV	Y,2 >Y
	JUMP	?CND4
?CCL6:	SET	'Y,1
?CND4:	GRTR?	X,1 \?CCL9
	DIV	X,2 >X
	JUMP	?CND7
?CCL9:	SET	'X,1
?CND7:	DISPLAY	P,Y,X
	RTRUE	


	.FUNCT	FLUSH-OLD-PICTURE:ANY:0:0,Y
	WINGET	S-TEXT,WCRCNT >Y
	ZERO?	Y /FALSE
	ICALL2	N-CRLF,Y
	CALL1	RESET-MARGIN
	RSTACK	


	.FUNCT	N-CRLF:ANY:1:1,Y,CNT
	WINATTR	-3,A-SCRIPT,O-CLEAR
?PRG1:	IGRTR?	'CNT,Y \?CND3
	WINATTR	-3,A-SCRIPT,O-SET
	RTRUE	
?CND3:	CRLF	
	JUMP	?PRG1


	.FUNCT	MARGINAL-PIC:ANY:1:4,P,RIGHT?,C,CTOP?,TMP,X,Y,YLEFT,HIGH,WIDE,CENTER?,BORD?
	ASSIGNED?	'RIGHT? /?CND1
	SET	'RIGHT?,TRUE-VALUE
?CND1:	PICINF	P,YX-TBL \FALSE
	WINGET	S-TEXT,WHIGH >HIGH
	WINGET	S-TEXT,WWIDE >WIDE
	ICALL1	FLUSH-OLD-PICTURE
	GET	YX-TBL,0
	CALL2	YCEILING,STACK >Y
	EQUAL?	MACHINE,APPLE-2E,APPLE-2C,APPLE-2GS \?CND6
	GRTR?	Y,HIGH \?CND6
	SET	'BORD?,TRUE-VALUE
	SUB	Y,BORDER-HEIGHT >Y
?CND6:	GET	YX-TBL,1 >X
	ZERO?	C /?CCL12
	PICINF	C,YX-TBL \?CCL12
	GET	YX-TBL,0 >NEXT-PIC-CRCNT
	GET	YX-TBL,1 >NEXT-PIC-WIDTH
	JUMP	?CND10
?CCL12:	SET	'C,0
	SET	'NEXT-PIC-CRCNT,0
	SET	'NEXT-PIC-WIDTH,0
?CND10:	CALL2	MAKE-ROOM-FOR,Y >YLEFT
	MUL	FONT-X,10
	ADD	X,STACK
	LESS?	STACK,WIDE /?CND15
	SET	'CENTER?,TRUE-VALUE
?CND15:	ZERO?	BORD? /?CND17
	SCREEN	S-BORDER
	CURSET	1,1
?CND17:	ZERO?	CENTER? /?CCL21
	SUB	WIDE,X
	DIV	STACK,2
	ADD	1,STACK
	JUMP	?CND19
?CCL21:	ZERO?	RIGHT? /?CCL23
	LESS?	X,WIDE \?CCL23
	SUB	WIDE,X
	ADD	1,STACK
	JUMP	?CND19
?CCL23:	PUSH	1
?CND19:	DISPLAY	P,0,STACK
	ZERO?	BORD? /?CND26
	SCREEN	S-TEXT
?CND26:	ZERO?	CENTER? /?CCL30
	CURSET	YLEFT,1
	ICALL1	CURSOR-OFF
	ZERO?	DEMO-VERSION? /?CCL33
	ICALL2	INPUT-DEMO,1
	JUMP	?CND31
?CCL33:	INPUT	1
?CND31:	EQUAL?	MACHINE,AMIGA \?CND34
	ICALL1	DISPLAY-BORDER
?CND34:	ICALL1	CURSOR-ON
	CALL2	YCEILING,HIGH
	SUB	STACK,FONT-Y >Y
	SUB	HIGH,Y
	LESS?	STACK,FONT-Y \?CND36
	SUB	Y,FONT-Y >Y
?CND36:	INC	'Y
	GRTR?	YLEFT,Y \?CND38
	SUB	YLEFT,Y
	SCROLL	S-TEXT,STACK
	CURSET	Y,1
?CND38:	CRLF	
	JUMP	?CND28
?CCL30:	ZERO?	C /?CCL42
	ZERO?	CTOP? /?CCL42
	PUSH	NEXT-PIC-WIDTH
	JUMP	?CND40
?CCL42:	PUSH	X
?CND40:	ICALL	SET-MARGIN,STACK,RIGHT?
	DIV	Y,FONT-Y >Y
	ZERO?	C /?CCL47
	ZERO?	CTOP? /?CND48
	SET	'NEXT-PIC-WIDTH,X
?CND48:	SET	'PIC-SIDE,RIGHT?
	CALL2	YCEILING,NEXT-PIC-CRCNT
	DIV	STACK,FONT-Y
	SUB	STACK,1 >TMP
	ZERO?	CTOP? /?CCL52
	SUB	Y,TMP
	SUB	STACK,1 >NEXT-PIC-CRCNT
	ADD	TMP,1
	WINPUT	0,WCRCNT,STACK
	JUMP	?CND50
?CCL52:	ADD	TMP,1 >NEXT-PIC-CRCNT
	SUB	Y,TMP
	SUB	STACK,1
	WINPUT	0,WCRCNT,STACK
?CND50:	WINPUT	0,WCRFUNC,NEXT-MARGIN
	JUMP	?CND28
?CCL47:	ZERO?	BORD? /?CCL55
	PUSH	RESET-MARGIN-1
	JUMP	?CND53
?CCL55:	PUSH	RESET-MARGIN
?CND53:	WINPUT	0,WCRFUNC,STACK
	EQUAL?	P,P-OAR \?CND56
	INC	'Y
?CND56:	WINPUT	0,WCRCNT,Y
?CND28:	SUB	HIGH,YLEFT
	GRTR?	STACK,FONT-Y /FALSE
	RTRUE	


	.FUNCT	SET-MARGIN:ANY:2:2,X,RIGHT?,WIDE
	WINGET	S-TEXT,WWIDE >WIDE
	ADD	X,2
	CALL2	XCEILING,STACK
	DIV	STACK,FONT-X >X
	ZERO?	RIGHT? /?CCL3
	MUL	X,FONT-X
	MARGIN	TEXT-MARGIN,STACK
	JUMP	?CND1
?CCL3:	MUL	X,FONT-X
	MARGIN	STACK,TEXT-MARGIN
?CND1:	DIV	WIDE,FONT-X
	SUB	STACK,X >WIDE
	GRTR?	WIDE,INBUF-LENGTH \?CCL6
	PUSH	INBUF-LENGTH
	JUMP	?CND4
?CCL6:	PUSH	WIDE
?CND4:	PUTB	P-INBUF,0,STACK
	RTRUE	


	.FUNCT	NEXT-MARGIN:ANY:0:0
	ZERO?	NEXT-PIC-CRCNT /TRUE
	ICALL	SET-MARGIN,NEXT-PIC-WIDTH,PIC-SIDE
	WINPUT	S-TEXT,WCRCNT,NEXT-PIC-CRCNT
	WINPUT	S-TEXT,WCRFUNC,RESET-MARGIN-1
	SET	'NEXT-PIC-CRCNT,0
	RTRUE	


	.FUNCT	RESET-MARGIN-1:ANY:0:0
	ICALL1	DISPLAY-BORDER
	CALL1	RESET-MARGIN
	RSTACK	

	.SEGMENT "HINTS"


	.FUNCT	RESET-MARGIN:ANY:0:0
	WINPUT	S-TEXT,WCRCNT,0
	WINPUT	S-TEXT,WCRFUNC,0
	MARGIN	TEXT-MARGIN,TEXT-MARGIN
	PUTB	P-INBUF,0,INBUF-LENGTH
	RTRUE	

	.ENDSEG

	.SEGMENT "0"


	.FUNCT	MAKE-ROOM-FOR:ANY:1:1,Y,YLEFT,LLEFT,HIGH,YLOC,XLOC
	WINGET	S-TEXT,WHIGH >HIGH
	WINGET	S-TEXT,WYPOS >YLOC
	WINGET	S-TEXT,WXPOS >XLOC
	GRTR?	Y,HIGH \?CND1
	SET	'Y,HIGH
?CND1:	SUB	HIGH,YLOC
	ADD	1,STACK >YLEFT
	GRTR?	Y,YLEFT \?CND3
	SUB	Y,YLEFT
	CALL2	YCEILING,STACK >YLEFT
	WINGET	S-TEXT,WLCNT
	SUB	STACK,1
	MUL	STACK,FONT-Y
	SUB	YLOC,STACK >LLEFT
	GRTR?	YLEFT,LLEFT \?CND5
	DIV	HIGH,FONT-Y
	WINPUT	S-TEXT,WLCNT,STACK
	CRLF	
	WINGET	S-TEXT,WYPOS
	SUB	STACK,FONT-Y
	CURSET	STACK,1
?CND5:	SCROLL	S-TEXT,YLEFT
	SUB	YLOC,YLEFT >YLOC
	GRTR?	YLOC,0 /?CND7
	SET	'YLOC,1
?CND7:	CURSET	YLOC,XLOC
?CND3:	WINGET	S-TEXT,WYPOS
	ADD	Y,STACK >YLEFT
	RETURN	YLEFT

	.ENDSEG

	.ENDI