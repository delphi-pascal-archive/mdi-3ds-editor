object TextureForm: TTextureForm
  Left = 287
  Top = 239
  Width = 449
  Height = 283
  Caption = 'TextureForm'
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
    Left = 6
    Top = 10
    Width = 48
    Height = 13
    Caption = 'File name:'
  end
  object TextureFileNameLabel: TLabel
    Left = 62
    Top = 11
    Width = 3
    Height = 13
  end
  object Label1: TLabel
    Left = 365
    Top = 39
    Width = 73
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Transparent:'
  end
  object Label2: TLabel
    Left = 371
    Top = 112
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
    Left = 4
    Top = 42
    Width = 200
    Height = 200
  end
  object Image: TImage
    Left = 4
    Top = 41
    Width = 200
    Height = 200
  end
  object FileSizeLabel: TLabel
    Left = 12
    Top = 27
    Width = 62
    Height = 13
    Caption = 'FileSizeLabel'
  end
  object TextureSizeLabel: TLabel
    Left = 373
    Top = 133
    Width = 56
    Height = 13
    Caption = 'TextureSize'
  end
  object MinFilterGroup: TRadioGroup
    Left = 207
    Top = 35
    Width = 79
    Height = 58
    Caption = 'Min Filter'
    Items.Strings = (
      'Nearest'
      'Linear')
    TabOrder = 0
    OnClick = MinFilterGroupClick
  end
  object WrapSGroup: TRadioGroup
    Left = 291
    Top = 35
    Width = 76
    Height = 58
    Caption = 'Wrap S '
    Items.Strings = (
      'Clamp'
      'Repeat')
    TabOrder = 1
    OnClick = WrapSGroupClick
  end
  object MagFilterGroup: TRadioGroup
    Left = 207
    Top = 100
    Width = 79
    Height = 58
    Caption = 'Mag Filter'
    Items.Strings = (
      'Nearest'
      'Linear')
    TabOrder = 2
    OnClick = MinFilterGroupClick
  end
  object WrapTGroup: TRadioGroup
    Left = 291
    Top = 101
    Width = 76
    Height = 58
    Caption = 'Wrap T'
    Items.Strings = (
      'Clamp'
      'Repeat')
    TabOrder = 3
    OnClick = WrapSGroupClick
  end
  object EnvModeGroup: TRadioGroup
    Left = 291
    Top = 164
    Width = 106
    Height = 73
    Caption = 'Environment Mode'
    Items.Strings = (
      'Modulate'
      'Decal'
      'Blend')
    TabOrder = 4
    OnClick = EnvModeGroupClick
  end
  object TexTransEdit: TEdit
    Tag = 22
    Left = 381
    Top = 59
    Width = 37
    Height = 18
    AutoSize = False
    TabOrder = 5
  end
  object ApplyBtn: TButton
    Left = 377
    Top = 85
    Width = 47
    Height = 17
    Caption = 'Apply'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = ApplyBtnClick
  end
  object ClearBtn: TButton
    Left = 218
    Top = 207
    Width = 56
    Height = 25
    Caption = 'Clear'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = ClearBtnClick
  end
  object LoadBtn: TButton
    Left = 218
    Top = 173
    Width = 56
    Height = 25
    Caption = 'Load'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    OnClick = LoadBtnClick
  end
end
