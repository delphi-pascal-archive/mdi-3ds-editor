object TexturesForm: TTexturesForm
  Left = 366
  Top = 235
  BorderStyle = bsDialog
  Caption = 'Textures'
  ClientHeight = 322
  ClientWidth = 611
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
  object Label8: TLabel
    Left = 176
    Top = 4
    Width = 48
    Height = 13
    Caption = 'File name:'
  end
  object TextureFileNameLabel: TLabel
    Left = 232
    Top = 5
    Width = 3
    Height = 13
  end
  object Label1: TLabel
    Left = 535
    Top = 33
    Width = 73
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Transparent:'
  end
  object Label2: TLabel
    Left = 541
    Top = 106
    Width = 60
    Height = 13
    Caption = 'Texture size:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Bevel: TBevel
    Left = 174
    Top = 36
    Width = 200
    Height = 200
  end
  object Image: TImage
    Left = 174
    Top = 38
    Width = 200
    Height = 200
  end
  object FileSizeLabel: TLabel
    Left = 182
    Top = 21
    Width = 62
    Height = 13
    Caption = 'FileSizeLabel'
  end
  object TextureSizeLabel: TLabel
    Left = 543
    Top = 127
    Width = 56
    Height = 13
    Caption = 'TextureSize'
  end
  object GroupBox4: TGroupBox
    Left = 6
    Top = 7
    Width = 160
    Height = 234
    Caption = 'Textures'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object TexBox: TListBox
      Left = 2
      Top = 15
      Width = 156
      Height = 217
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
      OnClick = TexBoxClick
    end
  end
  object MinFilterGroup: TRadioGroup
    Left = 377
    Top = 29
    Width = 79
    Height = 58
    Caption = 'Min Filter'
    Items.Strings = (
      'Nearest'
      'Linear')
    TabOrder = 1
    OnClick = MinFilterGroupClick
  end
  object WrapSGroup: TRadioGroup
    Left = 461
    Top = 29
    Width = 76
    Height = 58
    Caption = 'Wrap S '
    Items.Strings = (
      'Clamp'
      'Repeat')
    TabOrder = 2
    OnClick = WrapSGroupClick
  end
  object MagFilterGroup: TRadioGroup
    Left = 377
    Top = 94
    Width = 79
    Height = 58
    Caption = 'Mag Filter'
    Items.Strings = (
      'Nearest'
      'Linear')
    TabOrder = 3
  end
  object WrapTGroup: TRadioGroup
    Left = 461
    Top = 95
    Width = 76
    Height = 58
    Caption = 'Wrap T'
    Items.Strings = (
      'Clamp'
      'Repeat')
    TabOrder = 4
  end
  object EnvModeGroup: TRadioGroup
    Left = 461
    Top = 158
    Width = 106
    Height = 73
    Caption = 'Environment Mode'
    Items.Strings = (
      'Modulate'
      'Decal'
      'Blend')
    TabOrder = 5
    OnClick = EnvModeGroupClick
  end
  object TexTransEdit: TEdit
    Tag = 22
    Left = 551
    Top = 53
    Width = 37
    Height = 18
    AutoSize = False
    TabOrder = 6
  end
  object ApplyBtn: TButton
    Left = 547
    Top = 79
    Width = 47
    Height = 17
    Caption = 'Apply'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object ClearBtn: TButton
    Left = 388
    Top = 201
    Width = 56
    Height = 25
    Caption = 'Clear'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    OnClick = ClearBtnClick
  end
  object LoadBtn: TButton
    Left = 388
    Top = 167
    Width = 56
    Height = 25
    Caption = 'Load'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = LoadBtnClick
  end
  object UseBox: TCheckBox
    Left = 440
    Top = 248
    Width = 57
    Height = 17
    Caption = 'Use'
    TabOrder = 10
    OnClick = UseBoxClick
  end
end
