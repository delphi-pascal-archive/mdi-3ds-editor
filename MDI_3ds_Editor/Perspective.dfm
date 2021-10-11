object PerspectiveForm: TPerspectiveForm
  Left = 185
  Top = 282
  BorderStyle = bsDialog
  Caption = 'Perspective'
  ClientHeight = 145
  ClientWidth = 375
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 291
    Top = 0
    Width = 84
    Height = 145
    Align = alRight
    BevelInner = bvLowered
    TabOrder = 0
    object OKBtn: TBitBtn
      Left = 5
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = OKBtnClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object ApplyBtn: TButton
      Left = 5
      Top = 44
      Width = 75
      Height = 25
      Caption = 'Apply'
      TabOrder = 1
      OnClick = ApplyBtnClick
    end
    object BitBtn1: TBitBtn
      Left = 5
      Top = 80
      Width = 75
      Height = 25
      TabOrder = 2
      OnClick = BitBtn1Click
      Kind = bkCancel
    end
  end
  object GroupBox1: TGroupBox
    Left = 6
    Top = 3
    Width = 275
    Height = 138
    Caption = 'Perspective'
    TabOrder = 1
    object Label3: TLabel
      Left = 6
      Top = 19
      Width = 114
      Height = 16
      Caption = 'Field of view angle:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 26
      Top = 50
      Width = 74
      Height = 16
      Caption = 'Aspect ratio:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 40
      Top = 77
      Width = 39
      Height = 16
      Caption = 'zNear:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 47
      Top = 107
      Width = 29
      Height = 16
      Caption = 'zFar:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ZFarEdit: TEdit
      Left = 120
      Top = 107
      Width = 65
      Height = 21
      TabOrder = 4
    end
    object ZNearEdit: TEdit
      Left = 120
      Top = 78
      Width = 65
      Height = 21
      TabOrder = 3
    end
    object AspectEdit: TEdit
      Left = 120
      Top = 48
      Width = 65
      Height = 21
      TabOrder = 1
    end
    object FovEdit: TEdit
      Left = 120
      Top = 19
      Width = 65
      Height = 21
      TabOrder = 0
    end
    object AutoBox: TCheckBox
      Left = 191
      Top = 51
      Width = 79
      Height = 17
      Caption = 'Auto aspect'
      TabOrder = 2
      OnClick = AutoBoxClick
    end
  end
end
