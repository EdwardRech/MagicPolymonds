Program Area_Finder;
Uses Graph, WinCRT,Polymonds;
const Koef=9;			//увеличение фигуры
	  Koef2x=630;		//передвижение по иксу
	  Koef2y=350;		//передвижение по игреку
Type PNode = ^TNode;
	 TNode = Record
				data: Integer;
				next: PNode;
			End;
			
			
var f,f2,f3: File of LongInt;
	aX,aY: Array [1..30] of LongInt;
	maxx, maxxi, area, i, n, maximum, minimum: LongInt;
	mb, ma: THeapStatus;
	head, p, q: PNode;
	gd,gm: Smallint;
Begin
	mb:=GetHeapStatus;
	Assign(f,'Magic_Polymonds_Cords.dat'); Reset(f);
	Assign(f2,'All_Polymonds_Moves.dat'); Rewrite(f2); //maximums files
	Assign(f3,'All_Polymonds_Cords.dat'); Rewrite(f3); //minumum files
	Write('Insert n: '); Readln(n);
	inc(n);
	new(head); head^.next:=nil; p:=head; maximum:=0; minimum:=0;
	While not Eof(f) do Begin
		For i:=1 to n do Begin
			Read(f,aX[i]);
			Read(f,aY[i]);
		End;
		maxx:=0; 
		maxxi:=0; 
		area:=0; 
		For i:=1 to n do 
			if maxx<aX[i] then begin 
				maxx:=aX[i]; 
				maxxi:=i; 
			end; 
		For i:=maxxi to N-1 do 
			begin 
			area:=area+((ax[i]+ax[i+1])*(ay[i]-ay[i+1])); 
			end; 
		For i:=0 to maxxi-1 do begin 
			area:=area+((ax[i]+ax[i+1])*(ay[i]-ay[i+1]));  
		end; 
		area:=area div 2; 
		if area<0 then area:=area*-1;
		p^.data:=area;
		new(q); p^.next:=q; q^.next:=nil; p:=q;
		If area=maximum then Begin
			For i:=1 to n do Begin
				Write(f2,ax[i]);
				Write(f2,ay[i]);
			End;
		End
		Else If area=minimum then Begin
			For i:=1 to n do Begin
				Write(f3,ax[i]);
				Write(f3,ay[i]);
			End;
		End
		Else If area>maximum then Begin
			maximum:=area;
			Close(f2); Rewrite(f2);
			For i:=1 to n do Begin
				Write(f2,ax[i]);
				Write(f2,ay[i]);
			End;
		End
		Else if (area<minimum) OR (minimum=0) then Begin
			minimum:=area;
			Close(f3); Rewrite(f3);
			For i:=1 to n do Begin
				Write(f3,ax[i]);
				Write(f3,ay[i]);
			End;
		End;
	End;
	Close(f); Close(f2); Close(f3);
	
	p:=head;
	While p^.next<>nil do Begin
		q:=p; p:=p^.next; 
		Dispose(q);
	End;
	Dispose(p);
	ma:=GetHeapStatus;
	Writeln('Memory ',ma.totalallocated-mb.totalallocated);
	
	SetLineStyle(solidln,0,thickwidth);
	Reset(f2);
	maximum:=0;
	While not EoF(f2) do Begin
		For i:=1 to n do Begin
			Read(f2,aX[i]);
			Read(f2,aY[i]);
		End;
		gd:=Detect; InitGraph(gd,gm,'');
		SetBkColor(White);
		ClearDevice;
		SetColor(Green);
		inc(maximum);
		DrawNum(maximum);
		For maxx:=1 to n do Begin 
			MoveTo(aX[maxx-1]*Koef+Koef2x,aY[maxx-1]*Koef+Koef2y);
			LineTo(aX[maxx]*Koef+Koef2x,aY[maxx]*Koef+Koef2y);
		End;
		Readkey;
		CloseGraph; 
	End;
	Close(f2);
		
	Reset(f3);
	minimum:=0;
	While not EoF(f3) do Begin
		For i:=1 to n do Begin
			Read(f3,aX[i]);
			Read(f3,aY[i]);
		End;
		gd:=Detect; InitGraph(gd,gm,'');
		SetBkColor(White);
		ClearDevice;
		SetColor(Green);
		inc(minimum);
		DrawNum(minimum);
		For maxx:=1 to n do Begin 
			MoveTo(aX[maxx-1]*Koef+Koef2x,aY[maxx-1]*Koef+Koef2y);
			LineTo(aX[maxx]*Koef+Koef2x,aY[maxx]*Koef+Koef2y);
		End;
		Readkey;
		CloseGraph; 
	End;
	Close(f3);	
		
	
End.