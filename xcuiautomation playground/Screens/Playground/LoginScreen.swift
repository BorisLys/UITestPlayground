import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject var appState: AppState

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?

    var body: some View {
        Form {
            Section("Credentials") {
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .accessibilityIdentifier(AccessibilityIDs.loginEmail)

                SecureField("Password", text: $password)
                    .accessibilityIdentifier(AccessibilityIDs.loginPassword)

                Toggle("Remember me", isOn: $rememberMe)
                    .accessibilityIdentifier(AccessibilityIDs.loginRemember)
            }

            if let errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .accessibilityIdentifier(AccessibilityIDs.loginError)
            }

            Section {
                Button {
                    performLogin()
                } label: {
                    HStack {
                        if isLoading {
                            ProgressView()
                                .accessibilityIdentifier(AccessibilityIDs.loginSpinner)
                        }
                        Text("Login")
                    }
                }
                .disabled(isLoading)
                .accessibilityIdentifier(AccessibilityIDs.loginSubmit)
            }
        }
        .navigationTitle("Login")
    }

    private func performLogin() {
        errorMessage = nil
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password are required"
            return
        }

        isLoading = true
        Task {
            try? await Task.sleep(nanoseconds: 800_000_000)
            await MainActor.run {
                self.isLoading = false
                self.appState.isLoggedIn = true
            }
        }
    }
}
