object frmSettings: TfrmSettings
  Left = 219
  Top = 122
  BorderStyle = bsDialog
  Caption = 'ProSnooper - Settings'
  ClientHeight = 424
  ClientWidth = 303
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
  object Bevel1: TBevel
    Left = -8
    Top = 384
    Width = 321
    Height = 9
    Shape = bsTopLine
  end
  object Button1: TButton
    Left = 216
    Top = 392
    Width = 81
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = Button1Click
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 289
    Height = 361
    ActivePage = TabSheet1
    MultiLine = True
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Colors'
      object Label9: TLabel
        Left = 16
        Top = 48
        Width = 31
        Height = 13
        Caption = 'Text 1'
      end
      object Label6: TLabel
        Left = 16
        Top = 240
        Width = 25
        Height = 13
        Caption = 'Quits'
      end
      object Label5: TLabel
        Left = 16
        Top = 208
        Width = 25
        Height = 13
        Caption = 'Parts'
      end
      object Label4: TLabel
        Left = 16
        Top = 176
        Width = 24
        Height = 13
        Caption = 'Joins'
      end
      object Label3: TLabel
        Left = 16
        Top = 144
        Width = 35
        Height = 13
        Caption = 'Actions'
      end
      object Label2: TLabel
        Left = 16
        Top = 112
        Width = 84
        Height = 13
        Caption = 'Private messages'
      end
      object Label10: TLabel
        Left = 16
        Top = 80
        Width = 31
        Height = 13
        Caption = 'Text 2'
      end
      object Label1: TLabel
        Left = 16
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Background'
      end
      object colText2: TColorBox
        Left = 120
        Top = 80
        Width = 145
        Height = 22
        Selected = 7703700
        Style = [cbStandardColors, cbExtendedColors, cbCustomColor, cbPrettyNames]
        ItemHeight = 16
        TabOrder = 2
      end
      object colText1: TColorBox
        Left = 120
        Top = 48
        Width = 145
        Height = 22
        Selected = 14074262
        Style = [cbStandardColors, cbExtendedColors, cbCustomColor, cbPrettyNames]
        ItemHeight = 16
        TabOrder = 1
      end
      object colQuits: TColorBox
        Left = 120
        Top = 240
        Width = 145
        Height = 22
        Selected = 11523313
        Style = [cbStandardColors, cbExtendedColors, cbCustomColor, cbPrettyNames]
        ItemHeight = 16
        TabOrder = 7
      end
      object colPrivate: TColorBox
        Left = 120
        Top = 112
        Width = 145
        Height = 22
        Selected = 7335633
        Style = [cbStandardColors, cbExtendedColors, cbCustomColor, cbPrettyNames]
        ItemHeight = 16
        TabOrder = 3
      end
      object colParts: TColorBox
        Left = 120
        Top = 208
        Width = 145
        Height = 22
        Selected = 14475461
        Style = [cbStandardColors, cbExtendedColors, cbCustomColor, cbPrettyNames]
        ItemHeight = 16
        TabOrder = 6
      end
      object colJoins: TColorBox
        Left = 120
        Top = 176
        Width = 145
        Height = 22
        Selected = 13559276
        Style = [cbStandardColors, cbExtendedColors, cbCustomColor, cbPrettyNames]
        ItemHeight = 16
        TabOrder = 5
      end
      object colBackground: TColorBox
        Left = 120
        Top = 16
        Width = 145
        Height = 22
        Style = [cbStandardColors, cbExtendedColors, cbCustomColor, cbPrettyNames]
        ItemHeight = 16
        TabOrder = 0
      end
      object colActions: TColorBox
        Left = 120
        Top = 144
        Width = 145
        Height = 22
        Selected = 10794749
        Style = [cbStandardColors, cbExtendedColors, cbCustomColor, cbPrettyNames]
        ItemHeight = 16
        TabOrder = 4
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Buddies'
      ImageIndex = 5
      object lbBuddies: TListBox
        Left = 8
        Top = 8
        Width = 185
        Height = 313
        ItemHeight = 13
        TabOrder = 0
      end
      object Button8: TButton
        Left = 200
        Top = 43
        Width = 73
        Height = 25
        Caption = 'Delete'
        TabOrder = 1
        OnClick = Button8Click
      end
      object Button9: TButton
        Left = 200
        Top = 11
        Width = 73
        Height = 25
        Caption = 'Add'
        TabOrder = 2
        OnClick = Button9Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Display'
      ImageIndex = 1
      object Bevel3: TBevel
        Left = 72
        Top = 24
        Width = 193
        Height = 9
        Shape = bsTopLine
      end
      object Bevel2: TBevel
        Left = 96
        Top = 104
        Width = 169
        Height = 9
        Shape = bsTopLine
      end
      object Label7: TLabel
        Left = 32
        Top = 64
        Width = 38
        Height = 13
        Caption = 'Format:'
      end
      object Label8: TLabel
        Left = 16
        Top = 96
        Width = 77
        Height = 13
        Caption = 'Channel Actions'
      end
      object Label11: TLabel
        Left = 16
        Top = 16
        Width = 51
        Height = 13
        Caption = 'Timestamp'
      end
      object Bevel10: TBevel
        Left = 40
        Top = 208
        Width = 225
        Height = 9
        Shape = bsTopLine
      end
      object Label16: TLabel
        Left = 16
        Top = 200
        Width = 23
        Height = 13
        Caption = 'Chat'
      end
      object Label19: TLabel
        Left = 24
        Top = 224
        Width = 50
        Height = 13
        Caption = 'Font size: '
      end
      object edTimeStamp: TEdit
        Left = 80
        Top = 64
        Width = 57
        Height = 21
        TabOrder = 1
        Text = 'hh:nn:ss'
      end
      object cbTimeStamps: TCheckBox
        Left = 24
        Top = 40
        Width = 77
        Height = 17
        Caption = 'Timestamps'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object cbQuits: TCheckBox
        Left = 24
        Top = 168
        Width = 97
        Height = 17
        Caption = 'Show quits'
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
      object cbParts: TCheckBox
        Left = 24
        Top = 144
        Width = 97
        Height = 17
        Caption = 'Show parts'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object cbJoins: TCheckBox
        Left = 24
        Top = 120
        Width = 97
        Height = 17
        Caption = 'Show joins'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object edFntSize: TComboBox
        Left = 80
        Top = 224
        Width = 57
        Height = 21
        ItemHeight = 13
        TabOrder = 5
        Text = '8'
        Items.Strings = (
          '8'
          '9'
          '10'
          '11'
          '12'
          '14'
          '18'
          '24'
          '36'
          '48'
          '72')
      end
      object cbBlink: TCheckBox
        Left = 24
        Top = 256
        Width = 241
        Height = 17
        Caption = 'Blink tray icon'
        TabOrder = 6
      end
      object cbDisableScroll: TCheckBox
        Left = 24
        Top = 280
        Width = 105
        Height = 17
        Caption = 'Disable autoscroll'
        TabOrder = 7
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Sounds'
      ImageIndex = 2
      object Bevel6: TBevel
        Left = 136
        Top = 152
        Width = 129
        Height = 9
        Shape = bsTopLine
      end
      object Bevel5: TBevel
        Left = 141
        Top = 88
        Width = 124
        Height = 9
        Shape = bsTopLine
      end
      object Bevel4: TBevel
        Left = 152
        Top = 24
        Width = 113
        Height = 9
        Shape = bsTopLine
      end
      object Label12: TLabel
        Left = 16
        Top = 16
        Width = 134
        Height = 13
        Caption = 'When a buddy comes online'
      end
      object Label13: TLabel
        Left = 16
        Top = 80
        Width = 123
        Height = 13
        Caption = 'When you are highlighted'
      end
      object Label14: TLabel
        Left = 16
        Top = 144
        Width = 119
        Height = 13
        Caption = 'When you are messaged'
      end
      object edsndBuddy: TEdit
        Left = 24
        Top = 40
        Width = 161
        Height = 21
        TabOrder = 0
      end
      object Button2: TButton
        Left = 192
        Top = 40
        Width = 25
        Height = 21
        Caption = '>'
        TabOrder = 1
        OnClick = Button2Click
      end
      object edsndHiLite: TEdit
        Left = 24
        Top = 104
        Width = 161
        Height = 21
        TabOrder = 3
      end
      object Button3: TButton
        Left = 224
        Top = 104
        Width = 25
        Height = 21
        Caption = '...'
        TabOrder = 5
        OnClick = Button3Click
      end
      object edsndMsg: TEdit
        Left = 24
        Top = 168
        Width = 161
        Height = 21
        TabOrder = 6
      end
      object Button4: TButton
        Left = 224
        Top = 168
        Width = 25
        Height = 21
        Caption = '...'
        TabOrder = 8
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 224
        Top = 40
        Width = 25
        Height = 21
        Caption = '...'
        TabOrder = 2
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 192
        Top = 104
        Width = 25
        Height = 21
        Caption = '>'
        TabOrder = 4
        OnClick = Button6Click
      end
      object Button7: TButton
        Left = 192
        Top = 168
        Width = 25
        Height = 21
        Caption = '>'
        TabOrder = 7
        OnClick = Button7Click
      end
      object Button10: TButton
        Left = 192
        Top = 216
        Width = 73
        Height = 25
        Caption = 'Stop sounds'
        TabOrder = 9
        Visible = False
        OnClick = Button10Click
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Games'
      ImageIndex = 3
      object Bevel7: TBevel
        Left = 124
        Top = 24
        Width = 141
        Height = 9
        Shape = bsTopLine
      end
      object Label15: TLabel
        Left = 16
        Top = 16
        Width = 104
        Height = 13
        Caption = 'When hosting a game'
      end
      object Label17: TLabel
        Left = 56
        Top = 88
        Width = 55
        Height = 13
        Caption = 'Away-text:'
      end
      object Label20: TLabel
        Left = 56
        Top = 216
        Width = 55
        Height = 13
        Caption = 'Away-text:'
      end
      object Label18: TLabel
        Left = 16
        Top = 168
        Width = 100
        Height = 13
        Caption = 'When joining a game'
      end
      object Bevel8: TBevel
        Left = 120
        Top = 176
        Width = 145
        Height = 9
        Shape = bsTopLine
      end
      object Label22: TLabel
        Left = 16
        Top = 272
        Width = 137
        Height = 13
        Caption = 'Use W:A exe to open games'
      end
      object Bevel11: TBevel
        Left = 160
        Top = 280
        Width = 105
        Height = 9
        Shape = bsTopLine
      end
      object cbHostGameAnn: TCheckBox
        Left = 32
        Top = 40
        Width = 185
        Height = 17
        Caption = 'Announce'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object cbHostGameAway: TCheckBox
        Left = 32
        Top = 64
        Width = 97
        Height = 17
        Caption = 'Go away'
        TabOrder = 1
      end
      object edHostGameAway: TEdit
        Left = 56
        Top = 104
        Width = 185
        Height = 21
        TabOrder = 2
      end
      object cbGetIP: TCheckBox
        Left = 32
        Top = 136
        Width = 217
        Height = 17
        Caption = 'Get IP and port from W:A'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object cbJoinGameAway: TCheckBox
        Left = 32
        Top = 192
        Width = 97
        Height = 17
        Caption = 'Go away'
        TabOrder = 4
      end
      object edJoinGameAway: TEdit
        Left = 56
        Top = 232
        Width = 185
        Height = 21
        TabOrder = 5
      end
      object edExe: TEdit
        Left = 56
        Top = 296
        Width = 153
        Height = 21
        TabOrder = 6
      end
      object Button11: TButton
        Left = 216
        Top = 296
        Width = 25
        Height = 21
        Caption = '...'
        TabOrder = 7
        OnClick = Button11Click
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Away'
      ImageIndex = 4
      object Bevel9: TBevel
        Left = 48
        Top = 24
        Width = 217
        Height = 9
        Shape = bsTopLine
      end
      object Label21: TLabel
        Left = 16
        Top = 16
        Width = 27
        Height = 13
        Caption = 'Away'
      end
      object cbAwayAnnounce: TCheckBox
        Left = 32
        Top = 40
        Width = 233
        Height = 17
        Caption = 'Announce when going away'
        TabOrder = 0
      end
      object cbResumeAnnounce: TCheckBox
        Left = 32
        Top = 64
        Width = 217
        Height = 17
        Caption = 'Announce when resuming from away'
        TabOrder = 1
      end
      object cbSendAwayPriv: TCheckBox
        Left = 32
        Top = 88
        Width = 233
        Height = 17
        Caption = 'Send away reason on private message'
        TabOrder = 2
      end
      object cbSendAwayHiLite: TCheckBox
        Left = 32
        Top = 112
        Width = 233
        Height = 17
        Hint = 'Send the away-reason to anyone who mentions your nickname.'
        Caption = 'Send away reason on highlight'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
      end
    end
  end
  object mp: TMediaPlayer
    Left = 40
    Top = 392
    Width = 29
    Height = 28
    VisibleButtons = [btPlay]
    Visible = False
    TabOrder = 2
    OnNotify = mpNotify
  end
  object OpenDialog1: TOpenDialog
    Filter = 
      'Wave files (*.wav)|*.wav|Windows Media Audio (*.wma)|*.wma|MP3 a' +
      'udio (*.mp3)|*.mp3|All files (*.*)|*.*'
    Left = 8
    Top = 392
  end
  object OpenDialog2: TOpenDialog
    Filter = 
      'WA.exe, WormKit.exe|wa.exe;wormkit.exe|Executable files (*.exe)|' +
      '*.exe'
    Left = 72
    Top = 392
  end
end
