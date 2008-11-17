(*

This program is licensed under the rndware License, which can be found in LICENSE.TXT

Copyright (c) Simon Hughes 2007-2008

*)
unit nickdock;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DockPanel, ImgList, ComCtrls, Menus;

type
  TfrmdkNickList = class(TDockableForm)
    lvNicks: TListView;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    Sendprivatemessage1: TMenuItem;
    Addtobuddylist1: TMenuItem;
    Removefrombuddylist1: TMenuItem;
    N1: TMenuItem;
    Ignore1: TMenuItem;
    Unignore1: TMenuItem;
    N2: TMenuItem;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Addtobuddylist1Click(Sender: TObject);
    procedure Sendprivatemessage1Click(Sender: TObject);
    procedure Removefrombuddylist1Click(Sender: TObject);
    procedure Ignore1Click(Sender: TObject);
    procedure Unignore1Click(Sender: TObject);
    procedure lvNicksMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lvNicksDblClick(Sender: TObject);
    procedure lvNicksChanging(Sender: TObject; Item: TListItem;
      Change: TItemChange; var AllowChange: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmdkNickList: TfrmdkNickList;

implementation

uses mainform, loginform, preferform;

{$R *.dfm}

procedure TfrmdkNickList.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 CanClose := False;
end;

procedure TfrmdkNickList.Addtobuddylist1Click(Sender: TObject);
begin
 if nickfrm.lvNicks.ItemIndex <> -1 then begin
 frmSettings.lbBuddies.Items.Add(lvNicks.Selected.SubItems[1]);
 lvNicks.Selected.SubItemImages[0] := 75;
 END;
end;

procedure TfrmdkNickList.Sendprivatemessage1Click(Sender: TObject);
begin
 if nickfrm.lvNicks.ItemIndex <> -1 then begin
  frmMain.Memo1.Text := '/msg '+lvNicks.Selected.SubItems[1]+' ';
  frmMain.Memo1.SelStart := Length(frmMain.Memo1.Text);
  frmMain.Memo1.SetFocus;
 end;
end;

procedure TfrmdkNickList.Removefrombuddylist1Click(Sender: TObject);
begin
 if nickfrm.lvNicks.ItemIndex <> -1 then begin
 frmSettings.lbBuddies.Items.Delete(frmSettings.lbBuddies.Items.IndexOf(lvNicks.Selected.SubItems[1]));
 lvNicks.Selected.SubItemImages[0] := 74;
 frmMain.irc.whois(lvNicks.Selected.SubItems[1],'');
 END;
end;

procedure TfrmdkNickList.Ignore1Click(Sender: TObject);
begin
 if nickfrm.lvNicks.ItemIndex <> -1 then begin
 frmMain.lbIgnore.Items.Add(lvNicks.Selected.SubItems[1]);
 lvNicks.Selected.SubItemImages[0] := 76;
 end;
end;

procedure TfrmdkNickList.Unignore1Click(Sender: TObject);
begin
 if nickfrm.lvNicks.ItemIndex <> -1 then begin
 frmMain.lbIgnore.Items.Delete(frmMain.lbIgnore.Items.IndexOf(lvNicks.Selected.SubItems[1]));
 lvNicks.Selected.SubItemImages[0] := 74;
 frmMain.irc.whois(lvNicks.Selected.SubItems[1],'');
 end;
end;

procedure TfrmdkNickList.lvNicksMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 frmMain.lbnicksMouseMove(nil, Shift, X, Y);
end;

procedure TfrmdkNickList.lvNicksDblClick(Sender: TObject);
begin
if nickfrm.lvNicks.ItemIndex <> -1 then begin
 frmMain.Memo1.Text := '/msg '+lvNicks.Selected.SubItems[1]+' ';
 frmMain.Memo1.SelStart := Length(frmMain.Memo1.Text);
 frmMain.Memo1.SetFocus;
end else
 frmMain.Memo1.Text := '';
end;

procedure TfrmdkNickList.lvNicksChanging(Sender: TObject; Item: TListItem;
  Change: TItemChange; var AllowChange: Boolean);
begin
  frmMain.Caption := 'ProSnooper - '+frmLogin.cbchan.Text+' ('+IntToStr(lvNicks.Items.Count)+')';
  AllowChange := True;
end;

end.
