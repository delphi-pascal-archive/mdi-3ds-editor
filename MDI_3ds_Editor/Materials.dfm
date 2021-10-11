object MaterialsForm: TMaterialsForm
  Left = 281
  Top = 181
  Width = 354
  Height = 486
  Caption = 'Materials'
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
  object Label1: TLabel
    Left = 9
    Top = 384
    Width = 42
    Height = 13
    Caption = 'Texture :'
  end
  object GroupBox4: TGroupBox
    Left = 9
    Top = 12
    Width = 160
    Height = 357
    Caption = 'Materials'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object MatBox: TListBox
      Left = 2
      Top = 15
      Width = 156
      Height = 340
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
      OnClick = MatBoxClick
    end
  end
  object MaterialBox: TGroupBox
    Left = 183
    Top = 4
    Width = 158
    Height = 366
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object ColorBox: TGroupBox
      Left = 6
      Top = 16
      Width = 143
      Height = 280
      Caption = 'Color'
      TabOrder = 0
      object GroupBox3: TGroupBox
        Left = 9
        Top = 12
        Width = 124
        Height = 65
        Caption = 'Ambient'
        TabOrder = 0
        object Amb: TShape
          Left = 6
          Top = 38
          Width = 111
          Height = 19
        end
        object AmbR: TStaticText
          Left = 6
          Top = 15
          Width = 34
          Height = 17
          Alignment = taCenter
          AutoSize = False
          BorderStyle = sbsSunken
          Color = clRed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 0
        end
        object AmbG: TStaticText
          Left = 45
          Top = 15
          Width = 34
          Height = 17
          Alignment = taCenter
          AutoSize = False
          BorderStyle = sbsSunken
          Color = clGreen
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 1
        end
        object AmbB: TStaticText
          Left = 83
          Top = 15
          Width = 34
          Height = 17
          Alignment = taCenter
          AutoSize = False
          BorderStyle = sbsSunken
          Color = clBlue
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 2
        end
      end
      object GroupBox5: TGroupBox
        Left = 9
        Top = 78
        Width = 124
        Height = 65
        Caption = 'Diffuse'
        TabOrder = 1
        object Diff: TShape
          Left = 6
          Top = 38
          Width = 111
          Height = 19
        end
        object DiffR: TStaticText
          Left = 6
          Top = 15
          Width = 34
          Height = 17
          Alignment = taCenter
          AutoSize = False
          BorderStyle = sbsSunken
          Color = clRed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 0
        end
        object DiffG: TStaticText
          Left = 45
          Top = 15
          Width = 34
          Height = 17
          Alignment = taCenter
          AutoSize = False
          BorderStyle = sbsSunken
          Color = clGreen
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 1
        end
        object DiffB: TStaticText
          Left = 83
          Top = 15
          Width = 34
          Height = 17
          Alignment = taCenter
          AutoSize = False
          BorderStyle = sbsSunken
          Color = clBlue
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 2
        end
      end
      object GroupBox6: TGroupBox
        Left = 10
        Top = 144
        Width = 124
        Height = 65
        Caption = 'Specular'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 2
        object Spec: TShape
          Left = 6
          Top = 38
          Width = 111
          Height = 19
        end
        object SpecR: TStaticText
          Left = 6
          Top = 15
          Width = 34
          Height = 17
          Alignment = taCenter
          AutoSize = False
          BorderStyle = sbsSunken
          Color = clRed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 0
        end
        object SpecG: TStaticText
          Left = 45
          Top = 15
          Width = 34
          Height = 17
          Alignment = taCenter
          AutoSize = False
          BorderStyle = sbsSunken
          Color = clGreen
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 1
        end
        object SpecB: TStaticText
          Left = 83
          Top = 15
          Width = 34
          Height = 17
          Alignment = taCenter
          AutoSize = False
          BorderStyle = sbsSunken
          Color = clBlue
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 2
        end
      end
      object GroupBox7: TGroupBox
        Left = 10
        Top = 210
        Width = 124
        Height = 65
        Caption = 'Emission'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 3
        object Emis: TShape
          Left = 6
          Top = 38
          Width = 111
          Height = 19
        end
        object EmisR: TStaticText
          Left = 6
          Top = 15
          Width = 34
          Height = 17
          Alignment = taCenter
          AutoSize = False
          BorderStyle = sbsSunken
          Color = clRed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 0
        end
        object EmisG: TStaticText
          Left = 45
          Top = 15
          Width = 34
          Height = 17
          Alignment = taCenter
          AutoSize = False
          BorderStyle = sbsSunken
          Color = clGreen
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 1
        end
        object EmisB: TStaticText
          Left = 83
          Top = 15
          Width = 34
          Height = 17
          Alignment = taCenter
          AutoSize = False
          BorderStyle = sbsSunken
          Color = clBlue
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 2
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 6
      Top = 296
      Width = 142
      Height = 63
      TabOrder = 1
      object Label4: TLabel
        Left = 2
        Top = 7
        Width = 79
        Height = 19
        Alignment = taCenter
        AutoSize = False
        Caption = 'Transparent:'
      end
      object Label12: TLabel
        Left = 80
        Top = 7
        Width = 60
        Height = 19
        Alignment = taCenter
        AutoSize = False
        Caption = 'Shininess:'
      end
      object MatTranspEdit: TEdit
        Tag = 22
        Left = 25
        Top = 27
        Width = 41
        Height = 21
        AutoSize = False
        ReadOnly = True
        TabOrder = 0
      end
      object Shin: TEdit
        Tag = 22
        Left = 88
        Top = 27
        Width = 47
        Height = 21
        AutoSize = False
        ReadOnly = True
        TabOrder = 1
      end
    end
  end
  object AssignBtn: TBitBtn
    Left = 24
    Top = 413
    Width = 75
    Height = 25
    Caption = 'Assign'
    TabOrder = 2
    OnClick = AssignBtnClick
  end
  object Button: TBitBtn
    Left = 260
    Top = 412
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkClose
  end
  object DeleteBtn: TBitBtn
    Left = 140
    Top = 413
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 4
    OnClick = DeleteBtnClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object TextureBtn: TButton
    Left = 55
    Top = 383
    Width = 283
    Height = 18
    TabOrder = 5
  end
end
