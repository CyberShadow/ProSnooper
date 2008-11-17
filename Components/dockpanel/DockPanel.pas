{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{-------------------------------------------------------------------------------
  This is a modified version of the dockpanel originally written for the
  OpenPerl IDE. It's been made to be as easy to use as physicly possible,
  handling a lot of the stuff for you.
}
{-------------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance with
the License. You may obtain a copy of the License at http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: DockPanel.pas, released 04 Nov 2001.

The Initial Developer of the Original Code is Jürgen Güntherodt.

Portions created by Jürgen Güntherodt <jguentherodt@users.sourceforge.net>
are Copyright (C) 2001-2002 Jürgen Güntherodt. All Rights Reserved.

Contributor: Stefan Ascher <stievie@users.sourceforge.net>

Alternatively, the contents of this file may be used under the terms of the
GNU General Public License Version 2 or later (the "GPL"), in which case
the provisions of the GPL are applicable instead of those above.
If you wish to allow use of your version of this file only under the terms
of the GPL and not to allow others to use your version of this file
under the MPL, indicate your decision by deleting the provisions above and
replace them with the notice and other provisions required by the GPL.
If you do not delete the provisions above, a recipient may use your version
of this file under either the MPL or the GPL.

$Id: DockPanel.pas,v 1.4 2002/05/26 13:47:35 jguentherodt Exp $

You may retrieve the latest version of this file at the Open Perl IDE webpage,
located at http://open-perl-ide.sourceforge.net or http://www.lost-sunglasses.de
-------------------------------------------------------------------------------}
unit DockPanel;

interface

uses
  extCtrls, controls, classes, windows, comCtrls, forms, sysUtils,
  graphics, messages, ImgList, iniFiles, registry;

Type TTabType=(ttText, ttIcon);

type

  TDockHandler = class;
  TPageControlHost = class;
  TDockPanel = class(TPanel)
  private
    m_iWidth: Integer;
    m_bUnDocking: Boolean;
    TabPos: TTabPosition;
    m_iMinSize: Integer;
    m_bDockOnPageControl: Boolean;
    pSizer: TSplitter;
  protected
    procedure PSizerMoved(Sender: TObject);
    function CreateDockManager: IDockManager; override;
    procedure DockOver(Source: TDragDockObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    procedure UnDock(Sender: TObject; Client: TControl; NewTarget: TWinControl; var Allow: Boolean);
    procedure DoEndDock(Target: TObject; X, Y: Integer); override;
    procedure GetSiteInfo(Client: TControl; var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean); override;
    procedure DoStartDock(var DragObject: TDragObject); override;
    function DoUnDock(NewTarget: TWinControl; Client: TControl): Boolean; override;
    procedure Resize(Sender: TObject);
    function GetAsString: String; virtual;
    procedure SetAsString(s: String); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DockDrop(Source: TDragDockObject; X, Y: Integer); override;
    property AsString: String Read GetAsString Write SetAsString;
    property MinSizeWidth: Integer Read m_iMinSize Write m_iMinSize;
  published
    property TabPosition: TTabPosition read TabPos write TabPos;
  end;


  TSetOtherHostAsStringEvent = procedure(Sender: TDockHandler; sValue: String) of object;
  TGetOtherHostAsStringEvent = function(Sender: TDockHandler): String of object;

  TDockHandler = class
  private
    m_iMinSize: Integer;
    m_slDockPanels: TStringList;
    m_slPageControlHosts: TStringList;
    m_slDockClients: TStringList;
    m_Owner: TComponent;
    m_OnRefresh: TNotifyEvent;
    m_slDockHosts: TStringList;
    m_OnSetOtherHostsAsString: TSetOtherHostAsStringEvent;
    m_OnGetOtherHostsAsString: TGetOtherHostAsStringEvent;
    m_pcShadow: TPageControl;
    TType: TTabType;    
    m_nLockRefreshCount: Integer;
    function GetDockPanelCount: Integer;
    function GetDockPanels(i: Integer): TDockPanel;
    function GetPageControlHostCount: Integer;
    function GetPageControlHosts(i: Integer): TPageControlHost;
    function GetDockHostCount: Integer;
    function GetDockHosts(i: Integer): TWinControl;
    function GetDockClientCount: Integer;
    function GetDockClients(i: Integer): TWinControl;
    procedure BuildOldPageControl(sAlign, sData: String);
    procedure DoRefresh; virtual;
    procedure DoSetOtherHostsAsString(sValue: String);
    function DoGetOtherHostsAsString: String;
  protected
    function GetAsString: String; virtual;
    procedure SetAsString(s: String); virtual;
    procedure RegisterDockPanel(pnl: TDockPanel); virtual;
    procedure UnRegisterDockPanel(pnl: TDockPanel); virtual;
    procedure UnregisterPageControlHost(pch: TPageControlHost); virtual;
    procedure RegisterPageControlHost(pch: TPageControlHost); virtual;
    procedure RegisterDockClient(ctrl: TControl); virtual;
    procedure UnRegisterDockClient(ctrl: TControl); virtual;
  public
    bLoadSuccess: Boolean;

    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure LockRefresh;
    procedure UnlockRefresh;
    procedure UnRegisterDockHost(wctrl: TWinControl);
    procedure SaveDesktop(regPath: String);
    procedure LoadDesktop(regPath: String);
    procedure RegisterDockHost(wctrl: TWinControl);
    procedure Refresh;
    property DockClientCount: Integer Read GetDockClientCount;
    property DockClients[i: Integer]: TWinControl Read GetDockClients;
    property DockHostCount: Integer Read GetDockHostCount;
    property DockHosts[i: Integer]: TWinControl Read GetDockHosts;
    property DockPanelCount: Integer Read GetDockPanelCount;
    property DockPanels[i: Integer]: TDockPanel Read GetDockPanels;
    property PageControlHostCount: Integer Read GetPageControlHostCount;
    property PageControlHosts[i: Integer]: TPageControlHost Read GetPageControlHosts;
    property AsString: String Read GetAsString Write SetAsString;

    property Owner: TComponent Read m_Owner;
    property OnRefresh: TNotifyEvent Read m_OnRefresh Write m_OnRefresh;
    property OnSetOtherHostsAsString: TSetOtherHostAsStringEvent Read m_OnSetOtherHostsAsString Write m_OnSetOtherHostsAsString;
    property OnGetOtherHostsAsString: TGetOtherHostAsStringEvent Read m_OnGetOtherHostsAsString Write m_OnGetOtherHostsAsString;
    property TabType: TTabType Read TType Write TType;
  end;


  TPageControlHost = class(TForm)
    PageControl: TPageControl;
    tmr: TTimer;
    img: TImageList;
    procedure PageControlUnDock(Sender: TObject; Client: TControl;
      NewTarget: TWinControl; var Allow: Boolean);
    procedure tmrTimer(Sender: TObject);
    procedure PageControlGetSiteInfo(Sender: TObject; DockClient: TControl;
      var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
    procedure PageControlDockDrop(Sender: TObject; Source: TDragDockObject;
      X, Y: Integer);
    procedure PageControlChange(Sender: TObject);
  private
    { Private declarations }
    m_bOnClose: Boolean;
    function GetVisibleDockClientCount: Integer;
  protected
    function GetAsString: String; virtual;
    procedure SetAsString(s: String); virtual;
    procedure DoShow; override;
    procedure DoHide; override;
    procedure DoStartDock(var DragObject: TDragObject); override;
    procedure DoEndDock(Target: TObject; X, Y: Integer); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property AsString: String Read GetAsString Write SetAsString;
  end;

  TDockableForm = class(TForm)
  private
    m_CaptionPanel: TPanel;
    m_LastHostDockSiteClass: TClass;
    function GetVisible: Boolean;
    procedure SetVisible(b: Boolean);
  protected
    function GetAsString: String; virtual;
    procedure SetAsString(s: String); virtual;
    procedure DoEndDock(Target: TObject; X, Y: Integer); override;
    procedure DoShow; override;
    procedure DoHide; override;
    property AsString: String Read GetAsString Write SetAsString;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RefreshCaption; virtual;
    property Visible: Boolean Read GetVisible Write SetVisible;
    property LastHostDockSiteClass: TClass Read m_LastHostDockSiteClass;
  end;

  var
  bDontSize: BOolean;

function DockHandler(AOwner: TComponent = nil): TDockHandler;


procedure Register;


implementation

{$R *.DFM}
// {$R F_DOCKABLEFORM.DFM}

const
  InternalDockHandler: TDockHandler = nil;


procedure Register;
begin
  RegisterComponents('DockPanel', [TDockPanel]);
end;


function GetVisibleDockClientCount(win: TWinControl): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to win.DockClientCount - 1 do begin
    if win.DockClients[i].Visible then inc(Result);
  end;
end;


function DockHandler(AOwner: TComponent): TDockHandler;
begin
  if InternalDockHandler = nil then InternalDockHandler := TDockHandler.Create(AOwner);
  Result := InternalDockHandler;
end;


function StrToBool(s: String): Boolean;
begin
  if s = 'FALSE' then Result := False else Result := True;
end;

function BoolToStr(b: Boolean): String;
begin
  if b then Result := 'TRUE' else Result := 'FALSE';
end;


////////////////////////////////////////////////////////////////////////////////
//  TDockHandler = class(TComponent)
////////////////////////////////////////////////////////////////////////////////
constructor TDockHandler.Create(AOwner: TComponent);
begin
  inherited Create;
  m_Owner := AOwner;
  if not (csDesigning in m_Owner.ComponentState) then begin
    m_pcShadow := TPageControl.Create(m_Owner);
    m_pcShadow.Parent := TWinControl(m_Owner);
    m_pcShadow.Visible := False;
    m_pcShadow.DockSite := True;
  end;
  m_slDockPanels := TStringList.Create;
  m_slDockPanels.Sorted := True;
  m_slDockPanels.Duplicates := dupIgnore;
  m_slPageControlHosts := TStringList.Create;
  m_slPageControlHosts.Sorted := True;
  m_slPageControlHosts.Duplicates := dupIgnore;
  m_slDockClients := TStringList.Create;
  m_slDockClients.Sorted := True;
  m_slDockClients.Duplicates := dupIgnore;
  m_slDockHosts := TStringList.Create;
  m_slDockHosts.Sorted := True;
  m_slDockHosts.Duplicates := dupIgnore;
  AsString := '';
end;

destructor TDockHandler.Destroy;
begin
  while DockPanelCount > 0 do UnRegisterDockPanel(DockPanels[0]);
  while PageControlHostCount > 0 do UnregisterPageControlHost(PageControlHosts[0]);
  while DockHostCount > 0 do UnregisterDockHost(DockHosts[0]);
  m_slDockHosts.Free;
  m_slDockPanels.Free;
  m_slPageControlHosts.Free;
  m_slDockClients.Free;
  inherited Destroy;
end;


procedure TDockHandler.LockRefresh;
begin
  inc(m_nLockRefreshCount);
end;


procedure TDockHandler.UnlockRefresh;
begin
  if m_nLockRefreshCount > 0 then dec(m_nLockRefreshCount);
  if m_nLockRefreshCount = 0 then Refresh;
end;

function TDockHandler.GetDockClientCount: Integer;
begin
  Result := m_slDockClients.Count;
end;


function TDockHandler.GetDockClients(i: Integer): TWinControl;
begin
  Result := TWinControl(m_slDockClients.Objects[i]);
end;


function TDockHandler.DoGetOtherHostsAsString: String;
begin
  if Assigned(m_OnGetOtherHostsAsString) then Result := m_OnGetOtherHostsAsString(Self);
end;


procedure TDockHandler.DoSetOtherHostsAsString(sValue: String);
begin
  if Assigned(m_OnSetOtherHostsAsString) then m_OnSetOtherHostsAsString(Self, sValue);
end;


function TDockHandler.GetDockHostCount: Integer;
begin
  Result := m_slDockHosts.Count;
end;


function TDockHandler.GetDockHosts(i: Integer): TWinControl;
begin
  Result := TWinControl(m_slDockHosts.Objects[i]);
end;


procedure TDockHandler.UnRegisterDockHost(wctrl: TWinControl);
var
  idx: Integer;
begin
  idx := m_slDockHosts.IndexOf(IntToStr(Integer(wctrl)));
  if idx > -1 then m_slDockHosts.Delete(idx);
end;


procedure TDockHandler.RegisterDockHost(wctrl: TWinControl);
begin
  m_slDockHosts.AddObject(IntToStr(Integer(wctrl)), wctrl);
end;


procedure TDockHandler.Refresh;
begin
  if m_nLockRefreshCount = 0 then DoRefresh;
end;


procedure TDockHandler.DoRefresh;
var i: Integer;
begin
  for i := 0 to GetDockPanelCount-1 do
    if GetVisibleDockClientcount(GetDockPanels(i)) = 0 then begin
      With GetDockPanels(i) do begin
        Width := 0;
        Height := 0;
        if pSizer <> nil then begin
          pSizer.Align := alNone;
          pSizer.Visible := False;
          pSizer.Destroy;
          pSizer := nil;
        end;
      end;
    end;
  if Assigned(m_OnRefresh) then m_OnRefresh(Self);

end;


procedure TDockHandler.RegisterDockClient(ctrl: TControl);
begin
  m_slDockClients.AddObject(IntToStr(Integer(ctrl)), ctrl);
  if ctrl.Owner <> nil then ctrl.Owner.RemoveComponent(ctrl);
  if Owner <> nil then Owner.InsertComponent(ctrl);
end;


procedure TDockHandler.UnRegisterDockClient(ctrl: TControl);
var
  idx: Integer;
begin
  idx := m_slDockClients.IndexOf(IntToStr(Integer(ctrl)));
  if idx > -1 then m_slDockClients.Delete(idx);
end;


function TDockHandler.GetDockPanelCount: Integer;
begin
  Result := m_slDockPanels.Count;
end;


function TDockHandler.GetDockPanels(i: Integer): TDockPanel;
begin
  Result := TDockPanel(m_slDockPanels.Objects[i]);
end;


function TDockHandler.GetPageControlHostCount: Integer;
begin
  Result := m_slPageControlHosts.Count;
end;


function TDockHandler.GetPageControlHosts(i: Integer): TPageControlHost;
begin
  Result := TPageControlHost(m_slPageControlHosts.Objects[i]);
end;


procedure TDockHandler.UnregisterPageControlHost(pch: TPageControlHost);
var
  idx: Integer;
begin
  idx := m_slPageControlHosts.IndexOf(IntToStr(Integer(pch)));
  if idx > -1 then m_slPageControlHosts.Delete(idx);
end;


procedure TDockHandler.RegisterPageControlHost(pch: TPageControlHost);
begin
  m_slPageControlHosts.AddObject(IntToStr(Integer(pch)), pch);
end;


function TDockHandler.GetAsString: String;
var
  sl: TStringList;
  i: Integer;
  sPageControlHosts: String;
  sDockPanels: String;
  sFloatingDockForms: String;
  frm: TDockableForm;
begin
  sl := TStringList.Create;
  for i := 0 to m_slDockClients.Count - 1 do begin
    frm := TDockableForm(m_slDockClients.Objects[i]);
    if frm.HostDockSite = nil then sl.Values[frm.Name] := frm.AsString;
  end;
  sFloatingDockForms := sl.CommaText;
  sl.Clear;
  for i := 0 to PageControlHostCount - 1 do begin
    sl.Values[PageControlHosts[i].Name] := PageControlHosts[i].AsString;
  end;
  sPageControlHosts := sl.CommaText;
  sl.Clear;
  for i := 0 to DockPanelCount - 1 do begin
    sl.Values[DockPanels[i].Name] := DockPanels[i].AsString;
  end;
  sDockPanels := sl.CommaText;
  sl.Clear;
  sl.Values['FloatingDockForms'] := sFloatingDockForms;
  sl.Values['PageControlHosts'] := sPageControlHosts;
  sl.Values['DockPanels'] := sDockPanels;
  sl.Values['OtherHosts'] := DoGetOtherHostsAsString;
  sl.Values['Version'] := '1';
  Result := sl.CommaText;
  sl.Free;
end;

procedure TDockHandler.LoadDesktop(regPath: string);
var
  reg: TRegistry;
  tmp: String;
begin
  reg := TRegistry.Create;
  reg.OpenKey(regPath, True);
  bLoadSuccess := False;
  tmp:=AsString;
  if reg.ValueExists('dockData') then begin
    SetAsString(reg.ReadString('dockData'));
    bLoadSuccess := True;
  end;

  reg.Free;
end;


procedure TDockHandler.SaveDesktop(regPath: string);
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  reg.OpenKey(regPath, True);
  reg.WriteString('dockData', AsString);
  reg.Free;
end;

procedure TDockHandler.BuildOldPageControl(sAlign, sData: String);
var
  sl: TStringList;
  pch: TPageControlHost;
  cmp: TComponent;
  i: Integer;
  dp: TDockPanel;
  nTabIndex: Integer;
begin
  sl := TStringList.Create;
  sl.CommaText := sData;
  if sl.Count > 3 then begin
    pch := TPageControlHost.Create(Owner);
    if DockHandler.TType = ttIcon then
      pch.PageControl.Images := pch.img;
    pch.Name := 'pc' + sAlign;
    cmp := Owner.FindComponent('dp' + sAlign);
    if (cmp <> nil) and (cmp is TDockPanel) then begin
      dp := TDockPanel(cmp);
      dp.Width := StrToIntDef(sl.Values['Width'], 200);
      dp.Height := StrToIntDef(sl.Values['Height'], 200);
      for i := 3 to sl.Count - 1 do begin
        cmp := Owner.FindComponent(sl.Names[i]);
        if (cmp <> nil) and (cmp is TDockableForm) then begin
          TDockableForm(cmp).AsString := sl.Values[cmp.Name];
          TDockableForm(cmp).ManualDock(pch.PageControl);
        end;
      end;
      pch.ManualDock(dp);
      nTabIndex := StrToIntDef(sl.Values['TabIndex'], -1);
      if (nTabIndex > -1) and (nTabIndex < pch.PageControl.PageCount) then
        pch.PageControl.ActivePage := pch.PageControl.Pages[nTabIndex];
      pch.Visible := True;
    end;
  end;
  sl.Free;
end;


procedure TDockHandler.SetAsString(s: String);
var
  sl: TStringList;
  i: Integer;
  slFloatingDockForms: TStringList;
  slPageControlHosts: TStringList;
  slDockPanels: TStringList;
  cmp: TComponent;
  ctrl: TControl;
  rct: TRect;
  sVersion: String;
begin
  // Lock updates
  LockRefresh;
  try
    bDontSize:=True;
    // Hide and float all registered dock clients
    for i := 0 to m_slDockClients.Count - 1 do begin
      ctrl := TControl(m_slDockClients.Objects[i]);
      TControl(m_slDockClients.Objects[i]).ManualDock(m_pcShadow);
      TControl(m_slDockClients.Objects[i]).Hide;
      if ctrl is TDockableForm then TDockableForm(ctrl).m_LastHostDockSiteClass := nil;
      rct := ctrl.BoundsRect;
      if ctrl.Parent <> nil then begin
        rct.TopLeft := ctrl.Parent.ClientToScreen(rct.TopLeft);
        rct.BottomRight := ctrl.Parent.ClientToScreen(rct.BottomRight);
      end;
      ctrl.ManualFloat(rct);
    end;

    // Destroy all dynamic page control hosts
    while PageControlHostCount > 0 do PageControlHosts[0].Free;


    sl := TStringList.Create;
    sl.CommaText := s;

    sVersion := UpperCase(sl.Values['Version']);

    if sVersion = '1' then begin
      // Handle floating dockable forms
      slFloatingDockForms := TStringList.Create;
      slFloatingDockForms.CommaText := sl.Values['FloatingDockForms'];
      for i := 0 to slFloatingDockForms.Count - 1 do begin
        cmp := Owner.FindComponent(slFloatingDockForms.Names[i]);
        if cmp <> nil then begin
          TDockableForm(cmp).AsString := slFloatingDockForms.Values[cmp.Name];
        end;
      end;
      slFloatingDockForms.Free;

      // Create dynamic page control hosts
      slPageControlHosts := TStringList.Create;
      slPageControlHosts.CommaText := sl.Values['PageControlHosts'];
      for i := 0 to slPageControlHosts.Count - 1 do begin
        cmp := Owner.FindComponent(slPageControlHosts.Names[i]);
        if cmp = nil then begin
          cmp := TPageControlHost.Create(Owner);
          TPageControlHost(cmp).SetParent(nil); //Owner as TWinControl);
          cmp.Name := slPageControlHosts.Names[i];
        end;
        TPageControlHost(cmp).AsString := slPageControlHosts.Values[cmp.Name];
      end;
      slPageControlHosts.Free;


      // Create dockpanels
      slDockPanels := TStringList.Create;
      slDockPanels.CommaText := sl.Values['DockPanels'];
      for i := 0 to slDockPanels.Count - 1 do begin
        cmp := Owner.FindComponent(slDockPanels.Names[i]);
        if cmp <> nil then begin
          TDockPanel(cmp).AsString := slDockPanels.Values[cmp.Name];
          if TDockPanel(cmp).DockClientCount = 0 then begin
            TDockPanel(cmp).Width := 0;
            TDockPanel(cmp).Height := 0;
          end;
        end;

      end;
      slDockPanels.Free;

      // Handle forms, which are docked in another way
      DoSetOtherHostsAsString(sl.Values['OtherHosts']);

    end else begin
      // Handle floating dockable forms
      slFloatingDockForms := TStringList.Create;
      slFloatingDockForms.CommaText := sl.Values['Floating'];
      for i := 0 to slFloatingDockForms.Count - 1 do begin
        cmp := Owner.FindComponent(slFloatingDockForms.Names[i]);
        if (cmp <> nil) and (cmp is TDockableForm) then begin
          TDockableForm(cmp).AsString := slFloatingDockForms.Values[cmp.Name];
        end;
      end;
      DoSetOtherHostsAsString('MainForm=' + slFloatingDockForms.Values['MainForm']);
      slFloatingDockForms.Free;

      BuildOldPageControl('Left', sl.Values['pcLeft']);
      BuildOldPageControl('Top', sl.Values['pcTop']);
      BuildOldPageControl('Right', sl.Values['pcRight']);
      BuildOldPageControl('Bottom', sl.Values['pcBottom']);
    end;

    sl.Free;
  finally
    // Unlock updates
    UnlockRefresh;
    bDontSize:=False;
  end;
end;




procedure TDockHandler.RegisterDockPanel(pnl: TDockPanel);
begin
  m_slDockPanels.AddObject(IntToStr(Integer(pnl)), pnl);
end;


procedure TDockHandler.UnRegisterDockPanel(pnl: TDockPanel);
var
  idx: Integer;
begin
  idx := m_slDockPanels.IndexOf(IntToStr(Integer(pnl)));
  if idx > -1 then m_slDockPanels.Delete(idx);
end;



////////////////////////////////////////////////////////////////////////////////
//  TDockPanel = class(TPanel)
////////////////////////////////////////////////////////////////////////////////
constructor TDockPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  m_iWidth := 200;
  m_iMinSize := 50;
  OnUnDock := UnDock;
  OnResize := Resize;
  DockHandler(AOwner).RegisterDockPanel(Self);
end;

procedure TDockPanel.PSizerMoved(Sender: TObject);
begin
    if (Align = alLeft) or (Align = alRight) then begin
      if Width < m_iMinSize then begin
        Width := m_iMinSize
      end;
    end
    else begin
      if Height < m_iMinSize then begin
        Height := m_iMinSize;
      end;
    end;
end;


procedure TDockPanel.Resize(Sender: TObject);
begin


end;


procedure TDockPanel.UnDock(Sender: TObject; Client: TControl; NewTarget: TWinControl; var Allow: Boolean);
begin
  m_bUndocking := True;
  if (Align = alLeft) or (align = alRight) then
    m_iWidth := Width
  else
    m_iWidth := Height;

  if GetVisibleDockClientCount(Self) = 1 then begin
    if (Align = alLeft) or (Align = alRight) then
      Width := 0
    else
      Height := 0;
    if pSizer <> nil then begin
      // This should never be the case but better safe than
      // sorry :)
      pSizer.Align := alNone;
      pSizer.Destroy;
      pSizer := nil;
    end;
  end;
end;

destructor TDockPanel.Destroy;
begin
  DockHandler.UnRegisterDockPanel(Self);
  inherited Destroy;
end;


function TDockPanel.CreateDockManager: IDockManager;
begin
  Result := inherited CreateDockManager;
(*
  if (DockManager = nil) and DockSite and UseDockManager then
    Result := TCustomDockTree.Create(Self)
  else
    Result := DockManager;
*)
end;


procedure TDockPanel.SetAsString(s: String);
var
  sl: TStringList;
  slDockClients: TStringList;
  cmp: TComponent;
  i: Integer;
  ms: TMemoryStream;
  h: String;
begin
  sl := TStringList.Create;
  sl.CommaText := s;
  bDontSize := True;
  // Restore dock clients
  slDockClients := TStringList.Create;
  slDockClients.CommaText := sl.Values['DockClients'];
  for i := 0 to slDockClients.Count - 1 do begin
    cmp := Owner.FindComponent(slDockClients.Names[i]);
    if (cmp <> nil) and (cmp is TDockableForm) then begin
      TDockableForm(cmp).AsString := slDockClients.Values[cmp.Name];
      TDockableForm(cmp).m_CaptionPanel.Visible := True;
    end;
  end;
  slDockClients.Free;

  // Load width and height
  Width := StrToIntDef(sl.Values['Width'], 200);
  Height := StrToIntDef(sl.Values['Height'], 200);
  m_iWidth := StrToIntDef(sl.Values['iWidth'], 200);
  // Load and apply docking information
  h := sl.Values['DockingData'];
  ms := TMemoryStream.Create;
  ms.SetSize(Length(h) div 2);
  HexToBin(PChar(h), ms.Memory, Length(h));
  ms.Seek(0, soFromBeginning);
  DockManager.LoadFromStream(ms);
  DockManager.ResetBounds(True);
  ms.Free;
  bDontSize:=False;
  sl.Free;
end;


function TDockPanel.GetAsString: String;
var
  i: Integer;
  sl: TStringList;
  ms: TMemoryStream;
  sDockingData: String;
  sDockClients: String;
begin
  Result := '';
  sl := TStringList.Create;

  for i := 0 to DockClientCount - 1 do begin
    sl.Values[DockClients[i].Name] := TDockableForm(DockClients[i]).AsString;
  end;

  sDockClients := sl.CommaText;
  sl.Clear;

  // Use DockManager to store docking information
  ms := TMemoryStream.Create;
  DockManager.SaveToStream(ms);
  SetLength(sDockingData, 2 * ms.Size);
  BinToHex(ms.Memory, PChar(sDockingData), ms.Size);
  ms.Free;

  sl.Values['DockClients'] := sDockClients;
  sl.Values['Width'] := IntToStr(Width);
  sl.Values['Height'] := IntToStr(Height);
  sl.Values['iWidth'] := IntToStr(m_iWidth);  
  sl.Values['DockingData'] := sDockingData;

  Result := sl.CommaText;
  if (Self.DockClientCount = 0) then begin
    Width := 0;
    Height := 0;
  end;
  sl.Free;
end;



procedure TDockPanel.DockDrop(Source: TDragDockObject; X, Y: Integer);
var
  pch: TPageControlHost;

begin
  m_bUndocking := True;
  if (Source.Control is TPageControlHost) then begin
    (Source.Control as TPageControlHost).PageControl.TabPosition := Self.TabPos;
    if ((Source.Control as TPageControlHost).PageControl.TabPosition <> tpLeft) and ((Source.Control as TPageControlHost).PageControl.TabPosition <> tpRight) then

    (Source.Control as TPageControlHost).PageControl.MultiLine := False;
  end;
  if m_bDockOnPageControl then begin
    pch := TPageControlHost.Create(Owner);
    pch.Parent := Self;
    pch.BoundsRect := Source.DropOnControl.ClientRect;
    pch.Visible := True;

    m_bDockOnPageControl := False;
    pch.ReplaceDockedControl(Source.DropOnControl, pch.PageControl, nil, alClient);
    Source.Control.ManualDock(pch.PageControl);
    pch.Caption := pch.PageControl.ActivePage.Caption;
    pch.PageControl.TabPosition := Self.TabPos;
    if (pch.PageControl.TabPosition <> tpLeft) and (pch.PageControl.TabPosition <> tpRight) then
      pch.PageControl.MultiLine := False;
  end else begin
    inherited DockDrop(Source, x, y);
    if m_iWidth < m_iMinSize then m_iWidth := m_iMinSize;

    if pSizer = nil then begin
      // Place a splitter
      pSizer := TSplitter.Create(Self.Parent);
      pSizer.OnMoved := PSizerMoved;
      pSizer.MinSize := m_iMinSize;
      pSizer.Color := clBtnFace;
      pSizer.Parent := Self.Parent;
      pSizer.Align := Self.Align;
      pSizer.Width := 4;
    end;
    if (Self.DockClientCount =1) and (bDontSize=False) then
      if (Self.Align = alLeft) or (Align = alRight) then
        Width := m_iWidth
      else
        Height := m_iWidth;
    if Align = alTop then
      pSizer.Top := Self.Height + Self.Top;
    if Align = alBottom then
      pSizer.Top := Self.Top;
    if Align = alLeft then
      pSizer.Left := Self.Left + Self.Width;
    if Align = alRight then
      pSizer.Left := Self.Left;
    pSizer.Visible := True;
  end;
end;


procedure TDockPanel.DockOver(Source: TDragDockObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  rct: TRect;
  nFrameWidth, nFrameHeight: Integer;
begin
  inherited DockOver(Source, x, y, State, Accept);
  m_bDockOnPageControl := False;
  if GetVisibleDockClientCount(Self) = 0 then begin
    if m_iWidth < m_iMinSize then m_iWidth := m_iMinSize;
    if Self.Align = alLeft then begin
      rct.TopLeft := Point(0, 0);
      rct.BottomRight := Point(m_iWidth, ClientHeight);
      rct.TopLeft := ClientToScreen(rct.TopLeft);
      rct.BottomRight := ClientToScreen(rct.BottomRight);
      Source.DockRect := rct;
    end
    else if Self.Align = alRight then begin
      rct.TopLeft := Point(Width - m_iWidth, 0);
      rct.BottomRight := Point(ClientWidth, ClientHeight);
      rct.TopLeft := ClientToScreen(rct.TopLeft);
      rct.BottomRight := ClientToScreen(rct.BottomRight);
      Source.DockRect := rct;
    end
    else if Self.Align = alBottom then begin
      rct.TopLeft := Point(0, ClientHeight - m_iWidth);
      rct.BottomRight := Point(Width, ClientHeight);
      rct.TopLeft := ClientToScreen(rct.TopLeft);
      rct.BottomRight := ClientToScreen(rct.BottomRight);
      Source.DockRect := rct;
    end
    else begin
      rct.TopLeft := Point(0, 0);
      rct.BottomRight := Point(Width, Top + m_iWidth);
      rct.TopLeft := ClientToScreen(rct.TopLeft);
      rct.BottomRight := ClientToScreen(rct.BottomRight);
      Source.DockRect := rct;
    end;
  end;
  if (Source.DropOnControl <> nil) and (not (Source.Control is TPageControlHost)) then begin
    if Source.Control.HostDockSite <> nil then begin
      if Source.Control.HostDockSite.Parent = Source.DropOnControl then exit;
    end;
    if Source.Control = Source.DropOnControl then exit;
    rct := Source.DropOnControl.BoundsRect;
    nFrameWidth := (rct.Right - rct.Left) div 5;
    nFrameHeight := (rct.Bottom - rct.Top) div 5;
    rct.Left := rct.Left + nFrameWidth;
    rct.Top := rct.Top + nFrameHeight;
    rct.Right := rct.Right - nFrameWidth;
    rct.Bottom := rct.Bottom - nFrameHeight;
    if PtInRect(rct, Point(x, y)) then begin
      rct.TopLeft := ClientToScreen(rct.TopLeft);
      rct.BottomRight := ClientToScreen(rct.BottomRight);
      Source.DockRect := rct;
      m_bDockOnPageControl := True;
    end;
  end;
end;


procedure TDockPanel.DoEndDock(Target: TObject; X, Y: Integer);
begin
  inherited DoEndDock(Target, x, y);
end;


procedure TDockPanel.GetSiteInfo(Client: TControl; var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
begin
  inherited GetSiteInfo(Client, InfluenceRect, MousePos, CanDock);
end;


procedure TDockPanel.DoStartDock(var DragObject: TDragObject);
begin
  inherited DoStartDock(DragObject);
end;


function TDockPanel.DoUnDock(NewTarget: TWinControl; Client: TControl): Boolean;
begin
  Result := inherited DoUndock(NewTarget, Client);
  DockHandler.Refresh;
end;





////////////////////////////////////////////////////////////////////////////////
//  TPageControlHost = class(TForm)
////////////////////////////////////////////////////////////////////////////////
constructor TPageControlHost.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DragKind := dkDock;
  DragMode := dmAutomatic;
  PageControl.HotTrack := True;
  DockHandler.RegisterPageControlHost(Self);
end;


destructor TPageControlHost.Destroy;
begin
  DockHandler.UnregisterPageControlHost(Self);
  inherited Destroy;
end;


procedure TPageControlHost.DoStartDock(var DragObject: TDragObject);
begin
  PageControl.SetFocus;
  inherited DoStartDock(DragObject);
end;


procedure TPageControlHost.DoEndDock(Target: TObject; X, Y: Integer);
begin
  inherited DoEndDock(Target, x, y);
  DockHandler.Refresh;
end;


procedure TPageControlHost.DoShow;
begin
  inherited DoShow;
  DockHandler.Refresh;
end;


procedure TPageControlHost.DoHide;
begin
  inherited DoHide;
  DockHandler.Refresh;
end;


function TPageControlHost.GetVisibleDockClientCount: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to PageControl.DockClientCount - 1 do begin
    if PageControl.DockClients[i].Visible then inc(Result);
  end;
end;


function TPageControlHost.GetAsString: String;
var
  sl: TStringList;
  i: Integer;
  s: String;
  ctrl: TControl;
  pt: TPoint;
begin
  sl := TStringList.Create;
  // Docked Controls, ActivePage, Visibility
  for i := 0 to PageControl.DockClientCount - 1 do begin
    ctrl := PageControl.DockClients[i];
    sl.Values[ctrl.Name] := TDockableForm(ctrl).AsString;
  end;
  s := sl.CommaText;
  sl.Clear;
  sl.Values['DockedControls'] := s;
  sl.Values['ActivePage'] := PageControl.ActivePage.Caption;
  pt := Point(Left, Top);
  if HostDockSite <> nil then pt := HostDockSite.ClientToScreen(pt);
  sl.Values['Left'] := IntToStr(pt.x);
  sl.Values['Top'] := IntToStr(pt.y);
  sl.Values['Width'] := IntToStr(Width);
  sl.Values['Height'] := IntToStr(Height);
//  PageControl.TabPosition := TTabPosition(StrToIntDef(sl.Values['TabPos'], 0);
  sl.Values['TabPos'] := IntToStr(Integer(PageControl.TabPosition));
  sl.Values['Visible'] := BoolToStr(Visible);
  sl.Values['Floating'] := BoolToStr(HostDockSite = nil);
  Result := sl.CommaText;
  sl.Free;
end;


procedure TPageControlHost.SetAsString(s: String);
var
  sl, slDockedControls: TStringList;
  sCaption: String;
  i: Integer;
  cmp: TComponent;
  nLeft, nTop, nWidth, nHeight: Integer;
  bFloating: Boolean;
begin
  Visible := False;

  sl := TStringList.Create;
  sl.CommaText := s;

  // Apply page control docking
  slDockedControls := TStringList.Create;
  slDockedControls.CommaText := sl.Values['DockedControls'];
  for i := 0 to slDockedControls.Count - 1 do begin
    cmp := Owner.FindComponent(slDockedControls.Names[i]);
    if (cmp <> nil) and (cmp is TDockableForm) then begin
      TDockableForm(cmp).AsString := slDockedControls.Values[cmp.Name];
      TDockableForm(cmp).m_CaptionPanel.Visible := False;
      TControl(cmp).ManualDock(PageControl);
    end;
  end;
  slDockedControls.Free;

  // Set active page
  sCaption := sl.Values['ActivePage'];
  for i := 0 to PageControl.PageCount - 1 do begin
    if PageControl.Pages[i].Caption = sCaption then
      PageControl.ActivePage := PageControl.Pages[i];
  end;

  nLeft := StrToIntDef(sl.Values['Left'], 0);
  nTop := StrToIntDef(sl.Values['Top'], 0);
  nWidth := StrToIntDef(sl.Values['Width'], 200);
  nHeight := StrToIntDef(sl.Values['Height'], 200);

  PageControl.TabPosition := TTabPosition(StrToIntDef(sl.Values['TabPos'], 0));
  if (PageControl.TabPosition <> tpLeft) and (PageControl.TabPosition <> tpRight) then
  PageControl.MultiLine := False;
  BoundsRect := Rect(nLeft, nTop, nLeft + nWidth, nTop + nHeight);

  bFloating := StrToBool(sl.Values['Floating']);
  if not bFloating then begin
    ManualDock(DockHandler.m_pcShadow);
    Align := alNone;
  end;

  // Set visibility
  Visible := StrToBool(sl.Values['Visible']);
  Caption := PageControl.ActivePage.Caption;
  sl.Free;
end;


procedure TPageControlHost.PageControlUnDock(Sender: TObject;
  Client: TControl; NewTarget: TWinControl; var Allow: Boolean);
begin

 if m_bOnClose then exit;
//  if PageControl.DockClientCount = 2 then begin
  if GetVisibleDockClientCount <= 2 then begin
    // at maximum one visible DockClient remains on page control
    m_bOnClose := True;
    tmr.Enabled := True;
  end;
end;

procedure TPageControlHost.tmrTimer(Sender: TObject);
var
  i: Integer;
  ctrl: TControl;
  sl: TStringList;
  rct: TRect;
begin
  tmr.Enabled := False;
  sl := TStringList.Create;
  i := 0;
  ctrl := nil;
  while i < PageControl.DockClientCount do begin
    if PageControl.DockClients[i].Visible then begin
      ctrl := PageControl.DockClients[i];
    end else begin
      sl.AddObject('', PageControl.DockClients[i]);
    end;
    inc(i);
  end;
  for i := 0 to sl.Count - 1 do begin
    rct := TControl(sl.Objects[i]).BoundsRect;
    rct.TopLeft := ClientToScreen(rct.TopLeft);
    rct.BottomRight := ClientToScreen(rct.BottomRight);
    TControl(sl.Objects[i]).ManualFloat(rct);
  end;
  sl.Free;
  if ctrl <> nil then ctrl.ReplaceDockedControl(Self, nil, nil, alNone);
  PostMessage(Handle, WM_CLOSE, 0, 0);
end;


procedure TPageControlHost.PageControlGetSiteInfo(Sender: TObject;
  DockClient: TControl; var InfluenceRect: TRect; MousePos: TPoint;
  var CanDock: Boolean);
begin
  CanDock := DockClient.HostDockSite <> PageControl;
  if CanDock = true then
    CanDock := (DockClient.Tag <> 1) and (DockClient.Tag <> 2);
end;



procedure TPageControlHost.PageControlDockDrop(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer);
var
  pch: TPageControlHost;
  Icon: TIcon;
begin
  if Source.Control is TDockableForm then begin
    if DockHandler.TType = TTIcon then begin
      PageControl.Images := img;
      Icon := TIcon.Create;
      Icon := (Source.Control as TDockableForm).Icon;
      PageControl.ActivePage.ImageIndex := img.AddIcon(Icon);
    end;
  end;
  if Source.Control is TPageControlHost then begin
    pch := Source.Control as TPageControlHost;
    while pch.PageControl.DockClientCount > 0 do begin
      pch.PageControl.DockClients[0].ManualDock(PageControl);
    end;
  end;
  Caption := PageControl.ActivePage.Caption;
end;


////////////////////////////////////////////////////////////////////////////////
//  TDockableForm = class(TForm)
////////////////////////////////////////////////////////////////////////////////
constructor TDockableForm.Create(AOwner: TComponent);
var
  pnl: TPanel;
begin
  inherited Create(AOwner);
  m_CaptionPanel := TPanel.Create(Self);
  m_CaptionPanel.Parent := Self;
  with m_CaptionPanel do begin
    Height := 0;
    Align := alTop;
    BevelInner := bvNone;
    BevelOuter := bvNone;
  end;
  // Caption
  pnl := TPanel.Create(Self);
  pnl.Parent := m_CaptionPanel;
  pnl.Align := alClient;
  pnl.Alignment := taLeftJustify;
  pnl.Caption := '  ' + Self.Caption;
  pnl.BevelInner := bvNone;
  pnl.BevelOuter := bvNone;
  pnl.Font.Color := clNavy;
  DockHandler(AOwner).RegisterDockClient(Self);
end;


destructor TDockableForm.Destroy;
begin

  DockHandler.UnRegisterDockClient(Self);
  inherited Destroy;
end;

function TDockableForm.GetVisible: Boolean;
var
  ctr: TWinControl;
begin
  Result := inherited Visible;
  ctr := Parent;
  while Result and (ctr <> nil) do begin
    if not (ctr is TTabSheet) then Result := ctr.Visible;
    ctr := ctr.Parent;
  end;
end;


procedure TDockableForm.SetVisible(b: Boolean);
var
  ctr: TWinControl;
  pc: TPageControl;
begin
  if b then begin
    if (m_LastHostDockSiteClass <> nil) and (Parent = nil) then begin
      DockHandler.DoSetOtherHostsAsString(m_LastHostDockSiteClass.ClassName + '=' + Name);
      inherited Visible := True;
      exit;
    end;
    inherited Visible := True;
    ctr := Parent;
    while ctr <> nil do begin
      ctr.Visible := True;
      if ctr is TTabSheet then begin
        pc := TTabSheet(ctr).PageControl;
        if pc <> nil then pc.ActivePage := TTabSheet(ctr);
      end else if ctr is TForm then begin
        ctr.BringToFront;
      end;
      ctr := ctr.Parent;
    end;
  end else begin
    inherited Visible := False;
  end;
end;


procedure TDockableForm.RefreshCaption;
begin
  m_CaptionPanel.Visible := (HostDockSite <> nil) and (HostDockSite is TDockPanel);
end;


procedure TDockableForm.DoShow;
begin
  if HostDockSite <> nil then begin
    m_LastHostDockSiteClass := HostDockSite.ClassType;
  end else begin
    m_LastHostDockSiteClass := nil;
  end;
  inherited DoShow;
  DockHandler.Refresh;
end;


procedure TDockableForm.DoHide;
begin
  if HostDockSite <> nil then begin
    m_LastHostDockSiteClass := HostDockSite.ClassType;
  end else begin
    m_LastHostDockSiteClass := nil;
  end;
  inherited DoHide;
  DockHandler.Refresh;
end;


procedure TDockableForm.DoEndDock(Target: TObject; X, Y: Integer);
begin
  if HostDockSite <> nil then begin
    m_LastHostDockSiteClass := HostDockSite.ClassType;
  end else begin
    m_LastHostDockSiteClass := nil;
  end;
  inherited DoEndDock(Target, x, y);
  DockHandler.Refresh;
end;


function TDockableForm.GetAsString: String;
var
  sl: TStringList;
  pt: TPoint;
begin
  sl := TStringList.Create;
  pt := Point(Left, Top);
  if HostDockSite <> nil then pt := HostDockSite.ClientToScreen(pt);
  sl.Values['Left'] := IntToStr(pt.x);
  sl.Values['Top'] := IntToStr(pt.y);
  sl.Values['Width'] := IntToStr(Width);
  sl.Values['Height'] := IntToStr(Height);
  sl.Values['Visible'] := BoolToStr(inherited Visible);
  sl.Values['Floating'] := BoolToStr(HostDockSite = nil);
  Result := sl.CommaText;
  sl.Free;
end;


procedure TDockableForm.SetAsString(s: String);
var
  sl: TStringList;
  nLeft, nTop, nWidth, nHeight: Integer;
  bFloating: Boolean;
begin
  sl := TStringList.Create;
  sl.CommaText := s;
  nLeft := StrToIntDef(sl.Values['Left'], 0);
  nTop := StrToIntDef(sl.Values['Top'], 0);
  nWidth := StrToIntDef(sl.Values['Width'], 200);
  nHeight := StrToIntDef(sl.Values['Height'], 200);
  BoundsRect := Rect(nLeft, nTop, nLeft + nWidth, nTop + nHeight);
  bFloating := StrToBool(sl.Values['Floating']);
  if not bFloating then ManualDock(DockHandler.m_pcShadow);
  inherited Visible := StrToBool(sl.Values['Visible']);
  sl.Free;
end;


procedure TPageControlHost.PageControlChange(Sender: TObject);
begin
  Caption := PageControl.ActivePage.Caption;
end;

initialization
finalization
  if InternalDockHandler <> nil then InternalDockHandler.Free;
end.
