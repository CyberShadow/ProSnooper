object PageControlHost: TPageControlHost
  Left = 108
  Top = 481
  Width = 396
  Height = 272
  BorderStyle = bsSizeToolWin
  Color = clBtnFace
  DragKind = dkDock
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 388
    Height = 245
    Align = alClient
    DockSite = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnChange = PageControlChange
    OnDockDrop = PageControlDockDrop
    OnGetSiteInfo = PageControlGetSiteInfo
    OnUnDock = PageControlUnDock
  end
  object tmr: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tmrTimer
    Left = 16
    Top = 16
  end
  object img: TImageList
    Left = 184
    Top = 128
  end
end
