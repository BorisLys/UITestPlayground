import SwiftUI

struct OTPScreen: View {
    @State private var code: String = ""
    @State private var remainingSeconds: Int = 30
    @State private var isTimerActive: Bool = true
    @State private var showToast: Bool = false

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 24) {
                TextField("OTP Code", text: $code)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .accessibilityIdentifier(AccessibilityIDs.otpCode)

                Text("Time left: \(remainingSeconds)s")
                    .monospacedDigit()
                    .accessibilityIdentifier(AccessibilityIDs.otpTimer)

                Button("Resend code") {
                    resendCode()
                }
                .accessibilityIdentifier(AccessibilityIDs.otpResend)

                Spacer()
            }

            if showToast {
                Text("Code sent")
                    .padding()
                    .background(.black.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding()
                    .accessibilityIdentifier(AccessibilityIDs.toastMessage)
            }
        }
        .navigationTitle("OTP + Timer")
        .onAppear(perform: startTimer)
    }

    private func startTimer() {
        isTimerActive = true
        Task {
            while isTimerActive && remainingSeconds > 0 {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                await MainActor.run {
                    remainingSeconds -= 1
                }
            }
        }
    }

    private func resendCode() {
        remainingSeconds = 30
        startTimer()
        showToast = true
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            await MainActor.run {
                showToast = false
            }
        }
    }
}
