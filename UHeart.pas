unit UHeart;

interface
uses UImage,ImageLoader,UTile;
type
  THeart = class (TTile)
   public
    constructor create(ImageLoader:TImageLoader);reintroduce;
  end;

implementation

constructor THeart.create(ImageLoader:TImageLoader);
begin
  Image:=TImage.Create;
  name:='Heart';
  Image.Add_anim(ImageLoader,'res\heart1.png');
  Image.Add_anim(ImageLoader,'res\heart2.png');
  Image.Add_anim(ImageLoader,'res\heart3.png');
  Image.Add_anim(ImageLoader,'res\heart4.png');
  Image.Add_anim(ImageLoader,'res\heart5.png');
  Image.Add_anim(ImageLoader,'res\heart6.png');
  Image.Anim_Speed:=100;
end;

end.
