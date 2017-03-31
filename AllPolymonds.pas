Unit AllPolymonds;

Interface
Uses Graph, WinCRT;

Type A=Array [1..30] of LongInt;
	 IntFile=File of LongInt;
	 R=Record
		Move, Side: Smallint;
	   End;
	 RArray=Array [1..30] of R;
	 AFile=File of RArray;
Procedure Move(PrevMove:LongInt; var CurX,CurY:LongInt; var MoveNum:Smallint; j:Smallint; var MoveList:RArray; var LastMove:LongInt; Side:Smallint);
Procedure RevMove(var LastMove:LongInt; var CurX,CurY:LongInt; j:Smallint; var Sides:Integer);
Procedure ToCords(var MoveList:RArray; n:Integer; var f2:IntFile);
Procedure DrawNum(i:Integer); 
Function SideCheck(var Sides:Integer; i2:Smallint):Smallint;

Implementation

Procedure Move(PrevMove:LongInt; var CurX,CurY:LongInt; var MoveNum:Smallint; j:Smallint; var MoveList:RArray; var LastMove:LongInt; Side:Smallint);
Begin
	If (PrevMove=MoveNum) or (PrevMove-3=MoveNum) or (PrevMove+3=MoveNum) then Begin
		If MoveNum>5 then MoveNum:=1
		Else inc(MoveNum);
	End;
	MoveList[j].Move:=MoveNum; MoveList[j].Side:=Side;
	Begin
		Case MoveNum of
			1:Begin
				inc(CurX,Side); dec(CurY,Side); LastMove:=MoveNum+3;
			End;
			2: Begin
				inc(CurX,Side*2); LastMove:=MoveNum+3;
			End;
			3: Begin
				inc(CurX,Side); inc(CurY,Side); LastMove:=MoveNum+3;
			End;
			4:Begin
				dec(CurX,Side); inc(CurY,Side); LastMove:=MoveNum-3;
			End;
			5:Begin
				dec(CurX,Side*2); LastMove:=MoveNum-3;
			End;
			6:Begin
				dec(CurX,Side); dec(CurY,Side); LastMove:=MoveNum-3;
			End;
		End;
	End;
End;

Procedure RevMove(var LastMove:LongInt; var CurX,CurY:LongInt; j:Smallint; var Sides:Integer);
var i: Smallint;
	num: integer;
Begin
	If LastMove>3 then dec(LastMove,3)
	Else inc(LastMove,3);
	Case LastMove of
		4:Begin
			inc(CurX,j); dec(CurY,j);
		End;
		5: Begin
			inc(CurX,j*2);
		End;
		6: Begin
			inc(CurX,j); inc(CurY,j); 
		End;
		1:Begin
			dec(CurX,j); inc(CurY,j); 
		End;
		2:Begin
			dec(CurX,j*2);
		End;
		3:Begin
			dec(CurX,j); dec(CurY,j);
		End;
	End;
	num:=1;
	For i:=1 to j-1 do num:=num*2;
	Sides:=Sides or num;
End;

Procedure ToCords(var MoveList:RArray; n:Integer; var f2:IntFile);
var i:Smallint;
	x,y: LongInt;
Begin
	x:=0;         y:=0;
	Write(f2,x);  Write(f2,y);
	For i:=1 to n-1 do Begin
		Case MoveList[i].Move of 
			1: Begin
				x:=x+MoveList[i].side; y:=y+MoveList[i].side;
			End;
			2:Begin
				x:=x+(MoveList[i].side*2);
			End;
			3:Begin
				x:=x+MoveList[i].side; y:=y-MoveList[i].side;
			End;
			4:Begin
				x:=x-MoveList[i].side; y:=y-MoveList[i].side;
			End;
			5:Begin
				x:=x-(MoveList[i].side*2);
			End;
			6:Begin
				x:=x-MoveList[i].side; y:=y+MoveList[i].side;
			End;
		End;
		Write(f2,x);  Write(f2,y);
	End;
	Write(f2,0);  Write(f2,0);
End;

Procedure DrawNum(i:Integer);                  
var j, x: Integer;
Begin
	MoveTO(47,1);
	j:=i;
	SetTextStyle(defaultfont,horizdir,2);
	x:=0;
	Repeat
		inc(x);
		Case j mod 10 of
			0: Begin
				OutText('0');
			End;
			1:Begin
				OutText('1');
			End;
			2:Begin
				OutText('2');
			End;
			3:Begin
				OutText('3');
			End;
			4:Begin
				OutText('4');
			End;
			5:Begin
				OutText('5');
			End;
			6:Begin
				OutText('6');
			End;
			7:Begin
				OutText('7');
			End;
			8:Begin
				OutText('8');
			End;
			9:Begin
				OutText('9');
			End;
		End;
		j:= j div 10;
		MoveTo(47-x*15,1);
	Until(x=3);
End;

Function SideCheck(var Sides:Integer; i2:Smallint):Smallint;
var num, i, j: Integer;
Begin
	num:=1; i:=0; j:=1;
	Repeat
		num:=num*2;
		inc(j);
		If Sides and num <> 0 then Begin
			inc(i);
			If i=i2 then Begin
				Sides:=Sides xor num;
				Exit(j);
			End;
		End;	
	Until 1=2;
End;

End.