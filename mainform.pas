unit mainform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, Menus, StrUtils, vortex,
  CoolTrayIcon, Registry, IdHTTP, ShellAPI, DockPanel, nickdock, gamedock,
  ImgList, IdCmdTCPClient, IdContext, IdAntiFreezeBase,
  IdAntiFreeze, RichEditURL, DBCtrls, richedit;

type

  TWords = class
  private
    FText: string;
    FWords: TStringList;
    procedure Parse;
    function GetWord(Index: Integer): string;
    procedure SetText(const Value: string);
    function GetCount: integer;
  public
    constructor Create;
    destructor Destroy; override;
    function ConcatToEnd(From: integer): string;
    property Text: string
      read  FText
      write SetText;
    property Words[Index: Integer]: string
      read  GetWord;
      default;
    property Count: integer
      read  GetCount;
  end;

  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    Files1: TMenuItem;
    Exit1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    Panel1: TPanel;
    rechat: TRichEditURL;
    Memo1: TMemo;
    StatusBar1: TStatusBar;
    Connection1: TMenuItem;
    SaveDialog1: TSaveDialog;
    Saveas1: TMenuItem;
    N1: TMenuItem;
    irc: TVortex;
    CoolTrayIcon1: TCoolTrayIcon;
    Autologin1: TMenuItem;
    tmrGames: TTimer;
    pmChatEditBox: TPopupMenu;
    Copy1: TMenuItem;
    N4: TMenuItem;
    SelectAll1: TMenuItem;
    http: TIdHTTP;
    DockPanel1: TDockPanel;
    Settings1: TMenuItem;
    DockPanel2: TDockPanel;
    DockPanel3: TDockPanel;
    DockPanel4: TDockPanel;
    Games1: TMenuItem;
    JoindirectIP1: TMenuItem;
    N2: TMenuItem;
    N5: TMenuItem;
    lbIgnore: TListBox;
    N6: TMenuItem;
    HostWormnet1: TMenuItem;
    pnAway: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Channellist1: TMenuItem;
    IdAntiFreeze1: TIdAntiFreeze;
    N7: TMenuItem;
    Help2: TMenuItem;
    Label3: TLabel;
    lblHiLites: TLabel;
    Label5: TLabel;
    lblMsgs: TLabel;
    tmrWhoCompat: TTimer;
    lbIgnoreAway: TListBox;
    Icons: TImageList;
    FD: TFindDialog;
    N3: TMenuItem;
    Find1: TMenuItem;
    Clear1: TMenuItem;
    Image1: TImage;
    procedure Memo1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure rechatMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lbnicksMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Saveas1Click(Sender: TObject);
    procedure Memo1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ircMOTD(Line: String; EndOfMotd: Boolean);
    procedure ircNickInUse(Nickname: String);
    procedure ircChannelMessage(Channelname, Content, Nickname, Ident,
      Mask: String);
    procedure ircAfterPrivateMessage(Nickname, Ident, Mask,
      Content: String);
    procedure ircAfterUserJoin(Nickname, Hostname, Channel: String);
    procedure ircAfterUserPart(Nickname, Hostname, Channelname,
      Reason: String);
    procedure ircAfterUserQuit(Nickname, Reason: String);
    procedure ircNames(Commanicks, Channel: String; endofnames: Boolean);
    procedure ircAfterUserKick(KickedUser, Kicker, Channel,
      Reason: String);
    procedure ircConnect;
    procedure ircDisconnect;
    procedure ircAfterAction(NickName, Content, Destination: String);
    procedure About1Click(Sender: TObject);
    procedure CoolTrayIcon1Click(Sender: TObject);
    procedure CoolTrayIcon1MinimizeToTray(Sender: TObject);
    procedure lbGamesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure Autologin1Click(Sender: TObject);
    procedure tmrGamesTimer(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Settings1Click(Sender: TObject);
    procedure AddRichLine(RichEdit: TRichEdit; const StrToAdd: String);
    procedure JoindirectIP1Click(Sender: TObject);
   procedure ircQuoteServer(Command: String);
    function FindListViewItem(lv: TListView; const S: string; column: Integer): TListItem;
    procedure ircWho(Channel, Nickname, Username, Hostname, Name,
      Servername, status, other: String; EndOfWho: Boolean);
    procedure ircAfterJoined(Channelname: String);
    procedure HostWormnet1Click(Sender: TObject);
    procedure GoAway(Reason: String);
    procedure FormDestroy(Sender: TObject);
    procedure ircServerError(ErrorString: String);
    procedure Label2Click(Sender: TObject);
    procedure Channellist1Click(Sender: TObject);
    procedure Help2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure tmrWhoCompatTimer(Sender: TObject);
    procedure ircAfterUserNickChange(Oldnick, Newnick: String);
    procedure rechatURLClick(Sender: TObject; const URL: String);
    procedure Find1Click(Sender: TObject);
    procedure FDFind(Sender: TObject);
    function FindText(const SearchStr: string;
               StartPos, FindLength : LongInt; Options: TSearchTypes;
               SearchDown: Boolean = TRUE): Integer;
    procedure Clear1Click(Sender: TObject);
    procedure ircNoSuchNickChannel(Value: String);
    procedure ircAfterInvited(NickName, Channel: String);
    procedure ircMode(Nickname, Destination, Mode: String);
    procedure SetFlagRank(Flag, Rank: Integer; Nickname: String);
    procedure ircAfterTopic(ChannelName, Nickname, Topic: String);
  private
    procedure AppException(Sender: TObject; E: Exception);
  public
    IsAway: Boolean;
    function MakeTimeStamp: String;
    function MakeTimeStampNoTags: String;
  end;

var
  frmMain: TfrmMain;
  PreviousFoundPos: integer;
  nickfrm: TfrmdkNickList;
  gmfrm: TfrmdkGmList;
  AwayReason: String;

implementation

uses loginform, aboutform, preferform, joinform, hostform,
  chanlistform, messagesform;


{$R *.dfm}

procedure TfrmMain.AppException(Sender: TObject; E: Exception);
begin
  AddRichLine(rechat,MakeTimeStamp+'ProSnooper error: '+e.Message+' ['+Sender.ClassName+']');
end;

constructor TWords.Create;
begin
  inherited;
  FWords := TStringList.Create;
end;

destructor TWords.Destroy;
begin
  FWords.Free;
  inherited;
end;

function TWords.GetCount: integer;
begin
  Result := FWords.Count;
end;

function TWords.GetWord(Index: Integer): string;
begin
  if index >= Count then
    Result := ''
  else
    Result := FWords[index];
end;

procedure TWords.Parse;
var
  i: integer;
  w: string;
begin
  FWords.Clear;
  w := '';
  for i := 1 to Length(FText) do
  begin
    case FText[i] of
    #9, #10, #13, #32: // whitespace
      if w <> '' then
      begin
        FWords.Add(w);
        w := '';
      end;
    else
      w := w + FText[i]
    end;
  end;
  if w <> '' then
    FWords.Add(w);
end;

procedure TWords.SetText(const Value: string);
begin
  if Value <> FText then
  begin
    FText := Value;
    Parse;
  end;
end;

function TWords.ConcatToEnd(From: integer): string;
var
  i: integer;
begin
  result := '';
  for i := From to Count-1 do
  begin
    if i <> From then
      Result := Result + ' ';
    Result := Result + Words[i];
  end;
end;

procedure TfrmMain.AddRichLine(RichEdit: TRichEdit; const StrToAdd: String);
var
   StrLeft: String;
   TempStyle: TFontStyles;
   TempStr: String;
   changed: boolean;
   HadFocus: Boolean;
   WasHideSel: Boolean;
   SelSt, SelL: Integer;

   function FromLeftUntilStr(var OriginalStr: String; const UntilStr: String; const ToEndIfNotFound, Trim: Boolean): String;
   var
      TempPos: Integer;
   begin
      TempPos := Pos(UntilStr, OriginalStr);
      If TempPos > 0 Then
         Begin
            Result := Copy(OriginalStr, 1, TempPos - 1);
            If Trim Then
               Delete(OriginalStr, 1, TempPos - 1);
         End
            Else
         Begin
            If ToEndIfNotFound Then
               Begin
                  Result := OriginalStr;
                  If Trim Then
                     OriginalStr := '';
               End
                  Else
               Result := '';
         End;
   end;

   function FromLeftUntilStrX(var OriginalStr: String; const UntilStr: String; const ToEndIfNotFound, Trim: Boolean): String;
   var
      xStr : String;
   begin
      xStr := Copy(OriginalStr,2,Length(OriginalStr));
      result := '<' + FromLeftUntilStr(xStr,UntilStr,ToEndIfNotFound,Trim);
      OriginalStr := xStr;
   end;

   function StrStartsWith(var OriginalStr: String; const StartsWith: String; const IgnoreCase, Trim: Boolean): Boolean;
   var
      PartOfOriginalStr: String;
      NewStartsWith: String;
   begin
      PartOfOriginalStr := Copy(OriginalStr, 1, Length(StartsWith));
      NewStartsWith := StartsWith;

      If IgnoreCase Then Begin
         PartOfOriginalStr := LowerCase(PartOfOriginalStr);
         NewStartsWith := LowerCase(NewStartsWith);
      End;

      Result := PartOfOriginalStr = NewStartsWith;

      If (Result = True) And (Trim = True) Then
         Delete(OriginalStr, 1, Length(NewStartsWith));
   end;

   procedure AddToStyle(var Style: TFontStyles; AStyle: TFontStyle);
   begin
      If Not (AStyle In Style) Then
         Style := Style + [AStyle];
   end;

   procedure RemoveFromStyle(var Style: TFontStyles; AStyle: TFontStyle);
   begin
      If AStyle In Style Then
         Style := Style - [AStyle];
   end;
begin
   // ProSnooper hack: don't move the scrollbar
   if frmSettings.cbDisableScroll.Checked then begin
     HadFocus := GetFocus = RichEdit.Handle;
     if HadFocus then Windows.SetFocus(0);
      WasHideSel := RichEdit.HideSelection;
     RichEdit.HideSelection := true;
     SelSt := RichEdit.SelStart;
     SelL := RichEdit.SelLength;
   end;

   TempStyle := RichEdit.Font.Style;
   StrLeft := StrToAdd;
   RichEdit.SelStart := Length(RichEdit.Text);
   
   if Pos('\',StrLeft) <> 0 then begin
   StrLeft := StringReplace(StrLeft,'\r','<pcol=clRed>',[rfReplaceAll, rfIgnoreCase]);
   StrLeft := StringReplace(StrLeft,'\b','<pcol=clAqua>',[rfReplaceAll, rfIgnoreCase]);
   StrLeft := StringReplace(StrLeft,'\g','<pcol=clLime>',[rfReplaceAll, rfIgnoreCase]);
   StrLeft := StringReplace(StrLeft,'\k','<pcol=clGray>',[rfReplaceAll, rfIgnoreCase]);
   StrLeft := StringReplace(StrLeft,'\n','<pcol=clMedGray>',[rfReplaceAll, rfIgnoreCase]);
   StrLeft := StringReplace(StrLeft,'\p','<pcol=$00FCB6F4>',[rfReplaceAll, rfIgnoreCase]);
   StrLeft := StringReplace(StrLeft,'\w','<pcol=clWhite>',[rfReplaceAll, rfIgnoreCase]);
   StrLeft := StringReplace(StrLeft,'\y','<pcol=clYellow>',[rfReplaceAll, rfIgnoreCase]);
   StrLeft := StringReplace(StrLeft,'\m','<pcol=clMoneyGreen>',[rfReplaceAll, rfIgnoreCase]);
   end;

   While StrLeft > '' Do Begin

      If StrStartsWith(StrLeft, '<', True, False) then
         Begin
            changed := false;
            // Bold Style
            If StrStartsWith(StrLeft, '<b>', True, True) Then
               begin AddToStyle(TempStyle, fsBold); changed := true; end;
            If StrStartsWith(StrLeft, '</b>', True, True) Then
               begin RemoveFromStyle(TempStyle, fsBold); changed := true; end;

            // Italic Style
            If StrStartsWith(StrLeft, '<i>', True, True) Then
               begin AddToStyle(TempStyle, fsItalic); changed := true; end;
            If StrStartsWith(StrLeft, '</i>', True, True) Then
               begin RemoveFromStyle(TempStyle, fsItalic); changed := true; end;

            // Underline Style
            If StrStartsWith(StrLeft, '<u>', True, True) Then
               begin AddToStyle(TempStyle, fsUnderline); changed := true; end;
            If StrStartsWith(StrLeft, '</u>', True, True) Then
               begin RemoveFromStyle(TempStyle, fsUnderline); changed := true; end;

            // Strikeout Style
            If StrStartsWith(StrLeft, '<s>', True, True) Then
               begin AddToStyle(TempStyle, fsStrikeOut); changed := true; end;
            If StrStartsWith(StrLeft, '</s>', True, True) Then
               begin RemoveFromStyle(TempStyle, fsStrikeOut); changed := true; end;

            // Color
            If StrStartsWith(StrLeft, '</color>', True, True) Then
               begin RichEdit.SelAttributes.Color := RichEdit.Font.Color; changed := true; end;
            If StrStartsWith(StrLeft, '<color=', True, True) Then Begin
               TempStr := FromLeftUntilStr(StrLeft, '>', False, True); changed := true;
               Try
                  RichEdit.SelAttributes.Color := StringToColor('cl'+TempStr);
               Except
                  RichEdit.SelAttributes.Color := RichEdit.Font.Color;
               End;
               Delete(StrLeft, 1, 1);
            End;

            If StrStartsWith(StrLeft, '</pcol>', True, True) Then
               begin RichEdit.SelAttributes.Color := RichEdit.Font.Color; changed := true; end;
            If StrStartsWith(StrLeft, '<pcol=', True, True) Then Begin
               TempStr := FromLeftUntilStr(StrLeft, '>', False, True); changed := true;
               Try
                  RichEdit.SelAttributes.Color := StringToColor(TempStr);
               Except
                  RichEdit.SelAttributes.Color := RichEdit.Font.Color;
               End;
               Delete(StrLeft, 1, 1);
            End;
            
            if not changed then
            begin
                RichEdit.SelAttributes.Style := TempStyle;
                RichEdit.Font.Color := frmSettings.colText2.Selected;
                RichEdit.SelAttributes.Size := StrToInt(frmSettings.edFntSize.Text);
                RichEdit.SelText := FromLeftUntilStrX(StrLeft, '<', True, True);

            end;
         End
         Else
         Begin
            RichEdit.SelAttributes.Style := TempStyle;
            RichEdit.Font.Color := frmSettings.colText2.Selected;
            RichEdit.SelAttributes.Size := StrToInt(frmSettings.edFntSize.Text);
            RichEdit.SelText := FromLeftUntilStr(StrLeft, '<', True, True);
         End;

      RichEdit.SelStart := Length(RichEdit.Text);
   End;
   RichEdit.SelText := #13#10;

   if frmSettings.cbDisableScroll.Checked then begin
      RichEdit.SelStart := SelSt;
      RichEdit.SelLength := SelL;
      if not WasHideSel then
       RichEdit.HideSelection := false;
      if HadFocus then
       Windows.SetFocus(RichEdit.Handle);
   end;
end;

function TfrmMain.MakeTimeStamp: String;
begin
  if frmSettings.cbTimeStamps.Checked = True then
   Result := '<pcol='+ColorToString(frmSettings.colText2.Selected)+'>['+FormatDateTime(frmSettings.edTimeStamp.Text,now)+']</pcol> '
  else
   Result := '';
end;

function TfrmMain.MakeTimeStampNoTags: String;
begin
  if frmSettings.cbTimeStamps.Checked = True then
    Result := '['+FormatDateTime(frmSettings.edTimeStamp.Text,now)+'] '
  else
   Result := '';
end;

procedure TfrmMain.Memo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
W: TWords;
S: String;
begin
 if Key = VK_RETURN then begin
  W := TWords.Create;
  W.Text := Memo1.Text;

  if LowerCase(W[0]) = '/me' then begin
   irc.SendCTCP(frmLogin.cbchan.Text, 'ACTION '+W.ConcatToEnd(1)+#1);
   AddRichLine(rechat,MakeTimeStamp+'<pcol='+ColorToString(frmSettings.colActions.Selected)+'><i>* <b>'+irc.IrcOptions.MyNick+' '+W.ConcatToEnd(1)+'</i></b></pcol>');
   W.Free;
   Memo1.Clear;
   Exit;
  end;

  if LowerCase(W[0]) = '/quote' then begin
   IRC.Quote(W.ConcatToEnd(1));
   AddRichLine(rechat,MakeTimeStamp+'Command to server: '+W.ConcatToEnd(1));
   W.Free;
   Memo1.Clear;
   Exit;
  end;

  if LowerCase(W[0]) = '/msg' then begin
   irc.Say(W[1], W.ConcatToEnd(2));
   AddRichLine(rechat,MakeTimeStamp+'<pcol='+ColorToString(frmSettings.colPrivate.Selected)+'>-> <b>['+W[1]+'] '+W.ConcatToEnd(2)+'</pcol></b>');
   W.Free;
   Memo1.Clear;
   Exit;
  end;

  if LowerCase(W[0]) = '/away' then begin
   GoAway(w.ConcatToEnd(1));
   W.Free;
   Memo1.Clear;
   Exit;
  end;

  if LowerCase(W[0]) = '/sex' then begin
   try
    S := http.Get('http://djlol.dk/sex/');
   finally
    irc.Say(frmLogin.cbchan.Text,S);
    AddRichLine(rechat,MakeTimeStamp+'<pcol='+ColorToString(frmSettings.colText1.Selected)+'><b>['+irc.IrcOptions.Mynick+'] '+S+'</b></pcol>');
   end;
   W.Free;
   Memo1.Clear;
   Exit;
  end;

  if LowerCase(W[0]) = '/buddymsg' then begin
   irc.Say(frmSettings.lbBuddies.Items.CommaText,W.ConcatToEnd(1));
   AddRichLine(rechat,MakeTimeStamp+'<pcol='+ColorToString(frmSettings.colPrivate.Selected)+'>-> <b>[*All buddies*] '+W.ConcatToEnd(1)+'</b></pcol>');
   W.Free;
   Memo1.Clear;
   Exit;
  end;

  if Copy(W[0],1,1) = '/' then begin
   AddRichLine(rechat,MakeTimeStamp+'Unknown command.');
   W.Free;
   Memo1.Clear;
   Exit;
  end;

  irc.Say(frmLogin.cbchan.Text,Memo1.Text);
  AddRichLine(rechat,MakeTimeStamp+'<pcol='+ColorToString(frmSettings.colText1.Selected)+'><b>['+irc.IrcOptions.Mynick+'] '+Memo1.Text+'</b></pcol>');

  W.Free;
  Memo1.Clear;

 end;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
   function  GetAppVersion:string;
   var
    Size, Size2: DWord;
    Pt, Pt2: Pointer;
   begin
     Size := GetFileVersionInfoSize(PChar (ParamStr (0)), Size2);
     if Size > 0 then
     begin
       GetMem (Pt, Size);
       try
          GetFileVersionInfo (PChar (ParamStr (0)), 0, Size, Pt);
          VerQueryValue (Pt, '\', Pt2, Size2);
          with TVSFixedFileInfo (Pt2^) do
          begin
            Result:= IntToStr (HiWord (dwFileVersionMS)) + '.' +
                     IntToStr (LoWord (dwFileVersionMS)) + '.' +
                     IntToStr (HiWord (dwFileVersionLS)) + ' build ' +
                     IntToStr (LoWord (dwFileVersionLS));
         end;
       finally
         FreeMem (Pt);
       end;
     end;
   end;

var
ans: Word;
begin
ans := MessageDlg('Do you really want to quit?', mtConfirmation,[mbYes, mbNo], 0);
 if ans = mrNo then
  CanClose := false
 else begin
  DockHandler.SaveDesktop('\Software\ProSnooper');
  
  if frmMain.WindowState <> wsMaximized then begin
   frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Pos1',rdInteger,Height);
   frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Pos2',rdInteger,Top);
   frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Pos3',rdInteger,Left);
   frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Pos4',rdInteger,Width);
   frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Buddies',rdString,frmSettings.lbBuddies.Items.CommaText);
  end;

  if frmMain.WindowState = wsMaximized then
   frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','WindowState',rdString,'Maximized')
  else if frmMain.WindowState = wsMinimized then
   frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','WindowState',rdString,'Minimized')
  else
   frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','WindowState',rdString,'Normal');

  irc.Quit('ProSnooper '+GetAppVersion);

  Application.Terminate;
 end;
end;

procedure TfrmMain.GoAway(Reason: String);
begin
 if IsAway = False then begin
     if Reason = '' then
      AwayReason := 'No reason specified'
     else
      AwayReason := Reason;

     AddRichLine(rechat,MakeTimeStamp+'You have been marked as being away: '+AwayReason);
     IsAway := True;

     pnAway.Show;

     tmrGames.Interval := 60000;

     if frmSettings.cbAwayAnnounce.Checked then begin
      irc.SendCTCP(frmLogin.cbchan.Text, 'ACTION is away ('+AwayReason+')'+#1);
      AddRichLine(rechat,MakeTimeStamp+'<pcol='+ColorToString(frmSettings.colActions.Selected)+'><i>* '+irc.IrcOptions.MyNick+' is going away ('+AwayReason+')</i></pcol>');
     end;
 end else begin
     if Reason <> '' then begin //change away reason while away
       AddRichLine(rechat,MakeTimeStamp+'Away reason changed to: '+AwayReason);
       AwayReason := Reason;
     end else begin
       AddRichLine(rechat,MakeTimeStamp+'You are not marked as being away any longer.');
       IsAway := False;
       AwayReason := '';

       lblMsgs.Caption := '0';
       lblHiLites.Caption := '0';
       frmMessages.Memo1.Clear;
       lbIgnoreAway.Clear;

       pnAway.Hide;

       tmrGames.Interval := 10000;
       tmrGames.OnTimer(nil);

       if frmSettings.cbResumeAnnounce.Checked then begin
        irc.SendCTCP(frmLogin.cbchan.Text, 'ACTION is no longer marked as being away.'+#1);
        AddRichLine(rechat,MakeTimeStamp+'<pcol='+ColorToString(frmSettings.colActions.Selected)+'><i>* '+irc.IrcOptions.MyNick+' is no longer marked as being away.</i></pcol>');
       end;
     end;
 end;
end;

procedure TfrmMain.rechatMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 StatusBar1.Panels[1].Text := 'Chat window: Messages are displayed here.';
end;

procedure TfrmMain.lbnicksMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 StatusBar1.Panels[1].Text := 'User list: Users on the current channel are listed here.';
end;

procedure TfrmMain.Saveas1Click(Sender: TObject);
begin
 if SaveDialog1.Execute then
  rechat.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TfrmMain.Memo1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 StatusBar1.Panels[1].Text := 'Message field: Enter your message and press ''Return'' to send.';
end;

procedure TfrmMain.ircMOTD(Line: String; EndOfMotd: Boolean);
begin
 if Endofmotd then begin
  irc.Join(frmLogin.cbchan.Text,'');
  tmrGames.OnTimer(nil);
 end;
end;

procedure TfrmMain.ircNickInUse(Nickname: String);
begin
 irc.Nick(Nickname+'-PrSnp');
end;

procedure TfrmMain.ircChannelMessage(Channelname, Content, Nickname, Ident,
  Mask: String);
begin
 if lbIgNore.Items.IndexOf(NickName) = -1 then begin

  if Pos(Lowercase(frmLogin.eduser.Text),Lowercase(Content)) <> 0 then begin  // if highlighted
   if IsAway = True then begin
    lblHiLites.Caption := IntToStr(StrToInt(lblHiLites.Caption) + 1);
    frmMessages.Memo1.Lines.Add(MakeTimeStampNoTags+Nickname+' highlighted you: '+Content);
    if lbIgnoreAway.Items.IndexOf(NickName) = -1 then
     if frmSettings.cbSendAwayHiLite.Checked then begin
      lbIgnoreAway.Items.Add(Nickname);
      irc.Say(NickName,'Away: '+AwayReason);
     end;
   end;
   if frmSettings.cbBlink.Checked then
   CoolTrayIcon1.CycleIcons := True;
   if frmSettings.edsndHiLite.Text <> '' then begin
     frmSettings.mp.Close;
     frmSettings.mp.FileName := frmSettings.edsndHiLite.Text;
     frmSettings.mp.Open;
     frmSettings.mp.Play;
   end;

   CoolTrayIcon1.ShowBalloonHint('ProSnooper',Nickname+' highlighted you.',bitInfo,10);
  end; //end highlight

  AddRichLine(rechat,MakeTimeStamp+'<pcol='+ColorToString(frmSettings.colText1.Selected)+'>['+Nickname+'] '+Content+'</pcol>');
 end;
end;

procedure TfrmMain.ircAfterPrivateMessage(Nickname, Ident, Mask,
  Content: String);
begin
   if lbIgnore.Items.IndexOf(NickName) = -1 then begin
     if frmSettings.edsndMsg.Text <> '' then begin
       frmSettings.mp.Close;
       frmSettings.mp.FileName := frmSettings.edsndMsg.Text;
       frmSettings.mp.Open;
       frmSettings.mp.Play;
     end;

     if IsAway = True then begin // away message
      if lbIgnoreAway.Items.IndexOf(NickName) = -1 then
       if frmSettings.cbSendAwayPriv.Checked then begin
        lbIgnoreAway.Items.Add(Nickname);
        irc.Say(NickName,'Away: '+AwayReason);
       end;
       lblMsgs.Caption := IntToStr(StrToInt(lblMsgs.Caption) + 1);
       frmMessages.Memo1.Lines.Add(MakeTimeStampNoTags+Nickname+' messaged you: '+Content);
     end;

     CoolTrayIcon1.ShowBalloonHint('ProSnooper','You received a private message.',bitInfo,10);
     if frmSettings.cbBlink.Checked then
     CoolTrayIcon1.CycleIcons := True;

     AddRichLine(rechat,MakeTimeStamp+'<pcol='+ColorToString(frmSettings.colPrivate.Selected)+'><- ['+Nickname+'] '+Content+'</pcol>');
  end;
end;

procedure TfrmMain.ircAfterUserJoin(Nickname, Hostname, Channel: String);
begin
  if frmSettings.lbBuddies.Items.IndexOf(NickName) <> -1 then begin
    if frmSettings.edsndBuddy.Text <> '' then begin
      frmSettings.mp.Close;
      frmSettings.mp.FileName := frmSettings.edsndBuddy.Text;
      frmSettings.mp.Open;
      frmSettings.mp.Play;
    end;


    if frmSettings.cbBlink.Checked then
      CoolTrayIcon1.CycleIcons := True;

    CoolTrayIcon1.ShowBalloonHint('ProSnooper',Nickname+' logged on.',bitInfo,10);
  end;

  if frmSettings.cbJoins.Checked = True then
   AddRichLine(rechat,MakeTimeStamp+'<b><pcol='+ColorToString(frmSettings.colJoins.Selected)+'>Join: </b>'+Nickname+'.</pcol>');

  with nickfrm.lvNicks.Items.Add do begin
   ImageIndex := 49;
   SubItemImages[Subitems.Add('')] := 74;
   SubItems.Add(NickName);
   irc.whois(NickName,'');
  end;


end;

procedure TfrmMain.ircAfterUserPart(Nickname, Hostname, Channelname,
  Reason: String);
begin
 if FindListViewItem(nickfrm.lvNicks,nickname,2) <> nil then begin
     if frmSettings.cbParts.Checked = True then begin
         AddRichLine(rechat,MakeTimeStamp+'<b><pcol='+ColorToString(frmSettings.colParts.Selected)+'>Part: </b>'+Nickname+'</pcol>');
     end;

  nickfrm.lvNicks.Items[FindListViewItem(nickfrm.lvNicks,NickName,2).Index].Delete;
 end;
  
end;

procedure TfrmMain.ircAfterUserQuit(Nickname, Reason: String);
var
 ReasonTemp: String;
begin

  if FindListViewItem(nickfrm.lvNicks,nickname,2) <> nil then begin // TheCyberShadow's IRC server sends a QUIT even if the nick is not on the channel
    if frmSettings.cbJoins.Checked = True then begin
         if Reason <> '' then
          ReasonTemp := ' ('+Reason+')'
         else
          ReasonTemp := '';

         AddRichLine(rechat,MakeTimeStamp+'<b><pcol='+ColorToString(frmSettings.colQuits.Selected)+'>Quit: </b>'+Nickname+ReasonTemp+'</pcol>');
    end;

    nickfrm.lvNicks.Items[FindListViewItem(nickfrm.lvNicks,NickName,2).Index].Delete;
 end;
end;



procedure TfrmMain.ircAfterUserKick(KickedUser, Kicker, Channel,
  Reason: String);
begin
 if FindListViewItem(nickfrm.lvNicks,kickeduser,2) <> nil then begin
  AddRichLine(rechat,MakeTimeStamp+'<b><pcol='+ColorToString(frmSettings.colQuits.Selected)+'> Kick: '+KickedUser+' was kicked by '+Kicker+' ('+Reason+')</pcol>');
  nickfrm.lvNicks.Items[FindListViewItem(nickfrm.lvNicks,KickedUser,2).Index].Delete;
 end;
end;

procedure TfrmMain.ircConnect;
begin
 StatusBar1.Panels[0].Text := 'Connected.';
end;

procedure TfrmMain.ircDisconnect;
begin
 StatusBar1.Panels[0].Text := 'Disconnected.';
 AddRichLine(rechat,'You have been disconnected.');
 tmrGames.Enabled := True;
end;

procedure TfrmMain.ircAfterAction(NickName, Content, Destination: String);
begin
 if lbIgNore.Items.IndexOf(NickName) = -1 then begin


    if Pos(Lowercase(frmLogin.eduser.Text),Lowercase(Content)) <> 0 then begin  // if highlighted
     if IsAway = True then begin
      lblHiLites.Caption := IntToStr(StrToInt(lblHiLites.Caption) + 1);
      frmMessages.Memo1.Lines.Add(MakeTimeStampNoTags+Nickname+' highlighted you: * '+Content);

      if lbIgnoreAway.Items.IndexOf(NickName) = -1 then
       if frmSettings.cbSendAwayHiLite.Checked then begin
        lbIgnoreAway.Items.Add(Nickname);
        irc.Say(NickName,'Away: '+AwayReason);
       end;
     end;

     CoolTrayIcon1.ShowBalloonHint('ProSnooper',Nickname+' highlighted you.',bitInfo,10);
     if frmSettings.cbBlink.Checked then
     CoolTrayIcon1.CycleIcons := True;

     if frmSettings.edsndHiLite.Text <> '' then begin
       frmSettings.mp.Close;
       frmSettings.mp.FileName := frmSettings.edsndHiLite.Text;
       frmSettings.mp.Open;
       frmSettings.mp.Play;
     end;

    end;  //end highlight


   AddRichLine(rechat,MakeTimeStamp+'<pcol='+ColorToString(frmSettings.colActions.Selected)+'><i>* '+Nickname+' '+Content+'</i></pcol>')
 end;
end;

procedure TfrmMain.About1Click(Sender: TObject);
begin
 frmAbout.ShowModal;
end;

procedure TfrmMain.CoolTrayIcon1Click(Sender: TObject);
begin
 Application.Restore;
 CoolTrayIcon1.IconVisible := False;
 CoolTrayIcon1.IconIndex := 0;
 CoolTrayIcon1.CycleIcons := False;
 frmMain.Show;
 ShowWindow(Application.Handle, SW_SHOW);
end;

procedure TfrmMain.CoolTrayIcon1MinimizeToTray(Sender: TObject);
begin
 CoolTrayIcon1.ShowBalloonHint('ProSnooper','ProSnooper has been minimized to the tray.',bitInfo,10);
 frmMain.Hide;
end;

procedure TfrmMain.lbGamesMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
StatusBar1.Panels[1].Text := 'The Game List: A list of games on the current channel. Right-click for menu.';
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
 tmrGames.Enabled := True;
 if frmLogin.cbServer.Text <> 'wormnet1.team17.com' then tmrWhoCompat.Enabled := True;
 frmLogin.Hide;
 frmSettings.SetColors;
end;

procedure TfrmMain.Autologin1Click(Sender: TObject);
begin
  frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','AutoLogin',rdString,BoolToStr(AutoLogin1.Checked))
end;

procedure TfrmMain.tmrGamesTimer(Sender: TObject);
var
W: TWords;
Sl: TStringList;
I, ITemp: Integer;
begin
  Sl := TStringList.Create;
  W := TWords.Create;
   try
     Sl.Text := http.Get('http://'+frmLogin.cbServer.Text+'/wormageddonweb/GameList.asp?Channel='+StringReplace(frmLogin.cbchan.Text,'#','',[]));
     Itemp := gmfrm.lvGames.ItemIndex;
     gmfrm.lvGames.Clear;
   //  gmfrm.lvGames.Items.BeginUpdate;
     for I := 1 to Sl.Count-2 do begin
        if Pos('<GAMELIST',Sl[I]) = 0 then
        if Sl[I] <> '' then begin
          W.Text := Sl[I];
          with gmfrm.lvGames.Items.Add do begin
           if W[6] = '1' then
            ImageIndex := 63
           else
            ImageIndex := 62;
           SubItemImages[Subitems.Add('')] := StrToInt(W[4]);
           SubItems.Add(W[1]);
           SubItems.Add(W[2]);
           SubItems.Add(W[3]);
           SubItems.Add(W[7]);
          end;
        end;
      end;
    //  gmfrm.lvGames.Items.EndUpdate;
      gmfrm.lvGames.ItemIndex := Itemp;
   except
   end;
  W.Free;
  Sl.Free;
end;

procedure TfrmMain.Copy1Click(Sender: TObject);
begin
 rechat.CopyToClipboard;
end;

procedure TfrmMain.SelectAll1Click(Sender: TObject);
begin
 rechat.SelectAll;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
 Application.OnException := AppException;

 IsAway := False;

 DockHandler.ShowGrabberBars  := True;
 gmfrm                        := TfrmdkGmList.Create(self);
 nickfrm                      := TfrmdkNickList.Create(self);

 DockHandler.LoadDesktop('\Software\ProSnooper');

  if DockHandler.bLoadSuccess = False then begin
   gmfrm.ManualDock(DockPanel1);
   nickfrm.ManualDock(DockPanel1);
   gmfrm.Show;
   nickfrm.Show;
  end;
  
 DockHandler.Refresh;
end;

procedure TfrmMain.Exit1Click(Sender: TObject);
begin
 frmMain.Close;
end;

procedure TfrmMain.Settings1Click(Sender: TObject);
begin
 frmSettings.ShowModal;
end;

procedure TfrmMain.JoindirectIP1Click(Sender: TObject);
begin
 frmJoinGame.Show;
end;

function TfrmMain.FindListViewItem(lv: TListView; const S: string; column: Integer): TListItem;
var
  i: Integer;
  found: Boolean;
begin
  Assert(Assigned(lv));
  Assert((lv.viewstyle = vsReport) or (column = 0));
  Assert(S > '');
  for i := 0 to lv.Items.Count - 1 do
  begin
    Result := lv.Items[i];
    if column = 0 then
      found := AnsiCompareText(Result.Caption, S) = 0
    else if column > 0 then
      found := AnsiCompareText(Result.SubItems[column - 1], S) = 0
    else
      found := False;
    if found then
      Exit;
  end;
  // No hit if we get here
  Result := nil;
end;

procedure TfrmMain.SetFlagRank(Flag, Rank: Integer; Nickname: String);
var
I: Integer;
begin
 I  := FindListViewItem(nickfrm.lvNicks,NickName,2).Index;

 if (Rank > 74) or (Rank < 0) then Rank := 74; // can't get buddyflag or ignoreflag
 if (Flag > 61) or (Flag < 0) then Flag := 49; // can't get ranks as flags

 nickfrm.lvNicks.Items.Item[I].ImageIndex := Flag;

 if frmSettings.lbBuddies.Items.IndexOf(NickName) <> -1 then
  nickfrm.lvNicks.Items.Item[I].SubItemImages[0] := 75
 else
 if lbIgnore.Items.IndexOf(NickName) <> -1 then // if ignored
  nickfrm.lvNicks.Items.Item[I].SubItemImages[0] := 76
 else
  nickfrm.lvNicks.Items.Item[I].SubItemImages[0] := Rank;
end;

procedure TfrmMain.ircQuoteServer(Command: String);
var
 W: TWords;
begin
 W := TWords.Create;
 W.Text := Command;

 if W[1] = '311' then begin
  SetFlagRank(StrToIntDef(StringReplace(W[7], ':', '',[]),49),
              StrToIntDef(W[8],12)+62,
              W[3]);
 end;

 if W[1] = '403' then begin  // if channel doesn't exist
  frmChanList.lvChans.Clear;
  frmChanList.Show;
  irc.Quote('LIST');
  frmChanList.DoPart := False;  //some servers send a 403 if the parted channel doesnt exist
 end;

 if W[1] = '437' then begin  // if channel doesn't exist
  frmChanList.lvChans.Clear;
  frmChanList.Show;
  irc.Quote('LIST');
  frmChanList.DoPart := False;
 end;

 if (W[1] = '461') and (W[3] = 'JOIN') then begin  // if channel not specified
  frmChanList.lvChans.Clear;
  frmChanList.Show;
  irc.Quote('LIST');
  frmChanList.DoPart := False;
 end;

 if W[1] = '322' then begin  // on list event
    with frmChanList.lvChans.Items.Add do begin
     Caption := W[3];
     SubItems.Add(w[4]);
     SubItems.Add(StringReplace(W.ConcatToEnd(5),':','',[]));
    end;
 end;

 if W[1] = '432' then begin
  ShowMessage('Invalid nickname. Please choose another.');
  irc.Quit('');
  frmMain.Hide;
  frmLogin.Show;
 end;

 W.Free;
end;

procedure TfrmMain.ircNames(Commanicks, Channel: String;
  endofnames: Boolean);
var
Sl: TStringList;
I: Integer;
begin
 nickfrm.lvNicks.Clear;
 Sl := TStringList.Create;
 Sl.CommaText := irc.GetUsersFromChannel(Channel);
 nickfrm.lvNicks.Items.BeginUpdate;
   for I := 0 to Sl.Count-1 do
    with nickfrm.lvNicks.Items.Add do begin
     ImageIndex := 49;
     SubItemImages[Subitems.Add('')] := 74;
     SubItems.Add(StringReplace(Sl[I], '@','',[]));
    end;
 nickfrm.lvNicks.Items.EndUpdate;
end;

procedure TfrmMain.ircWho(Channel, Nickname, Username, Hostname, Name,
  Servername, status, other: String; EndOfWho: Boolean);
var
 W: TWords;
begin
    if EndOfWho = False then begin
     W := TWords.Create;
     W.Text := Name;
      if Channel = frmLogin.cbchan.Text then begin
        SetFlagRank(StrToIntDef(StringReplace(W[0], ':', '',[]), 49),
                    StrToIntDef(W[1],12)+62,
                    Nickname);
      end;
     W.Free;
    end;
end;

procedure TfrmMain.ircAfterJoined(Channelname: String);
begin
   irc.Quote('WHO '+Channelname);
end;

procedure TfrmMain.HostWormnet1Click(Sender: TObject);
begin
frmHost.Show;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
 Application.OnException := nil;
end;

procedure TfrmMain.ircServerError(ErrorString: String);
begin
AddRichLine(rechat, 'IRC Error: '+ErrorString);
end;

procedure TfrmMain.Label2Click(Sender: TObject);
begin
 GoAway('');
end;

procedure TfrmMain.Channellist1Click(Sender: TObject);
begin
  frmChanList.Show;
  frmChanList.lvChans.Clear;
  irc.Quote('LIST');
  frmChanList.DoPart := True;
end;

procedure TfrmMain.Help2Click(Sender: TObject);
begin
 ShellExecute(Handle,PChar('Open'),PChar('http://prosnooper.rndware.info/content/Documentation'), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmMain.Label3Click(Sender: TObject);
begin
 frmMessages.Show;
end;

procedure TfrmMain.tmrWhoCompatTimer(Sender: TObject);
begin
  // TheCyberShadow's server can't handle WHOIS, so we send out a WHO once in a while.
  irc.Quote('WHO '+frmLogin.cbchan.Text);
end;

procedure TfrmMain.ircAfterUserNickChange(Oldnick, Newnick: String);
begin
 if FindListViewItem(nickfrm.lvNicks,oldnick,2) <> nil then begin
  nickfrm.lvNicks.Items.Item[FindListViewItem(nickfrm.lvNicks,oldnick,2).Index].SubItems[1] := NewNick;
  AddRichLine(rechat,MakeTimeStamp+'<b><pcol='+ColorToString(frmSettings.colJoins.Selected)+'>Nick: </b>'+OldNick+' -> '+NewNick+'.</pcol>');
 end;
end;

procedure TfrmMain.rechatURLClick(Sender: TObject; const URL: String);
begin
 Shellexecute(Handle,PChar('Open'),PChar(URL),nil,nil,SW_SHOW);
end;

procedure TfrmMain.Find1Click(Sender: TObject);
begin
  FD.Execute;
end;

function TfrmMain.FindText(const SearchStr: string; // custom find routine
               StartPos, FindLength : LongInt; Options: TSearchTypes;
               SearchDown: Boolean = TRUE): Integer;
var
  Find: TFindText;
  Flags: Word;
begin
  with Find do begin
    chrg.cpMin := StartPos;
    chrg.cpMax := StartPos + FindLength;
    lpstrText := PChar(SearchStr);
  end;
 
  Flags := 0;

  if stWholeWord in Options then
   Flags := Flags or FT_WHOLEWORD
  else
   Flags := Flags and not FT_WHOLEWORD;

  if stMatchCase in Options then
   Flags := Flags or FT_MATCHCASE
  else
   Flags := Flags and not FT_MATCHCASE;

  if SearchDown then
   Flags := Flags OR $01
  else
   Flags := Flags OR $01;

  Result := -1;
 
  if SearchDown then
   Result := SendMessage(rechat.Handle, EM_FINDTEXT, Flags, LongInt(@Find))
  else // Search up doesn't work at all, so we loop through the text backwards
   while (StartPos > -1) and (result = -1) do begin
    //result := RichEdit1.Perform(EM_FindText, Flags, LongInt(@Find));
    Result := SendMessage(rechat.Handle, EM_FINDTEXT, Flags, LongInt(@Find));
    Dec(StartPos);
    Find.chrg.cpMin := StartPos;
   end;
end;

procedure TfrmMain.FDFind(Sender: TObject);
var
  FoundAt: LongInt;
  StartPos, FindLength: LongInt;
  TheFindOptions: TFindOptions;
  TheSearchTypes: TSearchTypes;
begin
  TheFindOptions := [];
  TheSearchTypes := [];

  if frDown in FD.Options then begin
    StartPos := rechat.SelStart + rechat.SelLength;
    FindLength := Length(rechat.Text) - StartPos;
  end else begin
    StartPos := rechat.SelStart;
    FindLength := 0;
  end;
 
  with Sender as TFindDialog do begin
   if frMatchCase in Options then
    TheSearchTypes := TheSearchTypes + [stMatchCase];
   if frWholeWord in Options then
    TheSearchTypes := TheSearchTypes + [stWholeWord];
  end;

  FoundAt := FindText(FD.FindText, StartPos, FindLength, TheSearchTypes,  (frDown in FD.Options) );

  if FoundAt <> -1 then begin
      rechat.SetFocus;
      rechat.SelStart := FoundAt;
      rechat.SelLength := Length(FD.FindText);
      rechat.Perform(EM_SCROLLCARET, 0, 0); //scroll to found line
  end else
      MessageDlg('"' + FD.FindText + '" could not be found.', mtInformation, [mbOk], 0);
end;

procedure TfrmMain.Clear1Click(Sender: TObject);
begin
 rechat.Clear;
end;

procedure TfrmMain.ircNoSuchNickChannel(Value: String);
begin
 AddRichLine(rechat, MakeTimeStamp+'No such nick/channel.');
end;

procedure TfrmMain.ircAfterInvited(NickName, Channel: String);
begin
 AddRichLine(rechat, MakeTimeStamp+Nickname+' invites you to join '+Channel);
end;

procedure TfrmMain.ircMode(Nickname, Destination, Mode: String);
begin
AddRichLine(rechat, MakeTimeStamp+Nickname+' sets mode: ['+Destination+'] '+Mode);
end;

procedure TfrmMain.ircAfterTopic(ChannelName, Nickname, Topic: String);
begin
if NIckname = '' then
 AddRichLine(rechat, MakeTimeStamp+'Topic is: ['+ChannelName+'] '+Topic)
else
 AddRichLine(rechat, MakeTimeStamp+Nickname+' changes topic: ['+ChannelName+'] '+Topic);
end;

end.
