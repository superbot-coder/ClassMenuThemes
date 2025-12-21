(*
  Telegram channel: https://t.me/delphi_solutions
  Telegram chat: https://t.me/delphi_solutions_chat
  Telegram video: https://t.me/delphi_solutions_video
  DONATE ME  https://t.me/delphi_solutions_donate
*)

unit uMenuThemes;

interface

USES
  System.SysUtils, System.Classes, Vcl.Forms,
  // Vcl.Dialogs,
  Vcl.Menus, Themes;

Type
  TMenuThemes = class(TComponent)
  private type
    TMenuType = (mtPopup, mtMenuItem, mtAllMenu);
  private
    FThemesCount: Word;
    FPopupMenu: TPopupMenu;
    FMenuItem: TMenuItem;
    FOnChangeTheme: TNotifyEvent;
    procedure MenuItemClick(Sender: TObject);
    procedure MenuInit(MenuType: TMenuType);
    procedure SetCaption(Value: String);
  public
    constructor Create(AOwner: TComponent);
    function GetPopupMenu: TPopupMenu;
    procedure InsertToMainMenu(MainMenu: TMainMenu; Index: SmallInt);
    procedure SetOnClick(MenuClick: TNotifyEvent; MemuType: TMenuType);
    property Caption: String write SetCaption;
    property OnChangeTheme: TNotifyEvent write FOnChangeTheme;
  end;

implementation

{ TThemes }

constructor TMenuThemes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPopupMenu := Nil;
  FMenuItem  := Nil;
  FThemesCount := Length(TStyleManager.StyleNames);
end;

function TMenuThemes.GetPopupMenu: TPopupMenu;
begin
  if Not Assigned(FPopupMenu) then
  begin
    FPopupMenu := TPopupMenu.Create(Self);
    MenuInit(mtPopup);
  end;
  Result := FPopupMenu;
end;

procedure TMenuThemes.InsertToMainMenu(MainMenu: TMainMenu; Index: SmallInt);
begin
  if Not Assigned(FMenuItem) then
  begin
    FMenuItem := TMenuItem.Create(Self);
    FMenuItem.Caption := 'Themes';
    MenuInit(mtMenuItem);
  end;
  if MainMenu.Items.Count < index then
    index := MainMenu.Items.Count;
  MainMenu.Items.Insert(Index, FMenuItem);
end;

procedure TMenuThemes.MenuInit(MenuType: TMenuType);
begin
  for var i: Word := 0 to Pred(FThemesCount) do
  begin
    var NewMenuItem: TMenuItem;
    case MenuType of
      mtPopup: NewMenuItem := TMenuItem.Create(FPopupMenu);
      mtMenuItem: NewMenuItem := TMenuItem.Create(FMenuItem);
    end;
    NewMenuItem.Caption   := TStyleManager.StyleNames[i];
    NewMenuItem.AutoCheck := true;
    NewMenuItem.Visible   := true;
    NewMenuItem.Enabled   := true;
    NewMenuItem.OnClick   := MenuItemClick;
    NewMenuItem.Name      := 'MenuThemes' + i.ToString;
    if TStyleManager.StyleNames[i] = TStyleManager.ActiveStyle.Name then
      NewMenuItem.Checked := true;
    case MenuType of
      mtPopup: FPopupMenu.Items.add(NewMenuItem);
      mtMenuItem:  FMenuItem.Add(NewMenuItem);
    end;
  end;
end;

procedure TMenuThemes.MenuItemClick(Sender: TObject);
begin

 for var i: Word := 0 to Pred(FThemesCount) do
 begin
   if Assigned(FPopupMenu) then
     FPopupMenu.Items[i].Checked := false;
   if Assigned(FMenuItem) then
     FMenuItem[i].Checked := false;
 end;

 var SetStyleName := TMenuItem(Sender).Caption.Replace('&', '');

 if Assigned(FPopupMenu) then
   FPopupMenu.Items.Find(SetStyleName).Checked := true;

 if Assigned(FMenuItem) then
   FMenuItem.Find(SetStyleName).Checked := true;

 TStyleManager.SetStyle(SetStyleName);
 FOnChangeTheme(Sender);
end;

procedure TMenuThemes.SetCaption;
begin
  if Not Assigned(FMenuItem) then
    raise Exception.Create('Error: The "MenuItem" has not been created');
  FMenuItem.Caption := Value;
end;

procedure TMenuThemes.SetOnClick(MenuClick: TNotifyEvent; MemuType: TMenuType);
begin
  case MemuType of
    mtMenuItem: FMenuItem.OnClick := MenuClick;
    mtPopup: FPopupMenu.OnPopup := MenuClick;
    mtAllMenu:
      begin
        FMenuItem.OnClick := MenuClick;
        FPopupMenu.OnPopup := MenuClick;
      end;
  end;
end;

end.
