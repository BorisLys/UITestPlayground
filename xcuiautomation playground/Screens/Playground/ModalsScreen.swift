import SwiftUI

struct ModalsScreen: View {
    @State private var showFullScreen = false
    @State private var showSheet = false

    var body: some View {
        VStack(spacing: 24) {
            Button("Present Full Screen") {
                showFullScreen = true
            }
            .accessibilityIdentifier(AccessibilityIDs.modalsFullscreen)
            .fullScreenCover(isPresented: $showFullScreen) {
                NavigationStack {
                    VStack(spacing: 16) {
                        NavigationLink("Go deeper") {
                            Text("Nested Screen")
                        }
                        Button("Dismiss") {
                            showFullScreen = false
                        }
                        .accessibilityIdentifier(AccessibilityIDs.modalsDismiss)
                    }
                    .navigationTitle("Full Screen")
                }
            }

            Button("Present Sheet") {
                showSheet = true
            }
            .accessibilityIdentifier(AccessibilityIDs.modalsSheet)
            .sheet(isPresented: $showSheet) {
                NavigationStack {
                    VStack(spacing: 16) {
                        Text("Sheet content")
                        Button("Dismiss") {
                            showSheet = false
                        }
                        .accessibilityIdentifier(AccessibilityIDs.modalsDismiss)
                    }
                    .padding()
                    .navigationTitle("Sheet")
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Modals")
    }
}
