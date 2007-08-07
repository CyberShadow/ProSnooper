unit buddyform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Registry;

type
  TfrmBuddies = class(TForm)
    lbBuddies: TListBox;
    Button2: TButton;
    Button1: TButton;
    Bevel2: TBevel;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBuddies: TfrmBuddies;

implementation

uses loginform;

{$R *.dfm}

procedure TfrmBuddies.Button1Click(Sender: TObject);
var
S:String;
begin
 if InputQuery('Add a buddy','Enter the nickname your buddy uses.',S) then
  lbBuddies.Items.Add(S);
end;

procedure TfrmBuddies.Button2Click(Sender: TObject);
begin
if lbBuddies.ItemIndex <> -1 then
 lbBuddies.Items.Delete(lbBuddies.ItemIndex);
end;

procedure TfrmBuddies.Button3Click(Sender: TObject);
begin
 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Buddies',rdString,lbBuddies.Items.CommaText);
 Close;
end;

end.
