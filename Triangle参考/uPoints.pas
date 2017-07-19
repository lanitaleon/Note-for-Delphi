unit uPoints;

interface

uses
  Types, Windows, SysUtils, Classes, Generics.Collections;

type
  Float = Double;

  {$REGION ' TPoint2D '}

  TPoint2D = record
  public
    /// <summary> ����������깹��һ���� </summary>
    constructor Create(const X, Y: Float);  overload;
    /// <summary> ����һ������ֵΪ 0 �ĵ� </summary>
    class function Create(): TPoint2D; overload; static; inline;
    ///
    class var Zero: TPoint2D;
    /// <summary> ����������X��ļнǣ���Χ[0 ~ DoublePI) </summary>
    function Angle: Float;
    /// <summary> ����������ָ����������� </summary>
    function CrossMul(const Pt2: TPoint2D): Extended; inline;
    /// <summary> ���ص���ָ����ľ��� </summary>
    function DistanceTo(const PtRef: TPoint2D): Float; inline;
    /// <summary> ����������ָ���������ڻ� </summary>
    function DotMul(const Pt2: TPoint2D): Extended; inline;
    /// <summary> ���ص���ָ����X��Y����������ϵ� </summary>
    function ExtMax(const Pt2: TPoint2D): TPoint2D; inline;
    /// <summary> ���ص���ָ����X��Y������С����ϵ� </summary>
    function ExtMin(const Pt2: TPoint2D): TPoint2D; inline;
    /// <summary> �ж�������ָ�������Ƿ�ƽ�� </summary>
    /// <returns> ������ͬ�������ֵλ����Χ�ڷ���True </returns>
    function IsParallelTo(const Vec: TPoint2D; Tol: Double = 1E-4): Boolean;
    /// <summary> �ж����������Ƿ�Ϊ1 </summary>
    function IsUnitLength: Boolean; inline;
    /// <summary> �ж����������Ƿ�Ϊ0 </summary>
    function IsZeroLength: Boolean; inline;
    /// <summary> ����������ģ </summary>
    function Mag: Float; inline;
    /// <summary> ����������ģ��ƽ�� </summary>
    function MagSqr: Extended; inline;
    /// <summary> ������ X ��Ϊ�Գ��᾵�� </summary>
    procedure MirrorX; inline;
    /// <summary> ������ Y ��Ϊ�Գ��᾵�� </summary>
    procedure MirrorY; inline;
    /// <summary> ������ԭ��Ϊ���ľ��� </summary>
    procedure MirrorO; inline;
    /// <summary> �����������Ϊ���ľ��� </summary>
    procedure MirrorBy(const APoint: TPoint2D); overload;
    /// <summary> ����һ������� </summary>
    class function NewRandom: TPoint2D; static;
    /// <summary> ��������Ϊ��λ���� </summary>
    /// <seealso cref="Normalize" />
    function Normal: TPoint2D;

    /// <summary> ��������Ϊ��λ���� </summary>
    procedure Normalize;
    /// <summary> ���������Ĵ�ֱ����(-Y, X) </summary>
    function PerpVector: TPoint2D; inline;
    /// <summary> ������ԭ����ʱ����תAng�Ƕ� </summary>
    procedure RotateBy(const Ang: Float); overload;
    /// <summary> ������ָ�����ĵ���תָ���Ƕ� </summary>
    procedure RotateBy(const PtCenter: TPoint2D; const Angle: Float); overload;
    /// <summary> ������ת90�� </summary>
    procedure RotateBy90; overload;
    /// <summary> ������ָ������ת90�� </summary>
    procedure RotateBy90(const PtCenter: TPoint2D); overload;
    /// <summary> ���ַ�����ʽ��ﵱǰ���� </summary>
    function ToString(): string;
    /// <summary> �������㹹����������ʽ�����ط�������ʽ��ֵ�ķ��� </summary>
    /// <remarks> [x1, y1, 1]
    ///           [x2, y2, 1]
    ///           [x3, y3, 1]  </remarks>
    class function Orientation(const p1, p2, p3: TPoint2D): Integer; static;
    /// <summary> ������� </summary>
    class operator Add(const Pt1, Pt2: TPoint2D): TPoint2D; overload;
    /// <summary> ���ָ��ϵ�� </summary>
    /// <remarks> ������ DIV_BY_ZERO_PROTECT ���ж��Ƿ��0 </remarks>
    class operator Divide(const Pt: TPoint2D; const coeff: Float): TPoint2D;
    /// <summary> �ж������Ƿ���� </summary>
    class operator Equal(const Pt1, Pt2: TPoint2D): Boolean;
    /// <summary> ��������ֵΪָ��ϵ���ĵ� </summary>
    class operator Explicit(const value: Float): TPoint2D;
    /// <summary> TPoint ת��Ϊ TPoint2D </summary>
    class operator Implicit(const Pt: Types.TPoint): TPoint2D; overload;
    /// <summary> ���븡������� </summary>
    class operator Multiply(const Pt: TPoint2D; const coeff: Float): TPoint2D; overload;
    /// <summary> ������������ </summary>
    class operator Multiply(const coeff: Float; const Pt: TPoint2D): TPoint2D; overload;
    /// <summary> ��ȡ��ֵ </summary>
    class operator Negative(const Pt: TPoint2D): TPoint2D;
    /// <summary> �ж������Ƿ񲻵� </summary>
    class operator NotEqual(const Pt1, Pt2: TPoint2D): Boolean;
    /// <summary> ������� </summary>
    class operator Subtract(const Pt1, Pt2: TPoint2D): TPoint2D; overload;
  public
    X: Float;
    Y: Float;
  end;

  /// <summary> ��ά��ָ�� </summary>
  PPoint2D = ^TPoint2D;
  /// <summary> ��ά�㶨������ָ�� </summary>
  PPoints2D = ^TPoints2D;
  /// <summary> ��ά�㶨������ </summary>
  TPoints2D = array[0..32767] of TPoint2D;
  /// <summary> ��ά�㶯̬����ָ�� </summary>
  PDynPoints2D = ^TDynPoints2D;
  /// <summary> ��ά�㶯̬���� </summary>
  TDynPoints2D = array of TPoint2D;
  /// <summary> ��ά���� </summary>
  TVector2D = TPoint2D;
  /// <summary> ��ά��С </summary>
  TSize2D = TPoint2D;

  /// <summary> ��ά���б� </summary>
  TPoint2DList = TList<TPoint2D>;
  /// <summary> ��ά���б� </summary>
  TPointList2D = TPoint2DList;

  {$ENDREGION}

  {$REGION ' TPoint3D '}

  /// <summary> ��ά�ռ�� </summary>
  TPoint3D = record
  public
    /// <summary> ͨ��������������깹����ά�� </summary>
    constructor Create(const X, Y, Z: Float);  overload;
    /// <summary> ����һ���������Ϊ 0 �ĵ� </summary>
    class function Create(): TPoint3D; overload; static; inline;
    class var Zero: TPoint3D;
    /// <summary> ����������ָ�������ļн�ֵ,  ��Χ[0 ~ PI�� </summary>
    /// <remarks> ������ģΪ0ʱ����0���������϶�ʱ����0 </remarks>
    function AngleTo(const PtRef: TPoint3D): Float;
    /// <summary> ����������ָ����������� </summary>
    function CrossMul(const Pt2: TPoint3D): TPoint3D; inline;
    /// <summary> ���ص���ָ����ľ��� </summary>
    function DistanceTo(const PtRef: TPoint3D): Float; inline;
    function DistanceXY(const PtRef: TPoint3D): Float; inline;
    /// <summary> ����������ָ���������ڻ� </summary>
    function DotMul(const Pt2: TPoint3D): Extended; inline;
    /// <summary> �жϵ���ָ�����Ƿ���� </summary>
    function Equals(const Pt2: TPoint3D): Boolean; overload; inline;
    /// <summary> �жϵ���ָ�����Ƿ����(�����ֵ) </summary>
    function Equals(const Pt2: TPoint3D; const tolerance: Float): Boolean; overload; inline;
    /// <summary> ���ص���ָ�����и�����ֵ������ϵ� </summary>
    function ExtMax(const Pt2: TPoint3D): TPoint3D; inline;
    /// <summary> ���ص���ָ�����и�����ֵ��С����ϵ� </summary>
    function ExtMin(const Pt2: TPoint3D): TPoint3D; inline;
    /// <summary> �ж����������Ƿ�Ϊ 1 </summary>
    function IsUnitLength: Boolean; inline;
    /// <summary> �ж����������Ƿ�Ϊ 0 </summary>
    function IsZeroLength: Boolean; inline;
    /// <summary> ����������ģ </summary>
    function Mag: Float; inline;
    /// <summary> ��������ģ��ƽ�� </summary>
    function MagSqr: Extended; inline;
    function MagXY: Float; inline;
    /// <summary> ������ X ��Ϊ�Գ��᾵�� </summary>
    procedure MirrorX; inline;
    /// <summary> ������ Y ��Ϊ�Գ��᾵�� </summary>
    procedure MirrorY; inline;
    /// <summary> ������ Z ��Ϊ�Գ��᾵�� </summary>
    procedure MirrorZ; inline;
    /// <summary> ������ԭ��Ϊ���ľ��� </summary>
    procedure MirrorO; inline;
    /// <summary> ������ XY ƽ��Ϊ�Գ��澵�� </summary>
    procedure MirrorXOY; inline;
    /// <summary> ������ YZ ƽ��Ϊ�Գ��澵�� </summary>
    procedure MirrorYOZ; inline;
    /// <summary> ������ XZ ƽ��Ϊ�Գ��澵�� </summary>
    procedure MirrorXOZ; inline;
    /// <summary> �����������Ϊ���ľ��� </summary>
    procedure MirrorBy(const APoint: TPoint3D); overload;
    /// <summary> ��������Ϊ��λ���� </summary>
    /// <seealso cref="Normalize" />
    function Normal: TPoint3D; inline;
    /// <summary> ��������Ϊ��λ���� </summary>
    /// <remarks> ����ģΪ 0 ʱ����(1, 0, 0) </remarks>
    procedure Normalize; inline;
    /// <summary> �������� X ����תָ���Ƕ� </summary>
    /// <param name="ang"> ��ת�Ƕ� </param>
    procedure RotateX(const Ang: Float); overload; inline;
    /// <summary> �������� Y ����תָ���Ƕ� </summary>
    /// <param name="ang"> ��ת�Ƕ� </param>
    procedure RotateY(const Ang: Float); overload; inline;
    /// <summary> �������� Z ����תָ���Ƕ� </summary>
    /// <param name="ang"> ��ת�Ƕ� </param>
    procedure RotateZ(const Ang: Float); overload; inline;
    function RoundPoint: TPoint3D;
    /// <summary> ���ַ�����ʽ��ﵱǰ���� </summary>
    function ToString(): string;
    /// <summary> ������� </summary>
    class operator Add(const Pt1, Pt2: TPoint3D): TPoint3D; overload; inline;
    /// <summary> ������� </summary>
    /// <remarks> ��ά��������ά������ӣ�Z���겻�� </remarks>
    class operator Add(const Pt1: TPoint3D; const Pt2: TPoint2D): TPoint3D; overload; inline;
    /// <summary> ���ָ��ϵ�� </summary>
    /// <remarks> ���� DIV_BY_ZERO_PROTECT �ж��Ƿ��0 </remarks>
    class operator Divide(const Pt: TPoint3D; const coeff: Float): TPoint3D;
    /// <summary> �ж������Ƿ���� </summary>
    class operator Equal(const Pt1, Pt2: TPoint3D): Boolean; overload; inline;
    /// <summary> �ж������Ƿ���� </summary>
    /// <remarks> ��ά�����ά��Ƚϣ� ��ά Z ������ 0 ��Ƚ� </remarks>
    class operator Equal(const Pt1: TPoint3D; const Pt2: TPoint2D): Boolean; overload; inline;
    /// <summary> ��ά��ת��Ϊ��ά��, ��ά�� Z ����Ϊ 0 </summary>
    class operator Implicit(const Pt: TPoint2D): TPoint3D; inline;
    /// <summary> ��ά��ת��Ϊ��ά�㣬��ȡ XY ���� </summary>
    class operator Explicit(const Pt: TPoint3D): TPoint2D;
    /// <summary> ����ָ��ϵ����� </summary>
    class operator Multiply(const Pt: TPoint3D; const coeff: Float): TPoint3D; overload; inline;
    /// <summary> ����ָ��ϵ����� </summary>
    class operator Multiply(const coeff: Float; const Pt: TPoint3D): TPoint3D; overload; inline;
    /// <summary> ����ά������� ������������˴��� </summary>
    class operator Multiply(const Pt1, Pt2: TPoint3D): TPoint3D; overload; inline;
    /// <summary> ��������ֵȡ�� </summary>
    class operator Negative(const Pt: TPoint3D): TPoint3D; inline;
    /// <summary> �ж������Ƿ���� </summary>
    class operator NotEqual(const Pt1, Pt2: TPoint3D): Boolean; inline;
    /// <summary> ������� </summary>
    class operator Subtract(const Pt1, Pt2: TPoint3D): TPoint3D; overload; inline;
    /// <summary> ������� </summary>
    /// <remarks> ��ά�����ά�� Z ���겻�� </remarks>
    class operator Subtract(const Pt1: TPoint3D; const Pt2: TPoint2D): TPoint3D; overload; inline;
  public
    X: Float;
    Y: Float;
    Z: Float;
  end;

  /// <summary> ��ά��ָ�룬�μ�TPoint3D </summary>
  PPoint3D = ^TPoint3D;
  /// <summary> ��ά��������ָ�� </summary>
  PPoints3D = ^ TPoints3D;
  /// <summary> ��ά�������� </summary>
  TPoints3D = array[0..32767] of TPoint3D;
  /// <summary> �䳤��ά����ָ�� </summary>
  PDynPoints3D = ^TDynPoints3D;
  /// <summary> �䳤��ά���� </summary>
  TDynPoints3D = array of TPoint3D;
  /// <summary> ��ά���� </summary>
  TVector3D = TPoint3D;

  /// <summary> ��ά���б� </summary>
  TPoint3DList = TList<TPoint3D>;
  /// <summary> ��ά���б� </summary>
  TPointList3D = TPoint3DList;

  {$ENDREGION}

