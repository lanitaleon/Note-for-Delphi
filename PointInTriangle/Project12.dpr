program Project12;

uses
  Forms,
  TriangleUI in 'TriangleUI.pas' {Form3},
  CheckTriangle in 'CheckTriangle.pas',
  uGraph in 'uGraph.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
