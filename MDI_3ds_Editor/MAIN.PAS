unit Main;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus, StdCtrls,
    Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, ToolWin, aiOGL, OpenGL, ImgList;

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
    procedure Draw; override;  // перекрываем единственно с целью вывода FPS
  end;

  TMainForm = class(TForm)
    StatusBar: TStatusBar;
    ToolBar2: TToolBar;
    FileOpenBtn: TToolButton;
    FileSaveBtn: TToolButton;
    ToolButton3: TToolButton;
    FileNewBtn: TToolButton;
    CascadeBtn: TToolButton;
    TileHBtn: TToolButton;
    TileVBtn: TToolButton;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileAddItem: TMenuItem;
    FileCloseItem: TMenuItem;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    SceneItem: TMenuItem;
    ObjectsItem: TMenuItem;
    LightingItem: TMenuItem;
    MaterialsItem: TMenuItem;
    TexturesItem: TMenuItem;
    Background1: TMenuItem;
    LookAtItem: TMenuItem;
    PerspectiveItem: TMenuItem;
    N2: TMenuItem;
    Veiw1: TMenuItem;
    SolidItem: TMenuItem;
    LinesItem: TMenuItem;
    PointsItem: TMenuItem;
    N3: TMenuItem;
    InfoItem: TMenuItem;
    WindowItem: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowTileItem: TMenuItem;
    WindowTileItem2: TMenuItem;
    WindowMinimizeItem: TMenuItem;
    Help1: TMenuItem;
    HelpAboutItem: TMenuItem;
    JitterName: TMenuItem;
    procedure FileNew1Execute(Sender: TObject);
    procedure FileOpen1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ObjectsItemClick(Sender: TObject);
    procedure LightingItemClick(Sender: TObject);
    procedure Background1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InfoItemClick(Sender: TObject);
    procedure LookAtItemClick(Sender: TObject);
    procedure PerspectiveItemClick(Sender: TObject);
    procedure CascadeBtnClick(Sender: TObject);
    procedure TileHBtnClick(Sender: TObject);
    procedure TileVBtnClick(Sender: TObject);
    procedure FileCloseItemClick(Sender: TObject);
    procedure FileSaveItemClick(Sender: TObject);
    procedure FileSaveAsItemClick(Sender: TObject);
    procedure SolidItemClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure WindowMinimizeItemClick(Sender: TObject);
    procedure MaterialsItemClick(Sender: TObject);
    procedure TexturesItemClick(Sender: TObject);
    procedure JitterNameClick(Sender: TObject);
    procedure HelpAboutItemClick(Sender: TObject);
  private
    procedure NewMDI;
    procedure LookAtComput; // вычисляет положение точки взгляда, чтобы вся сцена была видна
  public
    procedure LoadFile(FileName: string);
    procedure SetEnable(b: boolean);
  protected
// обрабатываем сообщение WM_DROPFILES при перетаскивании файлов
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
  end;

var
  MainForm: TMainForm;
// координаты точек с максимальными и минимальными значениями X,Y,Z сцены
  Mx, Mn: TVector;

implementation

{$R *.DFM}

uses
  ShellAPI, Objects, Lighting, BG, Data, Info, LookAt, Perspective, ChildWin,
    Materials, Textures, Jitter, About;

function TMyScene.glObject: TglObject;
begin
  Result:= TMyObject.Create; // будем работать с объектами TMyObject
end; 

procedure TMyObject.Draw;
begin
// перемещаем каждый объект, чтобы сцена была в центре
  glTranslatef(-(Mn.X + Mx.X)/2, -(Mn.Y + Mx.Y)/2, -(Mn.Z + Mx.Z)/2);
  inherited;
end;  

procedure TMyScene.Draw; 
begin
  inherited;
  MainForm.StatusBar.Panels[1].Text:= Format('%f fps', [FPS]); // выводим fps(frames per second)
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  DragAcceptFiles(Handle, True); // форма может принимать файлы
  SetEnable(False);
  SolidItem.Tag:= GL_FILL; LinesItem.Tag:= GL_LINE; PointsItem.Tag:= GL_POINT;
  ObjectsDlg:= Nil;
end;

