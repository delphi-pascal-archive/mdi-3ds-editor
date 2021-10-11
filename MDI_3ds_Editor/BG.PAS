unit BG;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type

  TBGDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    GroupBox49: TGroupBox;
    BGColor: TShape;
    BG_R: TStaticText;
    BG_G: TStaticText;
    BG_B: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure BGColorMouseDown(Sender: TObject; Button: TMouseButton;
                                          Shift: TShiftState; X, Y: Integer);
    procedure CancelBtnClick(Sender: TObject);
  private
    BGColorSave: TColor;
  end;

var
  BGDlg: TBGDlg;

implementation

uses
  aiOGL, Data;

{$R *.DFM}

procedure TBGDlg.FormCreate(Sender: TObject);
begin
  ShowColor(CurScene.BG.ClearColor, BG_R, BG_G, BG_B, BGColor);
  BGColorSave:= CurScene.BG.ClearColor;
end;

procedure TBGDlg.BGColorMouseDown(Sender: TObject; Button: TMouseButton;
                                           Shift: TShiftState; X, Y: Integer);
begin
  Data1.ColorDialog.Color:= BGColor.Brush.Color;
  if Data1.ColorDialog.Execute then
    begin
      ShowColor(Data1.ColorDialog.Color, BG_R, BG_G, BG_B, BGColor);
      CurScene.BG.ClearColor:= BGColor.Brush.Color;
      CurScene.Paint;
    end;
end;

procedure TBGDlg.CancelBtnClick(Sender: TObject);
begin
  CurScene.BG.ClearColor:= BGColorSave;
  CurScene.Paint;
end;

end.
