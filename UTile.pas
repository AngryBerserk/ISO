unit UTile;

interface
uses UImage,ImageLoader;
type
  TTile = class
   public
    Image:TImage;
    name:String;
    constructor create(ImageLoader:TImageLoader);
    destructor destroy;override;
  end;

implementation

constructor TTile.create(ImageLoader:TImageLoader);
begin
  Image:=TImage.Create;
  name:='Dirt tile';
  Image.Add_anim(ImageLoader,'res\cube.png');
end;

destructor TTile.Destroy;
begin
  Image.Destroy;
end;

end.
