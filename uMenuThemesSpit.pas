(*
  Telegram channel: https://t.me/delphi_solutions
  Telegram chat: https://t.me/delphi_solutions_chat
  Telegram video: https://t.me/delphi_solutions_video
  DONATE ME  https://t.me/delphi_solutions_donate
*)

unit uMenuThemesSpit;

interface

USES
  System.SysUtils, System.Classes, Vcl.Forms, Vcl.Menus,
  Vcl.Themes;

type
  TMenuThemes = Class(TMenuItem)
  Private
    procedure MenuItemsClick(Sender: TObject); Inline;
    procedure MenuClick(Sender: TObject); Inline;
  public
    constructor Create(MainMenu: TMainMenu; index: SmallInt);
  End;

  TPopuMenuThemes = class(TPopupMenu)
  private
    procedure MenuItemClick(Sender: TObject); Inline;
    procedure MenuPopup(Sender: TObject); Inline;
  public
    constructor Create(AOwner: TForm);
  end;


implementation

{ TThemsMetod }

constructor TMenuThemes.Create(MainMenu: TMainMenu; index: SmallInt);
begin
  inherited Create(MainMenu);
  Caption := 'Themes';
  OnClick := MenuClick;
  if MainMenu.Items.Count < index then
    index := MainMenu.Items.Count;
  MainMenu.Items.Insert(Index, Self);
  for var i: Word := 0 to Pred(Length(TStyleManager.StyleNames)) do
  begin
    var NewMenuItem := TMenuItem.Create(Self);
    NewMenuItem.Caption   := TStyleManager.StyleNames[i];
    NewMenuItem.AutoCheck := true;
    NewMenuItem.Visible   := true;
    NewMenuItem.Enabled   := true;
    NewMenuItem.OnClick   := MenuItemsClick;
    NewMenuItem.Name      := 'MenuThemes' + i.ToString;
    if TStyleManager.StyleNames[i] = TStyleManager.ActiveStyle.Name then
      NewMenuItem.Checked := true;
    Add(NewMenuItem);
  end;
end;

procedure TMenuThemes.MenuClick(Sender: TObject);
begin
  for var i: Word := 0 to Pred(Count) do
    Self[i].Checked := False;
  Find(TStyleManager.ActiveStyle.Name).Checked := true;
end;

procedure TMenuThemes.MenuItemsClick(Sender: TObject);
begin
  for var i: Word := 0 to Pred(Count) do
    Self[i].Checked := false;
  var SetStyleName := TMenuItem(Sender).Caption.Replace('&', '');
  Find(SetStyleName).Checked := true;
  TStyleManager.SetStyle(SetStyleName);
end;

{ TPopuMenuThemes }

constructor TPopuMenuThemes.Create(AOwner: TForm);
begin
  inherited Create(AOwner);
  Self.OnPopup := MenuPopup;
  for var i: Word := 0 to Pred(Length(TStyleManager.StyleNames)) do
  begin
    var NewMenuItem := TMenuItem.Create(Self);
    NewMenuItem.Caption   := TStyleManager.StyleNames[i];
    NewMenuItem.AutoCheck := true;
    NewMenuItem.Visible   := true;
    NewMenuItem.Enabled   := true;
    NewMenuItem.OnClick   := MenuItemClick;
    NewMenuItem.Name      := 'MenuThemes' + i.ToString;
    if TStyleManager.StyleNames[i] = TStyleManager.ActiveStyle.Name then
      NewMenuItem.Checked := true;
    Items.Add(NewMenuItem);
  end;
end;

procedure TPopuMenuThemes.MenuItemClick(Sender: TObject);
begin
 for var i: Word := 0 to Pred(Self.items.Count) do
   Items[i].Checked := false;
 var SetStyleName := TMenuItem(Sender).Caption.Replace('&', '');
 Items.Find(SetStyleName).Checked := true;
 TStyleManager.SetStyle(SetStyleName);
end;

procedure TPopuMenuThemes.MenuPopup(Sender: TObject);
begin
  for var i: Word := 0 to Pred(Self.Items.Count) do
    Items[i].Checked := false;
  Items.Find(TStyleManager.ActiveStyle.Name).Checked := true;
end;

end.
