(*

This program is licensed under the rndware License, which can be found in LICENSE.TXT

Copyright (c) Simon Hughes 2007-2008

*)
unit joinform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ShellAPi, IniFiles, umEdit;

type
  TfrmJoinGame = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Bevel1: TBevel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Edit4: TEdit;
    Button2: TButton;
    Label5: TLabel;
    Edit5: TEdit;
    Button3: TButton;
    Edit3: TumValidEdit;
    Edit2: TumValidEdit;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure updatelink;
    procedure Button3Click(Sender: TObject);
    procedure Edit2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmJoinGame: TfrmJoinGame;

implementation

uses loginform, preferform;

{$R *.dfm}
{$warnings off}

procedure TfrmJoinGame.FormShow(Sender: TObject);
begin
 updatelink;
end;

procedure TfrmJoinGame.Button1Click(Sender: TObject);
var
 Port, ConnStr: String;
begin
 if Edit2.Text = '<default>' then
  Port := ''
 else
  Port := ':'+Edit2.Text;

  ConnStr := 'wa://'+Edit1.Text+Port+'?gameid='+Edit3.Text+'&scheme='+Edit4.Text;

 { if frmSettings.edExe.Text <> '' then
   ShellExecute(Handle, PChar('Open'), PChar(frmSettings.edExe), PChar(ConnStr), nil, SW_SHOW)
  else
   ShellExecute(Handle, PChar('Open'), PChar(ConnStr), nil, nil, SW_SHOW);  }

  if frmSettings.edExe.Text <> '' then
   if LowerCase(ExtractFileName(frmsettings.edExe.Text)) = 'wormkit.exe' then
    ShellExecute(Handle, PChar('Open'), PChar(frmSettings.edExe.Text), PChar('wa.exe '{wormkit requires exename}+ConnStr), nil, SW_SHOW)
   else
    ShellExecute(Handle, PChar('Open'), PChar(frmSettings.edExe.Text), PChar(ConnStr), nil, SW_SHOW)
  else
   ShellExecute(Handle, PChar('Open'), PChar(ConnStr), nil, nil, SW_SHOW);


 Close;
end;

procedure TfrmJoinGame.Button2Click(Sender: TObject);
begin
 Close;
end;

procedure TfrmJoinGame.updatelink;
var
 IP, Parameters: String;
 INI: TIniFile;

function GetWinDir: string;
 var
  dir: array [0..MAX_PATH] of Char;
 begin
  GetWindowsDirectory(dir, MAX_PATH);
  Result := StrPas(dir);
 end;
begin
 if Edit1.Text = '' then begin
  try
   ini := TIniFile.Create(GetWinDir+'\win.ini');
   IP := ini.ReadString('NetSettings','LocalAddress','')
  except
   IP := '';
  end;
  ini.Free;
 end else
  IP := Edit1.Text;

 if (Edit2.Text <> '') then
  if (Edit2.Text <> '<default>') then
   IP := IP+':'+Edit2.Text
  else begin
    try
     ini := TIniFile.Create(GetWinDir+'\win.ini');
     IP := IP+':'+ini.ReadString('NetSettings','HostingPort','17011')
    except
     IP := IP+':17011';
    end;
    ini.Free;
  end;

 if (Edit3.Text <> '') or (Edit4.Text <> '') then begin
  Parameters := '?gameid='+Edit3.Text+'&scheme='+Edit4.Text;
 end;

 Edit5.Text := 'wa://'+IP+Parameters;
end;

procedure TfrmJoinGame.Edit1Change(Sender: TObject);
begin
 updatelink;
end;

procedure TfrmJoinGame.Button3Click(Sender: TObject);
begin
 Edit5.SelectAll;
 Edit5.CopyToClipboard;
end;

procedure TfrmJoinGame.Edit2Click(Sender: TObject);
begin
 if Edit2.Text = '<default>' then
  Edit2.SelectAll;
end;

end.