{$REGION ' Rectangle '}

  { 2D Rectangle with Float precision }
  //Left<=Right, Top<=Bottom
  TRect2D = record
  public
    // <summary> �Ը������������㴴������ </summary>
    constructor Create(const pt1, pt2: TPoint2D); overload;
    // <summary> �Ը������ĸ�����ֵ�������� </summary>
    constructor Create(const Left, Top, Right, Bottom: Float); overload;
    // <summary> ��������㴴�����β�ʹ���׼�� </summary>
    procedure CreateNormalize(const pt1, pt2: TPoint2D);

    /// <summary> ���ؾ����������� </summary>
    function CenterPoint: TPoint2D;
    /// <summary> ���ؾ������Ͻ����� </summary>
    function TopRight: TPoint2D;
    /// <summary> ���ؾ������½ǽ����� </summary>
    function BottomLeft: TPoint2D;
    /// <summary> ���ؾ�������������� </summary>
    function LeftCenter: TPoint2D;
    /// <summary> ���ؾ����Ҳ��������� </summary>
    function RightCenter: TPoint2D;
    /// <summary> ���ؾ��ζ����������� </summary>
    function TopCenter: TPoint2D;
    /// <summary> ���ؾ��εױ��������� </summary>
    function BottomCenter: TPoint2D;

    /// <summary> ��չ�߿�ʹ����������ĵ� </summary>
    /// <param name="ptExt"> Ҫ�����ĵ� </param>
    procedure Extend(const ptExt: TPoint2D); overload;
    /// <summary> ��չ�߿�ʹ�����ָ���ľ��� </summary>
    /// <param name="ARect"> Ҫ�����ľ��� </param>
    procedure Extend(const ARect: Types.TRect); overload;
    /// <summary> ��չ�߿�ʹ�����ָ���ľ��� </summary>
    /// <param name="ARect"> Ҫ�����ľ��� </param>
    procedure Extend(const ARect: TRect2D); overload;

    /// <summary> �������ҷֱ���չcx��ȣ����·ֱ���չcy��� </summary>
    procedure Inflate(const cx, cy: Float); overload;
    /// <summary> �������ҷֱ���չASize.X��ȣ����·ֱ���չASize.Y��� </summary>
    procedure Inflate(const ASize: TSize2D); overload;

    /// <summary> ������չ֮��ľ��� </summary>
    /// <param name="cx"> �������ҷֱ���չcx��� </param>
    /// <param name="cy"> �������ҷֱ���չcx��� </param>
    function InflatedRect(const cx, cy: Float): TRect2D; overload;
    /// <summary> ������չ֮��ľ��� </summary>
    /// <param name="ASize"> �������ҷֱ���չASize.X��ȣ����·ֱ���չASize.Y���</param>
    function InflatedRect(const ASize: TSize2D): TRect2D; overload;

    /// <summary> ���������εĽ������� </summary>
    function Intersect(const ARect: TRect2D): TRect2D; overload;
    /// <summary> ���������εĽ������Σ������ؽ����Ƿ�Ϊ�� </summary>
    function Intersect(const ARect: TRect2D; var outRect: TRect2D): Boolean; overload;
    /// <summary> �ж����������Ƿ��ཻ </summary>
    function IntersectWith(const ARect: TRect2D): Boolean; overload;

    /// <summary> ���ؾ��ε����(ʼ��Ϊ��) </summary>
    function Area: Float;
    /// <summary> ���ؾ��ε��ܳ� </summmary>
    function CurveLength: Float;
    /// <summary> ���ضԽ��߳� </summary>
    function DiagonalLength: Double;
    /// <summary> ���ؾ��εĿ��(����Ϊ��ֵ) </summary>
    function Width: Float;
    /// <summary> ���ؾ��εĸ߶�(����Ϊ��ֵ) </summary>
    function Height: Float;
    /// <summary> �жϾ����Ƿ�Ϊ�� </summary>
    function IsEmpty: Boolean;

    /// <summary> ��񻯾��Σ�ʹ��������Left<=Right, Top<=Bottom</summary>
    procedure Normalize;
    /// <summary> ���ع�񻯾��� </summary>
    function NormalizedRect: TRect2D;

    /// <summary> ƽ�ƾ��� </summary>
    procedure Offset(dx, dy: Float); overload;
    /// <summary> ƽ�ƾ��� </summary>
    procedure Offset(const pt: TPoint2D); overload;

    /// <summary> ���ؾ��δ�С </summary>
    function Size: TSize2D;
    /// <summary> ���ַ�����ʽ��ﵱǰ���� </summary>
    function ToString(): string;
    /// <summary> �����������ε�����Χ�� </summary>
    function Union(const ARect: TRect2D): TRect2D;
    class var Null: TRect2D;
    /// <summary> �����;���ת��Ϊ�������� </summary>
    class operator Implicit(const rect: Types.TRect): TRect2D;
    /// <summary> ������ת��Ϊ���;��� </summary>
    class operator Explicit(const rect: TRect2D): TRect;
    /// <summary> �ж��������Ƿ���� </summary>
    class operator Equal(const rect1, rect2: TRect2D): Boolean;
    /// <summary> �ж��������Ƿ񲻵� </summary>
    class operator NotEqual(const rect1, rect2: TRect2D): Boolean;
    /// <summary> �Ծ��ν������� </summary>
    class operator Divide(const pt: TRect2D; const coeff: Float): TRect2D;
    /// <summary> �Ծ��ν������� </summary>
    class operator Multiply(const pt: TRect2D; const coeff: Float): TRect2D; overload;
    /// <summary> �Ծ��ν������� </summary>
    class operator Multiply(const coeff: Float; const pt: TRect2D): TRect2D; overload;
  public
    case Integer of
      0: (TopLeft, BottomRight: TPoint2D);
      1: (ExtMin, ExtMax: TPoint2D);
      2: (Left, Top, Right, Bottom: Float)
  end;

  TAABB2D = TRect2D;

