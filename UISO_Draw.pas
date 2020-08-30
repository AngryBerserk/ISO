unit UISO_Draw;

interface

uses windows,pngimage,Graphics;

type TISO_Draw=class
  private
    c_w,
    c_h:real;
    sprite_w:word;
  public
    rx,
    ry:integer;
    ix,
    iy,
    iz:Word;
    procedure Get_ISO(mx,my,y:word);
    procedure Set_ISO(x,y,z:Word);
    procedure Draw(P:TPNGImage;C:TCanvas);
    constructor create(cw,ch,w:word);
end;

implementation

procedure TISO_Draw.Draw(P: TPngImage;C:TCanvas);
begin
  if (rx<c_w)and(rx>(-1)*sprite_w*2)and(ry>(-1)*sprite_w)and(ry<c_h+sprite_w*2+iy*4)then
    C.Draw(rx,ry-iy*4,P);
end;

procedure TISO_Draw.Set_ISO(x,y,z:Word);
 var xx,yy:real;
begin
  ix:=x;
  iy:=y;
  iz:=z;
  xx:=x-z;
  yy:=(x+z)*0.5-y;
  rx:=trunc(c_w/2+xx*sprite_w);
  ry:=trunc(c_h/2+yy*sprite_w);
end;

procedure TISO_Draw.Get_ISO(mx: Word; my: Word; y:word);
 var xx,zz:real;
begin
     rx:=mx;
     ry:=my-y*20;
     xx:=mx-c_w/2-19;
     zz:=my-c_h/2+y*4+5;
     ix := trunc(( xx / 2 + zz  ) / 20)+1;
     iz := trunc(( zz - xx / 2  ) / 20)+1;
     iy :=y+1;
end;

constructor TISO_Draw.create(cw,ch,w:word);
begin
  sprite_w:=w;
  c_w:=cw;
  c_h:=ch;
end;

end.
