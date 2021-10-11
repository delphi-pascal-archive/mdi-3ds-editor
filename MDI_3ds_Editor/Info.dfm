object InfoForm: TInfoForm
  Left = 199
  Top = 180
  Width = 461
  Height = 222
  Caption = 'InfoForm'
  Color = clAqua
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 51
    Height = 13
    Caption = 'File name :'
  end
  object FileNameLabel: TLabel
    Left = 80
    Top = 16
    Width = 3
    Height = 13
  end
  object Label2: TLabel
    Left = 16
    Top = 40
    Width = 42
    Height = 13
    Caption = 'Objects :'
  end
  object ObjectsCountLabel: TLabel
    Left = 100
    Top = 40
    Width = 3
    Height = 13
  end
  object Label3: TLabel
    Left = 17
    Top = 61
    Width = 44
    Height = 13
    Caption = 'Vertices :'
  end
  object VerticesLabel: TLabel
    Left = 72
    Top = 61
    Width = 3
    Height = 13
  end
  object Label4: TLabel
    Left = 18
    Top = 82
    Width = 35
    Height = 13
    Caption = 'Faces :'
  end
  object FacesLabel: TLabel
    Left = 69
    Top = 82
    Width = 3
    Height = 13
  end
  object Label5: TLabel
    Left = 18
    Top = 104
    Width = 48
    Height = 13
    Caption = 'Materials :'
  end
  object MaterialsLabel: TLabel
    Left = 76
    Top = 104
    Width = 3
    Height = 13
  end
  object Label6: TLabel
    Left = 19
    Top = 124
    Width = 47
    Height = 13
    Caption = 'Textures :'
  end
  object TexturesLabel: TLabel
    Left = 77
    Top = 124
    Width = 3
    Height = 13
  end
  object Label7: TLabel
    Left = 18
    Top = 139
    Width = 66
    Height = 13
    Caption = 'Textures built:'
  end
  object TexBuiltLabel: TLabel
    Left = 92
    Top = 140
    Width = 3
    Height = 13
  end
end
