unit Materials;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, aiOGL, ExtCtrls, Data, Buttons;

type
  TMaterialsForm = class(TForm)
    GroupBox4: TGroupBox;
    MatBox: TListBox;
    MaterialBox: TGroupBox;
    ColorBox: TGroupBox;
    GroupBox3: TGroupBox;
    Amb: TShape;
    AmbR: TStaticText;
    AmbG: TStaticText;
    AmbB: TStaticText;
    GroupBox5: TGroupBox;
    Diff: TShape;
    DiffR: TStaticText;
    DiffG: TStaticText;
    DiffB: TStaticText;
    GroupBox6: TGroupBox;
    Spec: TShape;
    SpecR: TStaticText;
    SpecG: TStaticText;
    SpecB: TStaticText;
    GroupBox7: TGroupBox;
    Emis: TShape;
    EmisR: TStaticText;
    EmisG: TStaticText;
    EmisB: TStaticText;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label12: TLabel;
    MatTranspEdit: TEdit;
    Shin: TEdit;
    AssignBtn: TBitBtn;
    Button: TBitBtn;
    DeleteBtn: TBitBtn;
    Label1: TLabel;
    TextureBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure MatBoxClick(Sender: TObject);
    procedure AssignBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MaterialsForm: TMaterialsForm;

implementation

uses Objects;

{$R *.DFM}

procedure TMaterialsForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  with CurScene do
    for i:= 0 to Materials.MatCount - 1 do
      MatBox.Items.AddObject(Materials[i].Name, Materials[i]);
  MatBox.ItemIndex:= 0;
  MatBoxClick(Nil);
  MaterialBox.Visible:= CurScene.Materials.MatCount <> 0;
end;

procedure TMaterialsForm.MatBoxClick(Sender: TObject);
begin
  if MatBox.ItemIndex = -1 then
    Exit;
    with TMaterial(MatBox.Items.Objects[MatBox.ItemIndex]) do
      begin
        MaterialBox.Caption:= Name;
        ShowColor(Ambient, AmbR, AmbG, AmbB, Amb);
        ShowColor(Diffuse, DiffR, DiffG, DiffB, Diff);
        ShowColor(Specular, SpecR, SpecG, SpecB, Spec);
        ShowColor(Emission, EmisR, EmisG, EmisB, Emis);
        Shin.Text:= Format('%.2f', [Shininess]);
        MatTranspEdit.Text:= IntToStr(Transparent);
        if Assigned(Texture) then
          TextureBtn.Caption:= ExtractFileName(Texture.FileName) else
          TextureBtn.Caption:= 'No texture';
    end;
end;

procedure TMaterialsForm.AssignBtnClick(Sender: TObject);
var
  Material: TMaterial;
begin
  if MatBox.ItemIndex = -1 then
    Exit;
  with ObjectsDlg do
    begin
      with Self.MatBox do
        Material:= TMaterial(Items.Objects[ItemIndex]);
      if (CurObject <> nil) and (Self.MatBox.ItemIndex <> -1) then
        CurObject.FaceGroups[MatBox.ItemIndex].Material:= Material;
      with MatBox do
        Items[ItemIndex]:= Material.Name;
      CurMaterial:= Material;
      CurObject.Render;
    end;
  CurScene.Paint;
  ModalResult:= mrOK;
end;

procedure TMaterialsForm.DeleteBtnClick(Sender: TObject);
begin
  if MatBox.ItemIndex = -1 then
    Exit;
  with MatBox do
    if MessageDlg('Delete material "' + Items[ItemIndex] + '" ?' , mtConfirmation,
                                                [mbYes, mbNo], 0) = mrNo then
      Exit;                                          

  CurScene.Materials.DeleteMaterialI(MatBox.ItemIndex);
  CurScene.Render;
  CurScene.Paint;
  MatBox.Items.Clear;
  FormCreate(Sender);
  if Assigned(ObjectsDlg) then
    ObjectsDlg.ObjectsBoxClick(Sender);
end;

end.
