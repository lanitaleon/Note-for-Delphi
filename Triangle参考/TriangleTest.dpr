program TriangleTest;

uses
  Forms,
  MainUI in 'MainUI.pas' {FrmMain},
  uPoints in 'uPoints.pas',
  uTriangle in 'uTriangle.pas',
  uGraph in 'uGraph.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Èý½ÇÐÎ²âÊÔ';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
