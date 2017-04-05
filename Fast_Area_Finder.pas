Program Fast_Area_Finder;
Type PNode = ^TNode;
	 TNode = Record
				data: Integer;
				next: PNode;
			End;
			
var f: File of LongInt;
	aX,aY: Array [1..30] of LongInt;
	maxx, maxxi, area, i, n, maximum, minimum: LongInt;
	yeah: Boolean;
	mb, ma: THeapStatus;
	head, p, q: PNode;
Begin
	mb:=GetHeapStatus;
	Assign(f,'Magic_Polymonds_Cords.dat'); Reset(f);
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
		If area>maximum then maximum:=area
		Else if (area<minimum) OR (minimum=0) then minimum:=area;
	End;
	i:=minimum-1;
	Write('Excludes: ');
	p:=head;
	Repeat
		inc(i);
		yeah:=false;
		While p^.next<>nil do Begin
			If i=p^.data then Begin
				Yeah:=true;
				Break;
			End;
			p:=p^.next;
		End;
		If i=p^.data then Yeah:=true;
		p:=head;
		If (not Yeah) and (i mod 2=p^.data mod 2) then Write(i,' ');
	Until i=maximum;
	Writeln;
	Writeln('max - ',maximum,' min - ',minimum);
	Readln;
	Close(f);
	p:=head;
	While p^.next<>nil do Begin
		q:=p; p:=p^.next; 
		Dispose(q);
	End;
	Dispose(p);
	ma:=GetHeapStatus;
	Writeln('Memory ',ma.totalallocated-mb.totalallocated);
End.