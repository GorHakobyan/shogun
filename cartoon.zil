<VERSION YZIP>

<SINGLE-FILE? T>

<ROUTINE ANIMATE (CELS)
	 <REPEAT ()
		 <SETG CARTOON .CELS>
		 <SETG CARTOON-N 0>
		 <INPUT 1 1 ,NEXT-CEL>>>

<GLOBAL CARTOON <>>
<GLOBAL CARTOON-N 0>

<ROUTINE NEXT-CEL ("AUX" (N <GET ,CARTOON 1>))
	 <COND (<IGRTR? CARTOON-N <GET ,CARTOON 0>>
		<SET N 1>)>
	 <SCREEN 1>
	 <DISPLAY <GET ,CARTOON .N> 1 1>
	 <SCREEN 0>
	 <RFALSE>>
	 
<ROUTINE GO
	 <CLEAR -1>
	 <SPLIT </ <WINGET 0 ,WHIGH> 4>>
	 <ANIMATE ,CEL-TABLE>
	 <QUIT>>

<CONSTANT CEL-TABLE
	  <LTABLE 1 2 3 4 5 6 7 8>>
