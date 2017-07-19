unit TriangleUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckTriangle, ExtCtrls, Generics.Collections, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalc, Mask, RzEdit, RzCalcEdit,
  uGraph;

type
  TForm3 = class(TForm)
    mmShowJudge: TMemo;
    plDrawChoice: TPanel;
    btnCreateTri: TButton;
    lblTriNum: TLabel;
    edtTotalTri: TRzCalcEdit;
    procedure FormCreate(Sender: TObject);
    /// <summary> 点击按钮创建并绘制指定个三角形 </summary>
    procedure btnCreateTriClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FPaintBox: TMyPaintBox;
    ICheckPnt: IJudgePointInTri;
  public
    { Public declarations }
    /// <summary> 调用IJudgePointInTri接口 </summary>
    ///  <returns> 返回一个IJudgePointInTri类型的变量 </returns>
    function GetPointCheck: IJudgePointInTri;
  end;

var
  Form3: TForm3;

implementation

uses
  uFrmTest;
{$R *.dfm}

procedure TForm3.FormCreate(Sender: TObject);
begin
  System.ReportMemoryLeaksOnShutdown := True;
  FPaintBox := TMyPaintBox.Create(Self);
  FPaintBox.Parent := Self;
  FPaintBox.Align := alClient;
  FPaintBox.Width := 700;
  FPaintBox.Height := 700;
  plDrawChoice.BringToFront;
end;

procedure TForm3.FormDestroy(Sender: TObject);
begin
  //FPaintBox.TriList.Free;
  //FPaintBox.Triangle.Free;
end;

function TForm3.GetPointCheck: IJudgePointInTri;
begin
  Result := TCheckPoint.Create;
end;


procedure TForm3.btnCreateTriClick(Sender: TObject);
var
  NewTriList: TMyTriList;
begin
  FPaintBox.CounterClick := True;
  ICheckPnt := GetPointCheck;
  NewTriList := ICheckPnt.CreateTri(Round(edtTotalTri.Value));

  FPaintBox.ClearShapes;
  FPaintBox.TriList.AddRange(NewTriList);
  NewTriList.Free;
  FPaintBox.Clear;
end;

end.