{$ENDREGION}

{$REGION ' Point functions '}

/// <summary> ����һ����ά�� </summary>
function Point2D(const X, Y: Float): TPoint2D; overload; inline;
/// <summary> ����һ��Z����Ϊ0����ά�� </summary>
function Point3D(const X, Y: Float): TPoint3D; overload; inline;
/// <summary> ����һ����ά�� </summary>
function Point3D(const X, Y, Z: Float): TPoint3D; overload; inline;

{$ENDREGION}

{$REGION ' ����������'}

  /// <summary> �ж������������Ƿ���� </summary>
  function fEqual(s1, s2: Single): Boolean; overload; inline;
  /// <summary> �ж������������Ƿ���� </summary>
  /// <param name="tolerance"> ������ </param>
  function fEqual(s1, s2, tolerance: Single): Boolean; overload; inline;
  /// <summary> �ж�����˫���ȸ������Ƿ���� </summary>
  function fEqual(d1, d2: Double): Boolean; overload; //inline;
  /// <summary> �ж�����˫���ȸ������Ƿ���� </summary>
  /// <param name="tolerance"> ������ </param>
  function fEqual(d1, d2, tolerance: Double): Boolean; overload; //inline;
  /// <summary> �ж�������չ���ȸ������Ƿ���� </summary>
  function fEqual(e1, e2: Extended): Boolean; overload; inline;
  /// <summary> �ж�������չ���ȸ������Ƿ���� </summary>
  /// <param name="tolerance"> ������ </param>
  function fEqual(e1, e2, tolerance: Extended): Boolean; overload; inline;

  /// <summary> �ж�������������С </summary>
  /// <returns> True= s1 > s2 </returns>
  function fGreat(s1, s2: Single): Boolean; overload;
  /// <summary> �ж�������������С </summary>
  /// <returns> True= s1 < s2 </returns>
  function fSmall(s1, s2: Single): Boolean; overload;

  /// <summary> �ж�����˫���ȸ�������С </summary>
  /// <returns> True= d1 > d2 </returns>
  function fGreat(d1, d2: Double): Boolean; overload;
  /// <summary> �ж�����˫���ȸ�������С </summary>
  /// <returns> True= d1 < d2 </returns>
  function fSmall(d1, d2: Double): Boolean; overload;

  /// <summary> �ж�������չ���ȸ�������С </summary>
  /// <returns> True= e1 > e2 </returns>
  function fGreat(e1, e2: Extended): Boolean; overload;
  /// <summary> �ж�������չ���ȸ�������С </summary>
  /// <returns> True= e1 < e2 </returns>
  function fSmall(e1, e2: Extended): Boolean; overload;

  /// <summary> ���һ�������Ĵ�С����֤����ָ����Χ�� </summary>
  /// <returns> True= ������ָ����Χ�� </returns>
  function CheckRange(var I: Integer; const iMin, iMax: Integer): Boolean; overload;
  /// <summary> ���һ���������Ĵ�С����֤����ָ����Χ�� </summary>
  /// <returns> True= ��������ָ����Χ�� </returns>
  function CheckRange(var S: Single; const sMin, sMax: Single): Boolean; overload;
  /// <summary> ���һ��˫�������Ĵ�С����֤����ָ����Χ�� </summary>
  /// <returns> True= ˫��������ָ����Χ�� </returns>
  function CheckRange(var S: Double; const sMin, sMax: Double): Boolean; overload;

  /// <summary> ����ȡ�� </summary>
  function Floorf(d: Single): Integer; overload;
  /// <summary> ����ȡ�� </summary>
  function Floorf(d: Double): Integer; overload;
  /// <summary> ����ȡ�� </summary>
  function Floorf(d: Extended): Integer; overload;

