unit MainUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uPoints, uGraph, uTriangle,
  Mask, RzEdit, RzCalcEdit, ExtCtrls;

type
  TFrmMain = class(TForm)
    PnInfo: TPanel;
    Splitter1: TSplitter;
    grpTriangle: TGroupBox;
    lblPoint1: TLabel;
    lblX: TLabel;
    lblY: TLabel;
    edtX1: TRzCalcEdit;
    edtY1: TRzCalcEdit;
    edtX2: TRzCalcEdit;
    edtY2: TRzCalcEdit;
    lblPoint2: TLabel;
    edtX3: TRzCalcEdit;
    edtY3: TRzCalcEdit;
    lblPoint3: TLabel;
    BtnNew: TButton;
    GrpTestMethod: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure BtnNewClick(Sender: TObject);
    procedure GrpTestMethodClick(Sender: TObject);
  private
    FGraph: TMyPaintBox;
    procedure UpdateInfo;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.BtnNewClick(Sender: TObject);
begin
  FGraph.Triangle := TTriangle2D.NewRandom;
  FGraph.TestPoint := FGraph.Triangle.Center;
  UpdateInfo;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  FGraph := TMyPaintBox.Create(Self);
  FGraph.Parent := Self;
  FGraph.Align := alClient;
  UpdateInfo;
end;

procedure TFrmMain.GrpTestMethodClick(Sender: TObject);
begin
  case GrpTestMethod.ItemIndex of
  0: FGraph.TriangleTestInterface := TTestByAreal.Create;
  else
    FGraph.TriangleTestInterface := TTestByPoly.Create;
  end;
end;

procedure TFrmMain.UpdateInfo;
begin
  edtX1.Value := FGraph.Triangle.Vertex[0].X;
  edtY1.Value := FGraph.Triangle.Vertex[0].Y;
  edtX2.Value := FGraph.Triangle.Vertex[1].X;
  edtY2.Value := FGraph.Triangle.Vertex[1].Y;
  edtX3.Value := FGraph.Triangle.Vertex[2].X;
  edtY3.Value := FGraph.Triangle.Vertex[2].Y;
end;

end.
