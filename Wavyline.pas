unit Wavyline;

interface

uses Graphics, Windows;

const
  RequiredColor = $AAAAFF;//��������ʾ��ɫ

procedure DrawWaveLine4W(ACanvas: TCanvas; Bottom: Integer; Right: Integer);
procedure DrawWaveLine3W(ACanvas: TCanvas; Bottom: Integer; Right: Integer);
procedure DrawWaveLine3V(ACanvas: TCanvas; Bottom: Integer; Right: Integer);
procedure DrawWaveLine3R(ACanvas: TCanvas; Bottom: Integer; Right: Integer); overload;
procedure DrawWaveLine3R(DC: HDC; Bottom: Integer; Right: Integer); overload;
procedure DrawWaveLine2R(ACanvas: TCanvas; Bottom: Integer; Right: Integer); overload;
procedure DrawWaveLine2R(DC: HDC; Bottom: Integer; Right: Integer); overload;

implementation



//����VVV�Ͳ����ߣ�\/\/\/\/\/\/\/�������4px
procedure DrawWaveLine4W(ACanvas: TCanvas; Bottom: Integer; Right: Integer);
var
  i: integer;
begin
  i := 1;
  ACanvas.MoveTo(i, Bottom - 3);
  while i < Right - 1 do begin
    i := i + 3;
    ACanvas.LineTo(i, Bottom - (i mod 2)*3);
  end;
end;

//����VVV�Ͳ����ߣ�\/\/\/\/\/\/\/�������3px
procedure DrawWaveLine3W(ACanvas: TCanvas; Bottom: Integer; Right: Integer);
var
  i: integer;
begin
  i := 1;
  ACanvas.MoveTo(i, Bottom);
  while i < Right - 1 do begin
    i := i + 2;
    ACanvas.LineTo(i, Bottom - (i and $02)*1);
  end;
end;

//                      ___     ___
//����Բ���Ͳ����ߣ�___/   \___/   \�������3px
procedure DrawWaveLine3V(ACanvas: TCanvas; Bottom: Integer; Right: Integer);
var
  i: integer;
begin
  i := 1;
  ACanvas.MoveTo(i, Bottom);
  while i < Right - 1 do begin
    ACanvas.LineTo(i + 2, Bottom - ((i and $04) shr 1));
    i := i + 4;
    ACanvas.LineTo(i, Bottom - ((i and $04) shr 1));
  end;
end;

//                     __    __
//����Բ���Ͳ����ߣ�__/  \__/  \�������3px
procedure DrawWaveLine3R(ACanvas: TCanvas; Bottom: Integer; Right: Integer); overload;
var
  i: integer;
begin
  i := 1;
  ACanvas.MoveTo(i, Bottom - 2);
  while i < Right - 1 do begin
    ACanvas.LineTo(i + 1, Bottom - ((i and $01) * 2));
    i := i + 3;
    ACanvas.LineTo(i, Bottom - ((i and $01) * 2));
  end;
end;

procedure DrawWaveLine3R(DC: HDC; Bottom: Integer; Right: Integer); overload;
var
  i: integer;
  APen: TPen;
  H: HGDIOBJ;
begin
  APen := TPen.Create;
  try
    APen.Color := RequiredColor;
    APen.Style := psDot;
    H := SelectObject(DC, APen.Handle);
    try
      i := 1;
      MoveToEx(DC, i, Bottom - 2, nil);
      while i < Right do begin
        LineTo(DC, i + 1, Bottom - ((i and $01) * 2));
        i := i + 3;
        LineTo(DC, i, Bottom - ((i and $01) * 2));
      end;
    finally
      SelectObject(DC, H);
    end;
  finally
    APen.Free;
  end;
end;

//����Բ���Ͳ����ߣ�__--__--�������2px
procedure DrawWaveLine2R(ACanvas: TCanvas; Bottom: Integer; Right: Integer); overload;
var
  i: integer;
begin
  i := 1;
  ACanvas.MoveTo(i, Bottom - 1);
  while i < Right do begin
    ACanvas.LineTo(i + 2, Bottom - (i and $1));
    i := i + 3;
  end;
end;

procedure DrawWaveLine2R(DC: HDC; Bottom: Integer; Right: Integer); overload;
var
  i: integer;
  APen: TPen;
  H: HGDIOBJ;
begin
  APen := TPen.Create;
  try
    APen.Color := RequiredColor;
    APen.Style := psDot;
    H := SelectObject(DC, APen.Handle);
    try
      i := 1;
      MoveToEx(DC, i, Bottom - 1, nil);
      while i < Right do begin
        LineTo(DC, i + 2, Bottom - (i and $1));
        i := i + 3;
      end;
    finally
      SelectObject(DC, H);
    end;
  finally
    APen.Free;
  end;
end;

end.
