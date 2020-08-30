unit UDummyCube;

interface
uses UTile,UImage, ImageLoader;
type
  TDummyCube = class (TTile)
   public
    constructor create(ImageLoader:TImageLoader);reintroduce;
  end;
implementation

constructor TDummyCube.create(ImageLoader:TImageLoader);
begin
  Image:=TImage.Create;
  name:='Dummy';
  Image.Add_anim(ImageLoader,'res\cube_dummy.png');
  //Image.Add_anim('res\cube_cave.png');
end;

end.
