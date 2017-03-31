Program All_Magic_Polymonds;
Uses AllPolymonds, Graph, WinCRT;
const Koef=9;			//увеличение фигуры
	  Koef2x=630;		//передвижение по иксу
	  Koef2y=350;		//передвижение по игреку
var n: Integer;
	f: AFile;
	f2,f3: IntFile;
	
	
Procedure Find_Polymonds(var j:Smallint; var LastMove:A; var MoveList:RArray; var CurX,CurY:LongInt; var Sides:Integer);
var i, MoveNum, i2, SideLength: Smallint;
Begin
	inc(j);
	MoveNum:=0;
	For i:=1 to 4 do Begin
		inc(MoveNum);
		For i2:=1 to n-j+1 do Begin
			SideLength:=SideCheck(Sides,i2);
			Move(LastMove[j-1],CurX,CurY,MoveNum,j,MoveList,LastMove[j],SideLength);
			If j<>n then Find_Polymonds(j,LastMove,MoveList,CurX,CurY,Sides)
			Else Begin
				If ((CurX=0) and (CurY=0)) and ((LastMove[j]<>LastMove[1]) and (LastMove[j]<>LastMove[1]-3)) then Write(f, MoveList);
			End;
			ReVmove(LastMove[j],CurX,CurY,SideLength,Sides);
		End;
	End;
	dec(j);
End;

Function CrossChecking:LongInt;
var XArray, YArray: Array [1..31] of LongInt;
	i,j,k,k2: Smallint;
	x01,y01,x02,y02,x1,y1,x2,y2,t1,t2:Real;
	cross: Boolean;
	num: LongInt;
Begin
	num:=0;
	While not EoF(f2) do begin
		For i:=1 to n+1 do Begin
			Read(f2,XArray[i]);
			Read(f2,YArray[i]);
		End;
		k:=0; k2:=1; cross:=true;
		For i:=2 to n-1 do Begin
			x01:=XArray[i-1]; y01:=YArray[i-1]; x1:=XArray[i]; y1:=YArray[i];
			inc(k);
			For j:=3+k to n-k2+1 do Begin
				x02:=XArray[j-1]; y02:=YArray[j-1]; x2:=XArray[j]; y2:=YArray[j];
				If not ((((x1-x01)*(y2-y02))-((x2-x02)*(y1-y01))=0) or (((x2-x02)*(y1-y01))-((x1-x01)*(y2-y02))=0)) then Begin
					t1:=(((y2-y02)*(x02-x01))-((x2-x02)*(y02-y01))) / (((x1-x01)*(y2-y02))-((x2-x02)*(y1-y01)));
					t2:=(((y1-y01)*(x01-x02))-((x1-x01)*(y01-y02))) / (((x2-x02)*(y1-y01))-((x1-x01)*(y2-y02)));
					If ((t1>=0) and (t1<=1) and (t2>=0) and (t2<=1)) then Begin
						cross:=false;
						Break;
					End;
				End;
			End;
			If not cross then Break;
			k2:=0;
		End;
		If cross then Begin
			For i:=1 to n+1 do Begin
				Write(f3,XArray[i]);
				Write(f3,YArray[i]);
			End;
			inc(num);
		End;
	End;
	Exit(num);
End;

var CurX, CurY, jLong: LongInt;
	LastMove, RandomA: A;
	i, j, MoveNum, gd, gm, i2, k: Smallint;
	Answer: Char;
	MoveList: RArray;
	Sides: Integer;
Begin
	Write('Insert n: '); Readln(n);
	j:=1; Sides:=0;
	For i:=1 to n+1 do Begin
		LastMove[i]:=0;
		j:=j*2; inc(Sides,j);
	End;
	dec(Sides,j);
	CurX:=1; CurY:=-1; 
	MoveList[1].Move:=1; MoveList[1].Side:=1; 
	LastMove[1]:=4;
	MoveNum:=1; j:=2;
	Assign(f,'All_Polymonds_Moves.dat'); Rewrite(f);
	For i:=2 to 3 do Begin
		inc(MoveNum); k:=1;
		For i2:=2 to n do Begin
			k:=k*2;
			Sides:=Sides xor k;
			Move(LastMove[1],CurX,CurY,MoveNum,2,MoveList,LastMove[2],i2);
			Find_Polymonds(j,LastMove,MoveList,CurX,CurY,Sides);
			RevMove(LastMove[2],CurX,CurY,i2,Sides);
		End;
	End;
	Close(f);
	Writeln('Polymonds are found, let me do some stuff...');
	
	Assign(f2,'All_Polymonds_Cords.dat');
	Reset(f); Rewrite(f2);
	While not EoF(f) do Begin
		Read(f,MoveList);
		ToCords(MoveList,n,f2);
	End;
	Close(f); Close(f2);
	
	Assign(f3,'Magic_Polymonds_Cords.dat');
	Reset(f2); Rewrite(f3);
	Writeln('We found ',CrossChecking div 2,' magic polymonds');
	Close(f2); Close(f3);
	
	Repeat
		Writeln('Do you want to see them? Y/N');
		Readln(Answer);
	Until (Answer='Y') or (Answer='N');
	
	If Answer='N' then Halt
	Else Begin
		SetLineStyle(solidln,0,thickwidth);
		Reset(f3);
		jLong:=0;
		While not EoF(f3) do Begin
			For i:=1 to n+1 do Begin
				Read(f3,LastMove{x}[i]);
				Read(f3,RandomA{y}[i]);
			End;
			gd:=Detect; InitGraph(gd,gm,'');
			SetBkColor(White);
			ClearDevice;
			SetColor(Green);
			inc(jLong);
			DrawNum(jLong);
			For j:=1 to i do Begin 
				MoveTo(LastMove[j-1]*Koef+Koef2x,RandomA[j-1]*Koef+Koef2y);
				LineTo(LastMove[j]*Koef+Koef2x,RandomA[j]*Koef+Koef2y);
			End;
			Readkey;
			CloseGraph; 
		End;
		Close(f3);
	End;
End.