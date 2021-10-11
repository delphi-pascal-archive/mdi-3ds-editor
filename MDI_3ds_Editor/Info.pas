unit Info;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, aiOGL;

type
  TInfoForm = class(TForm)
    Label1: TLabel;
    FileNameLabel: TLabel;
    Label2: TLabel;
    ObjectsCountLabel: TLabel;
    Label3: TLabel;
    VerticesLabel: TLabel;
    Label4: TLabel;
    FacesLabel: TLabel;
    Label5: TLabel;
    MaterialsLabel: TLabel;
    Label6: TLabel;
    TexturesLabel: TLabel;
    Label7: TLabel;
    TexBuiltLabel: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InfoForm: TInfoForm;

implementation

{$R *.DFM}

procedure TInfoForm.FormCreate(Sender: TObject);
var
  i: integer;
  VCount,FCount: integer;
begin
  if CurScene = nil then
    Exit;
  FileNameLabel.Caption:= CurScene.FileName;
  ObjectsCountLabel.Caption:= IntToStr(CurScene.ObjectCount);
  VCount:= 0; FCount:= 0;
  for i:= 0 to CurScene.ObjectCount - 1 do
    begin
      Inc(VCount, CurScene.Objects[i].VertexCount);
      Inc(FCount, CurScene.Objects[i].FaceCount);
    end;
  VerticesLabel.Caption:= IntToStr(VCount);
  FacesLabel.Caption:= IntToStr(FCount);
  MaterialsLabel.Caption:= IntToStr(CurScene.Materials.MatCount);
  TexturesLabel.Caption:= IntToStr(CurScene.Materials.TexCount);
  VCount:= 0;
  for i:= 0 to CurScene.Materials.TexCount - 1 do
    if CurScene.Materials.Textures[i].TexFile = tfOK then
      Inc(VCount);
  TexBuiltLabel.Caption:= IntToStr(VCount);
end;

end.
