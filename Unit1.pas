unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls,pngimage,
    UTile,Vcl.ComCtrls, UISO_Draw,UTileManager, Vcl.Dialogs, Vcl.Menus;

const
  h=15;
  w=15;
  l=15;

type
  TForm1 = class(TForm)
    Splitter1: TSplitter;
    Panel2: TPanel;
    Scroll_l: TScrollBar;
    Label3: TLabel;
    Scroll_h: TScrollBar;
    Label1: TLabel;
    Scroll_w: TScrollBar;
    Label2: TLabel;
    PaintBox1: TPaintBox;
    TileList: TListBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Timer1: TTimer;
    Button1: TButton;
    Memo1: TMemo;
    Edit3: TEdit;
    CheckBox1: TCheckBox;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure Scroll_lChange(Sender: TObject);
    procedure TileListDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseLeave(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    ISO_c:TISO_Draw;
    TiM:TTileManager;
    BackBuffer:TBitmap;
    mouse_x,
    mouse_y,
    sx,
    sy,
    sz:Word;
    field:Array[1..w]of array[1..h]of array[1..l]of TTile;
    procedure ReDraw;
    procedure Timer(Sender: TObject; var Done: Boolean);
    procedure Initialize_TileList;
  end;

var
  Form1: TForm1;

implementation
{$R *.dfm}
procedure TForm1.Button1Click(Sender: TObject);
  var nx,ny:integer;
begin
//draw hit map
memo1.Visible:=false;
for ny := 0 to PaintBox1.Height do
  for nx := 0 to PaintBox1.width do
   Begin
     ISO_c.Get_ISO(nx,ny,h-Scroll_h.Position);
     if (ISO_c.ix>=1) and (ISO_c.iz>=1) and (ISO_c.ix<11) and (ISO_c.iz<11) then Begin
           Memo1.Lines.Add(IntToStr(nx)+'-'+IntToStr(ny)+'  '+IntToStr(ISO_c.ix)+':'+IntToStr(ISO_c.iy)+':'+IntToStr(ISO_c.iz));
           PaintBox1.Canvas.Pixels[nx,ny-(ISO_c.iy-1)*20]:=RGB(20*ISO_c.ix,20*ISO_c.iz,0);
     End;
   End;
   Memo1.Visible:=true;
end;

procedure TrimWorkingSet;
var
MainHandle: THandle;
begin
if Win32Platform = VER_PLATFORM_WIN32_NT then
begin
MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID);
SetProcessWorkingSetSize(MainHandle, DWORD(-1), DWORD(-1));
CloseHandle(MainHandle);
end;
end;

procedure TForm1.ReDraw;
 var x,y,z:word;

procedure draw_cursor;
 var P:TPNGImage;
begin
   if TileList.ItemIndex>-1 then
   Begin
     P:=TiM.Bitmap(TileList.Items.Objects[TileList.ItemIndex] as TTile);
     ISO_c.Get_ISO(mouse_x,mouse_y+(h-Scroll_h.Position)*20,h-Scroll_h.Position);
     Edit1.Text:=FloatToStr(ISO_c.ix);
     Edit2.Text:=FloatToStr(ISO_c.iy);
     Edit3.Text:=FloatToStr(ISO_c.iz);
     ISO_c.Set_ISO(ISO_c.ix,ISO_c.iy,ISO_c.iz);
     ISO_c.Draw(P,BackBuffer.canvas);
   End;
End;

begin
 BackBuffer.canvas.FillRect(rect(0,0,width,height));
 //
   //--------------here to calculate the display rectangle
 //
 for y := 1 to sy do
   for z := 1 to sz do
     for x := 1 to sx do
      Begin
        ISO_c.Get_ISO(mouse_x,mouse_y+(h-Scroll_h.Position)*20,h-Scroll_h.Position);
        if (ISO_c.ix=x)and(ISO_c.iy=y)and(ISO_c.iz=z) then Draw_cursor else
          if field[x,y,z]<>nil then
            Begin
              ISO_c.Set_ISO(x,y,z);
              //ISO_c.Get_ISO(ISO_c.ix,ISO_c.iy,ISO_c.iz);
              ISO_c.Draw(TiM.Bitmap(field[x,y,z]),BackBuffer.canvas);
            End;
      End;

 PaintBox1.Canvas.Draw(0,0,BackBuffer);
