import SwiftUI

/// Экран со списком сквозных сценариев.
/// Для простоты содержит только один сценарий: Login + OTP.
struct FlowsHomeView: View {
    var body: some View {
        List {
            Section("Auth Flows") {
                NavigationLink("Login + OTP") {
                    LoginScreen()
                }
            }
        }
        .navigationTitle("Flows")
    }
}
