unit preferform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Registry, MPlayer;

type
  TfrmSettings = class(TForm)
    Button1: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Bevel1: TBevel;
    Label9: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label10: TLabel;
    Label1: TLabel;
    colText2: TColorBox;
    colText1: TColorBox;
    colQuits: TColorBox;
    colPrivate: TColorBox;
    colParts: TColorBox;
    colJoins: TColorBox;
    colBackground: TColorBox;
    colActions: TColorBox;
    Label7: TLabel;
    edTimeStamp: TEdit;
    cbTimeStamps: TCheckBox;
    cbQuits: TCheckBox;
    cbParts: TCheckBox;
    cbJoins: TCheckBox;
    Label8: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label11: TLabel;
    TabSheet3: TTabSheet;
    Label12: TLabel;
    Bevel4: TBevel;
    edsndBuddy: TEdit;
    Button2: TButton;
    Label13: TLabel;
    Bevel5: TBevel;
    edsndHiLite: TEdit;
    Button3: TButton;
    Label14: TLabel;
    Bevel6: TBevel;
    edsndMsg: TEdit;
    Button4: TButton;
    OpenDialog1: TOpenDialog;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    mp: TMediaPlayer;
    TabSheet4: TTabSheet;
    Label15: TLabel;
    Bevel7: TBevel;
    cbHostGameAnn: TCheckBox;
    cbHostGameAway: TCheckBox;
    Label17: TLabel;
    edHostGameAway: TEdit;
    cbGetIP: TCheckBox;
    TabSheet5: TTabSheet;
    Label21: TLabel;
    Bevel9: TBevel;
    cbAwayAnnounce: TCheckBox;
    cbResumeAnnounce: TCheckBox;
    cbSendAwayPriv: TCheckBox;
    cbSendAwayHiLite: TCheckBox;
    Label16: TLabel;
    Bevel10: TBevel;
    Label19: TLabel;
    cbJoinGameAway: TCheckBox;
    edJoinGameAway: TEdit;
    Label20: TLabel;
    Label18: TLabel;
    Bevel8: TBevel;
    edFntSize: TComboBox;
    TabSheet6: TTabSheet;
    lbBuddies: TListBox;
    Button8: TButton;
    Button9: TButton;
    cbBlink: TCheckBox;
    Button10: TButton;
    Label22: TLabel;
    edExe: TEdit;
    Button11: TButton;
    Bevel11: TBevel;
    OpenDialog2: TOpenDialog;
    cbDisableScroll: TCheckBox;
    procedure SetColors;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure mpNotify(Sender: TObject);
    procedure Button11Click(Sender: TObject);
  private
    { Private declarations }
  public
   procedure PlaySound(Path: String);
  end;

var
  frmSettings: TfrmSettings;

implementation

uses mainform, gamedock, nickdock, loginform;

{$R *.dfm}

procedure TfrmSettings.SetColors;
begin
 mainform.gmfrm.lvGames.Color := colBackground.Selected;
 mainform.gmfrm.lvGames.Font.Color := coltext2.Selected;
 frmMain.rechat.Color := colBackground.Selected;
 frmMain.rechat.Font.Color := colText2.Selected;
 frmMain.Memo1.Color := colBackground.Selected;
 frmMain.Memo1.Font.Color := coltext2.Selected;

 mainform.nickfrm.lvnicks.Color := colBackground.Selected;
 mainform.nickfrm.lvnicks.Font.Color := coltext2.Selected;
end;