{$ENDREGION}

{$REGION ' ��������'}

const
  MinFloatEqual    = 1E-6;                  //������������ֵС�ڸ�ֵ����Ϊ���
  MinFloatEqualSqr = 1E-8;                  //
  DoublePI         = PI + PI;               //360��Ƕȣ�����Բ����
  HalfPI           = 0.5 * PI;              //90��Ƕ�, 0.5��Բ����
  OneOverDoublePI  = 0.5/PI;                //1/(2PI),
  RadToDegree      = 360 * OneOverDoublePI; //180/PI, ������Ƕ�ת��
  DegreeToRad      = PI/180;                //PI/180, �Ƕ��򻡶�ת��

  Org2D : TPoint2D = (X:0; Y:0);            //��ά���
  Origin2D : TPoint2D = (X:0; Y:0);         //��ά���
  Origin3D : TPoint3D = (X:0; Y:0; Z:0);    //��ά���
  WcsZero  : TPoint3D = (X:0; Y:0; Z:0);    //��ά���
  Dcs0     : TPoint2D = (X:0; Y:0);         //2ά���
  DcsX     : TPoint2D = (X:1; Y:0);         //2ά����X�ᵥλ����
  DcsY     : TPoint2D = (X:0; Y:1);         //2ά����Y�ᵥλ����
  Wcs0     : TPoint3D = (X:0; Y:0; Z:0);    //��ά���
  WcsX     : TPoint3D = (X:1; Y:0; Z:0);    //��ά����X�ᵥλ����
  WcsY     : TPoint3D = (X:0; Y:1; Z:0);    //��ά����Y�ᵥλ����
  WcsZ     : TPoint3D = (X:0; Y:0; Z:1);    //��ά����Z�ᵥλ����

  //��������ʽ���ַ���
  FloatFmtStr = '0.####';

  FloatTolerance   = 1E-5;                  //������������ֵС�ڸ�ֵ����Ϊ���
  SqrTolerance     = 1E-10;                 //ƽ����Ƚ�С�ڴ�ֵ��Ϊ���

{$ENDREGION}

implementation

uses
  Math;

{$REGION ' ���������� '}

function fEqual(s1, s2: Single): Boolean;
begin
  Result := Math.SameValue(s1, s2, FloatTolerance);
end;

function fEqual(s1, s2, tolerance: Single): Boolean;
begin
  Result := Math.SameValue(s1, s2, tolerance);
end;

function fEqual(d1, d2: Double): Boolean;
begin
  Result := Abs(d1-d2) < MinFloatEqual;
end;

function fEqual(d1, d2, tolerance: Double): Boolean;
begin
  Result := Abs(d1-d2) < tolerance;
end;

function fEqual(e1, e2: Extended): Boolean;
begin
  Result := Abs(e1-e2) < MinFloatEqual;
end;

function fEqual(e1, e2, tolerance: Extended): Boolean;
begin
  Result := Abs(e1-e2) < tolerance;
end;

function fGreat(s1, s2: Single): Boolean;
begin
  Result := s1 > MinFloatEqual + s2;
end;

function fSmall(s1, s2: Single): Boolean;
begin
  Result := s1 + MinFloatEqual < s2;
end;

function fGreat(d1, d2: Double): Boolean;
begin
  Result := d1 > MinFloatEqual + d2;
end;

function fSmall(d1, d2: Double): Boolean;
begin
  Result := d1 + MinFloatEqual < d2;
end;

function fGreat(e1, e2: Extended): Boolean;
begin
  Result := e1 > MinFloatEqual + e2;
end;

function fSmall(e1, e2: Extended): Boolean;
begin
  Result := e1 + MinFloatEqual < e2;
end;

function CheckRange(var I: Integer; const iMin, iMax: Integer): Boolean;
begin
  if I < iMin then
  begin
    I := iMin;
    Result := False;
  end
  else if I > iMax then
  begin
    I := iMax;
    Result := False;
  end
  else
    Result := True;
end;

function CheckRange(var S: Single; const sMin, sMax: Single): Boolean;
begin
  if S < sMin then
  begin
    S := sMin;
    Result := False;
  end
  else if S > sMax then
  begin
    S := sMax;
    Result := False;
  end
  else
    Result := True;
end;

function CheckRange(var S: Double; const sMin, sMax: Double): Boolean;
begin
  if S < sMin then
  begin
    S := sMin;
    Result := False;
  end
  else if S > sMax then
  begin
    S := sMax;
    Result := False;
  end
  else
    Result := True;
end;

function Floorf(d: Single): Integer;
begin
  Result := Floor(d + 1E-4);
end;

function Floorf(d: Double): Integer;
begin
  Result := Floor(d + 1E-6);
end;

function Floorf(d: Extended): Integer;
begin
  Result := Floor(d + 1E-8);
end;

{$ENDREGION}

{$REGION ' Points '}

  {$REGION ' TPoint2D '}

{ TPoint2D }

class operator TPoint2D.Add(const Pt1, Pt2: TPoint2D): TPoint2D;
begin
  Result.X := Pt1.X + Pt2.X;
  Result.Y := Pt1.Y + Pt2.Y;
