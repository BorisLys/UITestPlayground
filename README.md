## UITestPlayground (SwiftUI)

Учебный iOS‑проект для практики UI‑автоматизации на **XCTest / XCUITest**. Приложение представляет собой набор экранов и сценариев, покрывающих максимально широкий спектр типичных UI‑паттернов: формы входа, списки, гриды, алерты, модалки, жесты, WebView, нестабильные сценарии и т.п.

Проект **не содержит UI‑тестов** и предназначен как полигон для их написания.

---

## Технологии

- **Язык**: Swift 5+
- **UI**: SwiftUI (100%)
- **Архитектура**: MVVM (упрощённо, фокус на UI‑сценариях)
- **Навигация**: `NavigationStack` + `TabView` + `AppRoute`
- **Состояние**: `ObservableObject`, `@State`, `@EnvironmentObject`
- **Сеть**: `MockNetworkService` (локальный мок, без реального интернета)
- **WebView**: `WKWebView` через `UIViewRepresentable`
- **Минимальная iOS**: iOS 16

---

## Структура проекта

Основные директории внутри папки приложения `xcuiautomation playground/`:

- **`App/`**: точка входа и глобальное состояние
  - `UITestPlaygroundApp.swift` — `@main` приложение
  - `AppState.swift` — единый `ObservableObject` для состояния
  - `TestConfiguration.swift` — парсинг аргументов процесса и конфиг для тестов
  - `DeepLinkRouter.swift` — обработка deep link `uitest://...` и навигация
- **`Navigation/`**
  - `AppRoute.swift` — перечисление всех маршрутов
  - `RootTabView.swift` — корневой `TabView` + `NavigationStack`
  - `GridContextMenuScreen.swift` — экран с `LazyVGrid` и context menu
- **`Screens/`**
  - `Playground/` — демо‑экраны (Catalog, Login, OTP, Controls, Pickers и др.)
  - `Flows/` — сквозные сценарии (например, Login + OTP)
  - `FlakyLab/` — нестабильные сценарии (skeleton, случайные задержки, toast)
  - `Settings/` — экран настроек и конфигурации тестов
- **`Components/`**
  - `Web/WebViewContainer.swift` — обёртка над `WKWebView`
  - (заготовки для `Buttons/`, `Pickers/`, `Toast/`, `Skeleton/`)
- **`Models/`**
  - `CartItem.swift` — модель товара в корзине
- **`Services/`**
  - `MockNetworkService.swift` — мок‑сервис с задержкой (`Task.sleep`)
  - `SeedService.swift` — применение сидов (`empty`, `loggedIn`, `100items`)
- **`Accessibility/`**
  - `AccessibilityIDs.swift` — централизованный список `accessibilityIdentifier`
- **`Resources/`**
  - `Web/` — локальный HTML для WebView
  - `Seeds/` — (опционально) файлы с demo‑данными

---

## Глобальное состояние и конфигурация

- **`AppState`** (`App/AppState.swift`)
  - `@Published var isLoggedIn: Bool`
  - `@Published var cartItems: [CartItem]`
  - `@Published var favorites: Set<String>`
  - `@Published var currentSeed: String`
- **`TestConfiguration`** (`App/TestConfiguration.swift`)
  - Читает `ProcessInfo.processInfo.arguments` и поддерживает флаги:
    - `-uiTesting`
    - `-mockNetwork`
    - `-seed empty | loggedIn | 100items`
    - `-latencyMs Int`
    - `-disableAnimations`
    - `-deepLink uitest://...`
    - `-resetState`

`SeedService` применяет один из сидов к `AppState` на старте и по запросу с экрана Settings.

---

## Deep Links

Поддерживается схема `uitest://` с роутером `DeepLinkRouter`:

Примеры:

- `uitest://open/login`
- `uitest://open/controls`
- `uitest://open/pickers`
- `uitest://open/flaky`
- `uitest://open/settings`

Ссылка парсится и переводится в соответствующий `AppRoute` + выбор таба (`RootTab`). Это удобно для XCUITest: можно сразу открывать нужный экран по deep link или через аргументы запуска.

---

## Accessibility Identifiers

Все интерактивные элементы имеют `accessibilityIdentifier` и следуют соглашению из спецификации:

- Формат: `screen.element`
- Динамические элементы:
  - `catalog.cell.<id>`
  - `cart.cell.<id>`
- Для toast / skeleton:
  - `toast.message`
  - `loading.skeleton`

Список основных ID собран в `Accessibility/AccessibilityIDs.swift` и используется во всех экранах.

---

## Экраны (каталог демо)

1. **Demo Catalog** (`DemoCatalogScreen`)
   - `List` с секциями + `search`
   - Переключение List / Grid
   - Pull‑to‑refresh
   - IDs: `catalog.search`, `catalog.list`, `catalog.grid`, `catalog.cell.<id>`

2. **Login** (`LoginScreen`)
   - `TextField` email, `SecureField` password
   - `Toggle` "remember me"
   - Кнопка login + inline error + `ProgressView`
   - IDs: `login.email`, `login.password`, `login.remember`, `login.submit`, `login.error`, `login.spinner`

3. **OTP + Timer** (`OTPScreen`)
   - Поле ввода OTP, таймер обратного отсчёта,
   - Кнопка resend + toast "Code sent"
   - IDs: `otp.code`, `otp.timer`, `otp.resend`, `toast.message`