procedure TfrmSettings.Button1Click(Sender: TObject);
begin

 //save settings
 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','colBackground',
    rdInteger, colBackground.Selected);

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','colText1',
    rdInteger, colText1.Selected);

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','colText2',
    rdInteger, colText2.Selected);

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','colPrivate',
    rdInteger, colprivate.Selected);

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','colActions',
    rdInteger, colactions.Selected);

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','colJoins',
    rdInteger, coljoins.Selected);

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','colParts',
    rdInteger, colparts.Selected);

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','colQuits',
    rdInteger, colquits.Selected);

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','EnableTimestamps',
    rdString, BoolToStr(cbTimestamps.Checked));

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','TimeStampFormat',
    rdString, edTimeStamp.Text);

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','ShowJoins',
    rdString, BoolToStr(cbJoins.Checked));

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','ShowParts',
    rdString, BoolToStr(cbParts.Checked));

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','ShowQuits',
    rdString, BoolToStr(cbQuits.Checked));

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','BuddySound',
    rdString, edsndBuddy.Text);

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','HiLiteSound',
    rdString, edsndhilite.Text);

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','MsgSound',
    rdString, edsndmsg.Text);

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','HostAwayText',
    rdString, edHostGameAway.Text);

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','JoinAwayText',
    rdString, edJoinGameAway.Text);

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','HostGameAnn',
    rdString, BoolToStr(cbHostGameAnn.Checked));

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','HostGameAway',
    rdString, BoolToStr(cbHostGameAway.Checked));

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','GetIP',
    rdString, BoolToStr(cbGetIP.Checked));

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','JoinGameAway',
    rdString, BoolToStr(cbJoinGameAway.Checked));

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','AwayAnnounce',
    rdString, BoolToStr(cbAwayAnnounce.Checked));

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','ResumeAnnounce',
    rdString, BoolToStr(cbResumeAnnounce.Checked));

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','SendAwayPriv',
    rdString, BoolToStr(cbSendAwayPriv.Checked));

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','SendAwayHiLite',
    rdString, BoolToStr(cbSendAwayHiLite.Checked));

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','FntSize',
    rdString, edFntSize.Text);

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Buddies',
    rdString,lbBuddies.Items.CommaText);

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Blink',
    rdString, BoolToStr(cbBlink.Checked));

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','Waexe',
    rdString, edExe.Text);

 frmLogin.SetRegistryData(HKEY_CURRENT_USER,'\Software\ProSnooper','DisableScroll',
    rdString, BoolToStr(cbDisableScroll.Checked));

 SetColors;
 Close;
end;

procedure TfrmSettings.FormShow(Sender: TObject);
begin
 PageControl1.TabIndex := 0;
end;

procedure TfrmSettings.Button5Click(Sender: TObject);
begin
 if OpenDialog1.Execute then
  edsndBuddy.Text := OpenDialog1.FileName;
end;

procedure TfrmSettings.Button3Click(Sender: TObject);
begin
 if OpenDialog1.Execute then
  edsndHiLite.Text := OpenDialog1.FileName;
end;

procedure TfrmSettings.Button4Click(Sender: TObject);
begin
 if OpenDialog1.Execute then
  edsndMsg.Text := OpenDialog1.FileName;
end;

procedure TfrmSettings.Button2Click(Sender: TObject);
begin
  Button10.Show;
if edsndBuddy.Text <> '' then begin
 mp.Close;
 mp.FileName := edsndBuddy.Text;
 mp.Open;
 mp.Play;
end;
end;

procedure TfrmSettings.Button6Click(Sender: TObject);
begin
  Button10.Show;
if edsndHiLite.Text <> '' then begin
 mp.Close;
 mp.FileName := edsndHiLite.Text;
 mp.Open;
 mp.Play;
end;
end;

procedure TfrmSettings.Button7Click(Sender: TObject);
begin
  Button10.Show;
if edsndMsg.Text <> '' then begin
 mp.Close;
 mp.FileName := edsndMsg.Text;
 mp.Open;
 mp.Play;

end;
end;

procedure TfrmSettings.Button9Click(Sender: TObject);
var
 S: String;
begin
 if InputQuery('Add a buddy','Enter the nickname your buddy uses.',S) then
  lbBuddies.Items.Add(S);
end;

procedure TfrmSettings.Button8Click(Sender: TObject);
begin
if lbBuddies.ItemIndex <> -1 then
 lbBuddies.Items.Delete(lbBuddies.ItemIndex);
end;

procedure TfrmSettings.Button10Click(Sender: TObject);
begin
 mp.Stop;
 Button10.Hide;
end;

procedure TfrmSettings.mpNotify(Sender: TObject);
begin
 if mp.Mode <> mpPlaying then
  Button10.Hide;

 mp.Notify := True;
end;

procedure TfrmSettings.PlaySound(Path: String);
begin

end;

procedure TfrmSettings.Button11Click(Sender: TObject);
begin
 if OpenDialog2.Execute then
  edExe.Text := OpenDialog2.FileName;
end;

end.
