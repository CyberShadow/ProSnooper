object frmMain: TfrmMain
  Left = 315
  Top = 83
  Width = 434
  Height = 410
  Caption = 'ProSnooper'
  Color = clBtnFace
  Constraints.MinWidth = 419
  Font.Charset = ANSI_CHARSET
  Font.Color = clSilver
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 323
    Width = 426
    Height = 22
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 0
    object Memo1: TMemo
      Left = 0
      Top = 0
      Width = 426
      Height = 22
      Align = alClient
      Color = clBlack
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clYellow
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      WantReturns = False
      OnKeyDown = Memo1KeyDown
      OnMouseMove = Memo1MouseMove
    end
  end
  object rechat: TRichEdit
    Left = 9
    Top = 32
    Width = 410
    Height = 280
    Align = alClient
    BevelInner = bvNone
    Color = clBlack
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clSilver
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    HideSelection = False
    ParentCtl3D = False
    ParentFont = False
    PopupMenu = pmChatEditBox
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
    OnMouseMove = rechatMouseMove
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 345
    Width = 426
    Height = 19
    Panels = <
      item
        Text = 'Connecting...'
        Width = 100
      end
      item
        Width = 50
      end>
  end
  object DockPanel1: TDockPanel
    Left = 419
    Top = 32
    Width = 7
    Height = 280
    Align = alRight
    BevelOuter = bvNone
    DockSite = True
    TabOrder = 3
    TabPosition = tpTop
  end
  object DockPanel2: TDockPanel
    Left = 0
    Top = 23
    Width = 426
    Height = 9
    Align = alTop
    BevelOuter = bvNone
    DockSite = True
    TabOrder = 4
    TabPosition = tpTop
  end
  object DockPanel3: TDockPanel
    Left = 0
    Top = 32
    Width = 9
    Height = 280
    Align = alLeft
    BevelOuter = bvNone
    DockSite = True
    TabOrder = 5
    TabPosition = tpTop
  end
  object DockPanel4: TDockPanel
    Left = 0
    Top = 312
    Width = 426
    Height = 11
    Align = alBottom
    BevelOuter = bvNone
    DockSite = True
    TabOrder = 6
    TabPosition = tpTop
  end
  object mp: TMediaPlayer
    Left = 120
    Top = 80
    Width = 29
    Height = 29
    VisibleButtons = [btPlay]
    Visible = False
    TabOrder = 7
  end
  object lbIgnore: TListBox
    Left = 120
    Top = 48
    Width = 28
    Height = 28
    ItemHeight = 13
    TabOrder = 8
    Visible = False
  end
  object pnAway: TPanel
    Left = 0
    Top = 0
    Width = 426
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Color = 14680063
    Font.Charset = ANSI_CHARSET
    Font.Color = clBtnText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    Visible = False
    DesignSize = (
      426
      23)
    object Label1: TLabel
      Left = 6
      Top = 5
      Width = 168
      Height = 13
      Caption = 'You are currently marked as away.'
    end
    object Label2: TLabel
      Left = 177
      Top = 5
      Width = 103
      Height = 13
      Cursor = crHandPoint
      Caption = 'Click here to go back.'
      Font.Charset = ANSI_CHARSET
      Font.Color = 9639221
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = Label2Click
    end
    object Label3: TLabel
      Left = 290
      Top = 5
      Width = 50
      Height = 13
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      Caption = 'Highlights:'
      Font.Charset = ANSI_CHARSET
      Font.Color = 9639221
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = Label3Click
    end
    object lblHiLites: TLabel
      Left = 343
      Top = 5
      Width = 6
      Height = 13
      Anchors = [akTop, akRight]
      Caption = '0'
    end
    object Label5: TLabel
      Left = 359
      Top = 5
      Width = 51
      Height = 13
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      Caption = 'Messages:'
      Font.Charset = ANSI_CHARSET
      Font.Color = 9639221
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = Label3Click
    end
    object lblMsgs: TLabel
      Left = 412
      Top = 5
      Width = 6
      Height = 13
      Anchors = [akTop, akRight]
      Caption = '0'
    end
  end
  object MainMenu1: TMainMenu
    AutoLineReduction = maManual
    Left = 56
    Top = 48
    object Files1: TMenuItem
      Caption = 'Files'
      object Saveas1: TMenuItem
        Caption = 'Save chat log...'
        ShortCut = 16467
        OnClick = Saveas1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Connection1: TMenuItem
      Caption = 'Options'
      object Channellist1: TMenuItem
        Caption = 'Channels...'
        ShortCut = 49219
        OnClick = Channellist1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Autologin1: TMenuItem
        AutoCheck = True
        Caption = 'Auto-login'
        OnClick = Autologin1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Buddies1: TMenuItem
        Caption = 'Buddies...'
        ShortCut = 49218
        OnClick = Buddies1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Settings1: TMenuItem
        Caption = 'Settings...'
        ShortCut = 49235
        OnClick = Settings1Click
      end
    end
    object Games1: TMenuItem
      Caption = 'Games'
      object JoindirectIP1: TMenuItem
        Caption = 'Join/host (direct IP)'
        ShortCut = 49224
        OnClick = JoindirectIP1Click
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object HostWormnet1: TMenuItem
        Caption = 'Host (Wormnet)'
        ShortCut = 16456
        OnClick = HostWormnet1Click
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object Help2: TMenuItem
        Caption = 'Help...'
        ShortCut = 112
        OnClick = Help2Click
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object About1: TMenuItem
        Caption = 'About'
        ShortCut = 113
        OnClick = About1Click
      end
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.rtf'
    Filter = 'Rich Text (*.rtf)|*.rtf'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Save chat log'
    Left = 24
    Top = 48
  end
  object irc: TVortex
    IrcOptions.ServerHost = 'stockholm.se.eu.undernet.org'
    IrcOptions.ServerPort = '6667'
    IrcOptions.UserName = 'IRC Component'
    IrcOptions.UserIdent = 'Username'
    IrcOptions.MyNick = 'Vortex193'
    IrcOptions.DefaultQuitMessage = 'ProSnooper 1.0.3'
    CtcpOptions.VersionReply = 'ProSnooper 1.1 build 107'
    CtcpOptions.FingerReply = 'FooBar'
    CtcpOptions.ReplyOnPing = False
    CtcpOptions.AnswerCtcps = True
    SocksOptions.SocksAuthentication = socksNoAuthentication
    AuthOptions.System = 'Vortex'
    AuthOptions.UseAuth = False
    AuthOptions.Enabled = False
    AfterPrivateMessage = ircAfterPrivateMessage
    AfterUserJoin = ircAfterUserJoin
    AfterJoined = ircAfterJoined
    AfterUserPart = ircAfterUserPart
    AfterUserQuit = ircAfterUserQuit
    AfterUserKick = ircAfterUserKick
    AfterAction = ircAfterAction
    OnChannelMessage = ircChannelMessage
    OnQuoteServer = ircQuoteServer
    OnServerError = ircServerError
    OnNickInUse = ircNickInUse
    OnNames = ircNames
    OnMOTD = ircMOTD
    OnWho = ircWho
    OnDisconnect = ircDisconnect
    OnConnect = ircConnect
    Left = 24
    Top = 80
  end
  object CoolTrayIcon1: TCoolTrayIcon
    CycleInterval = 0
    Icon.Data = {
      0000010001002020000001001800A80C00001600000028000000200000004000
      0000010018000000000000000000130B0000130B00000000000000000000E9C5
      52EAC552EAC552EAC453EAC553E9C552EAC553EAC552E9C552EAC553EAC553EA
      C552EAC553EAC552E9C552EAC553EAC553EAC552EAC553EAC552EAC552EAC553
      EAC553E9C452EAC553EAC553EAC552EAC552EAC453EAC553EAC553EAC552EBC8
      5EEBC85DEBC85EEBC85DEBC95DEBC95EEBC95DEBC95DEBC85DEBC85EEBC95DEB
      C85EECC95EECC95EEBC85EECC95EEBC95DEBC85DEBC95EEBC95EEBC95EEBC95E
      ECC85EEBC85DEBC85DEBC95DEBC85DEBC95DEBC95EEBC95DECC95DEBC95EECCC
      68ECCD68EDCD68ECCD69ECCC69EDCC68EDCC68ECCD68ECCC69EDCD69EDCC69ED
      CC68EDCD69EDCD68ECCD69ECCC69EDCC68EDCC69ECCC68ECCC69EDCC69EDCC68
      ECCC69EDCC69ECCC68ECCD68ECCC68EDCC69ECCC69EDCC68EDCC69EDCD68EED0
      74EDD074EED074EED074EED074EED074EED074EED075EED074EED074EED074EE
      D074EDD074EED074EED174EED074EED074EED074EED074EED074EED074EED074
      EED074EED074EED074EED074EED074EED074EED174EED074EED074EED074EFD4
      7FEFD47FF0D47FEFD47FF0D480EFD47FEFD47FEFD47FEFD47FEFD47FE2C878E2
      C879F0D480EFD47FEFD47FEFD480EFD47FEFD47FEFD47FEFD480EFD480EFD47F
      F0D47FEFD47FEFD47FEFD37FEFD47FEFD480EFD47FEFD47FEFD480EFD480F0D8
      8BF0D88BF0D88BF0D78BF0D88AF1D88AF1D88AF1D88BE4CB82897B4E897B4F88
      7B4F8F8052F1D88BF0D88BF1D88BF1D88AF1D78BF0D88AF1D88BF0D88BF1D88B
      F1D88BF1D78BF1D88BF1D88BF1D88AF1D88BF1D78BF1D88BF0D78BF0D88AF2DB
      96F2DC96F2DB96F2DC97F2DC96F2DB96F2DB96F2DC96D7C4868A7D568A7D558A
      7D558A7D56F2DC96F2DC96F2DC96F2DB96F2DB96F2DB96F2DC96F2DC96F2DC96
      F2DC96F2DB96F2DC96F2DC96F2DB96F2DC96F2DC96F2DC96F2DC96F2DC97F4DF
      A1F3DFA1F3DFA1F3E0A2F4DFA1F4E0A1F3DFA2F3DFA1D9C7908B7F5C8A7F5C8A
      7F5C8A7F5CF4DFA1F4DFA2F3E0A1F3E0A1F3DFA1F3DFA1F3E0A1F3DFA1F4DFA1
      F4DFA1F3E0A1F4DFA2F3E0A1F3E0A1F3E0A1F3DFA1F3DFA1F4DFA2F3DFA1F5E3
      ACF4E2ACF4E3ACF4E3ACF5E3ADF4E3ACF4E3ACF4E3ACD9CA998B81628B81628B
      81628B8162F5E3ACF5E3ACF5E3ACF5E3ACF5E3ADF5E3ACF5E3ACF5E3ACF4E3AC
      F4E2ACF5E3ACF5E3ACF5E3ADF5E3ACF5E3ACF4E3ACF5E3ACF5E3ACF5E3ACF6E7
      B6F6E7B7F6E6B7F6E6B7F6E7B7F6E6B6F6E7B7F6E6B7DBCEA28C83688C83678C
      83688C8368F6E7B7F5E6B7F6E6B6F6E7B6F6E7B7F6E7B7F6E6B7F6E7B7F6E7B6
      F6E6B7F6E6B7F6E6B6F6E7B7F5E7B7F6E6B7F6E7B7F6E7B7F6E7B7F6E7B7F7EA
      C1F7EAC1F8EAC2F8EAC1F7EAC1F7EAC2F8EAC1F7EAC1DCD0AC8D856E8D866E8C
      856E8D856EF7EAC1DCD0ACB4AB8EA79E82A79E82C2B897DCD0ACF8EAC1F7EBC1
      F8EAC1F8EAC1F7EAC1F7EAC1F7EAC1F7EAC1F7EAC1F8EAC1F7EAC1F7EAC1F8ED
      CBF9EDCBF9EECBF9EDCBF8EDCBF8EECBF9EDCBF8EDCBDDD3B58D87738D87738E
      87738D8773BCB39A8E87748D87738D87738E87738E87738E8773BCB39AF9EDCB
      F8EDCBF9EECBF9EECBF8EDCBF8EDCBF8EDCBF8EDCBF9EDCBF8EECBF9EECBF9F1
      D4F9F1D5FAF1D5FAF1D4F9F0D5FAF1D4FAF1D4FAF1D4DED6BE8E88798E89798E
      89798E88798E89798E88798E89798E89798E88798E89798E89798E8979BDB6A0
      FAF1D4FAF0D5FAF1D5FAF1D5FAF1D4FAF1D4F9F1D5FAF1D5FAF0D4FAF1D4FAF4
      DDFBF4DEFAF4DDFAF4DDFBF4DDFBF3DDFBF4DDFAF4DDDFD8C58F8A7E8E8A7E8E
      8A7E8F8A7E8E8A7E8E8A7E9490839490838F8A7E8F8A7E8E8B7E8F8A7E8F8B7E
      ECE6D1FAF4DDFBF4DDFBF4DDFAF3DDFBF3DEFAF3DDFBF3DDFAF4DDFBF4DEFCF6
      E6FCF6E5FCF6E6FCF7E6FBF6E6FBF6E6FBF6E6FCF6E6E0DBCD8F8C828F8C828F
      8C828F8C828F8C82CDC8BAF4EFDFFBF6E6CDC9BA8F8C828F8C838F8C828F8C82
      BFBBAEFBF6E6FCF6E5FCF7E5FCF7E5FBF6E5FBF6E5FCF6E6FCF7E6FBF6E6FDF9
      EDFCF8EDFCF9EDFCF8EDFDF8EDFCF9EDFCF9EDFDF9EDE0DED3908E878F8E8790
      8E878F8E87D4D1C7FDF9EDFCF8EDFDF9EDFDF9EDA4A1998F8E87908E87908E87
      9D9A93FCF9EEFDF9EDFCF8EDFCF9EDFDF8EDFDF9EDFDF9EDFDF9EDFCF9EDFEFB
      F4FEFBF4FDFBF4FDFBF3FEFBF4FEFBF4FEFBF4FEFBF3E1DFD9908F8B908F8B90
      8F8B908F8BFEFBF4FDFBF4FDFBF4FEFBF4FDFBF4CECCC6908F8B908F8B908F8B
      908F8BFEFBF4FDFBF3FDFBF4FDFBF4FDFBF3FEFBF3FDFBF4FDFBF3FEFBF3FEFD
      FAFEFDF9FEFDFAFEFDFAFEFDF9FEFDFAFEFDFAFEFDFAE2E1DF90908E91908E90
      908E90908EFEFDFAFEFDFAFEFEFAFEFDF9FEFEFAE3E1DE90908E91908E90908E
      91908EFEFDFAFEFDFAFEFDF9FEFEFAFEFDFAFEFDFAFEFDFAFEFDFAFEFDFAFFFF
      FFFFFFFFFEFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFE3E2E391919091909191
      9191909191FFFEFFFFFFFFFFFFFFFEFEFFFFFEFFE2E2E3919190919091909091
      919191FFFEFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
      FFFFFFFFFFFFFFFEFFFFFFFEFFFEFFFFFFFFFEFFFFFFE2E3E290919190919191
      9191919190FEFEFFFFFFFFFEFFFFFEFFFFFFFEFFDCDBDC919091909191919191
      919191FFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFEFFFEFFFFFFFFFEFEFFFFFFFF
      FFFFFFFFFEFFFFFFFEFFFFFFFFFFFFFFFEFFFFFFFFFEE3E3E391919091919091
      9191919191EAEAEAFFFEFFFFFFFFFEFFFFFFFEFFBAB9BA909091919090919090
      909191FFFFFFFEFFFFFFFFFFFFFFFFFEFFFEFFFFFFFFFFFFFEFFFFFEFFFFFFFF
      FFFFFFFFFFFFFFFFFEFFFEFFFFFFFFFFFEFFFEFEFEFFE3E2E391909191919091
      9191919191969697EAEAEAFEFFFFFFFFFEEAE9EA979797919190919191919190
      A5A4A5FFFEFFFFFEFFFEFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFEFFFEFFFFFFFF
      FEFFFFFFFFFFFFFEFEFFFFFEFEFFFEFEFEFFFFFFFFFFE2E2E391909091919091
      9191909091919191919091B9BABAB9B9B99D9E9D919091909191919191919191
      D6D5D5FFFFFFFEFEFFFFFFFEFFFFFFFEFEFEFEFFFEFFFFFEFFFFFFFFFEFFFFFF
      FFFEFEFEFFFFFFFFFEFFFFFFFFFFFEFFFEFFFFFFFFFEE3E3E391919091919190
      9090919091909191909091919190919191919191919191919191919091979797
      F8F8F7FEFEFFFFFFFFFEFFFFFFFFFEFFFFFFFFFFFFFEFFFFFFFFFEFEFFFEFFFE
      FEFFFFFEFFFEFFFEFFFEFFFEFEFFFFFEFFFFFFFEFFFEE3E3E391909191919091
      9191C1C1C1A5A5A5919191919191919091919090909191909191979797E9E9EA
      FFFFFFFFFFFEFFFFFFFFFFFEFEFEFFFFFEFFFFFEFEFEFFFFFFFFFFFFFFFFFFFE
      FFFEFFFEFFFFFFFFFEFEFFFEFEFFFFFFFFFEFEFFFFFFF8F8F7ACACAC979797AC
      ACACDBDCDCFFFFFFC7C8C79E9E9D919191909191919091A5A5A5EAEAEAFFFFFE
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFEFFFEFFFEFFFEFFFFFFFFFFFF
      FEFEFFFEFFFEFFFEFFFEFFFFFFFFFEFFFEFEFFFEFEFFFFFFFFFFFEFFFFFFFEFF
      FFFFFFFEFFFFFFFFFFFEFFFFFFFFF8F8F7E3E3E2F8F8F8FFFFFEFEFFFFFEFFFF
      FFFEFFFFFFFFFFFEFEFFFEFFFFFFFEFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFEFF
      FFFFFFFFFFFEFFFEFEFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFEFFFEFEFFFFFFFF
      FEFFFEFEFEFFFEFFFFFFFEFEFEFFFFFFFFFFFFFFFFFEFFFEFFFFFEFFFFFFFEFF
      FFFFFFFFFFFFFFFEFEFFFFFFFFFFFFFFFFFEFEFFFFFFFEFFFFFFFEFFFFFFFFFE
      FFFFFEFFFFFFFFFFFEFFFFFFFFFFFEFFFFFEFFFEFFFEFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFEFFFFFFFFFFFFFFFEFEFFFFFFFFFF
      FFFEFFFFFFFFFFFFFEFFFFFFFFFFFFFFFEFFFFFFFFFEFFFFFEFFFEFFFFFFFFFF
      FFFFFFFFFFFFFFFEFFFFFFFFFEFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFEFEFEFF
      FFFEFFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFEFFFFFFFFFEFFFF
      FFFFFFFEFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFEFFFFFFFEFEFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFFFEFEFFFEFEFFFFFF
      FEFFFFFFFFFFFFFFFFFEFFFEFEFFFFFFFFFEFEFFFFFFFFFFFEFFFFFFFFFFFFFF
      FEFFFEFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFFFFFFFEFEFFFFFFFF
      FFFFFFFEFFFFFEFEFEFFFFFEFFFFFFFFFFFFFFFFFEFEFFFEFFFFFFFEFFFFFFFF
      FEFFFEFFFFFEFFFFFFFFFFFFFFFFFEFFFEFEFFFFFFFFFFFFFEFFFEFFFEFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000}
    IconIndex = 0
    MinimizeToTray = True
    OnClick = CoolTrayIcon1Click
    OnMinimizeToTray = CoolTrayIcon1MinimizeToTray
    Left = 88
    Top = 48
  end
  object tmrGames: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = tmrGamesTimer
    Left = 88
    Top = 80
  end
  object pmChatEditBox: TPopupMenu
    Left = 56
    Top = 112
    object Copy1: TMenuItem
      Caption = 'Copy'
      OnClick = Copy1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object SelectAll1: TMenuItem
      Caption = 'Select All'
      OnClick = SelectAll1Click
    end
  end
  object http: TIdHTTP
    AllowCookies = True
    HandleRedirects = True
    RedirectMaximum = 0
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'T17Client/1.2'
    HTTPOptions = [hoForceEncodeParams]
    Left = 56
    Top = 80
  end
  object IdAntiFreeze1: TIdAntiFreeze
    OnlyWhenIdle = False
    Left = 24
    Top = 112
  end
  object tmrWhoCompat: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = tmrWhoCompatTimer
    Left = 88
    Top = 112
  end
end
