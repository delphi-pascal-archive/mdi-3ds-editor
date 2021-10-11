unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, StdCtrls, aiOgl, OpenGL, Math;

type

  TMyObject = class(TglObject)
  public
// добавим перенос каждого объекта, чтобы сцена была в начале координат
    procedure Draw; override;
  end;

  TMyScene = class(TglScene)
  public
// переопределяем функцию, чтобы указать, с какими объектами будем работать
    function glObject: TglObject; override;
    procedure Draw; override;  
  end;

  TMainForm = class(TForm)
    ToolBar2: TToolBar;
    Button1: TButton;
    OpenDialog: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    glScene: TMyScene;
    Back, Left, Right, Top, Bottom: TglObject;
    procedure LoadFile(FileName: string);
    procedure LookAtComput;
    procedure RoomDraw;
    procedure Idle (Sender: TObject; var Done: Boolean);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

var
  Mx, Mn: TVector;
  StartTime, LastTime: dWord;
  Light1, Light2 : gluQuadricObj;
  D, Ang1, Ang2: Extended;


procedure TMyObject.Draw;
begin
// перемещаем каждый объект, чтобы сцена была в центре
  glTranslatef(-(Mn.X + Mx.X)/2, -(Mn.Y + Mx.Y)/2, -(Mn.Z + Mx.Z)/2);
  inherited;
end;

function TMyScene.glObject: TglObject;
begin
  Result:= TMyObject.Create; // будем работать с объектами TMyObject
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  if OpenDialog.Execute then
    LoadFile(OpenDialog.FileName);
end;

procedure TMainForm.LookAtComput;
var
  D2: single;
begin
  with CurScene do
    begin
      D2:= Abs(Mx.X - Mn.X);
      if Abs(Mx.Y - Mn.Y) > D2 then
        D2:= Abs(Mx.Y - Mn.Y);
      if Abs(Mx.Z - Mn.Z) > D2 then
        D2:= Abs(Mx.Z - Mn.Z);
      D2:= D2 / 2;   // D2-половина наибольшего размера
      EyePoint:= Vector(0, 0, 1.2 * D2); // отодвинуть точку взгляда на 20%
      zNear:= 0.1 * D2;
      zFar:= 2.4 * D2;
// по умолчанию направление взгляда в (0,0,-1) и вектор вверх (0,1,0), т.е. ось Y вверх
    end;
end;

function CreatePlane(Point1, Point2, Point3, Point4: TVector): TglObject;
begin
  Result:= TglObject.Create;
  CurScene.AddObject(Result);
  with Result do
    begin
      Frozen:= True;
      VertexCount:= 4;
      Vertices[0].Vector:= Point1; Vertices[1].Vector:= Point2;
      Vertices[2].Vector:= Point3; Vertices[3].Vector:= Point4;

      FaceCount:= 2;
      Faces[0]:= Face(0, 1, 3); Faces[1]:= Face(1, 2, 3);

      FaceGroupCount:= 1;
      FaceGroups[0].Material:= Nil; FaceGroups[0].OriginFace:= 0; FaceGroups[0].FaceCount:= 2;
      GetShadow:= True;
    end;

end;

procedure TMainForm.RoomDraw;
var
  Material1, Material2: TMaterial;
  i: integer;
