//  наверное, многие пмсали в своих программах строки вроде таких:
//   glEnable(GL_LINE_SMOOTH); glEnable(GL_POLYGON_SMOOTH);
//  glHint(GL_LINE_SMOOTH_HINT, GL_NICEST);  glHint(GL_POLYGON_SMOOTH_HINT, GL_NICEST);
// но я не видел от них никакого эффекта. Здесь для сглаживания используется jitter(дрожание).
// Параметры - количество проходов сглаживания и Value - так сказать, величина размытия.
// При большом кол-ве проходов сглаживания весьма замедляется скорость рисования


unit Jitter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, aiOGL;

type
  TJitterForm = class(TForm)
    RG: TRadioGroup;
    EnabledBox: TCheckBox;
    Panel1: TPanel;
    Bar: TScrollBar;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    ST: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure EnabledBoxClick(Sender: TObject);
    procedure RGClick(Sender: TObject);
    procedure BarChange(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    SaveJitter: TJitter;
  public
    { Public declarations }
  end;

var
  JitterForm: TJitterForm;

implementation

{$R *.DFM}

procedure TJitterForm.FormCreate(Sender: TObject);
begin
  SaveJitter:= CurScene.Jitter;
  with CurScene.Jitter do
    begin
      EnabledBox.Checked:= Enabled;           
      Bar.Enabled:= Enabled;
      RG.Enabled:= Enabled;
      ST.Caption:= IntToStr(Value);
      Bar.Position:= Value;
      case PassCount of
        2: RG.ItemIndex:= 0;
        3: RG.ItemIndex:= 1;
        4: RG.ItemIndex:= 2;
        8: RG.ItemIndex:= 3;
        15: RG.ItemIndex:= 4;
        24: RG.ItemIndex:= 5;
        66: RG.ItemIndex:= 6;
      end;
    end;
end;

procedure TJitterForm.EnabledBoxClick(Sender: TObject);
begin
  CurScene.Jitter.Enabled:= EnabledBox.Checked;
  Bar.Enabled:= EnabledBox.Checked;
  RG.Enabled:= EnabledBox.Checked;
  CurScene.Paint;
end;

procedure TJitterForm.RGClick(Sender: TObject);
begin
  with CurScene.Jitter do
    case RG.ItemIndex of
        0: PassCount:= 2;
        1: PassCount:= 3;
        2: PassCount:= 4;
        3: PassCount:= 8;
        4: PassCount:= 15;
        5: PassCount:= 24;
        6: PassCount:= 66;
    end;
  CurScene.Paint;
end;

procedure TJitterForm.BarChange(Sender: TObject);
begin
  ST.Caption:= IntToStr(Bar.Position);
  CurScene.Jitter.Value:= Bar.Position;
  CurScene.Paint;
end;

procedure TJitterForm.BitBtn2Click(Sender: TObject);
begin
  CurScene.Jitter:= SaveJitter;
  CurScene.Paint;
end;

end.
