import SwiftUI

struct AlertsSheetsScreen: View {
    @State private var showBasicAlert = false
    @State private var showTextFieldAlert = false
    @State private var showConfirmation = false
    @State private var textFieldValue: String = ""

    var body: some View {
        VStack(spacing: 24) {
            Button("Alert OK/Cancel") {
                showBasicAlert = true
            }
            .accessibilityIdentifier(AccessibilityIDs.alertsBasic)
            .alert("Basic Alert", isPresented: $showBasicAlert) {
                Button("Cancel", role: .cancel) {}
                Button("OK", role: .none) {}
            } message: {
                Text("This is a simple alert.")
            }

            Button("Alert with text field") {
                showTextFieldAlert = true
            }
            .accessibilityIdentifier(AccessibilityIDs.alertsTextfield)
            .alert("Enter value", isPresented: $showTextFieldAlert) {
                TextField("Value", text: $textFieldValue)
                Button("OK") {}
            }

            Button("Confirmation dialog") {
                showConfirmation = true
            }
            .accessibilityIdentifier(AccessibilityIDs.alertsSheet)
            .confirmationDialog("Choose option", isPresented: $showConfirmation, titleVisibility: .visible) {
                Button("One") {}
                Button("Two") {}
                Button("Cancel", role: .cancel) {}
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Alerts & Sheets")
    }
}
