import SwiftUI

struct RootTabView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var config: TestConfiguration
    @EnvironmentObject var router: DeepLinkRouter

    var body: some View {
        NavigationStack(path: $router.path) {
            TabView(selection: $router.selectedTab) {
                PlaygroundHomeView()
                    .tabItem {
                        Label("Playground", systemImage: "list.bullet.rectangle")
                    }
                    .tag(RootTab.playground)

                FlowsHomeView()
                    .tabItem {
                        Label("Flows", systemImage: "flowchart")
                    }
                    .tag(RootTab.flows)

                FlakyLabScreen()
                    .tabItem {
                        Label("Flaky Lab", systemImage: "exclamationmark.triangle")
                    }
                    .tag(RootTab.flakyLab)

                SettingsScreen()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
                    .tag(RootTab.settings)
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .demoCatalog:
                    DemoCatalogScreen()
                case .login:
                    LoginScreen()
                case .otp:
                    OTPScreen()
                case .controls:
                    ControlsZooScreen()
                case .pickers:
                    PickersScreen()
                case .listEditing:
                    ListEditingScreen()
                case .grid:
                    GridContextMenuScreen()
                case .alerts:
                    AlertsSheetsScreen()
                case .modals:
                    ModalsScreen()
                case .webView:
                    WebViewLabScreen()
                case .gestures:
                    GesturesLabScreen()
                case .permissions:
                    PermissionsLabScreen()
                case .flaky:
                    FlakyLabScreen()
                case .settings:
                    SettingsScreen()
                }
            }
        }
    }
}
