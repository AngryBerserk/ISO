unit UImage;

interface
uses classes,sysutils,dateutils,ImageLoader,pngimage;
Type
  TImage = class
  private
    Picture:TStringList;
    Anim_count:Word;
    last_time:TTime;
  public
    Alpha:Word;
    Anim_Speed:Word;
    constructor Create;
    destructor Destroy;override;
    function Bitmap(ImageLoader:TImageLoader):TPNGImage;
    procedure Add_anim(ImageLoader:TImageLoader;f:String);
  end;

implementation

destructor TImage.Destroy;
begin
 Picture.Clear;
 Picture.Free;
end;

constructor TImage.Create;
begin
  Picture:=TStringList.Create;
  Anim_count:=0;
  Anim_Speed:=200;
  Alpha:=255;
end;

procedure TImage.Add_anim(ImageLoader:TImageLoader;f: string);
begin
 Picture.add(IntToStr(ImageLoader.add(f)));
end;

function TImage.Bitmap(ImageLoader:TImageLoader):TPNGImage;
 var P:TPNGImage;x,y:Word;DSTAlpha:PByteArray;
begin
  result:=nil;
  if Picture.Count>0 then
   Begin
    P:=ImageLoader.get(StrToInt(Picture[Anim_count]));  //Picture[Anim_count];
    //result:=Picture[Anim_count];
    //check animation speed
    if (now-last_time)>Anim_Speed/100000000 then
      Begin
        if Anim_count<Picture.count-1 then
         Begin
          Anim_Count:=Anim_Count+1;
         End
           else Anim_count:=0;
         last_time:=now;
      End;
    //Alpha modification
    for y:=0 to P.Height-1 do
      begin
        DstAlpha:=P.AlphaScanline[y];
        for x:=0 to P.Width-1 do
          if DstAlpha[x]<>0 then DstAlpha[x]:=alpha;
      end;
  result:=P
  End;
end;

end.
