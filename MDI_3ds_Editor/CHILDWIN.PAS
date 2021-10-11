unit Childwin;

interface

uses
  Windows, Classes, Graphics, Forms, Controls, StdCtrls, Messages, aiOGL,
  Menus, Sysutils, Main;

type
  TMDIChild = class(TForm)
    PopupMenu: TPopupMenu;
    ObjectNameItem: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
                                           Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure ObjectNameItemClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
  private
    LastX, LastY: integer; // вспомогательные переменные
  public
    glScene: TMyScene;     // наша сцена
  protected
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
  end;

var
  StepT: single = 25;
  StepR: single = 5;  // шаги перемещений и вращений сцены

implementation

uses
  ShellAPI, Objects, OpenGL;

{$R *.DFM}

procedure TMDIChild.FormCreate(Sender: TObject);
begin
  DragAcceptFiles(Handle, True); // форма может принимать файлы
end;

procedure TMDIChild.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  glScene.Free;
  Action:= caFree;
  with MainForm do
    SetEnable(MDIChildCount <> 1);
end;

procedure TMDIChild.FormActivate(Sender: TObject);
begin
  SetCurScene(glScene);  // установить текущую сцену
end;

procedure TMDIChild.FormMouseDown(Sender: TObject; Button: TMouseButton;
                                           Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
  GLObject: TGLObject;
begin
  if (Button = mbRight) then
    begin
      SetFocus;
      GLObject:= CurScene.GetObjectFromScreenCoord(X,Y); // получить объект под указателем мыши
      if GLObject = nil then
        Exit;
      PopUpMenu.Items[0].Tag:= Integer(glObject);  
      PopUpMenu.Items[0].Caption:= GLObject.Name;      // имя объекта
      P:= ClientToScreen(Point(X, Y));
      PopUpMenu.PopUp(P.X, P.Y);
    end else
    if Button = mbLeft then
      begin
        LastX:= X;
        LastY:= Y;
      end;
end;

procedure TMDIChild.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
// вращаем сцену
  if ssLeft in Shift then
    begin
      if ssShift in Shift then
        CurScene.Rotate(Y - LastY, X - LastX, 0) else
        CurScene.Rotate(Y - LastY, 0, X - LastX);
      LastX:= X;
      LastY:= Y;
      CurScene.Paint;
    end;
end;

procedure TMDIChild.WMDropFiles(var Msg: TWMDropFiles);
var
  Buffer: array[0..MAX_PATH] of Char;
  Count: cardinal;
begin
// перетаскивание файла
  Count:= DragQueryFile(Msg.Drop, $FFFFFFFF, nil, 0);
  if Count > 0 then
  begin
    DragQueryFile(Msg.Drop, 0, Buffer, MAX_PATH);
    DragFinish(Msg.Drop);
    Msg.Result:= 0;
    SetFocus;
    MainForm.LoadFile(Buffer);
  end;
end;

procedure TMDIChild.ObjectNameItemClick(Sender: TObject);
begin
// показываем ObjectsDlg и текущим является выбранный объект
  Application.CreateForm(TObjectsDlg, ObjectsDlg);
  with ObjectsDlg.ObjectsBox do
    ItemIndex:= Items.IndexOfObject(TglObject((Sender as TMenuItem).Tag));
  ObjectsDlg.ObjectsBoxClick(Sender);
  ObjectsDlg.ShowModal;
  ObjectsDlg.Free;
end;

procedure TMDIChild.FormKeyPress(Sender: TObject; var Key: Char);
begin
  with CurScene do
    case Key of
// 6,4 - перемещение вдоль оси X; 8,2 - перемещение вдоль оси Y; // '+' '-' - перемещение вдоль оси Z
      '6': Translate(-StepT, 0, 0);
      '4': Translate( StepT, 0, 0);
      '8': Translate(0, -StepT, 0);
      '2': Translate(0,  StepT, 0);
      '+': Translate(0, 0,  StepT);
      '-': Translate(0, 0, -StepT);

// масштабирование
      'Q','q': Scale( 0.1, 0, 0);
      'W','w': Scale(-0.1, 0, 0);
      'E','e': Scale(0, 0.1, 0);
      'R','r': Scale(0, -0.1, 0);
      'D','d': Scale(0, 0, 0.1);
      'F','f': Scale(0, 0, -0.1);
  end;
  CurScene.Paint;
end;

procedure TMDIChild.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
  Key: char;
begin
  Key:= '+';
  FormKeyPress(Sender, Key);
end;

procedure TMDIChild.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
  Key: char;
begin
  Key:= '-';
  FormKeyPress(Sender, Key);
end;

end.
