object JitterForm: TJitterForm
  Left = 444
  Top = 286
  Width = 283
  Height = 214
  Caption = 'Jitter'
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
    Left = 150
    Top = 13
    Width = 33
    Height = 13
    Caption = 'Value :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object RG: TRadioGroup
    Left = 8
    Top = 64
    Width = 241
    Height = 57
    Caption = 'Passes Count'
    Columns = 7
    Items.Strings = (
      '2'
      '3'
      '4'
      '8'
      '15'
      '24'
      '66')
    TabOrder = 0
    OnClick = RGClick
  end
  object EnabledBox: TCheckBox
    Left = 16
    Top = 8
    Width = 73
    Height = 17
    Caption = 'Enabled'
    TabOrder = 1
    OnClick = EnabledBoxClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 139
    Width = 275
    Height = 41
    Align = alBottom
    TabOrder = 2
    object BitBtn1: TBitBtn
      Left = 56
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 152
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      OnClick = BitBtn2Click
      Kind = bkCancel
    end
  end
  object Bar: TScrollBar
    Left = 8
    Top = 40
    Width = 241
    Height = 17
    PageSize = 0
    Position = 100
    TabOrder = 3
    OnChange = BarChange
  end
  object ST: TStaticText
    Left = 194
    Top = 12
    Width = 20
    Height = 17
    BorderStyle = sbsSunken
    Caption = 'ST'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
end
