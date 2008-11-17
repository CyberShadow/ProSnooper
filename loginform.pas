(*

This program is licensed under the rndware License, which can be found in LICENSE.TXT

Copyright (c) Simon Hughes 2007-2008

*)

unit loginform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ImgList, ExtCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, inifiles, IdHTTP, Registry, XPMan, ShellAPI,
  Menus, Buttons;

type
  TfrmLogin = class(TForm)
    Button1: TButton;
    ImageList1: TImageList;
    ImageList2: TImageList;
    Image1: TImage;
    Button2: TButton;
    Bevel1: TBevel;
    Label2: TLabel;
    eduser: TEdit;
    Label1: TLabel;
    cbchan: TComboBox;
    Label3: TLabel;
    cbflag: TComboBoxEx;
    cbrank: TComboBoxEx;
    Label4: TLabel;
    Button3: TButton;
    CheckBox2: TCheckBox;
    Timer1: TTimer;
    http: TIdHTTP;
    Bevel2: TBevel;
    XPManifest1: TXPManifest;
    Label5: TLabel;
    cbServer: TComboBox;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SetRegistryData(RootKey: HKEY; Key, Value: string; RegDataType: TRegDataType; Data: variant);
    function GetRegistryData(RootKey: HKEY; Key, Value: string): variant;
    procedure Timer1Timer(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;
 OptionsOn: Boolean;
 FirstTime: Boolean;

implementation

uses mainform, preferform;

{$R *.dfm}

procedure TfrmLogin.SetRegistryData(RootKey: HKEY; Key, Value: string;
  RegDataType: TRegDataType; Data: variant);
var
  Reg: TRegistry;
  s: string;
begin
  Reg := TRegistry.Create(KEY_WRITE);
  try
    Reg.RootKey := RootKey;
    if Reg.OpenKey(Key, True) then begin
      try
        if RegDataType = rdUnknown then
          RegDataType := Reg.GetDataType(Value);
        if RegDataType = rdString then
          Reg.WriteString(Value, Data)
        else if RegDataType = rdExpandString then
          Reg.WriteExpandString(Value, Data)
        else if RegDataType = rdInteger then
          Reg.WriteInteger(Value, Data)
        else if RegDataType = rdBinary then begin
          s := Data;
          Reg.WriteBinaryData(Value, PChar(s)^, Length(s));
        end else
          raise Exception.Create(SysErrorMessage(ERROR_CANTWRITE));
      except
        Reg.CloseKey;
        raise;
      end;
      Reg.CloseKey;
    end else
      raise Exception.Create(SysErrorMessage(GetLastError));
  finally
    Reg.Free;
  end;
end;

function TfrmLogin.GetRegistryData(RootKey: HKEY; Key, Value: string): variant;
var
  Reg: TRegistry;
  RegDataType: TRegDataType;
  DataSize, Len: integer;
  s: string;
label cantread;
begin
  Reg := nil;
  try
    Reg := TRegistry.Create(KEY_QUERY_VALUE);
    Reg.RootKey := RootKey;
    if Reg.OpenKeyReadOnly(Key) then begin
      try
        RegDataType := Reg.GetDataType(Value);
        if (RegDataType = rdString) or
           (RegDataType = rdExpandString) then
          Result := Reg.ReadString(Value)
        else if RegDataType = rdInteger then
          Result := Reg.ReadInteger(Value)
        else if RegDataType = rdBinary then begin
          DataSize := Reg.GetDataSize(Value);
          if DataSize = -1 then goto cantread;
          SetLength(s, DataSize);
          Len := Reg.ReadBinaryData(Value, PChar(s)^, DataSize);
          if Len <> DataSize then goto cantread;
          Result := s;
        end else
cantread:
        //raise Exception.Create(SysErrorMessage(ERROR_CANTREAD));
      except
        s := ''; // Deallocates memory if allocated
        Reg.CloseKey;
        raise;
      end;
      Reg.CloseKey;
    end else
      // raise Exception.Create(SysErrorMessage(GetLastError));
  except
    Reg.Free;
    raise;
  end;
  Reg.Free;
end;

procedure TfrmLogin.Button1Click(Sender: TObject);
var
IRCQuery: TStringList;
IRCServ, IRCJoin, IRCCountry: String;

begin
if (edUser.Text = '') {or (cbChan.Text = '')} or (cbServer.Text = '') then
 Exit
else begin


    IRCQuery := TStringList.Create;
    try
     IRCQuery.Text := http.Get('http://'+cbServer.text+'/wormageddonweb/Login.asp?UserName=&Password=&IPAddress=');
    except
     ShowMessage('Error contacting server. This server or your network is down.');

     Exit;
    end;

    IRCServ := StringReplace(IRCQuery[0],'<CONNECT ','',[]);
    IRCServ := StringReplace(IRCServ,'>','',[]);

    if IRCQuery.Count >= 2 then begin // Server-controlled autojoin
     IRCJoin := StringReplace(IRCQuery[1],'<JOIN ','',[]);
     IRCJoin := StringReplace(IRCJoin,'>','',[]);
     cbChan.Text := IRCJoin;
    end;

    IRCQuery.Free;

     frmmain.irc.IrcOptions.MyNick := eduser.Text;
     frmmain.irc.IrcOptions.ServerHost := IRCServ;

     case cbflag.ItemIndex of
       51 : IRCCountry := 'CL';
       52 : IRCCountry := 'CS';
       53 : IRCCountry := 'SI';
       54 : IRCCountry := 'LB';
       55 : IRCCountry := 'MD';
       56 : IRCCountry := 'UA';
       57 : IRCCountry := 'LV';
       58 : IRCCountry := 'SK';
       59 : IRCCountry := 'CR';
       60 : IRCCountry := 'EE';
       61 : IRCCountry := 'CN';
     else
       IRCCountry := 'UK';
     end;


     frmmain.irc.IrcOptions.UserName := inttostr(cbflag.ItemIndex)+' '+inttostr(cbrank.ItemIndex)+' '+IRCCountry+' ProSnooper2';
     frmmain.irc.IrcOptions.Password := 'ELSILRACLIHP '; 
     frmmain.irc.connect;
     frmmain.Caption := 'ProSnooper - '+cbchan.Text;

     frmMain.Show;

     try
       SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Username',rdString,edUser.Text);
       SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Channel',rdString,cbChan.Text);
       SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','ServerList',rdString,cbServer.Items.CommaText);
       SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Server',rdString,cbServer.Text);
       SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Flag',rdString,IntToStr(cbFlag.ItemIndex));
       SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Rank',rdString,IntToStr(cbRank.ItemIndex));
       SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','AutoLogin',rdString,BoolToStr(CheckBox2.Checked));
     except
       ShowMessage('Cannot access registry.');
     end;
end;


end;

procedure TfrmLogin.FormShow(Sender: TObject);
  function GetWinDir: string;
  var
    dir: array [0..MAX_PATH] of Char;
  begin
    GetWindowsDirectory(dir, MAX_PATH);
    Result := StrPas(dir);
  end;
var
INI: TIniFile;
begin
if FirstTime = True then begin // load settings if this is applaunch (we should do this in onCreate instead)
 OptionsOn := False; //options toggle is off @ launch

  Height := 282;


  with TRegistry.Create do
    try
      RootKey := HKEY_CURRENT_USER;
      OpenKey('\Software\ProSnooper', False);

        if ValueExists('Username') = True then begin
          edUser.Text                 := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Username');
          cbChan.Text                 := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Channel');
          cbFlag.ItemIndex            := StrToInt(GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Flag'));
          cbRank.ItemIndex            := StrToInt(GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Rank'));
          CheckBox2.Checked           := StrToBool(GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','AutoLogin'));
          frmMain.Autologin1.Checked  := StrToBool(frmLogin.GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','AutoLogin'));

          if CheckBox2.Checked then //autologin
           Timer1.Enabled := True;
        end else begin
          cbFlag.ItemIndex            := 0;
          cbRank.ItemIndex            := 0;
        end;

        if ValueExists('colBackground') = True then begin //settings
          frmSettings.colBackground.Selected    := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','colBackground');
          frmSettings.colText1.Selected         := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','colText1');
          frmSettings.colText2.Selected         := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','colText2');
          frmSettings.colPrivate.Selected       := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','colPrivate');
          frmSettings.colActions.Selected       := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','colActions');
          frmSettings.colJoins.Selected         := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','colJoins');
          frmSettings.colParts.Selected         := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','colParts');
          frmSettings.colQuits.Selected         := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','colQuits');
          frmSettings.cbTimeStamps.Checked      := StrToBool(GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','EnableTimeStamps'));
          frmSettings.cbJoins.Checked           := StrToBool(GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','ShowJoins'));
          frmSettings.cbParts.Checked           := StrToBool(GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','ShowParts'));
          frmSettings.cbQuits.Checked           := StrToBool(GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','ShowQuits'));
          frmSettings.edTimeStamp.Text          := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','TimeStampFormat');
          frmSettings.edsndBuddy.Text           := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','BuddySound');
          frmSettings.edsndHiLite.Text          := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','HiLiteSound');
          frmSettings.edsndMsg.Text             := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','MsgSound');
        end;

        if ValueExists('HostAwayText') = True then begin  //settings added in 104
          frmSettings.edHostGameAway.Text       := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','HostAwayText');
          frmSettings.edJoinGameAway.Text       := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','JoinAwayText');
          frmSettings.cbJoinGameAway.Checked    := StrToBool(GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','JoinGameAway'));
          frmSettings.cbHostGameAnn.Checked     := StrToBool(GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','HostGameAnn'));
          frmSettings.cbAwayAnnounce.Checked    := StrToBool(GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','AwayAnnounce'));
          frmSettings.cbHostGameAway.Checked    := StrToBool(GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','HostGameAway'));
          frmSettings.cbGetIP.Checked           := StrToBool(GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','GetIP'));
          frmSettings.cbResumeAnnounce.Checked  := StrToBool(GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','ResumeAnnounce'));
          frmSettings.cbSendAwayPriv.Checked    := StrToBool(GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','SendAwayPriv'));
          frmSettings.cbSendAwayHiLite.Checked  := StrToBool(GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper\','SendAwayHiLite'));
        end;

        if ValueExists('Pos1') = True then begin
          frmMain.Height   := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Pos1');
          frmMain.Top      := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Pos2');
          frmMain.Left     := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Pos3');
          frmMain.Width    := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Pos4');
        end;

        if ValueExists('Buddies') = True then begin
          frmSettings.lbBuddies.Items.CommaText := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Buddies');
        end;

        if ValueExists('FntSize') = True then begin
          frmSettings.edFntSize.Text := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','FntSize');
        end;

        if ValueExists('ServerList') = True then begin
          cbServer.Items.CommaText := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','ServerList');
          cbServer.Text := GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Server');
        end;

        if ValueExists('WindowState') = True then begin
         if GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','WindowState') = 'Maximized' then
          frmMain.WindowState := wsMaximized
         else if GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','WindowState') = 'Minimized' then
          frmMain.WindowState := wsMinimized
         else
          frmMain.WindowState := wsNormal;
        end;

        if ValueExists('Blink') = True then
         frmSettings.cbBlink.Checked := StrToBool(GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Blink'));

        if ValueExists('Waexe') = True then
         frmSettings.edExe.Text := GetRegistryData(HKEY_CURRENT_USER, '\Software\ProSnooper','Waexe');

        if ValueExists('DisableScroll') = True then
         frmSettings.cbDisableScroll.Checked := StrToBool(GetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','DisableScroll'));
    finally
     Free;
    end;

   if eduser.Text = '' then begin  // WA username
     ini := TIniFile.Create(GetWindir+'\win.ini');
     try
       eduser.Text := ini.ReadString('NetSettings', 'PlayerName', '');
     finally
       ini.Free;
     end;
   end;

   if CheckBox2.Checked then
    Timer1.Enabled := True; // you cant open windowss onshow, so we use a timer instead

   FirstTime := False;
  end;
end;

procedure TfrmLogin.Button2Click(Sender: TObject);
begin
 Close;
end;

procedure TfrmLogin.Button3Click(Sender: TObject);

begin
if OptionsOn = False then begin
  Height := 378;
  Button1.Top := 316;
  Button2.Top := 316;
  Button3.Top := 316;
  Bevel2.Top := 304;
  Label3.Visible := True;
  Label4.Visible := True;
  cbFlag.Visible := True;
  cbRank.Visible := True;
  OptionsOn := True;
  Button3.Caption := 'Options <<';
end else begin
  Height := 282;
  Button1.Top := 220;
  Button2.Top := 220;
  Button3.Top := 220;
  Bevel2.Top := 208;
  Label3.Visible := False;
  Label4.Visible := False;
  cbFlag.Visible := False;
  cbRank.Visible := False;
  OptionsOn := False;
  Button3.Caption := 'Options >>';
end;
end;

procedure TfrmLogin.Timer1Timer(Sender: TObject);
begin
 Button1.OnClick(nil);
 Timer1.Enabled := False;
end;

procedure TfrmLogin.Image1Click(Sender: TObject);
begin
 ShellExecute(Handle,'Open','http://prosnooper.rndware.info',nil,nil,SW_SHOWNORMAL);
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
 FirstTime := True;
end;

procedure TfrmLogin.Button4Click(Sender: TObject);
begin

 try
  cbServer.Items.Text := http.Get('http://prosnooper.rndware.info/serverlist.txt');
 except
  ShowMessage('Could not get serverlist.');
 end;

end;

end.
