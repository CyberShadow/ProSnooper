unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, forms,
  Dialogs, ExtCtrls, DockPanel, StdCtrls, ComCtrls, Menus, ShellAPI;

type
  TForm1 = class(Tform)
    DockPanel1: TDockPanel;
    DockPanel2: TDockPanel;
    DockPanel4: TDockPanel;
    MainMenu1: TMainMenu;
    ViewWindows1: TMenuItem;
    Window11: TMenuItem;
    Window21: TMenuItem;
    Window31: TMenuItem;
    Window41: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    StatusBar1: TStatusBar;
    DockPanel3: TDockPanel;
    procedure formCreate(Sender: TObject);
    procedure formDestroy(Sender: TObject);
    procedure Window11Click(Sender: TObject);
    procedure Window21Click(Sender: TObject);
    procedure Window31Click(Sender: TObject);
    procedure Window41Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
  private
    { Private declarations }
    procedure DoRefresh(Sender: TObject);
  public
    { Public declarations }
  end;

var
  form1: Tform1;


implementation

{$R *.dfm}

uses unit2, unit3, Unit4, Unit5;

var
  frm2: Tform2;
  frm3: Tform3;
  frm4: Tform4;
  frm5: Tform5;



procedure TForm1.DoRefresh(Sender: TObject);
begin
  // This is where you can control the layout a bit IE make sure the
  // status bar stays below the bottom panel etc.
  // And make sure to verify the item isn't nil or it might not be
  // there and if thats the case then errors :)

  if (csDestroying in Self.ComponentState) then
    exit;  // If we are destroying everything don't bother
           // Not having this can cause errors.

  if StatusBar1 <> nil then StatusBar1.Top := Height;

  // This would also be the ideal place to place any code to handle
  // the checking and unchecking of menu's.
  if form1 = nil then exit;
  if (frm2 <> nil) and (Window11 <> nil) then Window11.Checked := frm2.Visible;
  if (frm3 <> nil) and (Window21 <> nil) then Window21.Checked := frm3.Visible;
  if (frm4 <> nil) and (Window31 <> nil) then Window31.Checked := frm4.Visible;
  if (frm5 <> nil) and (Window41 <> nil) then Window41.Checked := frm5.Visible;
end;


procedure TForm1.formDestroy(Sender: TObject);
begin
  DockHandler.SaveDesktop('demo\docking');
end;


procedure TForm1.Window11Click(Sender: TObject);
begin
  Window11.Checked := not Window11.Checked;
  frm2.Visible := Window11.Checked;
end;

procedure TForm1.Window21Click(Sender: TObject);
begin
  Window21.Checked := not Window21.Checked;
  frm3.Visible := Window21.Checked;
end;

procedure TForm1.Window31Click(Sender: TObject);
begin
  Window31.Checked := not Window31.Checked;
  frm4.Visible := Window31.Checked;
end;

procedure TForm1.Window41Click(Sender: TObject);
begin
  Window41.Checked := not Window41.Checked;
  frm5.Visible := Window41.Checked;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  pch: TPageControlHost;
begin
  frm2 := TForm2.Create(Self);
  frm3 := TForm3.Create(Self);
  frm4 := TForm4.Create(Self);
  frm5 := TForm5.Create(Self);
  DockHandler.OnRefresh := DoRefresh;
  DockHandler.TabType := ttIcon;  
  DockHandler.LoadDesktop('demo\docking');
  if DockHandler.bLoadSuccess = False then begin
    frm2.ManualDock(dockpanel3);
    frm3.ManualDock(dockpanel3);
    pch := TPageControlHost.Create(DockPanel2);
    pch.Visible := False;
    frm4.ManualDock(pch.PageControl);
    frm5.ManualDock(pch.PageControl);
    frm4.Show;
    frm5.Show;
    pch.ManualDock(DockPanel2);
    pch.Visible := True;
    frm2.Show;
    frm3.Show;
  end;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  ShellExecute(Handle, '', 'http://cedit.sourceforge.net/dockpanel.html', '', '', 0);
end;

end.

