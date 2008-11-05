object frmHost: TfrmHost
  Left = 216
  Top = 120
  BorderStyle = bsDialog
  Caption = 'ProSnooper - Host game'
  ClientHeight = 103
  ClientWidth = 289
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 56
    Height = 13
    Caption = 'Game name'
  end
  object Bevel1: TBevel
    Left = 0
    Top = 64
    Width = 289
    Height = 9
    Shape = bsTopLine
  end
  object Button1: TButton
    Left = 128
    Top = 72
    Width = 73
    Height = 25
    Caption = 'Go'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = Button1Click
  end
  object edName: TEdit
    Left = 8
    Top = 24
    Width = 273
    Height = 21
    TabOrder = 0
  end
  object Button2: TButton
    Left = 208
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 2
    OnClick = Button2Click
  end
  object http: TIdHTTP
    AllowCookies = True
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.CustomHeaders.Strings = (
      'Cookie: snooper=true'
      'UserLevel: 0'
      'UserServerIdent: 2')
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'T17Client/1.2'
    HTTPOptions = [hoForceEncodeParams]
    Left = 8
    Top = 72
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 120000
    OnTimer = Timer1Timer
    Left = 40
    Top = 72
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = Timer2Timer
    Left = 72
    Top = 72
  end
end
