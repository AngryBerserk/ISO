unit UTileManager;

interface
uses UTile,UDummyCube,UCubegrasstile,UWaterCube,UHeart,ImageLoader,pngimage;
type
  TTileManager=class
    private
      imageLoader:TImageLoader;
    public
      function createTileAs(N:String):TTile;
      function Bitmap(T:TTile):TPNGImage;
      //function
      constructor create;
      destructor Destroy;
  end;

implementation

function TTileManager.createTileAs(N:String):TTile;
begin
 if N='TTile' then result:=TTile.create(ImageLoader);
 if N='TDummyCube' then result:=TDummyCube.create(ImageLoader);
 if N='TcubegrassTile' then result:=TcubegrassTile.create(ImageLoader);
 if N='TWaterCube' then result:=TWaterCube.create(ImageLoader);
 if N='THeart' then result:=THeart.create(ImageLoader);
end;

function TTileManager.Bitmap(T: TTile):TPNGImage;
begin
 result:=T.Image.Bitmap(Imageloader)
end;

constructor TTileManager.create;
begin
  imageLoader:=TImageLoader.create;
end;

destructor TTileManager.Destroy;
Begin
  imageLoader.Destroy
End;

end.