procedure TMainForm.SetEnable(b: boolean);
begin
  FileCloseItem.Enabled:= b; FileSaveItem.Enabled:= b; FileSaveAsItem.Enabled:= b;
  FileSaveBtn.Enabled:= b; SceneItem.Enabled:= b; WindowItem.Enabled:= b;
  CascadeBtn.Enabled:= b; TileHBtn.Enabled:= b; TileVBtn.Enabled:= b;
end;

procedure TMainForm.NewMDI;
begin
  with TMDIChild.Create(Application) do
    Caption:= '';
  SetEnable(True);
end;

procedure TMainForm.FileNew1Execute(Sender: TObject);
begin
  NewMDI;  // создать новое окно
  with TMDIChild(ActiveMDIChild) do
    begin
      glScene:= TMyScene.Create(Self.ActiveMDIChild); // создаем сцену
      SetCurScene(glScene);                           // сделать ее текущей
// если сцена создана успешно, то ErrorCode = NoError
      if glScene.ErrorCode <> NoError then;
    end;
end;

procedure TMainForm.FileOpen1Execute(Sender: TObject);
begin
  if Data1.OpenDialog.Execute then
    LoadFile(Data1.OpenDialog.FileName);
end;

{procedure TMainForm.FileAddItemClick(Sender: TObject);
begin
  if MyOpenDialog.Execute then
    begin
      if ActiveMDIChild  = nil then
        begin
          LoadFile(MyOpenDialog.FileName);
          Exit;
        end;
      with CurScene do
        begin
          LoadFromFile(MyOpenDialog.FileName);
          Mx:= Max; Mn:= Min;  // для ускорения, чтобы не вычислять каждый раз заново
// в 3DA хранится точка взгляда, для 3DS надо вычислить
          if Uppercase(ExtractFileExt(FileName)) = '.3DS' then
            LookAtComput;
          LookAt;         // установить точку взгляда
          ActiveMDIChild.Caption:= ActiveMDIChild.Caption +
                     ChangeFileExt(ExtractFileName(MyOpenDialog.FileName), '');
          GetNormals;     // вычислить нормали
          Render;         // рендеринг сцены
          Paint;          // рисуем сцену
        end;
    end;
end;  }

procedure TMainForm.LoadFile(FileName: string);
begin
  if ActiveMDIChild = nil then
    NewMDI else
    CurScene.Free;     // убить старую сцену
  TMDIChild(ActiveMDIChild).glScene:= TMyScene.Create(ActiveMDIChild);
  SetCurScene(TMDIChild(ActiveMDIChild).glScene);
  CurScene.LoadFromFile(FileName);
 { with CurScene do
    for i:= 0 to ObjectCount - 1 do
      begin
        o:= Objects[i];
        Objects[i].ToOrigin;
        Objects[i].Rotate:= NullVector;
        Objects[i].Scale:= Vector(1, 1, 1);
        Objects[i].Translate:= NullVector;
      end; }
  with CurScene do
    begin
      Mx:= Max; Mn:= Min;  // для ускорения, чтобы не вычислять каждый раз заново
// в 3DA хранится точка взгляда, для 3DS надо вычислить
      if Uppercase(ExtractFileExt(FileName)) = '.3DS' then
        LookAtComput;
      LookAt;         // установить точку взгляда
      ActiveMDIChild.Caption:= ChangeFileExt(ExtractFileName(FileName), '');
      GetNormals;     // вычислить нормали
      Render;         // рендеринг сцены
      Paint;          // рисуем сцену
    end;
end;

procedure TMainForm.WMDropFiles(var Msg: TWMDropFiles);
var
  Buffer: array[0..MAX_PATH] of Char;
  i: integer;
begin
// DragQueryFile(Msg.Drop, $FFFFFFFF, nil, 0) выдает кол-во перетаскиваемых файлов
  for i:= 1 to DragQueryFile(Msg.Drop, $FFFFFFFF, nil, 0) do
    begin
      DragQueryFile(Msg.Drop, i-1, Buffer, MAX_PATH); // имя файла в Buffer
      FileNew1Execute(nil);                           // создать новое окно
      LoadFile(Buffer);                               // загрузить сцену
    end;
  Msg.Result := 0;
  DragFinish(Msg.Drop);
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

procedure TMainForm.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
begin
  for i:= MDIChildCount - 1 downto 0 do
    TMDIChild(MDIChildren[i]).glScene.Free;
  Action := caFree;
end;