end;

procedure TForm1.Save1Click(Sender: TObject);
begin
//
end;

procedure TForm1.Scroll_lChange(Sender: TObject);
 var x,y,z:word;
begin
  sx:=Scroll_w.Position;
  sy:=(Scroll_h.max+1)-Scroll_h.Position;
  Edit1.Text:=IntToStr(sy);
  sz:=(Scroll_l.max+1)-Scroll_l.Position;
  //make transparent
  Edit1.Text:=IntToStr(Scroll_h.Position);
  Edit2.Text:=IntToStr(sy);
  if checkBox1.Checked then
    if sy<>Scroll_h.max then sy:=sy+1;
  for y := 1 to sy do
    for z := 1 to sz do
      for x := 1 to sx do
        if field[x,y,z]<>nil then
        Begin
          ISO_c.Set_ISO(x,y,z);
            //Check if transparent
              if (Scroll_h.Position>1)and(checkBox1.Checked) then
              if y=sy then
                Field[x,y,z].Image.Alpha:=40 else Field[x,y,z].Image.Alpha:=255
                else Field[x,y,z].Image.Alpha:=255;
        End;
  redraw;
end;

procedure TForm1.TileListDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
 var
    listBox : TListBox;
    R:TRect;
    S:TPNGImage;
 begin
    listBox := Control as TListBox;
    with listBox.Canvas do
    begin
      FillRect(rect);
      S:=TiM.Bitmap(ListBox.Items.Objects[Index] as TTile);
      R:=Rect;
      R.SetLocation(Rect.Left+1,Rect.Top+1);
      R.Width:=S.Width;
      R.Height:=ListBox.ItemHeight-2;
      //Rect.Height:=100;
      S.Draw(ListBox.canvas,R);
      //Draw(Rect.Left+1,Rect.Top+1,T.Image.Bitmap);
      TextOut(45, rect.Top + rect.Height div 2, listBox.Items[Index]) ;
    end;
end;

procedure TForm1.Timer(Sender: TObject; var Done: Boolean);
begin
reDraw;
Done:=false;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
//TrimWorkingSet
end;

procedure TForm1.Initialize_TileList;
 var T,TCGTile,TDummy,TWaterCube,THeart:TTile;
Begin
 TiM:=TTileManager.create;
 TDummy:=TiM.createTileAs('TDummyCube');
 TileList.AddItem(TDummy.name,TDummy);
 T:=TiM.createTileAs('TTile');
 TileList.AddItem(T.name,T);
 TCGTile:=TiM.createTileAs('TcubegrassTile');
 TileList.AddItem(TCGTile.name,TCGTile);
 TWaterCube:=TiM.createTileAs('TWaterCube');
 TileList.AddItem(TWaterCube.name,TWaterCube);
 THeart:=TiM.createTileAs('THeart');
 TileList.AddItem(THeart.name,THeart);
End;

procedure TForm1.N2Click(Sender: TObject);
 var x,y,z:word;f:TextFile;S:String;
begin
//load
if OpenDialog1.Execute then
  if OpenDialog1.FileName<>'' then
    Begin
      AssignFile(f,OpenDialog1.FileName);
      Reset(f);
      for y := 1 to h do
        for z := 1 to l do
          for x := 1 to w do
            Begin
              Readln(f,S);
              if Field[x,y,z]<>nil then Field[x,y,z].Destroy;
              if S<>'nil' then Field[x,y,z]:=TiM.createTileAs(S)
                else Field[x,y,z]:=nil
            End;
      CloseFile(f);
    End;
end;

procedure TForm1.N3Click(Sender: TObject);
 var x,y,z:word;f:TextFile;
begin
//save
if SaveDialog1.Execute then
  if SaveDialog1.FileName<>'' then
    Begin
      AssignFile(f,SaveDialog1.FileName);
      Rewrite(f);
      for y := 1 to h do
        for z := 1 to l do
          for x := 1 to w do
            if Field[x,y,z]<>nil then Writeln(f,field[x,y,z].ClassName) else
              Writeln(f,'nil');
      CloseFile(f);
    End;
