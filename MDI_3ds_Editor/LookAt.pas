unit LookAt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, aiOGL;

type
  TLookAtForm = class(TForm)
    Panel1: TPanel;
    OKBtn: TBitBtn;
    ApplyBtn: TButton;
    EyeBox: TGroupBox;
    Label3: TLabel;
    Label1: TLabel;
    EyeYEdit: TEdit;
    Label2: TLabel;
    EyeZEdit: TEdit;
    EyeXEdit: TEdit;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    RefYEdit: TEdit;
    RefZEdit: TEdit;
    RefXEdit: TEdit;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    UpYEdit: TEdit;
    UpZEdit: TEdit;
    UpXEdit: TEdit;
    CancelBtn: TBitBtn;
    procedure ApplyBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
  private
    EyePointSave, RefPointSave, UpVectorSave: TVector;
  end;

var
  LookAtForm: TLookAtForm;

implementation

uses
  Data;

{$R *.DFM}

procedure TLookAtForm.FormCreate(Sender: TObject);
begin
  with CurScene do
    begin
      EyePointSave:= EyePoint; RefPointSave:= RefPoint; UpVectorSave:= UpVector;
      ShowVector(EyePoint, EyeXEdit, EyeYEdit, EyeZEdit);
      ShowVector(RefPoint, RefXEdit, RefYEdit, RefZEdit);
      ShowVector(UpVector, UpXEdit,  UpYEdit,  UpZEdit);
    end;
end;

procedure TLookAtForm.ApplyBtnClick(Sender: TObject);
begin
  with CurScene do
    begin                  
      EyePoint:= GetVector(EyeXEdit, EyeYEdit, EyeZEdit);
      RefPoint:= GetVector(RefXEdit, RefYEdit, RefZEdit);
      UpVector:= GetVector(UpXEdit,  UpYEdit,  UpZEdit);
      LookAt;
      Paint;
    end;
end;

procedure TLookAtForm.OKBtnClick(Sender: TObject);
begin
  ApplyBtnClick(Sender);
end;

procedure TLookAtForm.CancelBtnClick(Sender: TObject);
begin
  with CurScene do
    begin
      EyePoint:= EyePointSave; RefPoint:= RefPointSave; UpVector:= UpVectorSave;
      LookAt;
      Paint;
    end;
end;

end.
