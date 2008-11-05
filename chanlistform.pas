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
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    DoPart: Boolean;
  end;

var
  frmChanList: TfrmChanList;

implementation

uses mainform, loginform;

{$R *.dfm}

procedure TfrmChanList.Button1Click(Sender: TObject);
begin
 if lvChans.ItemIndex <> -1 then begin
  if DoPart = True then
  frmMain.irc.Part(frmLogin.cbchan.Text,'');
  Sleep(100);
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

procedure TfrmChanList.FormCreate(Sender: TObject);
begin
 DoPart := True;
end;

end.
