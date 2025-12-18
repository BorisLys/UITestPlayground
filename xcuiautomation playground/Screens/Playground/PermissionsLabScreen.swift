import SwiftUI

struct PermissionsLabScreen: View {
    @State private var notificationsStatus: String = "Unknown"
    @State private var locationStatus: String = "Unknown"

    var body: some View {
        Form {
            Section("Permissions") {
                Button("Request notifications") {
                    // Mock status change
                    notificationsStatus = "Granted"
                }
                .accessibilityIdentifier(AccessibilityIDs.permNotifications)

                Button("Request location") {
                    // Mock status change
                    locationStatus = "Denied"
                }
                .accessibilityIdentifier(AccessibilityIDs.permLocation)

                Text("Notifications: \(notificationsStatus)")
                    .accessibilityIdentifier(AccessibilityIDs.permNotificationsStatus)

                Text("Location: \(locationStatus)")
                    .accessibilityIdentifier(AccessibilityIDs.permLocationStatus)
            }
        }
        .navigationTitle("Permissions Lab")
    }
}
