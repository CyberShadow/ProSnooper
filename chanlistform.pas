unit chanlistform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TfrmChanList = class(TForm)
    lvChans: TListView;
    Button1: TButton;
    Bevel1: TBevel;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmChanList: TfrmChanList;

implementation

uses mainform, loginform;

{$R *.dfm}

procedure TfrmChanList.Button1Click(Sender: TObject);
begin
 if lvChans.ItemIndex <> -1 then begin
  frmMain.irc.Part(frmLogin.cbchan.Text,'');
  frmMain.irc.Join(lvChans.Selected.Caption,'');
  frmMain.Caption := 'ProSnooper - '+lvChans.Selected.Caption;
  frmLogin.cbchan.Text := lvChans.Selected.Caption;
  Close;
 end else
  Beep;
end;

procedure TfrmChanList.Button2Click(Sender: TObject);
begin
 Close;
end;

end.