end;

//����������X��ļнǣ���Χ[0 ~ DoublePI)
function TPoint2D.Angle: Float;
var
  t: Extended;
  m1, m2: Extended;
  e1, e2: Integer;
begin
  if (X = 0) then
  begin
    if Y > 0 then Exit(HalfPI) else Exit(DoublePI-HalfPI);
  end;
  if (Y = 0) then
  begin
    if X < 0 then Exit(PI) else Exit(0);
  end;

  // ȡβ���ͽ���
  Math.Frexp(X, m1, e1);
  Math.Frexp(Y, m2, e2);

  if Abs(e1 - e2) > 16 then  //��������16 (��ֵ���65536��)
  begin
    if (e1 > e2) then        //X�Ƚϴ�, ˮƽ
    begin
      if (m1 < 0) then Exit(PI) else Exit(0);
    end
    else begin               //Y�Ƚϴ�, ��ֱ
      if (m2 > 0) then Exit(HalfPI) else Exit(DoublePI-HalfPI);
    end;
  end
  else begin                 //�������16����
    m1 := Ldexp(m1, e1 - e2);
    t := m2 / m1;
    Result := ArcTan(t);
    if X < 0 then
      Result := Result + PI
    else if Result < 0 then
      Result := DoublePI + Result;
  end;
end;

constructor TPoint2D.Create(const X, Y: Float);
begin
  Self.X := X;
  Self.Y := Y;
end;

class function TPoint2D.Create: TPoint2D;
begin
  Result.X := 0;
  Result.Y := 0;
end;

function TPoint2D.CrossMul(const Pt2: TPoint2D): Extended;
begin
  Result := X * Pt2.Y - Y * Pt2.X;
end;

function TPoint2D.DistanceTo(const PtRef: TPoint2D): Float;
begin
  Result := (PtRef - Self).Mag;
end;

class operator TPoint2D.Divide(const Pt: TPoint2D; const coeff: Float): TPoint2D;
begin
  {$IFDEF DIV_BY_ZERO_PROTECT}
  if Abs(coeff) < FloatTolerance then
    raise EDividerTooSmall.CreateFmt(SNumberTooSmall, [coeff]);
  {$ENDIF}
  Result := Pt * (1 / coeff);
end;

function TPoint2D.DotMul(const Pt2: TPoint2D): Extended;
begin
  Result := X * Pt2.X + Y * Pt2.Y;
end;

class operator TPoint2D.Equal(const Pt1, Pt2: TPoint2D): Boolean;
begin
  Result := fEqual(Pt1.X, Pt2.X) and fEqual(Pt1.Y, Pt2.Y);
end;

class operator TPoint2D.Explicit(const value: Float): TPoint2D;
begin
  Result.X := value;
  Result.Y := value;
end;

function TPoint2D.ExtMax(const Pt2: TPoint2D): TPoint2D;
begin
  Result := Self;
  if Result.X < Pt2.X then
    Result.X := Pt2.X;
  if Result.Y < Pt2.Y then
    Result.Y := Pt2.Y;
end;

function TPoint2D.ExtMin(const Pt2: TPoint2D): TPoint2D;
begin
  Result := Self;
  if Result.X > Pt2.X then
    Result.X := Pt2.X;
  if Result.Y > Pt2.Y then
    Result.Y := Pt2.Y;
end;

class operator TPoint2D.Implicit(const Pt: Types.TPoint): TPoint2D;
begin
  Result.X := Pt.X;
  Result.Y := Pt.Y;
end;

function TPoint2D.IsParallelTo(const Vec: TPoint2D; Tol: Double): Boolean;
var
  sqrCrs, dm: Extended;
begin //2016.07.26 yxy, ������ƽ��
  sqrCrs := CrossMul(Vec);
  if (sqrCrs < -Tol) then Exit(False);
  dm := DotMul(Vec);
  sqrCrs := sqrCrs * sqrCrs;
  Result := (dm > 0) and (sqrCrs <= Tol * Tol * MagSqr * Vec.MagSqr);
end;

function TPoint2D.IsUnitLength: Boolean;
begin
  Result := fEqual(MagSqr, 1, SqrTolerance);
end;

function TPoint2D.IsZeroLength: Boolean;
begin
  Result := fEqual(MagSqr, 0, SqrTolerance);
end;

function TPoint2D.Mag: Float;
begin
  Result := Sqrt(MagSqr);
end;

function TPoint2D.MagSqr: Extended;
begin
  Result := X * X + Y * Y;
end;

procedure TPoint2D.MirrorBy(const APoint: TPoint2D);
var
  x1, y1: Float;
begin
  X1 := APoint.X + APoint.X - Self.X;
  Y1 := APoint.Y + APoint.Y - Self.Y;
  X := X1;
  Y := Y1;
end;

procedure TPoint2D.MirrorO;
begin
  X := -X;
  Y := -Y;
end;

procedure TPoint2D.MirrorX;
begin
  Y := -Y;
end;

procedure TPoint2D.MirrorY;
begin
  X := -X;
end;

class operator TPoint2D.Multiply(const coeff: Float; const Pt: TPoint2D): TPoint2D;
begin
  Result.X := Pt.X * coeff;
  Result.Y := Pt.Y * coeff;
end;

class operator TPoint2D.Multiply(const Pt: TPoint2D; const coeff: Float): TPoint2D;
begin
  Result.X := Pt.X * coeff;
  Result.Y := Pt.Y * coeff;
end;

class operator TPoint2D.Negative(const Pt: TPoint2D): TPoint2D;
begin
  Result.X := - Pt.X;
  Result.Y := - Pt.Y;
end;

class function TPoint2D.NewRandom: TPoint2D;
begin
  Result.X := Random(2000);
  Result.Y := Random(2000);
end;

function TPoint2D.Normal: TPoint2D;
begin
  Result := Self;
  Result.Normalize;
end;

procedure TPoint2D.Normalize;
var
  r: Extended;
  m1, m2: Extended;
  e1, e2: Integer;
begin
  if (X = 0) and (Y = 0) then Exit;

  // ȡβ���ͽ���
  Math.Frexp(X, m1, e1);
  Math.Frexp(Y, m2, e2);

  if Abs(e1 - e2) > 16 then  //��������16 (��ֵ���65536��)
  begin
    if (e1 > e2) then        //X�Ƚϴ�
    begin
      X := Sign(m1);
      Y := 0;
    end
    else begin               //Y�Ƚϴ�
      X := 0;
      Y := Sign(m2);
    end;
  end
  else begin                 //�������16����
    if e1 > e2 then
    begin
      X := Ldexp(m1, e1 - e2);
      Y := m2;
    end
    else begin
      X := m1;
      Y := Ldexp(m2, e2 - e1);
    end;
    r := Self.Mag;
    Assert(r < 1E6, 'r should less than 1E6 after normal exponent!');
    r := 1/r;
    X := X * r;
    Y := Y * r;
  end;
end;

class operator TPoint2D.NotEqual(const Pt1, Pt2: TPoint2D): Boolean;
begin
  Result := not fEqual(Pt1.X, Pt2.X) or not fEqual(Pt1.Y, Pt2.Y);
end;

class function TPoint2D.Orientation(const p1, p2, p3: TPoint2D): Integer;
var
  det: Extended;
