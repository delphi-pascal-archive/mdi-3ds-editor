unit Textures;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, aiOgl, Jpeg, OpenGL;

type
  TTexturesForm = class(TForm)
    GroupBox4: TGroupBox;
    TexBox: TListBox;
    Label8: TLabel;
    TextureFileNameLabel: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Bevel: TBevel;
    Image: TImage;
    FileSizeLabel: TLabel;
    TextureSizeLabel: TLabel;
    MinFilterGroup: TRadioGroup;
    WrapSGroup: TRadioGroup;
    MagFilterGroup: TRadioGroup;
    WrapTGroup: TRadioGroup;
    EnvModeGroup: TRadioGroup;
    TexTransEdit: TEdit;
    ApplyBtn: TButton;
    ClearBtn: TButton;
    LoadBtn: TButton;
    UseBox: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure TexBoxClick(Sender: TObject);
    procedure MinFilterGroupClick(Sender: TObject);
    procedure WrapSGroupClick(Sender: TObject);
    procedure EnvModeGroupClick(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure UseBoxClick(Sender: TObject);
    procedure LoadBtnClick(Sender: TObject);
  private
    CurTexture: TTexture;
    procedure ReRenderObjects;
  public
    { Public declarations }
  end;

var
  TexturesForm: TTexturesForm;

implementation

uses Data;

{$R *.DFM}

procedure TTexturesForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  with CurScene.Materials do
    for i:= 0 to TexCount - 1 do
      TexBox.Items.AddObject(ExtractFileName(Textures[i].FileName), Textures[i]);
  TexBox.ItemIndex:= 0;
  TexBoxClick(Sender);
end;

procedure TTexturesForm.TexBoxClick(Sender: TObject);
var
  b: boolean;
  Ext: string;
  JpegImage: TJpegImage;

procedure StrechImage;
begin
  with Image do
    begin
      if (Picture.Width > Bevel.Width) or (Picture.Height > Bevel.Height) then
        begin
          Stretch:= True;
          if Picture.Width > Picture.Height then
            begin
              Width:= Bevel.Width;
              Height:= Round(Bevel.Height * (Picture.Height / Picture.Width));
            end else
            begin
              Height:= Bevel.Height;
              Width:= Round(Bevel.Width * (Picture.Width / Picture.Height));
            end;
          Left:= Bevel.Left + (Bevel.Width - Width) div 2;
          Top:= Bevel.Top + (Bevel.Height - Height) div 2;
        end else
        begin
          Stretch:= False;
          Left:= Bevel.Left; Top:= Bevel.Top;
          Width:= Bevel.Width; Height:= Bevel.Height;
        end;
    end;
end;

begin
  FileSizeLabel.Visible:= False;
  with TexBox do
    b:= (ItemIndex <> -1) and (TTexture(Items.Objects[ItemIndex]).TexFile = tfOK);
  Label8.Visible:= b; TextureFileNameLabel.Visible:= b;
  Bevel.Visible:= b; Image.Visible:= b; MinFilterGroup.Visible:= b;
  MagFilterGroup.Visible:= b; WrapSGroup.Visible:= b; WrapTGroup.Visible:= b;
  EnvModeGroup.Visible:= b; Label1.Visible:= b; TexTransEdit.Visible:= b;
  ApplyBtn.Visible:= b; Label2.Visible:= b; TextureSizeLabel.Visible:= b;
  {LoadBtn.Visible:= b;} ClearBtn.Visible:= b; UseBox.Visible:= b;
  if TexBox.ItemIndex = -1 then
    Exit;

  with TexBox do
    CurTexture:= TTexture(Items.Objects[ItemIndex]);
  TextureFileNameLabel.Caption:= CurTexture.FileName;
  FileSizeLabel.Visible:= True;
  case CurTexture.TexFile of
    tfNotFound: FileSizeLabel.Caption:= 'File not found';
    tfExtNotSupported: FileSizeLabel.Caption:= 'Extension not supported';
    tfLoadError: FileSizeLabel.Caption:= 'Loading error';
  end;
  if CurTexture.TexFile <> tfOK then
    Exit;

  Ext:= UpperCase(ExtractFileExt(CurTexture.FileName));
  if (Ext = '.JPEG') or ({not NVLibLoaded and} (Ext = '.JPG'))  then
    begin
      JpegImage:= TJpegImage.Create;
      JpegImage.LoadFromFile(CurTexture.FoundFileName);
      Image.Picture.Bitmap.Assign(JpegImage);
      JpegImage.Free;
    end  else
    Image.Picture.LoadFromFile(CurTexture.FoundFileName);
  StrechImage;

  UseBox.Checked:= CurTexture.Use;

  MinFilterGroup.OnClick:= Nil;
  with MinFilterGroup do
    case CurTexture.MinFilter of
      GL_NEAREST: ItemIndex:= 0;
      GL_LINEAR:  ItemIndex:= 1;
    end;
  MinFilterGroup.OnClick:= MinFilterGroupClick;

  MagFilterGroup.OnClick:= Nil;
  with MagFilterGroup do
    case CurTexture.MagFilter of
      GL_NEAREST: ItemIndex:= 0;
      GL_LINEAR:  ItemIndex:= 1;
    end;
  MagFilterGroup.OnClick:= MinFilterGroupClick;

  WrapSGroup.OnClick:= Nil;
  with WrapSGroup do
    case CurTexture.WrapS of
      GL_CLAMP:  ItemIndex:= 0;
      GL_REPEAT: ItemIndex:= 1;
    end;
  WrapSGroup.OnClick:= WrapSGroupClick;

  WrapTGroup.OnClick:= Nil;
  with WrapTGroup do
    case CurTexture.WrapT of
      GL_CLAMP:  ItemIndex:= 0;
      GL_REPEAT: ItemIndex:= 1;
    end;
  WrapTGroup.OnClick:= WrapSGroupClick;

  EnvModeGroup.OnClick:= Nil;
  with EnvModeGroup do
    case CurTexture.EnvMode of
      GL_MODULATE: ItemIndex:= 0;
      GL_DECAL:    ItemIndex:= 1;
      GL_BLEND:    ItemIndex:= 2;
    end;
  EnvModeGroup.OnClick:= EnvModeGroupClick;

  TexTransEdit.Text:= IntToStr(CurTexture.Transparent);
  FileSizeLabel.Caption:= Format('%d x %d', [CurTexture.FileSize.X, CurTexture.FileSize.Y]);
  TextureSizeLabel.Caption:= Format('%d x %d', [CurTexture.TextureSize.X, CurTexture.TextureSize.Y]);
end;

procedure TTexturesForm.ReRenderObjects;
var
  i,j: integer;
begin
// если текущая текстура используется объектом, вызываем его метод Render
  with CurScene do
    for i:= 0 to ObjectCount - 1 do
      for j:= 0 to Objects[i].FaceGroupCount - 1 do
        if Objects[i].FaceGroups[j].Material.Texture = CurTexture then
          Objects[i].Render;
  CurScene.Paint;
end;

procedure TTexturesForm.MinFilterGroupClick(Sender: TObject);
begin
  with CurTexture do
    case (Sender as TRadioGroup).ItemIndex of
      0: if Sender = MinFilterGroup then
           MinFilter:= GL_NEAREST else
           MagFilter:= GL_NEAREST;
      1: if Sender = MinFilterGroup then
           MinFilter:= GL_LINEAR else
           MagFilter:= GL_LINEAR;
    end;
  ReRenderObjects;
  CurScene.Paint;
end;

procedure TTexturesForm.WrapSGroupClick(Sender: TObject);
begin
  with CurTexture do
    case (Sender as TRadioGroup).ItemIndex of
      0: if Sender = WrapSGroup then
           WrapS:= GL_CLAMP else
           WrapT:= GL_CLAMP;
      1: if Sender = WrapSGroup then
           WrapS:= GL_REPEAT else
           WrapT:= GL_REPEAT;
    end;
  ReRenderObjects;
  CurScene.Paint;
end;

procedure TTexturesForm.EnvModeGroupClick(Sender: TObject);
begin
  with CurTexture do
    case EnvModeGroup.ItemIndex of
      0: EnvMode:= GL_MODULATE;
      1: EnvMode:= GL_DECAL;
      2: EnvMode:= GL_BLEND;
    end;
  ReRenderObjects;
  CurScene.Paint;
end;

procedure TTexturesForm.ClearBtnClick(Sender: TObject);
begin
  {CurScene.Materials.DeleteTexture(CurTexture);
  ObjectsDlg.CurMaterial.Texture:= Nil;
  TextureFileNameLabel.Caption:= '';
  ShowTexture;
  ObjectsDlg.ReRenderObjects;
  CurScene.Paint;}
end;

procedure TTexturesForm.UseBoxClick(Sender: TObject);
begin
  CurTexture.Use:= UseBox.Checked;
  ReRenderObjects;
  CurScene.Paint;
end;

procedure TTexturesForm.LoadBtnClick(Sender: TObject);
begin
  if Data1.OpenPictureDialog.Execute then
//    with CurTexture do
      begin
//        if Texture = nil then
//          Texture:= CurScene.Materials.NewTexture;
        CurTexture.FileName:= Data1.OpenPictureDialog.FileName;
        CurTexture.Build;
        TexBoxClick(Sender);
        ReRenderObjects;
        CurScene.Paint;
      end;
end;

end.
