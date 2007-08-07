object frmMessages: TfrmMessages
  Left = 195
  Top = 107
  BorderStyle = bsDialog
  Caption = 'ProSnooper - Away log'
  ClientHeight = 215
  ClientWidth = 425
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
  object Bevel1: TBevel
    Left = -8
    Top = 176
    Width = 433
    Height = 9
    Shape = bsTopLine
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 409
    Height = 153
    Color = clBtnFace
    Ctl3D = True
    ParentCtl3D = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Button1: TButton
    Left = 344
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Close'
    Default = True
    TabOrder = 0
    WordWrap = True
    OnClick = Button1Click
  end
end