begin
  // computes the orientation of points a, b, c, d as the sign
  //   of the determinant
  //  |x1, y1, 1 |
  //  |x2, y2, 1 |
  //  |x3, y3, 1 |
  det :=  p1.X * (p2.Y - p3.Y)
        + p1.Y * (p3.X - p2.X)
        + (p2.X * p3.Y - p2.Y * p3.X);
  Result := Sign(det);
end;

function TPoint2D.PerpVector: TPoint2D;
begin
  Result.Create(-Y, X);
end;

procedure TPoint2D.RotateBy(const PtCenter: TPoint2D; const Angle: Float);
var
  PtC: TPoint2D;
begin
  //ƽ��
  PtC := Self - PtCenter;

  //��ת
  PtC.RotateBy(Angle);

  //ƽ��
  Self := PtC + PtCenter;
end;

procedure TPoint2D.RotateBy(const Ang: Float);
var
  cosA, sinA: Extended;
  X1, Y1: Float;
begin
  Math.SinCos(Ang, sinA, cosA);
  X1 :=  X * cosA - Y * sinA;
  Y1 :=  X * sinA + Y * cosA;
  X := X1;
  Y := Y1;
end;

procedure TPoint2D.RotateBy90;
var
  temp: Float;
begin
  temp := X;
  X := - Y;
  Y := temp;
end;

procedure TPoint2D.RotateBy90(const PtCenter: TPoint2D);
var
  X1, Y1: Float;
begin
  X1 :=  PtCenter.X + PtCenter.Y - Y;
  Y1 := -PtCenter.X + PtCenter.Y + X;
  X := X1;
  Y := Y1;
end;

class operator TPoint2D.Subtract(const Pt1, Pt2: TPoint2D): TPoint2D;
begin
  Result.X := Pt1.X - Pt2.X;
  Result.Y := Pt1.Y - Pt2.Y;
end;

function TPoint2D.ToString: string;
begin
  Result := '(' + FormatFloat(FloatFmtStr, X) + ', ' +
                  FormatFloat(FloatFmtStr, Y) + ')';
end;

{$ENDREGION}

  {$REGION ' TPoint3D '}

{ TPoint3D }

class operator TPoint3D.Add(const Pt1: TPoint3D; const Pt2: TPoint2D): TPoint3D;
begin
  Result.X := Pt1.X + Pt2.X;
  Result.Y := Pt1.Y + Pt2.Y;
  Result.Z := Pt1.Z;
end;

class operator TPoint3D.Add(const Pt1, Pt2: TPoint3D): TPoint3D;
begin
  Result.X := Pt1.X + Pt2.X;
  Result.Y := Pt1.Y + Pt2.Y;
  Result.Z := Pt1.Z + Pt2.Z;
end;

function TPoint3D.AngleTo(const PtRef: TPoint3D): Float;
var
  cv: Float;
  ma, mb: Float;
begin
  ma := Self.Mag;
  mb := PtRef.Mag * ma;
  if (mb < FloatTolerance) then
  begin
    Result := 0;
    Exit;
  end;

  // A . B = |A| . |B| . Cos(theta)
  cv := Self.DotMul(PtRef);
  if (cv * SqrTolerance > mb) then
  begin
    // too near
    Result := 0;
  end
  else begin
    cv := cv /(mb);

    if (cv > 1) then
      cv := 1
    else if (cv < -1) then
      cv := -1;

    Result := ArcCos(cv);
  end;
end;

constructor TPoint3D.Create(const X, Y, Z: Float);
begin
  Self.X := X;
  Self.Y := Y;
  Self.Z := Z;
end;

class function TPoint3D.Create: TPoint3D;
begin
  Result.X := 0;
  Result.Y := 0;
  Result.Z := 0;
end;

function TPoint3D.CrossMul(const Pt2: TPoint3D): TPoint3D;
begin
  Result.X := Y * Pt2.Z - Z * Pt2.Y;
  Result.Y := Z * Pt2.X - X * Pt2.Z;
  Result.Z := X * Pt2.Y - Y * Pt2.X;
end;

function TPoint3D.DistanceTo(const PtRef: TPoint3D): Float;
begin
  Result := (PtRef - Self).Mag;
end;

function TPoint3D.DistanceXY(const PtRef: TPoint3D): Float;
begin
  Result := (PtRef - Self).MagXY;
end;

class operator TPoint3D.Divide(const Pt: TPoint3D; const coeff: Float): TPoint3D;
begin
  {$IFDEF DIV_BY_ZERO_PROTECT}
  if Abs(coeff) < FloatTolerance then
    raise EDividerTooSmall.CreateFmt(SNumberTooSmall, [coeff]);
  {$ENDIF}
  Result := Pt * ( 1 / coeff);
end;

function TPoint3D.DotMul(const Pt2: TPoint3D): Extended;
begin
  Result := X * Pt2.X + Y * Pt2.Y + Z * Pt2.Z;
end;

class operator TPoint3D.Equal(const Pt1, Pt2: TPoint3D): Boolean;
begin
  Result := fEqual(Pt1.X, Pt2.X) and
            fEqual(Pt1.Y, Pt2.Y) and
            fEqual(Pt1.Z, Pt2.Z);
end;

class operator TPoint3D.Equal(const Pt1: TPoint3D; const Pt2: TPoint2D): Boolean;
begin
  inherited;
  Result := fEqual(Pt1.X, Pt2.X) and
            fEqual(Pt1.Y, Pt2.Y) and
            fEqual(Pt1.Z, 0);
end;

function TPoint3D.Equals(const Pt2: TPoint3D; const tolerance: Float): Boolean;
begin
  Result := Pt2.DistanceTo(Self) < tolerance;
end;

function TPoint3D.Equals(const Pt2: TPoint3D): Boolean;
begin
  Result := Self = Pt2;
end;

class operator TPoint3D.Explicit(const Pt: TPoint3D): TPoint2D;
begin
  Result.X := Pt.X;
  Result.Y := Pt.Y;
end;

function TPoint3D.ExtMax(const Pt2: TPoint3D): TPoint3D;
begin
  Result := Self;
  if Result.X < Pt2.X then
    Result.X := Pt2.X;
  if Result.Y < Pt2.Y then
    Result.Y := Pt2.Y;
  if Result.Z < Pt2.Z then
    Result.Z := Pt2.Z;
end;

function TPoint3D.ExtMin(const Pt2: TPoint3D): TPoint3D;
begin
  Result := Self;
  if Result.X > Pt2.X then
    Result.X := Pt2.X;
  if Result.Y > Pt2.Y then
    Result.Y := Pt2.Y;
  if Result.Z > Pt2.Z then
    Result.Z := Pt2.Z;
end;

class operator TPoint3D.Implicit(const Pt: TPoint2D): TPoint3D;
begin
  Result.X := Pt.X;
  Result.Y := Pt.Y;
  Result.Z := 0;
end;

function TPoint3D.IsUnitLength: Boolean;
begin
  Result := fEqual(MagSqr, 1, SqrTolerance);
end;

function TPoint3D.IsZeroLength: Boolean;
begin
  Result := fEqual(MagSqr, 0, SqrTolerance);
end;

function TPoint3D.Mag: Float;
begin
  Result := Sqrt(MagSqr);
end;

