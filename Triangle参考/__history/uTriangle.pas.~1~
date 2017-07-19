unit uTriangle;

interface

uses
  Windows, SysUtils, Classes, uPoints, Generics.Collections;

type
  TTriangle2D = record
  public
    function Center: TPoint2D;
    class function NewRandom: TTriangle2D; static;
  public
    Vertex: array[0..2] of TPoint2D;
  end;

  TTriangle2DList = TList<TTriangle2D>;

  /// 三角形测试接口
  ITriangleTest = interface
    ['{2460083C-69F7-4319-BDD9-F1871BB3C959}']
    /// <summary> 测试一个点是否在三角形内 </summary>
    /// <param name="Pnt1">构成三角形的三点中的第1个 </param>
    /// <param name="Pnt2">构成三角形的三点中的第2个 </param>
    /// <param name="Pnt3">构成三角形的三点中的第3个 </param>
    /// <param name="PntTest">要测试的点 </param>
    /// <returns>当PntTest在指定的三角形内部时返回True否则返回False</returns>
    function IsIn(const Pnt1, Pnt2, Pnt3, PntTest: TPoint2D): Boolean;
  end;

  /// 使用重心坐标方式来判断一个点是否在三角形内部
  TTestByAreal = class(TInterfacedObject, ITriangleTest)
  public
    function IsIn(const Pnt1, Pnt2, Pnt3, PntTest: TPoint2D): Boolean;
  end;

  /// 使用多边形方式判断一个点是否在三角形内部
  TTestByPoly = class(TInterfacedObject, ITriangleTest)
  public
    function IsIn(const Pnt1, Pnt2, Pnt3, PntTest: TPoint2D): Boolean;
  end;

implementation

uses
  Math;

{ TTestByAreal }

function TTestByAreal.IsIn(const Pnt1, Pnt2, Pnt3, PntTest: TPoint2D): Boolean;
var
  e1, e2, e3: TVector2D;
  d1, d2, d3: TVector2D;
  Coord: TPoint3D;
begin
  e1 := Pnt3 - Pnt2;
  e2 := Pnt1 - Pnt3;
  e3 := Pnt2 - Pnt1;
  d1 := PntTest - Pnt1;
  d2 := PntTest - Pnt2;
  d3 := PntTest - Pnt3;

  // 求重心坐标
  Coord.X := e1.CrossMul(d3);
  Coord.Y := e2.CrossMul(d1);
  Coord.Z := e3.CrossMul(d2);

  // 重心坐标三点均在0-1之间时点在三角形内部
  Result := (Sign(Coord.X) = Sign(Coord.Y)) and
            (Sign(Coord.X) = Sign(Coord.Z));
end;

{ TTestByPoly }


///判断一个点是否在指定的多边形中
///Parameters
///   ptHit: 被判断的点
///   points: 构成多边形的定点。该多边形的任意两条不相邻的边不应有交点
///Returns
///   被检测的点在多边形内部则返回True，否则返回False
function PtInPoly(const PtHit: TPoint2D; const Points: array of TPoint2D): Boolean;
var
  I, PntCount: Integer;
  tx, ty: Single;
  ptVertex0, ptVertex: TPoint2D;
  yflag0, yflag1, xflag0: Boolean;
begin
  Result := False;
  PntCount := Length(Points);
  if PntCount < 3 then Exit;

  tx := ptHit.X;
  ty := ptHit.Y;


  ptVertex0 := points[PntCount-1] ;
  // get test bit for above/below X axis */
  yflag0 := ( ptVertex0.Y >= ty );

  for I := 0 to PntCount - 1 do
  begin
    ptVertex := points[I] ;
    yflag1 := ( ptVertex.Y >= ty ) ;
	  // check if endpoints straddle (are on opposite sides) of X axis
    // (i.e. the Y's differ); if so, +X ray could intersect this edge.
	  if ( yflag0 <> yflag1 ) then
    begin
	    xflag0 := ( ptVertex0.X >= tx ) ;
	    // check if endpoints are on same side of the Y axis (i.e. X's
	    // are the same); if so, it's easy to test if edge hits or misses.
	    if ( xflag0 = ( ptVertex.X >= tx ) ) then
      begin
        //if edge's X values both right of the point, must hit
        if ( xflag0 ) then
          Result := not Result;
      end
      else begin
        //compute intersection of pgon segment with +X ray, note
		    // if >= point's X; if so, the ray hits it.
        if ( (ptVertex.X - (ptVertex.Y - ty) *
		        ( ptVertex0.X - ptVertex.X)/(ptVertex0.Y - ptVertex.Y)) >= tx ) then
            Result := not Result;
      end;
    end;

    // move to next pair of vertices, retaining info as possible */
    yflag0 := yflag1 ;
    ptVertex0 := ptVertex;
  end;
end;

function TTestByPoly.IsIn(const Pnt1, Pnt2, Pnt3, PntTest: TPoint2D): Boolean;
var
  Pnts: array[0..2] of TPoint2D;
begin
  Pnts[0] := Pnt1;
  Pnts[1] := Pnt2;
  Pnts[2] := Pnt3;
  Result := PtInPoly(PntTest, Pnts);
end;

{ TTriangle2D }

function TTriangle2D.Center: TPoint2D;
begin
  Result := Vertex[0] + Vertex[1] + Vertex[2];
  Result := Result / 3;
end;

class function TTriangle2D.NewRandom: TTriangle2D;
begin
  Result.Vertex[0] := TPoint2D.NewRandom;
  Result.Vertex[1] := TPoint2D.NewRandom;
  Result.Vertex[2] := TPoint2D.NewRandom;
end;

end.
