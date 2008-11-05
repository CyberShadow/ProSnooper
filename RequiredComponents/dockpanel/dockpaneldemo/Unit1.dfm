object Form1: TForm1
  Left = 271
  Top = 218
  Width = 870
  Height = 498
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object DockPanel1: TDockPanel
    Left = 0
    Top = 73
    Width = 89
    Height = 275
    Align = alLeft
    DockSite = True
    TabOrder = 0
    TabPosition = tpBottom
  end
  object DockPanel2: TDockPanel
    Left = 760
    Top = 73
    Width = 102
    Height = 275
    Align = alRight
    DockSite = True
    TabOrder = 1
    TabPosition = tpTop
  end
  object DockPanel4: TDockPanel
    Left = 0
    Top = 0
    Width = 862
    Height = 73
    Align = alTop
    DockSite = True
    TabOrder = 2
    TabPosition = tpTop
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 433
    Width = 862
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object DockPanel3: TDockPanel
    Left = 0
    Top = 348
    Width = 862
    Height = 85
    Align = alBottom
    DockSite = True
    TabOrder = 4
    TabPosition = tpLeft
  end
  object MainMenu1: TMainMenu
    Left = 424
    Top = 240
    object ViewWindows1: TMenuItem
      Caption = 'View Windows'
      object Window11: TMenuItem
        Caption = 'Window1'
        OnClick = Window11Click
      end
      object Window21: TMenuItem
        Caption = 'Window2'
        OnClick = Window21Click
      end
      object Window31: TMenuItem
        Caption = 'Window3'
        OnClick = Window31Click
      end
      object Window41: TMenuItem
        Caption = 'Window4'
        OnClick = Window41Click
      end
    end
    object Help1: TMenuItem
      Caption = '&Help'
      object About1: TMenuItem
        Caption = '&About'
        OnClick = About1Click
      end
    end
  end
end
