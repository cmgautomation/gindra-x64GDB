unit mainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  strutils;

type

  { TForm1 }

  TForm1 = class(TForm)
    Bt_GtoX: TButton;
    Bt_GX64toG: TButton;
    Bt_start: TButton;
    ed_ghindra: TEdit;
    ed_ghindra_entryPoint: TEdit;
    ed_X64GDB: TEdit;
    ed_entryPoint: TEdit;
    ed_X64GDB_entryPoint: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Panel1: TPanel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    procedure Bt_GtoXClick(Sender: TObject);
    procedure Bt_GX64toGClick(Sender: TObject);
    procedure Bt_startClick(Sender: TObject);
  private
    differenza, indirizzoX, indirizzoG: int64;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }


function Hex2Dec(hexVal: string): int64;
var
  i: integer;
  base: int64;
  err: boolean;
  ch: char;
begin
  hexVal := trim(hexVal);
  base := 1; // Initializing base value to 1, i.e 16^0
  Result := 0;
  for i := Length(hexVal) downto 1 do
  begin
    //per escludere i caratteri non previsti
    err := False;
    ch := hexVal[i];
    case ch of
      '0': ;
      '1': Result := Result + base;
      '2': Result := Result + 2 * base;
      '3': Result := Result + 3 * base;
      '4': Result := Result + 4 * base;
      '5': Result := Result + 5 * base;
      '6': Result := Result + 6 * base;
      '7': Result := Result + 7 * base;
      '8': Result := Result + 8 * base;
      '9': Result := Result + 9 * base;
      'a', 'A': Result := Result + 10 * base;
      'b', 'B': Result := Result + 11 * base;
      'c', 'C': Result := Result + 12 * base;
      'd', 'D': Result := Result + 13 * base;
      'e', 'E': Result := Result + 14 * base;
      'f', 'F': Result := Result + 15 * base;
      else
        Err := True;
    end;
    if not err then  base := base * 16;
  end;
end;



function Dec2Hex(n: int64): string;
var
  ans: string;
  i: integer;
  rem: int64;
begin
  ans := '';
  while n <> 0 do
  begin
    rem := n mod 16;
    case rem of
      0: ans := ans + '0';
      1: ans := ans + '1';
      2: ans := ans + '2';
      3: ans := ans + '3';
      4: ans := ans + '4';
      5: ans := ans + '5';
      6: ans := ans + '6';
      7: ans := ans + '7';
      8: ans := ans + '8';
      9: ans := ans + '9';
      10: ans := ans + 'A';
      11: ans := ans + 'B';
      12: ans := ans + 'C';
      13: ans := ans + 'D';
      14: ans := ans + 'E';
      15: ans := ans + 'F';
    end;
    n := n div 16;
  end;
  // reversing the ans string to get the final ans

  Result := '';
  for  i := Length(ans) downto 1 do
    Result := Result + ans[i];
end;

procedure TForm1.Bt_GtoXClick(Sender: TObject);
begin
  indirizzoG := Hex2Dec(ed_ghindra.Text);
  indirizzoX := indirizzoG + differenza;
  ed_X64GDB.Text := IntToHex(indirizzoX);
end;

procedure TForm1.Bt_GX64toGClick(Sender: TObject);
begin
  indirizzoX := Hex2Dec(ed_X64GDB.Text);
  indirizzoG := indirizzoX - differenza;
  ed_ghindra.Text := IntToHex(indirizzoG);
end;

procedure TForm1.Bt_startClick(Sender: TObject);
begin
  indirizzoG := Hex2Dec(ed_ghindra_entryPoint.Text);
  indirizzoX := Hex2Dec(ed_X64GDB_entryPoint.Text);
  differenza := indirizzoX - indirizzoG;
  ed_entryPoint.Text := Dec2Hex(differenza);
  Label7.Caption := Dec2Hex(indirizzoX);
  Label6.Caption := Dec2Hex(indirizzoG);
end;

end.
