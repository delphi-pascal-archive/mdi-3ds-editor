unit Objects;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, Dialogs,
    Buttons, ExtCtrls, Grids, aiOGL;

type
  TObjectsDlg = class(TForm)
    GroupBox1: TGroupBox;
    ObjectsBox: TListBox;
    GroupBox4: TGroupBox;
    MatBox: TListBox;
    MappedLabel: TLabel;
    CloseBtn: TBitBtn;
    DelBtn: TButton;
    ObjectBox: TGroupBox;
    VisibleBox: TCheckBox;
    BoundingBox: TCheckBox;
    FrozenBox: TCheckBox;
    RenameBtn: TButton;
    Label1: TLabel;
    Label2: TLabel;
    VertCountLabel: TLabel;
    FacesCountLabel: TLabel;
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
    MatTranspEdit: TEdit;
    Shin: TEdit;
    Label12: TLabel;
    Label3: TLabel;
    TexFileNameLabel: TLabel;
    TextureBtn: TBitBtn;
    PMBox: TComboBox;
    Label5: TLabel;
    CheckBox1: TCheckBox;
    SourceRG: TRadioGroup;
    DestRG: TRadioGroup;
    MoreBtn: TButton;
    AssignMat: TSpeedButton;
    procedure ObjectsBoxClick(Sender: TObject);
    procedure VisibleBoxClick(Sender: TObject);
    procedure BoundingBoxClick(Sender: TObject);
    procedure FrozenBoxClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RenameBtnClick(Sender: TObject);
    procedure MatBoxClick(Sender: TObject);
    procedure AmbMouseDown(Sender: TObject; Button: TMouseButton;
                                           Shift: TShiftState; X, Y: Integer);
    procedure TextureBtnClick(Sender: TObject);
    procedure ShinChange(Sender: TObject);
    procedure MatTranspEditChange(Sender: TObject);
    procedure PMBoxChange(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure SourceRGClick(Sender: TObject);
    procedure DestRGClick(Sender: TObject);
    procedure MoreBtnClick(Sender: TObject);
    procedure AssignMatClick(Sender: TObject);
  private
    FCurObject: TGLObject;
    FCurMaterial: TMaterial;
    procedure SetCurObject(ACurObject: TglObject);
    procedure SetCurMaterial(ACurMaterial: TMaterial);
  public
// текущий объект
    property CurObject: TGLObject read FCurObject write SetCurObject;
// текущий материал
    property CurMaterial: TMaterial read FCurMaterial write SetCurMaterial;
// вызывает Render для объекта при необходимости
    procedure ReRenderObjects;
  end;

var
  ObjectsDlg: TObjectsDlg;

implementation

uses
  Data, OpenGL, Texture, Materials;

{$R *.DFM}

procedure TObjectsDlg.FormCreate(Sender: TObject);
var
  i: integer;
begin
  Width:= MaterialBox.Left + MaterialBox.Width;
// заносим имена объектов в ObjectsBox
  with CurScene do
    for i:= 0 to ObjectCount - 1 do
      ObjectsBox.Items.AddObject(Objects[i].Name, Objects[i]);
  ObjectsBox.ItemIndex:= 0;
  ObjectsBoxClick(Sender);

 // CheckBox1.Checked:= DisableDepthTest;
{  case BlendSourceFactor of
    GL_ZERO: SourceRG.ItemIndex:= 0; GL_ONE:  SourceRG.ItemIndex:= 1;
    GL_DST_COLOR:  SourceRG.ItemIndex:= 2; GL_ONE_MINUS_DST_COLOR: SourceRG.ItemIndex:= 3;
    GL_SRC_ALPHA:  SourceRG.ItemIndex:= 4; GL_ONE_MINUS_SRC_ALPHA: SourceRG.ItemIndex:= 5;
    GL_DST_ALPHA:  SourceRG.ItemIndex:= 6; GL_ONE_MINUS_DST_ALPHA: SourceRG.ItemIndex:= 7;
    GL_SRC_ALPHA_SATURATE:  SourceRG.ItemIndex:= 8;
  end;

  case BlendDestFactor of
    GL_ZERO: DestRG.ItemIndex:= 0; GL_ONE:  DestRG.ItemIndex:= 1;
    GL_SRC_COLOR:  DestRG.ItemIndex:= 2; GL_ONE_MINUS_SRC_COLOR: DestRG.ItemIndex:= 3;
    GL_SRC_ALPHA:  DestRG.ItemIndex:= 4; GL_ONE_MINUS_SRC_ALPHA: DestRG.ItemIndex:= 5;
    GL_DST_ALPHA:  DestRG.ItemIndex:= 6; GL_ONE_MINUS_DST_ALPHA: DestRG.ItemIndex:= 7;
  end; }
end;

procedure TObjectsDlg.SetCurObject(ACurObject: TglObject);
var
  b: boolean;
  i: integer;
begin
  MatBox.Items.Clear;
  b:= not(ACurObject = nil);
  ObjectBox.Visible:= b; MaterialBox.Visible:= b; GroupBox4.Visible:= b;
  RenameBtn.Visible:= b; DelBtn.Visible:= b; MappedLabel.Visible:= b;
  if ACurObject <> nil then
    with ACurObject do
    begin
//  получить список материалов объекта
      for i:= 0 to FaceGroupCount - 1 do
        if FaceGroups[i].Material = nil then
          MatBox.Items.AddObject('DEFAULT', Nil) else
          MatBox.Items.AddObject(FaceGroups[i].Material.Name, FaceGroups[i].Material);
      MatBox.ItemIndex:= 0;

      if Mapped then                  //   есть ли текстурные координаты
        MappedLabel.Caption:= 'Mapped' else
        MappedLabel.Caption:= 'Not' + #13#10 +'Mapped';
      VisibleBox.Checked:= Visible;
      BoundingBox.Checked:= Bounding;
      FrozenBox.Checked:= Frozen;
      VertCountLabel.Caption:= IntToStr(VertexCount);
      FacesCountLabel.Caption:= IntToStr(FaceCount);
      PMBox.ItemIndex:= GL_FILL - PolygonMode;
    end;
  FCurObject:= ACurObject;
  if (CurObject = nil) or (CurObject.FaceGroupCount = 0) then
    CurMaterial:= Nil else
    if CurObject.FaceGroups[0].Material = nil then
      CurMaterial:= Nil  else
      CurMaterial:= CurObject.FaceGroups[0].Material;
end;

procedure TObjectsDlg.SetCurMaterial(ACurMaterial: TMaterial);
begin
  MaterialBox.Visible:= ACurMaterial <> nil; Label3.Visible:= ACurMaterial <> nil;
  TexFileNameLabel.Visible:= ACurMaterial <> nil; TextureBtn.Visible:= ACurMaterial <> nil;
  if ACurMaterial <> nil then
    with ACurMaterial do
      begin
        MaterialBox.Caption:= Name;
// ShowColor(Color: TColor; C1,C2,C3: TControl; Shape: TControl)
        ShowColor(Ambient, AmbR, AmbG, AmbB, Amb);
        ShowColor(Diffuse, DiffR, DiffG, DiffB, Diff);
        ShowColor(Specular, SpecR, SpecG, SpecB, Spec);
        ShowColor(Emission, EmisR, EmisG, EmisB, Emis);
        Shin.Text:= Format('%.2f', [Shininess]);
        MatTranspEdit.Text:= IntToStr(Transparent);
        if ACurMaterial.Texture = nil then
          TexFileNameLabel.Caption:= 'No texture' else
          TexFileNameLabel.Caption:= ExtractFileName(ACurMaterial.Texture.FileName);
    end;
  FCurMaterial:= ACurMaterial;
end;

procedure TObjectsDlg.ObjectsBoxClick(Sender: TObject);
begin
  if ObjectsBox.ItemIndex = -1 then
    CurObject:= nil else
    with ObjectsBox do
      CurObject:= Items.Objects[ItemIndex] as TGLObject;
end;

procedure TObjectsDlg.MatBoxClick(Sender: TObject);
begin
  if MatBox.ItemIndex = -1 then
    CurMaterial:= Nil else
    CurMaterial:= TMaterial(MatBox.Items.Objects[MatBox.ItemIndex]);
end;

procedure TObjectsDlg.VisibleBoxClick(Sender: TObject);
begin
  if VisibleBox.Focused then
  if CurObject <> nil then
    begin
      CurObject.Visible:= VisibleBox.Checked;
      CurScene.Paint;
    end;
end;

procedure TObjectsDlg.BoundingBoxClick(Sender: TObject);
begin
  if BoundingBox.Focused then
  if CurObject <> nil then
    begin
      CurObject.Bounding:= BoundingBox.Checked;
      CurScene.Paint;
    end;
end;

procedure TObjectsDlg.FrozenBoxClick(Sender: TObject);
begin
  if FrozenBox.Focused then
  if CurObject <> nil then
    begin
      CurObject.Frozen:= FrozenBox.Checked;
      CurScene.Paint;
    end;
end;

procedure TObjectsDlg.PMBoxChange(Sender: TObject);
begin
  if CurObject <> nil then
    begin
      CurObject.PolygonMode:= GL_FILL - PMBox.ItemIndex;
      CurScene.Paint;
    end;
end;

procedure TObjectsDlg.DelBtnClick(Sender: TObject);
begin
  if CurObject <> nil then
    if MessageDlg('Delete object "' + CurObject.Name + '" ?' , mtConfirmation,
                                                [mbYes, mbNo], 0) = mrYes then
      begin
        CurScene.DeleteObject(CurObject);
        CurScene.Paint;
        CurObject:= Nil;
       // with ObjectsBox do
       //   Items.Delete(ItemIndex);
        ObjectsBox.Items.Clear;
        FormCreate(Sender);
      end;
end;

procedure TObjectsDlg.RenameBtnClick(Sender: TObject);
var
  s: string;
begin
  if CurObject <> nil then
    begin
      s:= CurObject.Name;
      if InputQuery('Rename object', 'Enter a new name', s) then
         begin
           CurObject.Name:= s;
           with ObjectsBox do
             begin
               Items[ItemIndex]:= s;
               Perform(CM_RECREATEWND, 0, 0);
               ItemIndex:= Items.IndexOfObject(CurObject);
             end;
         end;
    end;
end;

procedure TObjectsDlg.ReRenderObjects;
var
  i,j: integer;
begin
// если текущий материал используется объектом, вызываем его метод Render
  with CurScene do
    for i:= 0 to ObjectCount - 1 do
      for j:= 0 to Objects[i].FaceGroupCount - 1 do
        if Objects[i].FaceGroups[j].Material = CurMaterial then
          Objects[i].Render;
  CurScene.Paint;
end;

procedure TObjectsDlg.AmbMouseDown(Sender: TObject; Button: TMouseButton;
                                            Shift: TShiftState; X, Y: Integer);
begin
  if CurMaterial = nil then
    Exit;
  with Data1.ColorDialog do
    begin
      Color:= (Sender as TShape).Brush.Color;
      if Execute then
        begin
          with CurMaterial do
          if Sender = Amb then
            Ambient:= Color else
            if Sender = Diff then
              Diffuse:= Color else
              if Sender = Spec then
                Specular:= Color else
                Emission:= Color;
          SetCurMaterial(CurMaterial);
          ReRenderObjects;
        end;
    end;
end;

procedure TObjectsDlg.TextureBtnClick(Sender: TObject);
begin
  Application.CreateForm(TTextureForm, TextureForm);
  TextureForm.ShowModal;
  TextureForm.Free;
  SetCurMaterial(CurMaterial);
end;

procedure TObjectsDlg.ShinChange(Sender: TObject);
begin
  if Shin.Focused then
  begin
  try
    CurMaterial.Shininess:= StrToFloat(Shin.Text);
  except
    CurMaterial.Shininess:= 0;
  end;
  ReRenderObjects;
  end;
end;

procedure TObjectsDlg.MatTranspEditChange(Sender: TObject);
begin
  if MatTranspEdit.Focused then
  begin
    CurMaterial.Transparent:= StrToIntDef(MatTranspEdit.Text, 0);
  ReRenderObjects;
  end;
end;

procedure TObjectsDlg.CheckBox1Click(Sender: TObject);
begin
 // DisableDepthTest:= CheckBox1.Checked;
  CurScene.Render;
  CurScene.Paint;
end;

procedure TObjectsDlg.SourceRGClick(Sender: TObject);
begin
{  case SourceRG.ItemIndex of
    0: BlendSourceFactor:= GL_ZERO; 1: BlendSourceFactor:= GL_ONE;
    2: BlendSourceFactor:= GL_DST_COLOR; 3: BlendSourceFactor:= GL_ONE_MINUS_DST_COLOR;
    4: BlendSourceFactor:= GL_SRC_ALPHA; 5: BlendSourceFactor:= GL_ONE_MINUS_SRC_ALPHA;
    6: BlendSourceFactor:= GL_DST_ALPHA; 7: BlendSourceFactor:= GL_ONE_MINUS_DST_ALPHA;
    8: BlendSourceFactor:= GL_SRC_ALPHA_SATURATE;
  end;
  CurScene.Render;
  CurScene.Paint; }
end;

procedure TObjectsDlg.DestRGClick(Sender: TObject);
begin
{  case DestRG.ItemIndex of
    0: BlendDestFactor:= GL_ZERO; 1: BlendDestFactor:= GL_ONE;
    2: BlendDestFactor:= GL_SRC_COLOR; 3: BlendDestFactor:= GL_ONE_MINUS_SRC_COLOR;
    4: BlendDestFactor:= GL_SRC_ALPHA; 5: BlendDestFactor:= GL_ONE_MINUS_SRC_ALPHA;
    6: BlendDestFactor:= GL_DST_ALPHA; 7: BlendDestFactor:= GL_ONE_MINUS_DST_ALPHA;
  end;
  CurScene.Render;
  CurScene.Paint;}
end;

//GL_DST_COLOR - GL_ONE_MINUS_SRC_ALPHA

procedure TObjectsDlg.MoreBtnClick(Sender: TObject);
begin
  if MoreBtn.Tag = 0 then
    begin
      Width:= Width + SourceRG.Width;
      MoreBtn.Caption:= '<<More';
      MoreBtn.Tag:= 1;
    end else
    begin
      Width:= Width - SourceRG.Width;
      MoreBtn.Caption:= 'More>>';
      MoreBtn.Tag:= 0;
    end;
end;

procedure TObjectsDlg.AssignMatClick(Sender: TObject);
begin
  if MatBox.ItemIndex = -1 then
    Exit;
  Application.CreateForm(TMaterialsForm, MaterialsForm);
  MaterialsForm.ShowModal;
  MaterialsForm.Free;
end;

end.


