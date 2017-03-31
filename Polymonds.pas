Unit Polymonds;

Interface
Uses Graph, WinCRT;

Type A=Array [1..30] of LongInt;
	 AFile=File of A;
	 IntFile=File of LongInt;
Procedure Move(PrevMove:LongInt; var CurX,CurY:LongInt; var MoveNum:Smallint; j:Smallint; var MoveList:A; var LastMove:LongInt);
Procedure RevMove(var LastMove:LongInt; var CurX,CurY:LongInt; j:Smallint);
Procedure ToCords(var MoveList:A; n:Integer; var f2:IntFile);
Procedure DrawNum(i:Integer); 

Implementation

Procedure Move(PrevMove:LongInt; var CurX,CurY:LongInt; var MoveNum:Smallint; j:Smallint; var MoveList:A; var LastMove:LongInt);
Begin
	If (PrevMove=MoveNum) or (PrevMove-3=MoveNum) or (PrevMove+3=MoveNum) then Begin
		If MoveNum>5 then MoveNum:=1
		Else inc(MoveNum);
	End;
	MoveList[j]:=MoveNum;
	Begin
		Case MoveNum of
			1:Begin
				inc(CurX,j); dec(CurY,j); LastMove:=MoveNum+3;
			End;
			2: Begin
				inc(CurX,j*2); LastMove:=MoveNum+3;
			End;
			3: Begin
				inc(CurX,j); inc(CurY,j); LastMove:=MoveNum+3;
			End;
			4:Begin
				dec(CurX,j); inc(CurY,j); LastMove:=MoveNum-3;
			End;
			5:Begin
				dec(CurX,j*2); LastMove:=MoveNum-3;
			End;
			6:Begin
				dec(CurX,j); dec(CurY,j); LastMove:=MoveNum-3;
			End;
		End;
	End;
End;

Procedure RevMove(var LastMove:LongInt; var CurX,CurY:LongInt; j:Smallint);
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
End;

Procedure ToCords(var MoveList:A; n:Integer; var f2:IntFile);
var i:Smallint;
	x,y: LongInt;
Begin
	x:=0;         y:=0;
	Write(f2,x);  Write(f2,y);
	For i:=1 to n-1 do Begin
		Case MoveList[i] of 
			1: Begin
				x:=x+i; y:=y+i;
			End;
			2:Begin
				x:=x+(i*2);
			End;
			3:Begin
				x:=x+i; y:=y-i;
			End;
			4:Begin
				x:=x-i; y:=y-i;
			End;
			5:Begin
				x:=x-(i*2);
			End;
			6:Begin
				x:=x-i; y:=y+i;
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

End.