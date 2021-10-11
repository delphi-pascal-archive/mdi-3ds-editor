object MainForm: TMainForm
  Left = 215
  Top = 163
  Width = 870
  Height = 600
  Caption = 'Shadow'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar2: TToolBar
    Left = 0
    Top = 0
    Width = 862
    Height = 30
    BorderWidth = 1
    ButtonWidth = 44
    Color = clBtnFace
    Indent = 5
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Wrapable = False
    object Button1: TButton
      Left = 5
      Top = 2
      Width = 75
      Height = 22
      Caption = 'Load'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object OpenDialog: TOpenDialog
    Filter = '3ds files|*.3ds'
    Left = 114
    Top = 4
  end
end
