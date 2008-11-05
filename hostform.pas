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
 IP, Scheme, GameID, Connstr: String;
 SL: TStringList;
 I: Integer;
 W: TWords;
 Ini: TIniFile;
begin
  Timer1.OnTimer(nil); //remove last game

  try
    SL := TStringList.Create;
    SL.Text := frmMain.http.Get('http://'+frmLogin.cbServer.Text+'/wormageddonweb/RequestChannelScheme.asp?Channel='+ StringReplace(frmLogin.cbchan.Text,'#','',[]) );
    Scheme := StringReplace(SL[0],'<SCHEME=','',[rfIgnoreCase]);
    Scheme := StringReplace(Scheme,'>','',[]);
    Sl.Free;
  except
    frmMain.AddRichLine(frmmain.rechat,'Could not get channel scheme.');
  end;

  if frmSettings.cbGetIP.Checked then begin  // Get network settings
    ini := TIniFile.Create(GetWindir+'\win.ini');
    try
     ini := TIniFile.Create(GetWindir+'\win.ini');
     IP := ini.ReadString('NetSettings', 'LocalAddress', 'address-not-configured')+':'+ini.ReadString('NetSettings', 'HostingPort', '17011');
    finally
     ini.Free;
    end;
  end else
   try
    IP := Trim(http.Get('http://djlol.dk/ipaddress.php'));  // Otherwise, just get the public IP
   except
    frmMain.AddRichLine(frmmain.rechat,'Could not get your IP-address.');
    Exit;
   end;

  HostedGameName := 'ß'+StringReplace(edname.Text,' ','_',[rfReplaceAll]);

  try
   http.Get('http://'+frmLogin.cbServer.Text+'/wormageddonweb/Game.asp?Cmd=Create&Name='+ HostedGameName +'&HostIP='+IP+'&Nick='+frmLogin.edUser.Text+'&Chan='+ StringReplace(frmlogin.cbchan.Text,'#','',[]) +'&Loc='+ IntToStr(frmLogin.cbflag.ItemIndex) +'&Type=0&Pass=0');
   SL := TStringList.Create;
   SL.Text := http.Get('http://'+frmLogin.cbServer.Text+'/wormageddonweb/GameList.asp?Channel='+StringReplace(frmLogin.cbchan.Text,'#','',[]));

   W := TWords.Create; // search for games matching the users
   for I := 1 to Sl.Count-2 do begin
     W.Text := Sl[I];
     if W[3] = IP then
      if W[2] = frmLogin.eduser.Text then
       GameID := W[7];
   end;

   SL.Free;
  except
   frmMain.AddRichLine(frmMain.rechat,'Could not add game.');
  end;

  HostedGameID := GameID;

  if frmSettings.cbHostGameAnn.Checked then begin // announce
   frmMain.irc.SendCTCP(frmLogin.cbchan.Text, 'ACTION is hosting a game: '+HostedGameName+#1);
   frmmain.AddRichLine(frmmain.rechat,frmmain.MakeTimeStamp+'<pcol='+ColorToString(frmSettings.colActions.Selected)+'><i>* <b>'+frmmain.irc.IrcOptions.MyNick+' is hosting a game: '+HostedGameName+'</i></b></pcol>');
  end;

  if frmSettings.cbHostGameAway.Checked then
   if frmMain.IsAway = False then
   frmMain.GoAway(frmSettings.edHostGameAway.Text);

  ConnStr := 'wa://?gameid='+GameID+'&scheme='+Scheme;

 { if frmSettings.edExe.Text <> '' then
   ShellExecute(Handle, PChar('Open'), PChar(frmSettings.edExe), PChar(ConnStr), nil, SW_SHOW)
  else
   ShellExecute(Handle, PChar('Open'), PChar(ConnStr), nil, nil, SW_SHOW);   }

  if frmSettings.edExe.Text <> '' then
   if LowerCase(ExtractFileName(frmsettings.edExe.Text)) = 'wormkit.exe' then
    ShellExecute(Handle, PChar('Open'), PChar(frmSettings.edExe.Text), PChar('wa.exe '+ConnStr), nil, SW_SHOW)
   else
    ShellExecute(Handle, PChar('Open'), PChar(frmSettings.edExe.Text), PChar(ConnStr), nil, SW_SHOW)
  else
   ShellExecute(Handle, PChar('Open'), PChar(ConnStr), nil, nil, SW_SHOW);

  Timer1.Enabled := True; // remove game in 120 secs
  Timer2.Enabled := True; // remove game if WA.exe is closed

  frmMain.tmrGamesTimer(nil);
  frmMain.tmrGames.Enabled := False; // serverlist doesn't need to be updated while playing

  Close;
end;

procedure TfrmHost.Timer1Timer(Sender: TObject);
begin
  try
   http.Get('http://'+frmLogin.cbServer.Text+'/wormageddonweb/Game.asp?Cmd=Close&GameID='+HostedGameID+'&Name='+HostedGameName+'&HostID=&GuestID=&GameType=0');
  except
   frmMain.AddRichLine(frmMain.rechat,frmMain.MakeTimeStamp+'Couldn''t remove game.');
  end;
   Timer1.Enabled := False;
   Timer2.Enabled := False;
   frmMain.tmrGames.OnTimer(nil);
   frmMain.tmrGames.Enabled := True;
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
