object LookAtForm: TLookAtForm
  Left = 176
  Top = 188
  BorderStyle = bsDialog
  Caption = 'Look at'
  ClientHeight = 117
  ClientWidth = 448
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
    Left = 366
    Top = 0
    Width = 82
    Height = 117
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
      Top = 42
      Width = 75
      Height = 25
      Caption = 'Apply'
      TabOrder = 1
      OnClick = ApplyBtnClick
    end
    object CancelBtn: TBitBtn
      Left = 5
      Top = 76
      Width = 75
      Height = 25
      TabOrder = 2
      OnClick = CancelBtnClick
      Kind = bkCancel
    end
  end
  object EyeBox: TGroupBox
    Left = 8
    Top = 5
    Width = 105
    Height = 105
    Caption = 'Eye point'
    TabOrder = 1
    object Label3: TLabel
      Left = 10
      Top = 19
      Width = 14
      Height = 16
      Caption = 'X :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 10
      Top = 47
      Width = 15
      Height = 16
      Caption = 'Y :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 10
      Top = 74
      Width = 14
      Height = 16
      Caption = 'Z :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object EyeYEdit: TEdit
      Left = 32
      Top = 44
      Width = 65
      Height = 21
      TabOrder = 0
    end
    object EyeZEdit: TEdit
      Left = 32
      Top = 72
      Width = 65
      Height = 21
      TabOrder = 1
    end
    object EyeXEdit: TEdit
      Left = 32
      Top = 16
      Width = 65
      Height = 21
      TabOrder = 2
    end
  end
  object GroupBox1: TGroupBox
    Left = 127
    Top = 6
    Width = 105
    Height = 105
    Caption = 'Reference point'
    TabOrder = 2
    object Label4: TLabel
      Left = 10
      Top = 19
      Width = 14
      Height = 16
      Caption = 'X :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 10
      Top = 47
      Width = 15
      Height = 16
      Caption = 'Y :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 10
      Top = 74
      Width = 14
      Height = 16
      Caption = 'Z :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object RefYEdit: TEdit
      Left = 32
      Top = 44
      Width = 65
      Height = 21
      TabOrder = 0
    end
    object RefZEdit: TEdit
      Left = 32
      Top = 72
      Width = 65
      Height = 21
      TabOrder = 1
    end
    object RefXEdit: TEdit
      Left = 32
      Top = 16
      Width = 65
      Height = 21
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 246
    Top = 6
    Width = 105
    Height = 105
    Caption = 'Up vector'
    TabOrder = 3
    object Label7: TLabel
      Left = 10
      Top = 19
      Width = 14
      Height = 16
      Caption = 'X :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 10
      Top = 47
      Width = 15
      Height = 16
      Caption = 'Y :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 10
      Top = 74
      Width = 14
      Height = 16
      Caption = 'Z :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object UpYEdit: TEdit
      Left = 32
      Top = 44
      Width = 65
      Height = 21
      TabOrder = 0
    end
    object UpZEdit: TEdit
      Left = 32
      Top = 72
      Width = 65
      Height = 21
      TabOrder = 1
    end
    object UpXEdit: TEdit
      Left = 32
      Top = 16
      Width = 65
      Height = 21
      TabOrder = 2
    end
  end
end
