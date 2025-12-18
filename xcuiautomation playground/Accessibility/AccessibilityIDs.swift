import Foundation

/// Централизованный список accessibilityIdentifier-ов.
/// В коде экранов можно использовать как константы, но допускается и прямое использование строк из спецификации.
enum AccessibilityIDs {
    // Demo Catalog
    static let catalogSearch = "catalog.search"
    static let catalogList = "catalog.list"
    static let catalogGrid = "catalog.grid"

    // Login
    static let loginEmail = "login.email"
    static let loginPassword = "login.password"
    static let loginRemember = "login.remember"
    static let loginSubmit = "login.submit"
    static let loginError = "login.error"
    static let loginSpinner = "login.spinner"

    // OTP
    static let otpCode = "otp.code"
    static let otpTimer = "otp.timer"
    static let otpResend = "otp.resend"

    // Controls
    static let controlsButton = "controls.button"
    static let controlsSegment = "controls.segment"
    static let controlsSlider = "controls.slider"
    static let controlsSliderValue = "controls.sliderValue"
    static let controlsStepper = "controls.stepper"
    static let controlsToggle = "controls.toggle"
    static let controlsProgress = "controls.progress"

    // Pickers
    static let pickersDate = "pickers.date"
    static let pickersCountryCity = "pickers.countryCity"
    static let pickersApply = "pickers.apply"
    static let pickersResult = "pickers.result"

    // List Editing
    static let tableList = "table.list"
    static let tableEdit = "table.edit"
    static let tableLoadMore = "table.loadMore"

    // Grid
    static let collectionGrid = "collection.grid"

    // Alerts & Sheets
    static let alertsBasic = "alerts.basic"
    static let alertsTextfield = "alerts.textfield"
    static let alertsSheet = "alerts.sheet"

    // Modals
    static let modalsFullscreen = "modals.fullscreen"
    static let modalsSheet = "modals.sheet"
    static let modalsDismiss = "modals.dismiss"

    // WebView
    static let webviewContainer = "webview.container"

    // Gestures
    static let gesturesZoom = "gestures.zoom"
    static let gesturesCanvas = "gestures.canvas"
    static let gesturesCoords = "gestures.coords"
    static let gesturesReset = "gestures.reset"

    // Permissions
    static let permNotifications = "perm.notifications"
    static let permLocation = "perm.location"
    static let permNotificationsStatus = "perm.notificationsStatus"
    static let permLocationStatus = "perm.locationStatus"

    // Flaky Lab
    static let flakySkeleton = "loading.skeleton"
    static let flakyLoad = "flaky.load"
    static let flakyContent = "flaky.content"
    static let flakyToggle = "flaky.toggle"

    // Settings
    static let settingsMockNetwork = "settings.mockNetwork"
    static let settingsLatency = "settings.latency"
    static let settingsSeed = "settings.seed"
    static let settingsDisableAnimations = "settings.disableAnimations"
    static let settingsReset = "settings.reset"
    static let settingsDeepLinkField = "settings.deepLinkField"
    static let settingsOpenDeepLink = "settings.openDeepLink"
    static let settingsCurrentConfig = "settings.currentConfig"

    // Toast & Skeleton
    static let toastMessage = "toast.message"
    static let loadingSkeleton = "loading.skeleton"
}
