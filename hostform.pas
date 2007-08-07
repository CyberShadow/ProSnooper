unit hostform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, ShellAPI, Mainform, IniFiles, Psapi, tlhelp32;

type
  TfrmHost = class(TForm)
    http: TIdHTTP;
    Label1: TLabel;
    Button1: TButton;
    Bevel1: TBevel;
    Timer1: TTimer;
    edName: TEdit;
    Timer2: TTimer;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHost: TfrmHost;
  HostedGameID, HostedGameName: String;

implementation

uses loginform, preferform;

{$R *.dfm}

function GetWinDir: string; 
var 
  dir: array [0..MAX_PATH] of Char; 
begin 
  GetWindowsDirectory(dir, MAX_PATH); 
  Result := StrPas(dir); 
end;

procedure TfrmHost.Button1Click(Sender: TObject);
var
 IP, Scheme, GameID: String;
 SL: TStringList;
 I: Integer;
 W: TWords;
 Ini: TIniFile;
begin
  Timer1.OnTimer(nil); //remove last game

  SL := TStringList.Create;
  SL.Text := frmMain.http.Get('http://'+frmLogin.cbServer.Text+'/wormageddonweb/RequestChannelScheme.asp?Channel='+ StringReplace(frmLogin.cbchan.Text,'#','',[]) );
  Scheme := StringReplace(SL[0],'<SCHEME=','',[rfIgnoreCase]);
  Scheme := StringReplace(Scheme,'>','',[]);

  if frmSettings.cbGetIP.Checked then begin  // Get network settings
    ini := TIniFile.Create(GetWindir+'\win.ini');
    try
     IP := ini.ReadString('NetSettings', 'LocalAddress', 'address-not-configured')+':'+ini.ReadString('NetSettings', 'HostingPort', '17011');
    finally
     ini.Free;
    end;
  end else
    IP := Trim(http.Get('http://djlol.dk/ipaddress.php'));  // Otherwise, just get the public IP

  HostedGameName := 'ß'+StringReplace(edname.Text,' ','_',[rfReplaceAll]); // This is a beta-game after all (and we can't have spaces now can we?)

  try
   http.Get('http://'+frmLogin.cbServer.Text+'/wormageddonweb/Game.asp?Cmd=Create&Name='+ HostedGameName +'&HostIP='+IP+'&Nick='+frmLogin.edUser.Text+'&Chan='+ StringReplace(frmlogin.cbchan.Text,'#','',[]) +'&Loc='+ IntToStr(frmLogin.cbflag.ItemIndex) +'&Type=0&Pass=0');
    // Team17's servers returns a serverlist with Game.asp.
    // TheCyberShadow's does not. Hence, we request a GameList to get the GameID
    // - because headers in Indy's http client is tricky to do
   SL.Text := http.Get('http://'+frmLogin.cbServer.Text+'/wormageddonweb/GameList.asp?Channel='+StringReplace(frmLogin.cbchan.Text,'#','',[]));
  except
   frmMain.AddRichLine(frmMain.rechat,'Could not contact the server to add a game.');
  end;

  W  := TWords.Create; // This finds the GameID of the last game hosted by the user (in case ProSnooper failed in deleting a game)
  for I := 1 to Sl.Count-2 do begin
     W.Text := Sl[I];

     if W[3] = IP then  // If there's an ip that matches the user
      if W[2] = frmLogin.eduser.Text then // If the nick matches the user
       GameID := W[7];  // Then the game should be the users', and we set the GameID
  end;

  HostedGameID := GameID;

  if frmSettings.cbHostGameAnn.Checked then begin // Because ProSnooper doesn't quit, we can announce the game.
   frmMain.irc.SendCTCP(frmLogin.cbchan.Text, 'ACTION is hosting a game: ('+edName.Text+')'+#1);
   frmmain.AddRichLine(frmmain.rechat,'<pcol='+ColorToString(frmSettings.colActions.Selected)+'>'+frmmain.MakeTimeStamp+'<i>* '+frmmain.irc.IrcOptions.MyNick+' is hosting a game: ('+edName.Text+')</i></pcol>');
  end;

  if frmSettings.cbHostGameAway.Checked then // Engage away-mode!
   if frmMain.IsAway = False then // If we're not already away, of course.
   frmMain.GoAway(frmSettings.edHostGameAway.Text);

  // Let's play some Worms: Armageddon.
  ShellExecute(Handle, PChar('Open'), PChar('wa://?gameid='+GameID+'&scheme='+Scheme), nil, nil, SW_SHOW);

  Timer1.Enabled := True; // remove game in 120 secs
  Timer2.Enabled := True; // remove game if WA.exe is closed

  frmMain.tmrGames.Interval := 60000; // Less pressure on the server.

  Close;
end;

procedure TfrmHost.Timer1Timer(Sender: TObject);
begin
  try
   http.Get('http://'+frmLogin.cbServer.Text+'/wormageddonweb/Game.asp?Cmd=Close&GameID='+HostedGameID+'&Name='+HostedGameName+'&HostID=&GuestID=&GameType=0');
  except
   frmMain.AddRichLine(frmMain.rechat,'Couldn''t remove game');
  end;
 Timer1.Enabled := False;
 Timer2.Enabled := False;
   frmMain.tmrGames.Interval := 5000;
   frmMain.tmrGames.OnTimer(nil);
end;

procedure TfrmHost.FormShow(Sender: TObject);
begin
 edName.Clear;
end;

procedure TfrmHost.Timer2Timer(Sender: TObject);
  procedure CreateWin9xProcessList(List: TstringList);
  var
    hSnapShot: THandle;
    ProcInfo: TProcessEntry32;
  begin
    if List = nil then Exit;
    hSnapShot := CreateToolHelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    {$WARNINGS OFF}
    if (hSnapShot > THandle(-1)) then
    {$WARNINGS ON}
    begin
      ProcInfo.dwSize := SizeOf(ProcInfo);
      if (Process32First(hSnapshot, ProcInfo)) then
      begin
        List.Add(ProcInfo.szExeFile);
        while (Process32Next(hSnapShot, ProcInfo)) do
          List.Add(ProcInfo.szExeFile);
      end;
      CloseHandle(hSnapShot);
    end;
  end;

  procedure CreateWinNTProcessList(List: TstringList);
  var
    PIDArray: array [0..1023] of DWORD;
    cb: DWORD;
    I: Integer;
    ProcCount: Integer;
    hMod: HMODULE;
    hProcess: THandle;
    ModuleName: array [0..300] of Char;
  begin
    if List = nil then Exit;
    EnumProcesses(@PIDArray, SizeOf(PIDArray), cb);
    ProcCount := cb div SizeOf(DWORD);
    for I := 0 to ProcCount - 1 do
    begin
      hProcess := OpenProcess(PROCESS_QUERY_INFORMATION or
        PROCESS_VM_READ,
        False,
        PIDArray[I]);
      if (hProcess > 0) then
      begin
        EnumProcessModules(hProcess, @hMod, SizeOf(hMod), cb);
        GetModuleFilenameEx(hProcess, hMod, ModuleName, SizeOf(ModuleName));
        List.Add(ModuleName);
        CloseHandle(hProcess);
      end;
    end;
  end;
  
  procedure GetProcessList(var List: TstringList);
  var
    ovi: TOSVersionInfo;
  begin
    if List = nil then Exit;
    ovi.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
    GetVersionEx(ovi);
    case ovi.dwPlatformId of
      VER_PLATFORM_WIN32_WINDOWS: CreateWin9xProcessList(List);
      VER_PLATFORM_WIN32_NT: CreateWinNTProcessList(List);
    end
  end;

  function EXE_Running(FileName: string; bFullpath: Boolean): Boolean;
  var
    i: Integer;
    MyProcList: TstringList;
  begin
    MyProcList := TStringList.Create;
    try
      GetProcessList(MyProcList);
      Result := False;
      if MyProcList = nil then Exit;
      for i := 0 to MyProcList.Count - 1 do
      begin
        if not bFullpath then
        begin
          if CompareText(ExtractFileName(MyProcList.Strings[i]), FileName) = 0 then
            Result := True
        end
        else if CompareText(MyProcList.strings[i], FileName) = 0 then Result := True;
        if Result then Break;
      end;
    finally
      MyProcList.Free;
    end;
  end;
begin
 if EXE_Running('wa.exe',False) = False then begin
  Timer1.OnTimer(nil);
 end;
end;

procedure TfrmHost.Button2Click(Sender: TObject);
begin
 Close;
end;

end.
