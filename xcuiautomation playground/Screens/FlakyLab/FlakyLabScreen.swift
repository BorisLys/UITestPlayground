import SwiftUI

struct SkeletonView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.gray.opacity(0.3))
            .shimmer()
            .accessibilityIdentifier(AccessibilityIDs.loadingSkeleton)
    }
}

private struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [
                        .clear,
                        Color.white.opacity(0.6),
                        .clear
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .rotationEffect(.degrees(20))
                .offset(x: phase)
            )
            .onAppear {
                withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                    phase = 200
                }
            }
    }
}

private extension View {
    func shimmer() -> some View {
        modifier(ShimmerModifier())
    }
}

struct FlakyLabScreen: View {
    @State private var isLoading: Bool = false
    @State private var showContent: Bool = false
    @State private var showToast: Bool = false

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 24) {
                Button("Load random content") {
                    loadContent()
                }
                .accessibilityIdentifier(AccessibilityIDs.flakyLoad)

                Toggle("Toggle content visibility", isOn: $showContent)
                    .accessibilityIdentifier(AccessibilityIDs.flakyToggle)

                if isLoading {
                    SkeletonView()
                        .frame(height: 80)
                } else if showContent {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.green.opacity(0.2))
                        .frame(height: 80)
                        .overlay(Text("Loaded content"))
                        .accessibilityIdentifier(AccessibilityIDs.flakyContent)
                }

                Spacer()
            }
            .padding()

            if showToast {
                Text("Flaky event")
                    .padding()
                    .background(.black.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding()
                    .accessibilityIdentifier(AccessibilityIDs.toastMessage)
            }
        }
        .navigationTitle("Flaky Lab")
    }

    private func loadContent() {
        isLoading = true
        showContent = false

        let delayMs = Int.random(in: 300...2000)
        Task {
            try? await Task.sleep(nanoseconds: UInt64(delayMs) * 1_000_000)
            await MainActor.run {
                self.isLoading = false
                self.showContent = true
                self.showToast = true
            }
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            await MainActor.run {
                self.showToast = false
            }
        }
    }
}
