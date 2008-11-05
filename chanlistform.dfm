object frmChanList: TfrmChanList
  Left = 217
  Top = 127
  BorderStyle = bsDialog
  Caption = 'ProSnooper - Channel List'
  ClientHeight = 240
  ClientWidth = 425
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = -8
    Top = 200
    Width = 441
    Height = 9
    Shape = bsTopLine
  end
  object lvChans: TListView
    Left = 8
    Top = 8
    Width = 409
    Height = 177
    Columns = <
      item
        Caption = 'Channel'
        MaxWidth = 130
        Width = 130
      end
      item
        Caption = 'Users'
        MaxWidth = 40
        Width = 40
      end
      item
        Caption = 'Topic'
        MaxWidth = 230
        Width = 230
      end>
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = Button1Click
  end
  object Button1: TButton
    Left = 264
    Top = 208
    Width = 73
    Height = 25
    Caption = 'Join'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 344
    Top = 208
    Width = 73
    Height = 25
    Caption = 'Close'
    TabOrder = 2
    OnClick = Button2Click
  end
end