begin
  Mx:= glScene.Max; Mn:= glScene.Min;
  D:= Max(Mx.X - Mn.X, Mx.Y - Mn.Y); D:= Max(D, Mx.Z - Mn.Z);

  with glScene do
    begin
      EyePoint.z:= EyePoint.z + 1.5 * D;
      zFar:= zNear + 5*D;
      LightsOff;
    end;

  with glScene.Lighting do
    begin
      Enabled[0]:= True; Infinity[0]:= False; Direction[0]:= NullVector;
      SpotCutOff[0]:= 180;

      Enabled[1]:= True; Infinity[1]:= False; Direction[1]:= NullVector;
      SpotCutOff[1]:= 180; Diffuse[1]:= glScene.Lighting.Diffuse[0];
      Specular[1]:= glScene.Lighting.Specular[0];

      ModelAmbient:= RGB(255, 255, 255);
    end;

  Back:= CreatePlane(Vector(-D, -D, -D), Vector(D, -D, -D),
                     Vector(D, D, -D),  Vector(-D, D, -D));
  Back.Name:= 'Back';
  with Back do
    begin
      Vertices[0].U:= 0; Vertices[0].V:= 0; Vertices[1].U:= 3; Vertices[1].V:= 0;
      Vertices[2].U:= 3; Vertices[2].V:= 3; Vertices[3].U:= 0; Vertices[3].V:= 3;
    end;

  Left:= CreatePlane(Vector(-D, -D, -D), Vector(-D, D, -D),
                     Vector(-D, D, D),  Vector(-D, -D, D));
  Left.Name:= 'Left';
  with Left do
    begin
      Vertices[0].U:= 3; Vertices[0].V:= 0; Vertices[1].U:= 3; Vertices[1].V:= 3;
      Vertices[2].U:= 0; Vertices[2].V:= 3; Vertices[3].U:= 0; Vertices[3].V:= 0;
    end;

  Right:= CreatePlane(Vector(D, -D, -D), Vector(D, -D, D),
                     Vector(D, D, D),  Vector(D, D, -D));
  Right.Name:= 'Right';
  with Right do
    begin
      Vertices[0].U:= 0; Vertices[0].V:= 0; Vertices[1].U:= 3; Vertices[1].V:= 0;
      Vertices[2].U:= 3; Vertices[2].V:= 3; Vertices[3].U:= 0; Vertices[3].V:= 3;
    end;

  Top:= CreatePlane(Vector(-D, D, -D), Vector(D, D, -D),
                     Vector(D, D, D),  Vector(-D, D, D));
  Top.Name:= 'Top';

  Bottom:= CreatePlane(Vector(-D, -D, -D), Vector(-D, -D, D),
                     Vector(D, -D, D),  Vector(D, -D, -D));
  Bottom.Name:= 'Bottom';
  with Bottom do
    begin
      Vertices[0].U:= 0; Vertices[0].V:= 6; Vertices[1].U:= 0; Vertices[1].V:= 0;
      Vertices[2].U:= 6; Vertices[2].V:= 0; Vertices[3].U:= 6; Vertices[3].V:= 6;
    end;


  Material1:= glScene.Materials.NewMaterial;
  Material1.Texture:= glScene.Materials.NewTexture;
  Material1.Texture.FileName:= 'brick27.bmp';

  Material2:= glScene.Materials.NewMaterial;
  Material2.Texture:= glScene.Materials.NewTexture;
  Material2.Texture.FileName:= 'Лам.jpeg';  

  Left.FaceGroups[0].Material:= Material1;
  Right.FaceGroups[0].Material:= Material1;
  Back.FaceGroups[0].Material:= Material1;
  Bottom.FaceGroups[0].Material:= Material2;

  StartTime:= GetTickCount;
end;

procedure TMainForm.LoadFile(FileName: string);
begin
  if Assigned(glScene) then
    CurScene.Free;     // убить старую сцену
  glScene:= TMyScene.Create(Self);
  SetCurScene(glScene);
  CurScene.LoadFromFile(FileName);
  with CurScene do
    begin
      Mx:= Max; Mn:= Min;  // для ускорения, чтобы не вычислять каждый раз заново
// в 3DA хранится точка взгляда, для 3DS надо вычислить
      if Uppercase(ExtractFileExt(FileName)) = '.3DS' then
        LookAtComput;

      RoomDraw;

      LookAt;         // установить точку взгляда
      ActiveMDIChild.Caption:= ChangeFileExt(ExtractFileName(FileName), '');
      GetNormals;     // вычислить нормали
      Render;         // рендеринг сцены
      Paint;          // рисуем сцену
    end;
end;


procedure TMainForm.Idle(Sender: TObject; var Done: Boolean);
var
  A: extended;
begin
  Done:= False;
  if not Assigned(glScene) then
    Exit;
  Ang1:= (GetTickCount - StartTime) / 1000 / 20;   // делает оборот за 20 секунд
  Ang2:= (GetTickCount - StartTime) / 1000 / 27;   // делает оборот за 27 секунд

  glScene.Lighting.Position[0]:= Vector(cos(2 * pi * Ang1) * 0.9 * D, sin(2 * pi * Ang1) * 0.9 * D, 0);
  glScene.Lighting.Position[1]:= Vector(cos(2 * pi * Ang2) * 0.9 * D, 0, sin(2 * pi * Ang2) * 0.9 * D);


  A:= ((GetTickCount - LastTime) mod 1000) * 360 / 1000 / 10;  // оборот по всем осям за 10 с
  glScene.Rotate(A, A, A);

  LastTime:= GetTickCount;
  glScene.Paint;
end;

procedure TMyScene.Draw;
begin
  inherited;

  glDisable(GL_LIGHTING);
  glPushMatrix();
    with CurScene.Lighting.Position[0] do
      glTranslatef(X, Y, 0);
    glRotatef(90, 0, 1, 0);
    glRotatef(-Ang1 * 360, 1, 0, 0);
    glColor3f(1, 1, 0);
    gluCylinder(Light1, D/30, 0, D/30, 12, 12);
  glPopMatrix();

  glPushMatrix();
    with CurScene.Lighting.Position[1] do
      glTranslatef(X, Y, 0);
    glRotatef(90, 0, 1, 0);
    glRotatef(-Ang2 * 360, 0, 1, 0);
    glColor3f(1, 0, 0);
    gluCylinder(Light2, D/30, 0, D/30, 12, 12);
  glPopMatrix();
  glEnable(GL_LIGHTING);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Light1 := gluNewQuadric;
  Light2 := gluNewQuadric;

  Application.OnIdle:= Idle;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  gluDeleteQuadric(Light1);
  gluDeleteQuadric(Light2);
end;

end.
