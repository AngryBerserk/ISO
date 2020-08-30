unit UcubegrassTile;

interface
uses UTile, UImage, ImageLoader;
type
  TcubegrassTile = class (TTile)
   public
    constructor create(ImageLoader:TImageLoader);reintroduce;
  end;
implementation

constructor TcubegrassTile.create(ImageLoader:TImageLoader);
begin
  Image:=TImage.Create;
  name:='Grass on dirt tile';
  Image.Add_anim(ImageLoader,'res\cube_grass.png');
  //Image.Add_anim('res\cube_cave.png');
end;

end.