end;

procedure TForm1.FormDestroy(Sender: TObject);
 var x,y,z:word;
begin
 if TileList.ItemIndex>-1 then
  for z := 0 to TileList.Count-1 do
    (TileList.Items.Objects[z]).Destroy;
 TileList.Destroy;
 for y := 1 to h do
   for z := 1 to l do
     for x := 1 to w do
        if field[x,y,z]<>nil then field[x,y,z].Destroy;
 TiM.Destroy;
 ISO_c.Destroy;
 BackBuffer.Destroy;
end;

procedure TForm1.FormShow(Sender: TObject);
 var x,y,z:word;

Procedure Fill_Field;
 var c:byte;
Begin
 c:=0;//Random(2);
 case c of
  //0:field[x,y,z]:=TcubegrassTile.create(ImageLoader);
  0:field[x,y,z]:=TiM.createTileAs('TTile');
 end;
End;

begin
 Initialize_TileList;
 TileList.ItemIndex:=0;
 Application.OnIdle:=Timer;
 BackBuffer:=TBitmap.Create;
 ISO_c:=TISO_Draw.create(PaintBox1.width,PaintBox1.height,20);
 BackBuffer.Width:=PaintBox1.Width;
 BackBuffer.Height:=PaintBox1.Height;
 randomize;
 for y := 1 to h do
   for z := 1 to l do
     for x := 1 to w do
      fill_field;
 Scroll_h.Max:=h;
 Scroll_l.Max:=l;
 Scroll_w.Max:=w;
 Scroll_w.Position:=w;
 sx:=Scroll_w.Position;
 sy:=(Scroll_h.max+1)-Scroll_h.Position;
 Edit1.Text:=IntToStr(sy);
 sz:=(Scroll_l.max+1)-Scroll_l.Position;
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var P:TTile;
begin
  ISO_c.Get_ISO(mouse_x,mouse_y+(h-Scroll_h.Position)*20,h-Scroll_h.Position);
  if (ISO_c.ix<=w)and(ISO_c.ix>0)and
      (ISO_c.iy<=h)and(ISO_c.iy>0)and
        (ISO_c.iz<=l)and(ISO_c.iz>0) then
          Begin
           if Field[ISO_c.ix,ISO_c.iy,ISO_c.iz]<>nil then
              Field[ISO_c.ix,ISO_c.iy,ISO_c.iz].Destroy;
           Field[ISO_c.ix,ISO_c.iy,ISO_c.iz]:=nil;
           if not(ssCtrl in Shift) then
             Begin
              P:=TileList.Items.Objects[TileList.ItemIndex] as TTile;
              Field[ISO_c.ix,ISO_c.iy,ISO_c.iz]:=TiM.createTileAs(P.ClassName);
             End;
          End;
end;

procedure TForm1.PaintBox1MouseLeave(Sender: TObject);
begin
mouse_x:=0;
mouse_y:=0;
end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
 var P:TTile;
begin
  if ssCtrl in Shift then
    PaintBox1.Cursor:=crCross
    else PaintBox1.Cursor:=crDefault;
  mouse_x:=x;
  mouse_y:=y;
  if ssLeft in Shift then
  Begin
    ISO_c.Get_ISO(mouse_x,mouse_y+(h-Scroll_h.Position)*20,h-Scroll_h.Position);
    if (ISO_c.ix<=w)and(ISO_c.ix>0)and
        (ISO_c.iy<=h)and(ISO_c.iy>0)and
          (ISO_c.iz<=l)and(ISO_c.iz>0) then
            Begin
             if Field[ISO_c.ix,ISO_c.iy,ISO_c.iz]<>nil then
                Field[ISO_c.ix,ISO_c.iy,ISO_c.iz].Destroy;
             Field[ISO_c.ix,ISO_c.iy,ISO_c.iz]:=nil;
             if not(ssCtrl in Shift) then
               Begin
                P:=TileList.Items.Objects[TileList.ItemIndex] as TTile;
                Field[ISO_c.ix,ISO_c.iy,ISO_c.iz]:=TiM.createTileAs(P.ClassName);
               End;
            End;
  End;
end;

end.
