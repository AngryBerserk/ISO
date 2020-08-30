unit UWaterCube;

interface
uses UImage,ImageLoader,UTile;
type
  TWaterCube = class (TTile)
   public
    constructor create(ImageLoader:TImageLoader);reintroduce;
  end;

implementation

constructor TWaterCube.create(ImageLoader:TImageLoader);
begin
  Image:=TImage.Create;
  name:='Water';
  Image.Add_anim(ImageLoader,'res\cube_water.png');//'res\cube.png');
end;

end.
