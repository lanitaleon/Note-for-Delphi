unit uGraph;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  uPoints, uTriangle;

type
  TMyPaintBox = class(TCustomControl)
  private
    FMousePos: TPoint;
    FTestPoint: TPoint2D;
    FTriangle: TTriangle2D;
    FTriTestIntf: ITriangleTest;
    FViewCenter: TPoint2D;
    FZoomCoeff: Double;
    procedure SetTestPoint(const Value: TPoint2D);
    procedure SetTriangle(const Value: TTriangle2D);
    procedure SetTriTestIntf(const Value: ITriangleTest);
    procedure WmEraseBkgnd(var Msg: TMessage); message WM_ERASEBKGND;
  protected
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    procedure RecalcViewport;
    procedure Resize; override;
    function ScreenToWcs(const PtScr: TPoint): TPoint2D;
    function WcsToScreen(const PtWcs: TPoint2D): TPoint;
    property ViewCenter: TPoint2D read FViewCenter;
  public
    constructor Create(AOwner: TComponent); override;

    /// 以指定点为中心进行缩放，PtScrRef所在的位置在缩放前后不动
    procedure ZoomAt(const PtScrRef: TPoint; Ratio: Double);

    /// 获取或设置被测试的点
    property TestPoint: TPoint2D read FTestPoint write SetTestPoint;

    /// 获取或设置被测试的三角形
    property Triangle: TTriangle2D read FTriangle write SetTriangle;

    /// 三角形测试接口
    property TriangleTestInterface: ITriangleTest read FTriTestIntf
      write SetTriTestIntf;
  end;


implementation

uses
  Math;

{ TMyPaintBox }

constructor TMyPaintBox.Create(AOwner: TComponent);
begin
  inherited;
  FTriangle := TTriangle2D.NewRandom;
  FTestPoint := FTriangle.Center;
  FZoomCoeff := 1;
  FTriTestIntf := TTestByPoly.Create;
  DoubleBuffered := True;
end;

procedure TMyPaintBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  FMousePos := Point(X, Y);
  FTestPoint := ScreenToWcs(FMousePos);
  Invalidate;
end;

procedure TMyPaintBox.Paint;
var
  I: Integer;
  TestResult: Boolean;
  Points: array[0..2] of TPoint;
  PntTestScr: TPoint;
begin
  inherited;
  // Fill entire box to white
  Canvas.Brush.Color := clWhite;
  Canvas.Pen.Style := psClear;
  Canvas.FillRect(ClientRect);

  // Get Test Result
  TestResult := TriangleTestInterface.IsIn(Triangle.Vertex[0],
    Triangle.Vertex[1], Triangle.Vertex[2], FTestPoint);

  // draw triangle
  Canvas.Pen.Style := psSolid;
  if TestResult then
    Canvas.Pen.Color := clGreen
  else
    Canvas.Pen.Color := clRed;

  for I := 0 to 2 do
    Points[I] := WcsToScreen(Triangle.Vertex[I]);
  Canvas.Polygon(Points);

  // draw point
  PntTestScr := WcsToScreen(TestPoint);
  Canvas.Pen.Color := clBlue;
  Canvas.Ellipse(PntTestScr.X - 2, PntTestScr.Y - 2,
                 PntTestScr.X + 2, PntTestScr.Y + 2);
end;

procedure TMyPaintBox.RecalcViewport;
var
  box: TRect2D;
  rx, ry: Double;
  cx, cy: Double;
begin
  box.Create(FTestPoint, FTestPoint);
  box.Extend(FTriangle.Vertex[0]);
  box.Extend(FTriangle.Vertex[1]);
  box.Extend(FTriangle.Vertex[2]);
  if box.IsEmpty then Exit;

  rx := (ClientWidth - 16) / box.Width;
  ry := (ClientHeight - 16) / box.Height;
  FZoomCoeff := Min(rx, ry);

  cx := ClientWidth * 0.5 - box.CenterPoint.X * FZoomCoeff;
  cy := ClientHeight * 0.5 + box.CenterPoint.Y * FZoomCoeff;
  FViewCenter := Point2D(cx, cy);
end;

procedure TMyPaintBox.Resize;
begin
  inherited;
  RecalcViewport;
end;

function TMyPaintBox.ScreenToWcs(const PtScr: TPoint): TPoint2D;
begin
  if FZoomCoeff < MinFloatEqual  then
    FZoomCoeff := MinFloatEqual;
  Result.X := (PtScr.X - ViewCenter.X) / FZoomCoeff;
  Result.Y := (ViewCenter.Y - PtScr.Y) / FZoomCoeff;
end;

procedure TMyPaintBox.SetTestPoint(const Value: TPoint2D);
begin
  FTestPoint := Value;
  RecalcViewport;
  Invalidate;
end;

procedure TMyPaintBox.SetTriangle(const Value: TTriangle2D);
begin
  FTriangle := Value;
  RecalcViewport;
  Invalidate;
end;

procedure TMyPaintBox.SetTriTestIntf(const Value: ITriangleTest);
begin
  FTriTestIntf := Value;
  Invalidate;
end;

function TMyPaintBox.WcsToScreen(const PtWcs: TPoint2D): TPoint;
begin
  Result.X := Round(PtWcs.X * FZoomCoeff + ViewCenter.X);
  Result.Y := Round(ViewCenter.Y - PtWcs.Y * FZoomCoeff);
end;

procedure TMyPaintBox.WmEraseBkgnd(var Msg: TMessage);
begin
//  Msg.Result := 1;
end;

procedure TMyPaintBox.ZoomAt(const PtScrRef: TPoint; Ratio: Double);
var
  NewRatio: Double;
  PtRefWcs: TPoint2D;
  PtScrNew: TPoint2D;
begin
  if ratio < MinFloatEqual then Exit;

  PtRefWcs := Self.ScreenToWcs(PtScrRef);

  //Object : ptRef --> ptRef, ptRef + Vec -- > ptRef + Vec * ratio
  //Given  : ZoomCoeff, ViewCenter
  //Solve  : NewZoomCoeff, NewViewCenter;

  NewRatio := Ratio * FZoomCoeff;

  PtScrNew.X := PtRefWcs.X * NewRatio + ViewCenter.X;
  PtScrNew.Y := ViewCenter.Y - PtRefWcs.Y * NewRatio;

  FZoomCoeff := NewRatio;
  FViewCenter := PtScrRef - PtScrNew + ViewCenter;
  Invalidate;
end;

end.
