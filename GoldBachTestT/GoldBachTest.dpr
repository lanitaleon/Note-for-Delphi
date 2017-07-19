program GoldBachTest;

{$APPTYPE CONSOLE}
uses
  SysUtils,
  Math,
  Variants,
  Dialogs,
  Windows;

var
  Head, Tail, Sum: Int64;
  FNum: Int64;
  Index: Int64;
  PrimeSheet: array of Int64;
  OldTime: TDateTime;

function IsPrime(ANum: Int64): Boolean;         // 判断一个数是否为质数
var
  SqrtOfANum: Int64;
  J: Integer;
begin
  try
    Result := False;
    SqrtOfANum := Trunc(Sqrt(ANum)) + 1;
    for  J := 1 to Index - 1 do
      begin
        if ANum mod PrimeSheet[J] = 0  then
          Break;
        if PrimeSheet[J] >= SqrtOfANum then
        begin
          Result := True;
          Break;
        end;
      end;
  except
    outputdebugstring(PChar(FormatDateTime('hh:mm:ss.zzz', Now - OldTime)));
  end;
end;

procedure SetArrayLength;
begin
  if Index >= Length(PrimeSheet) - 1 then
  SetLength(PrimeSheet, Length(PrimeSheet) + 1000);
end;

begin
  OldTime := Now;
  FNum := 6;
  Index := 3;
  SetLength(PrimeSheet, 3);
  PrimeSheet := VarArrayOf([2, 3, 5]);
  while FNum <= Power(2, 32) - 1 do
  begin
    Inc(FNum, 2);
    SetArrayLength;
    if IsPrime(FNum - 1) then
    begin
      PrimeSheet[Index] := FNum - 1;
      Inc(Index);
    end;
    Head := 0;
    Tail := Index - 1;
    repeat
      Sum := PrimeSheet[Head] + PrimeSheet[Tail];
      if Sum > FNum then
        Dec(Tail)
      else if Sum < FNum then
        Inc(Head)
    until Sum = FNum;
    if FNum mod 1000000 = 0 then                    // 每隔 1000000 打印一次结果
    begin
      Writeln(Format('%d = %d + %d',[FNum, PrimeSheet[Head], PrimeSheet[Tail]]));
      if FNum > 2100000000 then
        Writeln(FormatDateTime('hh:mm:ss.zzz', Now - OldTime));
    end;
  end;
  Writeln(FNum);
  outputdebugstring(PChar(FormatDateTime('hh:mm:ss.zzz', Now - OldTime)));
  Readln;
end.