function TPoint3D.MagSqr: Extended;
begin
  Result := X * X + Y * Y + Z * Z;
end;

function TPoint3D.MagXY: Float;
begin
  Result := Sqrt(X * X + Y * Y);
end;

procedure TPoint3D.MirrorBy(const APoint: TPoint3D);
begin
  X := APoint.X + APoint.X - X;
  Y := APoint.Y + APoint.Y - Y;
  Z := APoint.Z + APoint.Z - Z;
end;

procedure TPoint3D.MirrorO;
begin
  X := -X;
  Y := -Y;
  Z := -Z;
end;

procedure TPoint3D.MirrorX;
begin
  Y := -Y;
  Z := -Z;
end;

procedure TPoint3D.MirrorXOY;
begin
  Z := -Z;
end;

procedure TPoint3D.MirrorXOZ;
begin
  Y := -Y;
end;

procedure TPoint3D.MirrorY;
begin
  X := -X;
  Z := -Z;
end;

procedure TPoint3D.MirrorYOZ;
begin
  X := -X;
end;

procedure TPoint3D.MirrorZ;
begin
  X := -X;
  Y := -Y;
end;

class operator TPoint3D.Multiply(const coeff: Float; const Pt: TPoint3D): TPoint3D;
begin
  Result.X := Pt.X * coeff;
  Result.Y := Pt.Y * coeff;
  Result.Z := Pt.Z * coeff;
end;

class operator TPoint3D.Multiply(const Pt: TPoint3D; const coeff: Float): TPoint3D;
begin
  Result.X := Pt.X * coeff;
  Result.Y := Pt.Y * coeff;
  Result.Z := Pt.Z * coeff;
end;

class operator TPoint3D.Multiply(const Pt1, Pt2: TPoint3D): TPoint3D;
begin
  Result := Pt1.CrossMul(Pt2);
end;

class operator TPoint3D.Negative(const Pt: TPoint3D): TPoint3D;
begin
  Result.X := - Pt.X;
  Result.Y := - Pt.Y;
  Result.Z := - Pt.Z;
end;

function TPoint3D.Normal: TPoint3D;
begin
  Result := Self;
  Result.Normalize;
end;

procedure TPoint3D.Normalize;
var
  r: Float;
begin
  if (Abs(x) > 1E6) then
    Self := Self / Abs(x);
  if (Abs(y) > 1E6) then
    Self := Self / Abs(y);
  if (Abs(z) > 1E6) then
    Self := Self / Abs(z);

  r := Self.Mag;
  if (r > FloatTolerance) then
    Self := Self * (1/r)
  else
    Self.Create(1, 0, 0);
end;

class operator TPoint3D.NotEqual(const Pt1, Pt2: TPoint3D): Boolean;
begin
  Result := not (Pt1 = Pt2);
end;

procedure TPoint3D.RotateX(const Ang: Float);
var
  cosA, sinA: Extended;
  Y1, Z1: Float;
begin
  Math.SinCos(Ang, sinA, cosA);
  Y1 := Y * cosA - Z * sinA;
  Z1 := Y * sinA + Z * cosA;
  Y := Y1;
  Z := Z1;
end;

procedure TPoint3D.RotateY(const Ang: Float);
var
  cosA, sinA: Extended;
  X1, Z1: Float;
begin
  Math.SinCos(Ang, sinA, cosA);
  X1 := X * cosA + Z * sinA;
  Z1 :=-X * sinA + Z * cosA;
  X := X1;
  Z := Z1;
end;

procedure TPoint3D.RotateZ(const Ang: Float);
var
  cosA, sinA: Extended;
  X1, Y1: Float;
begin
  Math.SinCos(Ang, sinA, cosA);
  X1 :=  X * cosA - Y * sinA;
  Y1 :=  X * sinA + Y * cosA;
  X := X1;
  Y := Y1;
end;

function TPoint3D.RoundPoint: TPoint3D;
begin
  Result.X := Round(X);
  Result.Y := Round(Y);
  Result.Z := Round(Z);
end;

class operator TPoint3D.Subtract(const Pt1: TPoint3D; const Pt2: TPoint2D): TPoint3D;
begin
  Result.X := Pt1.X - Pt2.X;
  Result.Y := Pt1.Y - Pt2.Y;
  Result.Z := Pt1.Z;
end;

class operator TPoint3D.Subtract(const Pt1, Pt2: TPoint3D): TPoint3D;
begin
  Result.X := Pt1.X - Pt2.X;
  Result.Y := Pt1.Y - Pt2.Y;
  Result.Z := Pt1.Z - Pt2.Z;
end;

function TPoint3D.ToString: string;
begin
  //Result := Format(FmtStr, [X, Y, Z]);
  Result := '(' + FormatFloat(FloatFmtStr, X) + ', ' +
                  FormatFloat(FloatFmtStr, Y) + ', ' +
                  FormatFloat(FloatFmtStr, Z) + ')';
end;

{$ENDREGION}

  {$REGION ' Point functions '}

function Point2D(const X, Y: Float): TPoint2D;
begin
  Result.X := X;
  Result.Y := Y;
end;

function Point3D(const X, Y: Float): TPoint3D;
begin
  Result.X := X;
  Result.Y := Y;
  Result.Z := 0;
end;

function Point3D(const X, Y, Z: Float): TPoint3D;
begin
  Result.X := X;
  Result.Y := Y;
  Result.Z := Z;
end;

  {$ENDREGION}

{$ENDREGION}

{$REGION ' TRect2D '}

{ TRect2D }

function TRect2D.Area: Float;
begin
  Result := Abs(Width * Height);
end;

function TRect2D.BottomCenter: TPoint2D;
begin
  Result.Create((Left + Right) * 0.5, Bottom);
end;

function TRect2D.BottomLeft: TPoint2D;
begin
  Result.Create(Left, Bottom);
end;

function TRect2D.CenterPoint: TPoint2D;
begin
  Result := TopLeft + BottomRight;
  Result := Result * 0.5;
end;

constructor TRect2D.Create(const pt1, pt2: TPoint2D);
begin
  TopLeft := pt1;
  BottomRight := pt2;
end;

constructor TRect2D.Create(const Left, Top, Right, Bottom: Float);
begin
  TopLeft.Create(Left, Top);
  BottomRight.Create(Right, Bottom);
end;

procedure TRect2D.CreateNormalize(const pt1, pt2: TPoint2D);
begin
  TopLeft := pt1;
  BottomRight := pt2;

  Normalize;
end;

function TRect2D.CurveLength: Float;
begin
  Result := Abs(BottomRight.X - TopLeft.X) + Abs(BottomRight.Y - TopLeft.Y);
  Result := Result + Result;
end;

function TRect2D.DiagonalLength: Double;
begin
  Result := BottomRight.DistanceTo(TopLeft);
end;

class operator TRect2D.Divide(const pt: TRect2D; const coeff: Float): TRect2D;
begin
  Result.Left := pt.Left / coeff;
  Result.Right := pt.Right / coeff;
  Result.Top := pt.Top / coeff;
  Result.Bottom := pt.Bottom / coeff;
end;

class operator TRect2D.Equal(const rect1, rect2: TRect2D): Boolean;
begin
  inherited;
  Result := (rect1.TopLeft = rect2.TopLeft) and
            (rect1.BottomRight = rect2.BottomRight);
