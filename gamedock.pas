unit gamedock;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DockPanel, Menus, ShellApi, ImgList, ComCtrls;

type

  TfrmdkGmList = class(TDockableForm)
    pmGamePop: TPopupMenu;
    Jointhisgame1: TMenuItem;
    Viewdetails1: TMenuItem;
    Update1: TMenuItem;
    Update2: TMenuItem;
    N1: TMenuItem;
    Host1: TMenuItem;
    lvGames: TListView;
    ImageList1: TImageList;
    procedure Jointhisgame1Click(Sender: TObject);
    procedure Viewdetails1Click(Sender: TObject);
    procedure Update2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Host1Click(Sender: TObject);
    procedure lvGamesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmdkGmList: TfrmdkGmList;

implementation

uses mainform, preferform, loginform;

{$R *.dfm}

procedure TfrmdkGmList.Jointhisgame1Click(Sender: TObject);
var
 ConnStr, Scheme: String;
 SL: TStringList;
begin
 if lvGames.ItemIndex <> -1 then begin
 SL := TStringList.Create;
 SL.Text := frmMain.http.Get('http://'+frmLogin.cbServer.Text+'/wormageddonweb/RequestChannelScheme.asp?Channel='+ StringReplace(frmLogin.cbchan.Text,'#','',[]) );
 Scheme := StringReplace(SL[0],'<SCHEME=','',[rfIgnoreCase]);
 Scheme := StringReplace(Scheme,'>','',[]);
 SL.Free;

 if frmSettings.cbJoinGameAway.Checked then
  if frmMain.IsAway = False then
   frmMain.GoAway(frmSettings.edJoinGameAway.Text);


  frmMain.AddRichLine(frmMain.rechat,'Joining <pcol='+ColorToString(frmSettings.colText1.Selected)+'>'+lvGames.Selected.SubItems[2]+' ('+lvGames.Selected.SubItems[3]+')</pcol>.');
  ConnStr := 'wa://'+lvGames.Selected.SubItems[3]+'?scheme='+Scheme+'&gameid='+lvGames.Selected.SubItems[4];
  if frmSettings.edExe.Text <> '' then
   if LowerCase(ExtractFileName(frmsettings.edExe.Text)) = 'wormkit.exe' then
    ShellExecute(Handle, PChar('Open'), PChar(frmSettings.edExe.Text), PChar('wa.exe '+ConnStr), nil, SW_SHOW)
   else
    ShellExecute(Handle, PChar('Open'), PChar(frmSettings.edExe.Text), PChar(ConnStr), nil, SW_SHOW)
  else
   ShellExecute(Handle, PChar('Open'), PChar(ConnStr), nil, nil, SW_SHOW);

 end;
end;

procedure TfrmdkGmList.Viewdetails1Click(Sender: TObject);
begin
 if lvGames.ItemIndex <> -1 then begin
  frmMain.AddRichLine(frmMain.rechat,frmMain.MakeTimeStamp+'<b>Details for <pcol='+ColorToString(frmSettings.colText1.Selected)+'>'+lvGames.Selected.SubItems[1]+'</pcol> by <pcol='+ColorToString(frmSettings.colText1.Selected)+'>'+lvGames.Selected.SubItems[2]+'</pcol>:</b>');
  frmMain.AddRichLine(frmMain.rechat,frmMain.MakeTimeStamp+'Hostname: <pcol='+ColorToString(frmSettings.colText1.Selected)+'>'+lvGames.Selected.SubItems[3]+'</pcol>');
  frmMain.AddRichLine(frmMain.rechat,frmMain.MakeTimeStamp+'Game ID: <pcol='+ColorToString(frmSettings.colText1.Selected)+'>'+lvGames.Selected.SubItems[4]+'</pcol>');
 end;
end;

procedure TfrmdkGmList.Update2Click(Sender: TObject);
begin
 frmMain.tmrGames.OnTimer(nil);
end;

procedure TfrmdkGmList.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 CanClose := False;
end;

procedure TfrmdkGmList.Host1Click(Sender: TObject);
begin
 frmMain.HostWormnet1Click(nil);
end;

procedure TfrmdkGmList.lvGamesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 frmMain.lbGamesMouseMove(nil, Shift, X, Y);
end;

end.
