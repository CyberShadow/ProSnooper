unit VortexChannels;

interface

uses classes;

Type TUser = class(TObject)
private
  FNickList : Tstringlist;
  FVoiced   : boolean;
  FOped     : boolean;
public
  Constructor Create;
  Destructor Destroy;
  property IsVoiced : Boolean read FVoiced;
  property IsOped : boolean read FOped;
end;

Type TChannels = Class(TObject)
private
  FChannelName  : string;
  FChannelTopic : String;
  FTopicSetBy   : String;
  FKeyPasswd    : string;
  FUsers        : Tuser;
  FInviteOnly   : Boolean;
  FOnlyOpTopic  : Boolean;
  FExternalMsg  : Boolean;
  FPrivate      : Boolean;
  FSecret       : Boolean;
  FLimit        : Boolean;
  FKey          : Boolean;
  FModerated    : Boolean;
  FLimitNum     : integer;
  FChannelType  : Char;
  FChannelID    : integer;
public
  Constructor Create;
  Destructor Destroy;
  Procedure SetTopic (NewTopic : string);
  Procedure SetTopicSetBy (NickName : string);
  Procedure SetChannelName (ChannelName : string);
  Procedure SetPassword (Password : string);
  Procedure SetLimit (Value : Integer);
  Procedure SetChannelID (ID : Integer);
  Procedure SetChannelType (Value : Char);
  procedure AddUsersFromCommaText(var users: string);
  procedure AddUserToChannel (user : string);
  procedure RemoveUserFromChannel (user : string);
  procedure DeleteUsers;
  procedure ClearUsers;
  Function  CountUsers : integer;
  Function  GetAllNicksFromChannel : string;
published
  property GetChannelType     : Char   read FChannelType;
  property GetChannelName     : string read FChannelName;
  property GetTopic           : string read FChannelTopic;
  property GetTopicSetBy      : string read FChannelTopic;
  property GetModeKeyPassword : string read FKeyPassWd;
  property GetModeNumLimit    : integer read FLimitNum;
  property IsInviteOnly       : boolean read FInviteOnly;
  property IsOnlyOpsSetTopic  : boolean read FOnlyOpTopic;
  property IsPrivate          : boolean read FPrivate;
  property IsSecret           : boolean read FSecret;
  property IsLimitedTo        : boolean read FLimit;
  property IsKey              : boolean read FKey;
  property IsModerated        : boolean read FModerated;
  property IsNoExternalMessages : boolean read FExternalMsg;
end;

implementation

  { TChannels }


constructor TChannels.Create;
begin
  inherited create;
  { initialization code }
  FUsers := TUser.Create;
  FUsers.FNickList := TStringList.create;
end;

destructor TChannels.Destroy;
begin
  { executed on destroy  }
  FUsers.FNickList.Free;
  FUsers.free;
  FUsers := nil;
  inherited destroy;
end;

procedure TChannels.SetChannelID(ID: Integer);
begin
  FChannelID := ID;
end;

procedure TChannels.SetChannelName(ChannelName: string);
begin
  FChannelName := ChannelName;
end;

procedure TChannels.SetLimit(Value: Integer);
begin
  FLimitNum := Value;
end;

procedure TChannels.SetPassword(Password: string);
begin
  FKeyPassWd := Password;
end;

procedure TChannels.SetTopic(NewTopic: string);
begin
  FChannelTopic := NewTopic;
end;

procedure TChannels.SetTopicSetBy(NickName: string);
begin
  FTopicSetBy := NickName;
end;

procedure TChannels.SetChannelType(Value: Char);
begin
  FChannelType := value;
end;

procedure TChannels.AddUsersFromCommaText(var users: string);
var
list  : Tstringlist;

begin
  { Convert spaces to commas...}
  while Pos(' ', users) > 0 do
  users[Pos(' ', users)] := ',';

  { creates a list of commausers...}
  list := Tstringlist.create;
  with list do
  begin
    CommaText := users;
    try
      { add users tp the nicklist }
      Fusers.FNickList.CommaText := Fusers.FNickList.CommaText + ',' + CommaText;
    except
    end;
  end;
  list.Free;
end;

procedure TChannels.AddUserToChannel(user: string);
begin
  with Fusers.FNickList do
    if indexof(user) = -1 then
    add(user);
end;

procedure TChannels.RemoveUserFromChannel(user: string);
begin
  with Fusers.FNickList do
  begin

    if indexof(user) <> -1 then
    begin
      delete(indexof(user));
      exit;
    end;

    if indexof('@' + user) <> -1 then
    begin
      delete(indexof('@' + user));
      exit;
    end;

    if indexof('+' + user) <> -1 then
      delete(indexof('+' + user));
  end;
end;

function TChannels.CountUsers: integer;
begin
  result := Fusers.FNickList.Count -1;
end;

procedure TChannels.DeleteUsers;
begin
  with Fusers do
  begin
    FNickList.Clear;
  free;
  end;
end;

procedure TChannels.ClearUsers;
begin
  with Fusers do
    FNickList.Clear;
end;


function TChannels.GetAllNicksFromChannel: string;
begin
  with Fusers.Fnicklist do
  begin
    if indexOf('') <> -1 then
    Delete(indexOf(''));
    result := CommaText;
  end;
end;


 { TUser }

Constructor TUser.Create;
begin

end;



destructor TUser.destroy;
begin

end;





end.

