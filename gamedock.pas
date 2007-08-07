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
 Scheme, ConnStr: String;
begin
 if lvGames.ItemIndex <> -1 then begin
 Scheme := frmMain.http.Get('http://'+frmLogin.cbServer.Text+'/wormageddonweb/RequestChannelScheme.asp?Channel='+ StringReplace(frmLogin.cbchan.Text,'#','',[]) );
 Scheme := StringReplace(Scheme,'<SCHEME=','',[rfIgnoreCase]);
 Scheme := StringReplace(Scheme,'>','',[]);

 if frmSettings.cbJoinGameAway.Checked then
  if frmMain.IsAway = False then
   frmMain.GoAway(frmSettings.edJoinGameAway.Text);


  frmMain.AddRichLine(frmMain.rechat,'Joining <pcol='+ColorToString(frmSettings.colText1.Selected)+'>'+lvGames.Selected.SubItems[2]+' ('+lvGames.Selected.SubItems[3]+')</pcol>.');
  ConnStr := lvGames.Selected.SubItems[3]+'?scheme='+Scheme+'&id='+lvGames.Selected.SubItems[4];
  ShellExecute(Handle, PChar('Open'), PChar('wa://'+ConnStr), nil, nil, SW_SHOW);
 end;
end;

procedure TfrmdkGmList.Viewdetails1Click(Sender: TObject);
begin
 if lvGames.ItemIndex <> -1 then begin
  frmMain.AddRichLine(frmMain.rechat,'Game: <pcol='+ColorToString(frmSettings.colText1.Selected)+'>'+lvGames.Selected.SubItems[1]+'</pcol>');
  frmMain.AddRichLine(frmMain.rechat,'Hostname: <pcol='+ColorToString(frmSettings.colText1.Selected)+'>'+lvGames.Selected.SubItems[3]+'</pcol>');
  frmMain.AddRichLine(frmMain.rechat,'ID: <pcol='+ColorToString(frmSettings.colText1.Selected)+'>'+lvGames.Selected.SubItems[4]+'</pcol>');
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
