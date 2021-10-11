unit Texture;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, aiOGL;

type
  TTextureForm = class(TForm)
    Label8: TLabel;
    TextureFileNameLabel: TLabel;
    MinFilterGroup: TRadioGroup;
    WrapSGroup: TRadioGroup;
    MagFilterGroup: TRadioGroup;
    WrapTGroup: TRadioGroup;
    EnvModeGroup: TRadioGroup;
    Label1: TLabel;
    TexTransEdit: TEdit;
    ApplyBtn: TButton;
    Label2: TLabel;
    Bevel: TBevel;
    ClearBtn: TButton;
    LoadBtn: TButton;
    Image: TImage;
    FileSizeLabel: TLabel;
    TextureSizeLabel: TLabel;
    procedure LoadBtnClick(Sender: TObject);
    procedure MinFilterGroupClick(Sender: TObject);
    procedure WrapSGroupClick(Sender: TObject);
    procedure EnvModeGroupClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ApplyBtnClick(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
  private
    procedure ShowTexture;
  end;

var
  TextureForm: TTextureForm;

implementation

uses
  Data, Objects, Jpeg, OpenGL;

{$R *.DFM}

procedure TTextureForm.ShowTexture;
var
  Ext: string;
  JpegImage: TJpegImage;
  b: boolean;
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
  with ObjectsDlg.CurMaterial, Image do
    begin
      if Texture = nil then
        Caption:= '' else
        Caption:= ExtractFileName(Texture.FileName);
      b:= (Texture <> nil) and (Texture.TexFile = tfOK);
      Image.Visible:= b; MinFilterGroup.Visible:= b; MagFilterGroup.Visible:= b;
      WrapTGroup.Visible:= b; WrapSGroup.Visible:= b; EnvModeGroup.Visible:= b;
      Label1.Visible:= b; TexTransEdit.Visible:= b; ApplyBtn.Visible:= b; Label2.Visible:= b;
      ClearBtn.Visible:= b; FileSizeLabel.Visible:= b; TextureSizeLabel.Visible:= b;
   //   TextureFileNameLabel.Visible:= b;
      if Texture = nil then
        Exit;
      TextureFileNameLabel.Caption:= Texture.FileName;
      FileSizeLabel.Visible:= True;
      case Texture.TexFile of
        tfNotFound: FileSizeLabel.Caption:= 'File not found';
        tfExtNotSupported: FileSizeLabel.Caption:= 'Extension not supported';
        tfLoadError: FileSizeLabel.Caption:= 'Loading error';
      end;
      if Texture.TexFile <> tfOK then
        Exit;
      Ext:= UpperCase(ExtractFileExt(Texture.FileName));
      if (Ext = '.JPEG') or ({not NVLibLoaded and} (Ext = '.JPG'))  then
        begin
          JpegImage:= TJpegImage.Create;
          JpegImage.LoadFromFile(Texture.FoundFileName);
          Picture.Bitmap.Assign(JpegImage);
          JpegImage.Free;
        end  else
        Picture.LoadFromFile(Texture.FoundFileName);
      StrechImage;

      MinFilterGroup.OnClick:= Nil;
      with MinFilterGroup do
        case Texture.MinFilter of
          GL_NEAREST: ItemIndex:= 0;
          GL_LINEAR:  ItemIndex:= 1;
        end;
      MinFilterGroup.OnClick:= MinFilterGroupClick;

      MagFilterGroup.OnClick:= Nil;
      with MagFilterGroup do
        case Texture.MagFilter of
          GL_NEAREST: ItemIndex:= 0;
          GL_LINEAR:  ItemIndex:= 1;
        end;
      MagFilterGroup.OnClick:= MinFilterGroupClick;

      WrapSGroup.OnClick:= Nil;
      with WrapSGroup do
        case Texture.WrapS of
          GL_CLAMP:  ItemIndex:= 0;
          GL_REPEAT: ItemIndex:= 1;
        end;
      WrapSGroup.OnClick:= WrapSGroupClick;

      WrapTGroup.OnClick:= Nil;
      with WrapTGroup do
      case Texture.WrapT of
        GL_CLAMP:  ItemIndex:= 0;
        GL_REPEAT: ItemIndex:= 1;
      end;
      WrapTGroup.OnClick:= WrapSGroupClick;

      EnvModeGroup.OnClick:= Nil;
      with EnvModeGroup do
        case Texture.EnvMode of
          GL_MODULATE: ItemIndex:= 0;
          GL_DECAL:    ItemIndex:= 1;
          GL_BLEND:    ItemIndex:= 2;
        end;
      EnvModeGroup.OnClick:= EnvModeGroupClick;

      TexTransEdit.Text:= IntToStr(Texture.Transparent);
      FileSizeLabel.Caption:= Format('%d x %d', [Texture.FileSize.X, Texture.FileSize.Y]);
      TextureSizeLabel.Caption:= Format('%d x %d', [Texture.TextureSize.X, Texture.TextureSize.Y]);
    end;
end;

procedure TTextureForm.LoadBtnClick(Sender: TObject);
begin
  if Data1.OpenPictureDialog.Execute then
    with ObjectsDlg.CurMaterial do
      begin
        if Texture = nil then
          Texture:= CurScene.Materials.NewTexture;
        Texture.FileName:= Data1.OpenPictureDialog.FileName;
        Texture.Build;
        ShowTexture;
        ObjectsDlg.ReRenderObjects;
        CurScene.Paint;
      end;
end;

procedure TTextureForm.MinFilterGroupClick(Sender: TObject);
begin
  with ObjectsDlg.CurMaterial.Texture do
    case (Sender as TRadioGroup).ItemIndex of
      0: if Sender = MinFilterGroup then
           MinFilter:= GL_NEAREST else
           MagFilter:= GL_NEAREST;
      1: if Sender = MinFilterGroup then
           MinFilter:= GL_LINEAR else
           MagFilter:= GL_LINEAR;
    end;
  ObjectsDlg.ReRenderObjects;
  CurScene.Paint;
end;

procedure TTextureForm.WrapSGroupClick(Sender: TObject);
begin
  with ObjectsDlg.CurMaterial.Texture do
    case (Sender as TRadioGroup).ItemIndex of
      0: if Sender = WrapSGroup then
           WrapS:= GL_CLAMP else
           WrapT:= GL_CLAMP;
      1: if Sender = WrapSGroup then
           WrapS:= GL_REPEAT else
           WrapT:= GL_REPEAT;
    end;
  ObjectsDlg.ReRenderObjects;
  CurScene.Paint;
end;

procedure TTextureForm.EnvModeGroupClick(Sender: TObject);
begin
  with ObjectsDlg.CurMaterial.Texture do
    case EnvModeGroup.ItemIndex of
      0: EnvMode:= GL_MODULATE;
      1: EnvMode:= GL_DECAL;
      2: EnvMode:= GL_BLEND;
    end;
  ObjectsDlg.ReRenderObjects;
  CurScene.Paint;
end;

procedure TTextureForm.FormCreate(Sender: TObject);
begin
  ShowTexture;
end;

procedure TTextureForm.ApplyBtnClick(Sender: TObject);
begin
  with ObjectsDlg.CurMaterial.Texture do
    begin
      Transparent:= StrToIntDef(TexTransEdit.Text, 0);
      Build;
    end;
  ObjectsDlg.ReRenderObjects;
  CurScene.Paint;
end;

procedure TTextureForm.ClearBtnClick(Sender: TObject);
begin
  CurScene.Materials.DeleteTexture(ObjectsDlg.CurMaterial.Texture);
  ObjectsDlg.CurMaterial.Texture:= Nil;
  TextureFileNameLabel.Caption:= '';
  ShowTexture;  
  ObjectsDlg.ReRenderObjects;
  CurScene.Paint;
end;

end.
