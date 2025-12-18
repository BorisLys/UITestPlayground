import SwiftUI

struct SettingsScreen: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var config: TestConfiguration
    @EnvironmentObject var router: DeepLinkRouter

    @State private var deepLinkText: String = "uitest://open/login"

    var body: some View {
        Form {
            Section("Network") {
                Toggle("Use mock network", isOn: $config.useMockNetwork)
                    .accessibilityIdentifier(AccessibilityIDs.settingsMockNetwork)

                VStack(alignment: .leading) {
                    Slider(value: Binding(
                        get: { Double(config.latencyMs) },
                        set: { config.latencyMs = Int($0) }
                    ), in: 0...3000, step: 100)
                    .accessibilityIdentifier(AccessibilityIDs.settingsLatency)

                    Text("Latency: \(config.latencyMs) ms")
                        .font(.caption)
                }
            }

            Section("Seed") {
                Picker("Seed", selection: $config.seed) {
                    Text("empty").tag("empty")
                    Text("loggedIn").tag("loggedIn")
                    Text("100items").tag("100items")
                }
                .accessibilityIdentifier(AccessibilityIDs.settingsSeed)

                Button("Apply seed") {
                    SeedService.apply(seed: config.seed, to: appState)
                }
            }

            Section("UI") {
                Toggle("Disable animations", isOn: $config.disableAnimations)
                    .accessibilityIdentifier(AccessibilityIDs.settingsDisableAnimations)

                Button("Reset state") {
                    SeedService.apply(seed: "empty", to: appState)
                }
                .accessibilityIdentifier(AccessibilityIDs.settingsReset)
            }

            Section("Deep Link") {
                TextField("uitest://...", text: $deepLinkText)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .accessibilityIdentifier(AccessibilityIDs.settingsDeepLinkField)

                Button("Open deep link") {
                    if let url = URL(string: deepLinkText) {
                        router.handle(url: url)
                    }
                }
                .accessibilityIdentifier(AccessibilityIDs.settingsOpenDeepLink)
            }

            Section("Current config") {
                Text("uiTesting: \(config.isUITesting ? "true" : "false"), mockNetwork: \(config.useMockNetwork ? "true" : "false"), seed: \(config.seed), latencyMs: \(config.latencyMs), disableAnimations: \(config.disableAnimations ? "true" : "false")")
                    .font(.footnote)
                    .accessibilityIdentifier(AccessibilityIDs.settingsCurrentConfig)
            }
        }
        .navigationTitle("Settings")
    }
}
