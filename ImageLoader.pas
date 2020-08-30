unit ImageLoader;

interface
uses classes,sysutils,pngimage,LImage;

type
  TImageLoader=class
    Images:TList;
    destructor Destroy;override;
    constructor create;
    function add(S:String):Word;
    function get(P:Word):TPNGImage;
  end;

implementation

destructor TImageLoader.destroy;
 var z:word;I:TLImage;
begin
 for z := 0 to Images.Count-1 do
  Begin
    I:=Images.Items[z];
    I.Destroy;
  End;
  Images.Free;
end;

constructor TImageLoader.create;
begin
  Images:=TList.Create;
end;

function TImageLoader.add(S: string):Word;
 var Image,I:TLImage;z:Word;
begin
 if Images.Count>0 then
 Begin
   for z := 0 to Images.Count-1 do Begin
    I:=Images.Items[z];
    if I.Name=s then Exit(z);
   End;
 End;
 Image:=TLImage.Create(s);
 Images.Add(Image);
 result:=Images.Count-1;
end;

function TImageLoader.get(P: Word):TPNGImage;
 var I:TLImage;
begin
 result:=nil;
 if Images.Count>=P then
 Begin
  I:=Images.Items[P];
  result:=I.Image;
 End;

end;


end.
