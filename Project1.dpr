program Project1;

uses
  fastMM4,
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  UTile in 'UTile.pas',
  UImage in 'UImage.pas',
  UcubegrassTile in 'UcubegrassTile.pas',
  UDummyCube in 'UDummyCube.pas',
  ImageLoader in 'ImageLoader.pas',
  LImage in 'LImage.pas',
  UISO_Draw in 'UISO_Draw.pas',
  UTileManager in 'UTileManager.pas',
  UWaterCube in 'UWaterCube.pas',
  UHeart in 'UHeart.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
