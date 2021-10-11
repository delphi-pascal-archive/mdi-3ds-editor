unit Lighting;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
    Buttons, ExtCtrls, aiOGL, ComCtrls;

type

  TLightingDlg = class(TForm)
    Panel1: TPanel;
    ApplyBtn: TButton;
    LightPages: TPageControl;
    Lighting: TTabSheet;
    GroupBox7: TGroupBox;
    ModelAmbColor: TShape;
    ModelAmbientRed: TStaticText;
    ModelAmbientGreen: TStaticText;
    ModelAmbientBlue: TStaticText;
    LocalViewerBox: TCheckBox;
    TwoSideBox: TCheckBox;
    Light0: TTabSheet;
    AmbBox0: TGroupBox;
    Amb0: TShape;
    AmbR0: TStaticText;
    AmbG0: TStaticText;
    AmbB0: TStaticText;
    DiffBox0: TGroupBox;
    Diff0: TShape;
    DiffR0: TStaticText;
    DiffG0: TStaticText;
    DiffB0: TStaticText;
    SpecBox0: TGroupBox;
    Spec0: TShape;
    SpecR0: TStaticText;
    SpecG0: TStaticText;
    SpecB0: TStaticText;
    ExpLabel0: TLabel;
    CutLabel0: TLabel;
    Exp0: TEdit;
    Cut0: TEdit;
    Inf0: TCheckBox;
    Switch0: TSpeedButton;
    PosBox0: TGroupBox;
    PX0: TLabel;
    PY0: TLabel;
    PZ0: TLabel;
    PosX0: TEdit;
    PosY0: TEdit;
    PosZ0: TEdit;
    DirBox0: TGroupBox;
    DX0: TLabel;
    DY0: TLabel;
    DZ0: TLabel;
    DirX0: TEdit;
    DirY0: TEdit;
    DirZ0: TEdit;
    AttBox0: TGroupBox;
    C0: TLabel;
    L0: TLabel;
    Q0: TLabel;
    AttConst0: TEdit;
    AttLin0: TEdit;
    AttQuad0: TEdit;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ApplyBtnClick(Sender: TObject);
    procedure ModelAmbColorMouseDown(Sender: TObject; Button: TMouseButton;
                                          Shift: TShiftState; X, Y: Integer);
    procedure Amb0MouseDown(Sender: TObject; Button: TMouseButton;
                                          Shift: TShiftState; X, Y: Integer);
    procedure LocalViewerBoxClick(Sender: TObject);
    procedure TwoSideBoxClick(Sender: TObject);
    procedure Inf0Click(Sender: TObject);
    procedure SBtn0Click(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
  private
    Error: boolean;
    LocalViewerSave, TwoSideSave: boolean;
    ModelAmbientSave: TColor;
    LightsSave: array of TLight;
    procedure CreateLightPages;
    procedure ShowLights;
    function FindControl(Page: integer;  Name1,Name2: string): TControl;
  end;

var
  LightingDlg: TLightingDlg;
  LastPage: integer;

implementation

uses
  Data;

{$R *.DFM}

procedure TLightingDlg.CreateLightPages;
var
  Page: integer;
  NewPage: TTabSheet;

procedure CopyPage;
var
  i,j: integer;
  CurControl1: TControl;
  CurControl2: TControl;
  NewControl: TControl;
  LastControl: TControl;

procedure CopyControlProperties(Control: TControl; Parent: TWinControl);
var
  Buffer: PChar;
  Size: byte;
begin
  if NewControl is TStaticText then
    begin
      TStaticText(NewControl).Color:= TStaticText(Control).Color;
      TStaticText(NewControl).Font.Assign(TStaticText(Control).Font);
      TStaticText(NewControl).AutoSize:= TStaticText(Control).AutoSize;
      TStaticText(NewControl).Alignment:= TStaticText(Control).Alignment;
      TStaticText(NewControl).BorderStyle:= TStaticText(Control).BorderStyle;
    end;
  NewControl.Top:= Control.Top;
  NewControl.Left:= Control.Left;
  NewControl.Width:= Control.Width;
  NewControl.Height:= Control.Height;

  Size:= Control.GetTextLen;
  Inc(Size);                       {Add room for null character}
  GetMem(Buffer, Size);            {Creates Buffer dynamic variable}
  Control.GetTextBuf(Buffer,Size);  //       getwindowtext
  NewControl.SetTextBuf(Buffer);
  FreeMem(Buffer, Size);           {Frees memory allocated to Buffer}

  NewControl.Name:= Copy(Control.Name, 1, Length(Control.Name) - 1) + IntToStr(Page);
  NewControl.Parent:= Parent;
end;

begin
  for i:= 0 to Light0.ControlCount - 1 do
    begin
      CurControl1:= Light0.Controls[i];
      if CurControl1 is TGroupBox then
        NewControl:= TGroupBox.Create(NewPage) else
        if CurControl1 is TLabel then
          NewControl:= TLabel.Create(NewPage) else
          if CurControl1 is TEdit then
            NewControl:= TEdit.Create(NewPage) else
            if CurControl1 is TCheckBox then
              begin
                NewControl:= TCheckBox.Create(NewPage);
              end else
              if CurControl1 is TSpeedButton then
                begin
                  NewControl:= TSpeedButton.Create(NewPage);
                  TSpeedButton(NewControl).Glyph.Assign(TSpeedButton(CurControl1).Glyph);
                  TSpeedButton(NewControl).NumGlyphs:= TSpeedButton(CurControl1).NumGlyphs;
                  TSpeedButton(NewControl).GroupIndex:= 1;
                  TSpeedButton(NewControl).AllowAllUp:= True;
                  TSpeedButton(NewControl).OnClick:= SBtn0Click;
                end;
      CopyControlProperties(CurControl1, NewPage);
      LastControl:= NewControl;
      if CurControl1 is TWinControl then
        for j:= 0 to TWinControl(CurControl1).ControlCount - 1 do
          begin
            CurControl2:= TWinControl(CurControl1).Controls[j];
            if CurControl2 is TLabel then
              NewControl:= TLabel.Create(LastControl) else
              if CurControl2 is TEdit then
                NewControl:= TEdit.Create(LastControl) else
                if CurControl2 is TStaticText then
                  begin
                    NewControl:= TStaticText.Create(LastControl);
                  end else
                 if CurControl2 is TShape then
                   begin
                     NewControl:= TShape.Create(LastControl);
                     TShape(NewControl).OnMouseDown:= Amb0MouseDown;
                   end;
            CopyControlProperties(CurControl2, LastControl as TWinControl);
          end;
    end;
end;

begin
  for Page:= 1 to MaxLights - 1 do // MaxLights - максимальное кол-во источников света в OpenGL
    begin
      NewPage:= TTabSheet.Create(LightPages);
      with NewPage do
        begin
          PageControl:= LightPages;
          Name:= 'Light' + IntToStr(Page);
          Caption:= Name;
        end;
      CopyPage; // копируем компоненты из первой закладки(нулевой источник) в новую
    end;
end;

function TLightingDlg.FindControl(Page: integer; Name1,Name2: string): TControl;
var
  i: integer;
  c1: TWinControl;
begin
  with LightPages.Pages[Page] do
    begin
      if Name1 <> '' then
        TControl(c1):= FindChildControl(Name1) else
        c1:= LightPages.Pages[Page];
      if Name2 <> '' then
        Result:= TWinControl(c1).FindChildControl(Name2) else
        Result:= c1;
      if Result = nil then
        for i := 0 to c1.ControlCount - 1 do
          if CompareText(c1.Controls[i].Name, Name2) = 0 then
            begin
              Result := c1.Controls[i];
              Exit;
            end;
    end;
end;

procedure TLightingDlg.ShowLights;
var
  i: integer;
  num: string;
  CheckBox: TCheckBox;
  SB: TSpeedButton;
begin
  ShowColor(CurScene.Lighting.ModelAmbient, ModelAmbientRed, ModelAmbientGreen,
                                              ModelAmbientBlue, ModelAmbColor);
  LocalViewerBox.Checked:= CurScene.Lighting.LocalViewer;
  TwoSideBox.Checked:= CurScene.Lighting.TwoSide;

  for i:= 0 to MaxLights - 1 do
    with CurScene.Lighting do
    begin
      num:= IntToStr(i);
      ShowColor(Ambient[i], FindControl(i+1, 'AmbBox' + num, 'AmbR' + num),
                            FindControl(i+1, 'AmbBox' + num, 'AmbG' + num),
                            FindControl(i+1, 'AmbBox' + num, 'AmbB' + num),
                            FindControl(i+1, 'AmbBox' + num, 'Amb' + num));
      ShowColor(Diffuse[i], FindControl(i+1, 'DiffBox' + num, 'DiffR' + num),
                            FindControl(i+1, 'DiffBox' + num, 'DiffG' + num),
                            FindControl(i+1, 'DiffBox' + num, 'DiffB' + num),
                            FindControl(i+1, 'DiffBox' + num, 'Diff' + num));
      ShowColor(Specular[i],FindControl(i+1, 'SpecBox' + num, 'SpecR' + num),
                            FindControl(i+1, 'SpecBox' + num, 'SpecG' + num),
                            FindControl(i+1, 'SpecBox' + num, 'SpecB' + num),
                            FindControl(i+1, 'SpecBox' + num, 'Spec' + num));
      ShowVector(Position[i], FindControl(i+1, 'PosBox' + num, 'PosX' + num),
                              FindControl(i+1, 'PosBox' + num, 'PosY' + num),
                              FindControl(i+1, 'PosBox' + num, 'PosZ' + num));
      ShowVector(Direction[i],FindControl(i+1, 'DirBox' + num, 'DirX' + num),
                              FindControl(i+1, 'DirBox' + num, 'DirY' + num),
                              FindControl(i+1, 'DirBox' + num, 'DirZ' + num));
      TEdit(FindControl(i+1, 'Exp' + num, '')).Text:= Format('%f', [SpotExponent[i]]);
      TEdit(FindControl(i+1, 'Cut' + num, '')).Text:= Format('%f', [SpotCutOff[i]]);


      CheckBox:= TCheckBox(FindControl(i+1, 'Inf' + num, ''));
      CheckBox.OnClick:= Nil;
      CheckBox.Checked:= Infinity[i];
      CheckBox.OnClick:= Inf0Click;
      ShowVector(Vector(AttConst[i], AttLinear[i], AttQuad[i]),
                                FindControl(i+1, 'AttBox' + num, 'AttConst' + num),
                                FindControl(i+1, 'AttBox' + num, 'AttLin' + num),
                                FindControl(i+1, 'AttBox' + num, 'AttQuad' + num));
      SB:= TSpeedButton(FindControl(i+1, '', 'Switch' + num));
      SB.OnClick:= Nil;
      SB.Down:= Enabled[i];
      SB.OnClick:= SBtn0Click;
    end;
end;

procedure TLightingDlg.FormCreate(Sender: TObject);
var
  i: integer;
begin
  CreateLightPages; // создать закладки для всех источников света
  ShowLights;       // показать все параметры освещения
  LightPages.ActivePageIndex:= LastPage;
// сохранить параметры освещения
  LocalViewerSave:= CurScene.Lighting.LocalViewer;
  TwoSideSave:= CurScene.Lighting.TwoSide;
  ModelAmbientSave:= CurScene.Lighting.ModelAmbient;
  SetLength(LightsSave, MaxLights);
  for i:= 0 to MaxLights - 1 do
    LightsSave[i]:= CurScene.Lighting[i];
end;

procedure TLightingDlg.OKBtnClick(Sender: TObject);
begin
  try
    ApplyBtnClick(Sender);
  finally
    if Error then
      ModalResult:= mrNone;
  end;
end;

procedure TLightingDlg.FormDestroy(Sender: TObject);
begin
  LastPage:= LightPages.ActivePageIndex;
  SetLength(LightsSave, 0);
end;

procedure TLightingDlg.ApplyBtnClick(Sender: TObject);
var
  i,j: integer;
  num: string[2];
  Vector: TVector;
begin
  Error:= False;
  try
  for i:= 0 to MaxLights - 1 do
    with CurScene.Lighting do
    begin
      j:= i;
      num:= IntToStr(i);  //char(i + $30);
      Position[i]:= GetVector(FindControl(i+1, 'PosBox' + num, 'PosX' + num),
                              FindControl(i+1, 'PosBox' + num, 'PosY' + num),
                              FindControl(i+1, 'PosBox' + num, 'PosZ' + num));
      Direction[i]:= GetVector(FindControl(i+1, 'DirBox' + num, 'DirX' + num),
                               FindControl(i+1, 'DirBox' + num, 'DirY' + num),
                               FindControl(i+1, 'DirBox' + num, 'DirZ' + num));

      SpotExponent[i]:= StrToFloat(TEdit(FindControl(i+1, 'Exp' + num, '')).Text);
      SpotCutOff[i]:= StrToFloat(TEdit(FindControl(i+1, 'Cut' + num, '')).Text);
      Vector:= GetVector(FindControl(i+1, 'AttBox' + num, 'AttConst' + num),
                         FindControl(i+1, 'AttBox' + num, 'AttLin' + num),
                         FindControl(i+1, 'AttBox' + num, 'AttQuad' + num));
      AttConst[i]:= Vector.X; AttLinear[i]:= Vector.Y; AttQuad[i]:= Vector.Z;
    end;
  ShowLights; // показать реальные значения параметров
  CurScene.Paint;
  except
    on EConvertError do
      begin
        LightPages.ActivePageIndex:= j + 1;
        Error:= True;
        raise;
      end;
  end;
end;

procedure TLightingDlg.ModelAmbColorMouseDown(Sender: TObject; Button: TMouseButton;
                                            Shift: TShiftState; X, Y: Integer);
begin
  Data1.ColorDialog.Color:= TShape(Sender).Brush.Color;
  if Data1.ColorDialog.Execute then
    begin
      ShowColor(Data1.ColorDialog.Color, ModelAmbientRed,
                           ModelAmbientGreen, ModelAmbientBlue, ModelAmbColor);
      CurScene.Lighting.ModelAmbient:= ModelAmbColor.Brush.Color;
      CurScene.Paint;
    end;
end;

procedure TLightingDlg.Amb0MouseDown(Sender: TObject; Button: TMouseButton;
                                           Shift: TShiftState; X, Y: Integer);
var
  Name_: string;
  num: string;
begin
  Data1.ColorDialog.Color:= (Sender as TShape).Brush.Color;
  if Data1.ColorDialog.Execute then
    begin
      num:= IntToStr(LightPages.ActivePageIndex - 1);
      Name_:= Copy(TShape(Sender).Name, 1, Length(TShape(Sender).Name) - Length(num));
      ShowColor(Data1.ColorDialog.Color, FindControl(LightPages.ActivePageIndex,
                                                Name_ + 'Box' + num, Name_ + 'R' + num),
        FindControl(LightPages.ActivePageIndex, Name_ + 'Box' + num, Name_ + 'G' + num),
        FindControl(LightPages.ActivePageIndex, Name_ + 'Box' + num, Name_ + 'B' + num),
                                                             Sender as TShape);
      with CurScene.Lighting do
      if Name_ = 'Amb' then
        Ambient[LightPages.ActivePageIndex-1]:= (Sender as TShape).Brush.Color else
        if Name_ = 'Diff' then
          Diffuse[LightPages.ActivePageIndex-1]:= (Sender as TShape).Brush.Color else
            Specular[LightPages.ActivePageIndex-1]:= (Sender as TShape).Brush.Color;
      CurScene.Paint;
    end;
end;

procedure TLightingDlg.LocalViewerBoxClick(Sender: TObject);
begin
  CurScene.Lighting.LocalViewer:= LocalViewerBox.Checked;
  CurScene.Paint;
end;

procedure TLightingDlg.TwoSideBoxClick(Sender: TObject);
begin
  CurScene.Lighting.TwoSide:= TwoSideBox.Checked;
  CurScene.Paint;
end;

procedure TLightingDlg.Inf0Click(Sender: TObject);
begin
  CurScene.Lighting.Infinity[LightPages.ActivePageIndex-1]:= TCheckBox(Sender).Checked;
  CurScene.Paint;
end;

procedure TLightingDlg.SBtn0Click(Sender: TObject);
begin
  CurScene.Lighting.Enabled[LightPages.ActivePageIndex-1]:= TSpeedButton(Sender).Down;
  CurScene.Paint;
end;

procedure TLightingDlg.CancelBtnClick(Sender: TObject);
var
  i: integer;
begin
// востановить сохраненные параметры 
  CurScene.Lighting.LocalViewer:= LocalViewerSave;
  CurScene.Lighting.TwoSide:= TwoSideSave;
  CurScene.Lighting.ModelAmbient:= ModelAmbientSave;
  for i:= 0 to MaxLights - 1 do
    CurScene.Lighting[i]:= LightsSave[i];
  CurScene.Paint;
end;

initialization

  LastPage:= 0;

end.

