unit Perspective;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons;

type
  TPerspectiveForm = class(TForm)
    Panel1: TPanel;
    OKBtn: TBitBtn;
    ApplyBtn: TButton;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    ZFarEdit: TEdit;
    ZNearEdit: TEdit;
    AspectEdit: TEdit;
    FovEdit: TEdit;
    AutoBox: TCheckBox;
    BitBtn1: TBitBtn;
    procedure ApplyBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure AutoBoxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    fovySave, AspectSave, zNearSave, zFarSave: single;
    AutoAspectSave: boolean;
  end;

var
  PerspectiveForm: TPerspectiveForm;

implementation

uses
  aiOGL;

{$R *.DFM}

procedure TPerspectiveForm.FormCreate(Sender: TObject);
begin
  with CurScene do
    begin
      fovySave:= fovy; AspectSave:= Aspect; zNearSave:= zNear; zFarSave:= zFar;
      FovEdit.Text:=    Format('%f', [fovy]);
      AspectEdit.Text:= Format('%f', [Aspect]);
      ZNearEdit.Text:=  Format('%f', [zNear]);
      ZFarEdit.Text:=   Format('%f', [zFar]);
      AutoAspectSave:= AutoAspect;
      AutoBox.Checked:= AutoAspect;
    end;
end;

procedure TPerspectiveForm.ApplyBtnClick(Sender: TObject);
begin
  with CurScene do
    begin
      fovy:= StrToFloat(FovEdit.Text);
      Aspect:= StrToFloat(AspectEdit.Text);
      zNear:= StrToFloat(zNearEdit.Text);
      zFar:=  StrToFloat(zFarEdit.Text);
      Perspective;
      Paint;
    end;
end;

procedure TPerspectiveForm.OKBtnClick(Sender: TObject);
begin
  ApplyBtnClick(Sender);
end;

procedure TPerspectiveForm.AutoBoxClick(Sender: TObject);
begin
  AspectEdit.Enabled:= not AutoBox.Checked;
  CurScene.AutoAspect:= AutoBox.Checked;
  AspectEdit.Text:= Format('%f', [CurScene.Aspect]);
end;

procedure TPerspectiveForm.BitBtn1Click(Sender: TObject);
begin
  with CurScene do
    begin
      fovy:= fovySave; Aspect:= AspectSave; zNear:= zNearSave; zFar:= zFarSave;
      AutoAspect:= AutoAspectSave;
      Paint;
    end;
end;

end.


