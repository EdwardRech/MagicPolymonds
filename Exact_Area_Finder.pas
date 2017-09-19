Program Exact_Area_Finder;
const Koef=9;			//увеличение фигуры
	  Koef2x=630;		//передвижение по иксу
	  Koef2y=350;		//передвижение по игреку
Type PNode = ^TNode;
	 TNode = Record
				data: Integer;
				next: PNode;
			End;
	 ChainA = Array [1..10] of Integer;
	 CordsA = Array [1..20] of LongInt;
	 Shape = Record
				Chain : ChainA;
				Area : LongInt;
				Cords: CordsA;
			 End;
	 Sides = Array [1..500] of Shape;
			
Function CheckIt(a,b: ChainA; n: Integer):Boolean;
var i: Integer;
Begin
	For i:=2 to n do Begin
		If a[i]<>b[i] then Break;
	End;
	If i=n then Exit(True);
	For i:=2 to n do Begin
		If a[i]<>b[n-i+2] then Exit(false);
	End;
	Exit(True);
End;		

Procedure PrintCords(a:CordsA; n:Integer);
var i:Integer;
Begin
	For i:=1 to n do Begin
		Write(a[i*2-1],' ');
		Writeln(a[i*2]);
	End;
	Writeln('=========');
End;
		
var f,f2: File of LongInt;
	aX,aY: Array [1..10] of LongInt;
	maxx, maxxi, area, i, n, j, requiredArea: LongInt;
	mb, ma: THeapStatus;
	head, p, q: PNode;
	Shapes: Sides;
	figure: Array [1..400] of Integer; 
Begin
	mb:=GetHeapStatus;
	Assign(f,'Magic_Polymonds_Cords.dat'); Reset(f);
	Assign(f2,'All_Polymonds_Moves.dat'); Rewrite(f2); //files
	Write('Insert n: '); Readln(n);
	Write('Area to find: '); Readln(requiredArea);
	inc(n);
	new(head); head^.next:=nil; p:=head; j:=0;
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
		If {(area=72)} (area=requiredArea) then Begin
			inc(j); Shapes[j].area:=area;
			For i:=1 to n do Begin
				Write(f2,ax[i]);
				Write(f2,ay[i]);
			End;
		End;
	End;
	Close(f); Close(f2);
	
	p:=head;
	While p^.next<>nil do Begin
		q:=p; p:=p^.next; 
		Dispose(q);
	End;
	Dispose(p);
	ma:=GetHeapStatus;
	Writeln('Memory ',ma.totalallocated-mb.totalallocated);
	
	Reset(f2);
	j:=0;
	While not EoF(f2) do Begin
		inc(j);
		For i:=1 to n do Begin
			Read(f2,aX[i]);
			Read(f2,aY[i]);
		End;
		For i:=1 to n do Begin
			Shapes[j].Cords[i*2-1]:=aX[i];
			Shapes[j].Cords[i*2]:=aY[i];
		End;
		For i:=2 to n do Begin
			If aY[i]=aY[i-1] then Begin
				If aX[i]>aX[i-1] then Shapes[j].Chain[i-1]:=(aX[i]-aX[i-1]) div 2
				Else Shapes[j].Chain[i-1]:=(aX[i-1]-aX[i]) div 2;
			End Else Begin
				If aY[i]>aY[i-1] then Shapes[j].Chain[i-1]:=(aY[i]-aY[i-1])
				Else Shapes[j].Chain[i-1]:=(aY[i-1]-aY[i]);
			End;
		End;
	End;
	Close(f2);

	For i:=1 to j-1 do Begin
		If Shapes[i].Area<>0 then Begin
			maxxi:=1;
			For maxx:=i+1 to j do Begin
				If Shapes[i].Area=Shapes[maxx].Area then Begin
					If CheckIt(Shapes[i].Chain,Shapes[maxx].Chain,n-1) then Begin
						inc(maxxi); 
						If maxxi=2 then figure[1]:=maxx
						Else If maxxi=3 then Begin
							PrintCords(Shapes[i].Cords,n);
							PrintCords(Shapes[figure[1]].Cords,n);
							PrintCords(Shapes[maxx].Cords,n);
							Figure[2]:=maxx;
						End Else if maxxi>3 then Begin
							PrintCords(Shapes[maxx].Cords,n);
							Figure[maxxi-1]:=maxx;
						End;
					End;
				End;
			End;
			If maxxi=1 then Writeln('WARNING')
			Else if maxxi=2 then Shapes[figure[1]].Area:=0
			Else if maxxi mod 2<>0 then Writeln('WARNING #2')
			Else Begin
				For maxx:=1 to maxxi div 2 do Begin
					Readln(area);
					Shapes[Figure[area-1]].Area:=0;
				End;
			End;
		End;
	End;
	
	maxx:=0;
	For i:=1 to j do Begin
		If Shapes[i].Area=0 then inc(maxx)
		Else PrintCords(Shapes[i].Cords,n);
	End;
	Writeln(maxx);
	readln;
End.