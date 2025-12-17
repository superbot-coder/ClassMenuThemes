
# Class MenuThemes 

**TMenuThemes**  - Это класс, который создает в главном меню программы новый раздел "Themes" и  PopupMenu например для кнопки с выпадающим списком BtnThemes.DropDownMenu  в которых перечислены все темы, которые добавлены в проекте, для того чтобы пользователь мог выбрать и переключить тему (стиль) программы.

![screenshot](https://github.com/superbot-coder/ClassMenuThemes/blob/main/images/image-01.png "")

#### ДВА МОДУЛЯ - ДВЕ РЕАЛИЗАЦИИ
**1 Модуль uMenuThemesSpit.Pas**  
В нем меню реализовано двумя отдельными классами  TMenuThemes, TPopuMenuThemes
Параметры конструктора класса TMenuThemes.Create(MainMenu: TMainMenu; index: SmallInt);
**MainMenu: TMainMenu** - это компонент главного который должен быть на форме
**index** - задает позицию куба будет вставлено созданное меню 
Например, раздел "File" идет всегда первым и имеет index = 0, если при создании меню задать index = 1, то раздел Themes будет создано вторым по счету:
"File" "Themes" "Help" 
##### Пример использования:
```pascal
procedure TFrmMain.FormCreate(Sender: TObject);
begin
     // for Mainmenu
     TMenuThemes.Create(MainMenu, 1);
     // for TButton
     BtnThemes.DropDownMenu := TPopuMenuThemes.Create(Self);
end;
```

2. **Модуль uModulThemes.pas**
Здесь создание меню для Главного меню и PopupMenu все объединено в одном классе и добавлен метод **SetOnClick** для установки  обработчиков событий **OnClick** и **OnPopup** для каждого меню через параметр **MemuType: TMenuType** 

Пример использования:
```pascal
type
  TForm1 = class(TForm)
    //.....
  private
    FMenuThemes: TMenuThemes; 
    procedure MenuThemesOnPopupClick(Sender: TObject);
    procedure MenuThemesOnClick(Sender: TObject);
  //......
procedure TForm1.FormCreate(Sender: TObject);
begin
  // создаем объект экземпляр класса
  FMenuThemes := TMenuThemes.Create(Form1);
  // Встраиваем раздел меню Themes в Главном меню
  FMenuThemes.InsertToMainMenu(MainMenu, 1);
  // Создаем PopupMenu и присваиваем кнопке BtnThemes
  BtnThemes.DropDownMenu := FMenuThemes.GetPopupMenu;
  
  // Устанавливаем обработчик собития OnClick для MenuItem
  // Add PopupMenu.OnPopup Handler
  FMenuThemes.SetOnClick(MenuThemesOnPopupClick, mtPopup);
   
   // Устанавливает обработчик события OnPopup для PopupMenu
   // Add MenuThemes.OnClick Handler
  FMenuThemes.SetOnClick(MenuThemesOnClick, mtMenuItem);
end;
```

##### Telegram channel: https://t.me/delphi_solutions
##### Telegram chat: https://t.me/delphi_solutions_chat
##### Telegram video: https://t.me/delphi_solutions_video
##### DONATE ME  https://t.me/delphi_solutions_donate