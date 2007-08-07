unit joinform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ShellAPi;

type
  TfrmJoinGame = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Bevel1: TBevel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmJoinGame: TfrmJoinGame;

implementation

uses loginform, mainform;

{$R *.dfm}

procedure TfrmJoinGame.FormShow(Sender: TObject);
begin
 // Edit2.Text := '<default>';
end;

procedure TfrmJoinGame.Button1Click(Sender: TObject);
var
 Port, Scheme: String;
begin
 Scheme := frmMain.http.Get('http://'+frmLogin.cbServer.Text+'/wormageddonweb/RequestChannelScheme.asp?Channel='+ StringReplace(frmLogin.cbchan.Text,'#','',[]) );
 Scheme := StringReplace(Scheme,'<SCHEME=','',[rfIgnoreCase]);
 Scheme := StringReplace(Scheme,'>','',[]);
if Edit2.Text = '<default>' then
 Port := ''
else
 Port := ':'+Edit2.Text;
  ShellExecute(Handle, PChar('Open'), PChar('wa://'+Edit1.Text+Port+'?gameid='+Edit3.Text+'&scheme='+Edit4.Text), nil, nil, SW_SHOW);

Close;
end;

procedure TfrmJoinGame.Button2Click(Sender: TObject);
begin
 Close;
end;

end.
