unit LImage;

interface
uses pngimage;
 type
  TLImage = class
    Image:TPNGImage;
    Name:String;
    constructor create(s:String);
    destructor Destroy;override;
  end;
implementation

constructor TLImage.create(s: string);
begin
  Image:=TPngImage.Create;
  Name:=s;
  Image.LoadFromFile(s);
end;

destructor TLImage.Destroy;
begin
  Image.Free;
end;

end.
