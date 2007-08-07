object frmJoinGame: TfrmJoinGame
  Left = 769
  Top = 170
  BorderStyle = bsDialog
  Caption = 'ProSnooper - Join/Host Direct IP'
  ClientHeight = 246
  ClientWidth = 289
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 193
    Height = 13
    Caption = 'Hostname (leave this empty for hosting)'
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Bevel1: TBevel
    Left = 0
    Top = 208
    Width = 297
    Height = 9
    Shape = bsTopLine
  end
  object Edit1: TEdit
    Left = 8
    Top = 24
    Width = 273
    Height = 21
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 8
    Top = 72
    Width = 273
    Height = 21
    TabOrder = 1
    Text = '<default>'
  end
  object Button1: TButton
    Left = 128
    Top = 216
    Width = 73
    Height = 25
    Caption = 'Go'
    Default = True
    TabOrder = 3
    OnClick = Button1Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 104
    Width = 273
    Height = 81
    Caption = 'Advanced'
    TabOrder = 2
    object Label3: TLabel
      Left = 16
      Top = 24
      Width = 38
      Height = 13
      Caption = 'GameID'
    end
    object Label4: TLabel
      Left = 136
      Top = 24
      Width = 37
      Height = 13
      Caption = 'Scheme'
    end
    object Edit3: TEdit
      Left = 16
      Top = 40
      Width = 113
      Height = 21
      TabOrder = 0
    end
    object Edit4: TEdit
      Left = 136
      Top = 40
      Width = 121
      Height = 21
      TabOrder = 1
    end
  end
  object Button2: TButton
    Left = 208
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 4
    OnClick = Button2Click
  end
end
