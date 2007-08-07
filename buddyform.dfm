object frmBuddies: TfrmBuddies
  Left = 582
  Top = 254
  BorderStyle = bsDialog
  Caption = 'ProSnooper - Buddies'
  ClientHeight = 319
  ClientWidth = 218
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    Left = 0
    Top = 280
    Width = 281
    Height = 9
    Shape = bsTopLine
  end
  object lbBuddies: TListBox
    Left = 8
    Top = 8
    Width = 201
    Height = 233
    ItemHeight = 13
    TabOrder = 3
  end
  object Button2: TButton
    Left = 136
    Top = 248
    Width = 73
    Height = 25
    Caption = 'Delete'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button1: TButton
    Left = 56
    Top = 248
    Width = 73
    Height = 25
    Caption = 'Add'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 136
    Top = 288
    Width = 73
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = Button3Click
  end
end