4. **Controls Zoo** (`ControlsZooScreen`)
   - Button, segmented control, slider + label, stepper + label, toggle + label, `ProgressView`
   - IDs: `controls.button`, `controls.segment`, `controls.slider`, `controls.sliderValue`, `controls.stepper`, `controls.toggle`, `controls.progress`

5. **Pickers** (`PickersScreen`)
   - `DatePicker`, два `Picker` (страна/город), кнопка apply, result label
   - IDs: `pickers.date`, `pickers.countryCity`, `pickers.apply`, `pickers.result`

6. **List Editing** (`ListEditingScreen`)
   - `List` с swipe actions, reorder, "Load more" footer
   - IDs: `table.list`, `table.edit`, `table.loadMore`

7. **Grid + Context Menu** (`GridContextMenuScreen`)
   - `LazyVGrid`, `contextMenu`, навигация к деталям (по роуту)
   - IDs: `collection.grid`, `collection.cell.<id>`

8. **Alerts & Sheets** (`AlertsSheetsScreen`)
   - Alert OK/Cancel, alert с текстовым полем, `ConfirmationDialog`
   - IDs: `alerts.basic`, `alerts.textfield`, `alerts.sheet`

9. **Modals** (`ModalsScreen`)
   - `fullScreenCover`, `.sheet`, вложенная навигация внутри модалок
   - IDs: `modals.fullscreen`, `modals.sheet`, `modals.dismiss`

10. **WebView Lab** (`WebViewLabScreen` + `WebViewContainer`)
    - `WKWebView` с локальным HTML (простая форма логина + JavaScript)
    - ID: `webview.container`

11. **Gestures Lab** (`GesturesLabScreen`)
    - `MagnificationGesture`, `DragGesture`, `TapGesture` (отслеживание координат), кнопка Reset
    - IDs: `gestures.zoom`, `gestures.canvas`, `gestures.coords`, `gestures.reset`

12. **Permissions Lab** (`PermissionsLabScreen`)
    - Мок‑кнопки запросов: notifications, location
    - Статусы в `Text`
    - IDs: `perm.notifications`, `perm.location`, `perm.notificationsStatus`, `perm.locationStatus`

13. **Flaky Lab** (`FlakyLabScreen`)
    - Skeleton loader (c `shimmer()`), случайная задержка, появляющийся/исчезающий контент, toast на 1с
    - IDs: `loading.skeleton`, `flaky.load`, `flaky.content`, `flaky.toggle`, `toast.message`

14. **Settings / Test Menu** (`SettingsScreen`)
    - Toggle mock network, slider latency, picker seed, toggle disable animations
    - Кнопка reset state
    - Поле deep link + кнопка open
    - Label текущей конфигурации
    - IDs: `settings.mockNetwork`, `settings.latency`, `settings.seed`, `settings.disableAnimations`, `settings.reset`, `settings.deepLinkField`, `settings.openDeepLink`, `settings.currentConfig`

---

## Mock Network и Seeds

- **`MockNetworkService`**
  - Возвращает массив строк с искусственной задержкой (`latencyMs` из `TestConfiguration`)
  - Используется для демонстрации асинхронных сценариев и ожиданий в тестах
- **Seeds (`SeedService`)**
  - `empty` — пользователь не залогинен, корзина пуста
  - `loggedIn` — пользователь залогинен, в корзине есть один элемент
  - `100items` — корзина содержит 100 элементов

Сиды применяются при старте (`UITestPlaygroundApp`) и по нажатию на кнопки в Settings.

---

## Скриншоты

Рекомендуемая структура для скриншотов (можно хранить их в Git, либо только локально):

- **`Resources/Screenshots/`**
  - `01_demo_catalog.png`
  - `02_login.png`
  - `03_otp.png`
  - `04_controls.png`
  - `05_pickers.png`
  - `06_list_editing.png`
  - `07_grid.png`
  - `08_alerts.png`
  - `09_modals.png`
  - `10_webview.png`
  - `11_gestures.png`
  - `12_permissions.png`
  - `13_flaky.png`
  - `14_settings.png`

В самом README можно разместить превью, например:

```markdown
![Demo Catalog](Resources/Screenshots/01_demo_catalog.png)
![Login](Resources/Screenshots/02_login.png)
![Flaky Lab](Resources/Screenshots/13_flaky.png)
```

Скриншоты удобно использовать в слайдах/лекциях и в описании заданий по XCUITest.

---

## Как запускать

1. Открыть `xcuiautomation playground.xcodeproj` в Xcode 16+.
2. Выбрать таргет **"xcuiautomation playground"** и iOS Simulator (iOS 16+).
3. Запустить приложение (`Cmd + R`).

### Примеры запуска с аргументами (для XCUITest)

- Старт в режиме UI‑тестов с мок‑сетью и большим latency:
  - `-uiTesting -mockNetwork -latencyMs 2000`
- Запуск с сидом и диплинком на Flaky Lab:
  - `-seed 100items -deepLink uitest://open/flaky`

Далее поверх этого проекта можно строить упражнения по:

- поиску и взаимодействию с элементами через accessibility identifiers
- работе с deep links
- ожиданиям в асинхронных сценариях (loading, skeleton, toasts)
- нестабильным сценариям (Flaky Lab)
- навигации и сложным иерархиям экранов.