end;

class operator TRect2D.Explicit(const rect: TRect2D): TRect;
begin
  Result.Left := Round(rect.Left);
  Result.Top := Round(rect.Top);
  Result.Right := Round(rect.Right);
  Result.Bottom := Round(rect.Bottom);
end;

procedure TRect2D.Extend(const ptExt: TPoint2D);
begin
  TopLeft := ptExt.ExtMin(TopLeft);
  BottomRight := ptExt.ExtMax(BottomRight);
end;

procedure TRect2D.Extend(const ARect: Types.TRect);
begin
  if TopLeft.X > ARect.Left then
    TopLeft.X := ARect.Left;
  if TopLeft.X > ARect.Right then
    TopLeft.X := ARect.Right;

  if BottomRight.X < ARect.Left then
    BottomRight.X := ARect.Left;
  if BottomRight.X < ARect.Right then
    BottomRight.X := ARect.Right;

  if TopLeft.Y > ARect.Top then
    TopLeft.Y := ARect.Top;
  if TopLeft.Y > ARect.Bottom then
    TopLeft.Y := ARect.Bottom;

  if BottomRight.Y < ARect.Top then
    BottomRight.Y := ARect.Top;
  if BottomRight.Y < ARect.Bottom then
    BottomRight.Y := ARect.Bottom;
end;

procedure TRect2D.Extend(const ARect: TRect2D);
begin
  if TopLeft.X > ARect.TopLeft.X then
    TopLeft.X := ARect.TopLeft.X;
  if TopLeft.Y > ARect.TopLeft.Y then
    TopLeft.Y := ARect.TopLeft.Y;

  if BottomRight.X < ARect.BottomRight.X then
    BottomRight.X := ARect.BottomRight.X;
  if BottomRight.Y < ARect.BottomRight.Y then
    BottomRight.Y := ARect.BottomRight.Y;
end;

function TRect2D.Height: Float;
begin
  Result := BottomRight.Y - TopLeft.Y;
end;

class operator TRect2D.Implicit(const rect: Types.TRect): TRect2D;
begin
  Result.TopLeft := rect.TopLeft;
  Result.BottomRight := rect.BottomRight;
end;

procedure TRect2D.Inflate(const cx, cy: Float);
begin
  TopLeft.Create(Left - cx, Top - cy);
  BottomRight.Create(Right + cx, Bottom + cy);
end;

procedure TRect2D.Inflate(const ASize: TSize2D);
begin
  TopLeft.Create(Left - ASize.X, Top - ASize.Y);
  BottomRight.Create(Right + ASize.X, Bottom + ASize.Y);
end;

function TRect2D.InflatedRect(const cx, cy: Float): TRect2D;
begin
  Result.TopLeft.Create(Left - cx, Top - cy);
  Result.BottomRight.Create(Right + cx, Bottom + cy);
end;

function TRect2D.InflatedRect(const ASize: TSize2D): TRect2D;
begin
  Result.TopLeft.Create(Left - ASize.X, Top - ASize.Y);
  Result.BottomRight.Create(Right + ASize.X, Bottom + ASize.Y);
end;

function TRect2D.Intersect(const ARect: TRect2D): TRect2D;
begin
  Intersect(ARect, Result);
end;

function TRect2D.Intersect(const ARect: TRect2D; var outRect: TRect2D): Boolean;
begin
  if Left < ARect.Left then
    outRect.Left := ARect.Left
  else
    outRect.Left := Left;
  if Top < ARect.Top then
    outRect.Top := ARect.Top
  else
    outRect.Top := Top;
  if Right > ARect.Right then
    outRect.Right := ARect.Right
  else
    outRect.Right := Right;
  if Bottom > ARect.Bottom then
    outRect.Bottom := ARect.Bottom
  else
    outRect.Bottom := Bottom;

  Result := not outRect.IsEmpty; //rect1.IntersectWith(rect2);
end;

function TRect2D.IntersectWith(const ARect: TRect2D): Boolean;
var
  dummy: TRect2D;
begin
  Result := Intersect(ARect, dummy);
end;

function TRect2D.IsEmpty: Boolean;
begin
  Result := (TopLeft.X >= BottomRight.X) or (TopLeft.Y >= BottomRight.Y);
end;

function TRect2D.LeftCenter: TPoint2D;
begin
  Result.Create(Left, (Top + Bottom) * 0.5);
end;

class operator TRect2D.Multiply(const pt: TRect2D; const coeff: Float): TRect2D;
begin
  inherited;
  Result.Left := pt.Left * coeff;
  Result.Right := pt.Right * coeff;
  Result.Top := pt.Top * coeff;
  Result.Bottom := pt.Bottom * coeff;
end;

class operator TRect2D.Multiply(const coeff: Float; const pt: TRect2D): TRect2D;
begin
  inherited;
  Result.Left := pt.Left * coeff;
  Result.Right := pt.Right * coeff;
  Result.Top := pt.Top * coeff;
  Result.Bottom := pt.Bottom * coeff;
end;

procedure TRect2D.Normalize;
var
  T: Float;
begin
  if Left > Right then
  begin
    T := TopLeft.X;
    TopLeft.X := BottomRight.X;
    BottomRight.X := T;
  end;
  if Top > Bottom then
  begin
    T := TopLeft.Y;
    TopLeft.Y := BottomRight.Y;
    BottomRight.Y := T;
  end;
end;

function TRect2D.NormalizedRect: TRect2D;
begin
  Result := Self;
  Result.Normalize;
end;

class operator TRect2D.NotEqual(const rect1, rect2: TRect2D): Boolean;
begin
  inherited;
  Result := not (rect1 = rect2);
end;

procedure TRect2D.Offset(dx, dy: Float);
begin
  Top := Top + dy;
  Left := Left + dx;
  Bottom := Bottom + dy;
  Right := Right + dx;
end;

procedure TRect2D.Offset(const pt: TPoint2D);
begin
  TopLeft := TopLeft + pt;
  BottomRight := BottomRight + pt;
end;

function TRect2D.RightCenter: TPoint2D;
begin
  Result.Create(Right, (Top + Bottom) * 0.5);
end;

function TRect2D.Size: TSize2D;
begin
  Result.X := Width;
  Result.Y := Height;
end;

function TRect2D.TopCenter: TPoint2D;
begin
  Result.Create((Left + Right) * 0.5, Top);
end;

function TRect2D.TopRight: TPoint2D;
begin
  Result.Create(Right, Top);
end;

function TRect2D.ToString: string;
begin
  Result := Format('((%.2f, %.2f), (%.2f, %.2f))',
                   [TopLeft.X, TopLeft.Y, BottomRight.X, BottomRight.Y]);
end;

function TRect2D.Union(const ARect: TRect2D): TRect2D;
var
  lt, rb: TPoint2D;
  rect1, rect2: TRect2D;
begin
  rect1 := Self.NormalizedRect;
  rect2 := ARect.NormalizedRect;
  lt := rect1.TopLeft.ExtMin(rect2.TopLeft);
  rb := rect1.BottomRight.ExtMax(rect2.BottomRight);
  Result.Create(lt, rb);
end;

function TRect2D.Width: Float;
begin
  Result := BottomRight.X - TopLeft.X;
end;

{$ENDREGION}

end.