procedure TMainForm.ObjectsItemClick(Sender: TObject);
begin
  Application.CreateForm(TObjectsDlg, ObjectsDlg);  // объекты и материалы сцены
  ObjectsDlg.ShowModal;
  ObjectsDlg.Free;
  ObjectsDlg:= Nil;
end;

procedure TMainForm.LightingItemClick(Sender: TObject);
begin
  Application.CreateForm(TLightingDlg, LightingDlg);  // освещение
  LightingDlg.ShowModal;
  LightingDlg.Free;
end;

procedure TMainForm.Background1Click(Sender: TObject);
begin
  Application.CreateForm(TBGDlg, BGDlg);       // цвет фона
  BGDlg.ShowModal;
  BGDlg.Free;
end;

procedure TMainForm.InfoItemClick(Sender: TObject);
begin
  Application.CreateForm(TInfoForm, InfoForm); // кое-какая информация о сцене
  InfoForm.ShowModal;
  InfoForm.Free;
end;

procedure TMainForm.LookAtItemClick(Sender: TObject);
begin
// точка взгляда, направление и вектор вверх сцены
  Application.CreateForm(TLookAtForm, LookAtForm);
  LookAtForm.ShowModal;
  LookAtForm.Free;
end;

procedure TMainForm.PerspectiveItemClick(Sender: TObject);
begin
// угол камеры, плоскости отсечения
  Application.CreateForm(TPerspectiveForm, PerspectiveForm);
  PerspectiveForm.ShowModal;
  PerspectiveForm.Free;
end;

procedure TMainForm.CascadeBtnClick(Sender: TObject);
begin
  Cascade;
end;

procedure TMainForm.TileHBtnClick(Sender: TObject);
begin
  TileMode:= tbHorizontal;
  Tile;
end;

procedure TMainForm.TileVBtnClick(Sender: TObject);
begin
  TileMode:= tbVertical;
  Tile;
end;

procedure TMainForm.FileCloseItemClick(Sender: TObject);
begin
  ActiveMDIChild.Close;
end;

procedure TMainForm.FileSaveItemClick(Sender: TObject);
begin
  with TMDIChild(ActiveMDIChild).glScene do
    if FileName = '' then
      FileSaveAsItemClick(Sender) else
      SaveToFile;
end;

procedure TMainForm.FileSaveAsItemClick(Sender: TObject);
begin
  if Data1.SaveDialog.Execute then
    begin
      CurScene.FileName:= Data1.SaveDialog.FileName;       
      CurScene.SaveToFile;
      ActiveMDIChild.Caption:= ChangeFileExt(ExtractFileName(CurScene.FileName), '');
    end;
end;

procedure TMainForm.SolidItemClick(Sender: TObject);
var
  i: integer;
begin
// рисуем все объекты сплошными, линиями или точками
  with CurScene do
    for i:= 0 to ObjectCount - 1 do
      Objects[i].PolygonMode:= TMenuItem(Sender).Tag;
  CurScene.Paint;
end;

procedure TMainForm.FormActivate(Sender: TObject);
var
  i: integer;
begin
  for i:= 1 to ParamCount do  // обрабатываем параметры
    begin
      FileNew1Execute(nil);
      LoadFile(ParamStr(i));
    end; 
end;

procedure TMainForm.WindowMinimizeItemClick(Sender: TObject);
var
  i: integer;
begin
  for i:= 1 to MDIChildCount - 1 do
    TMDIChild(MDIChildren[i]).WindowState:= wsMinimized;
end;

procedure TMainForm.MaterialsItemClick(Sender: TObject);
begin
  Application.CreateForm(TMaterialsForm, MaterialsForm);
  with MaterialsForm do
    begin
      AssignBtn.Visible:= False;
      ShowModal;
      Free;
    end;
end;

procedure TMainForm.TexturesItemClick(Sender: TObject);
begin
  Application.CreateForm(TTexturesForm, TexturesForm);  // текстуры
  TexturesForm.ShowModal;
  TexturesForm.Free;
end;

procedure TMainForm.JitterNameClick(Sender: TObject);
begin
  Application.CreateForm(TJitterForm, JitterForm); // сглаживание
  JitterForm.ShowModal;
  JitterForm.Free;
end;

procedure TMainForm.HelpAboutItemClick(Sender: TObject);
begin
  Application.CreateForm(TAboutForm, AboutForm);
  AboutForm.ShowModal;
  AboutForm.Free;
end;

end.
