import SwiftUI
import UserNotifications
import CoreLocation
import Combine

final class LocationPermissionManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var status: CLAuthorizationStatus = .notDetermined

    override init() {
        super.init()
        manager.delegate = self
        status = manager.authorizationStatus
    }

    func requestWhenInUse() {
        manager.requestWhenInUseAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        status = manager.authorizationStatus
    }
}

struct PermissionsLabScreen: View {
    @State private var notificationsStatus: String = "Unknown"
    @StateObject private var locationManager = LocationPermissionManager()

    private var locationStatusString: String {
        switch locationManager.status {
        case .notDetermined: return "NotDetermined"
        case .restricted: return "Restricted"
        case .denied: return "Denied"
        case .authorizedAlways: return "AuthorizedAlways"
        case .authorizedWhenInUse: return "AuthorizedWhenInUse"
        @unknown default: return "Unknown"
        }
    }

    var body: some View {
        Form {
            Section("Permissions") {
                Button("Request notifications") {
                    requestNotifications()
                }
                .accessibilityIdentifier(AccessibilityIDs.permNotifications)

                Button("Request location") {
                    locationManager.requestWhenInUse()
                }
                .accessibilityIdentifier(AccessibilityIDs.permLocation)

                Text("Notifications: \(notificationsStatus)")
                    .accessibilityIdentifier(AccessibilityIDs.permNotificationsStatus)

                Text("Location: \(locationStatusString)")
                    .accessibilityIdentifier(AccessibilityIDs.permLocationStatus)
            }
        }
        .navigationTitle("Permissions Lab")
        .onAppear {
            refreshNotificationStatus()
        }
    }

    private func requestNotifications() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            DispatchQueue.main.async {
                self.notificationsStatus = granted ? "Granted" : "Denied"
            }
        }
    }

    private func refreshNotificationStatus() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .notDetermined: self.notificationsStatus = "NotDetermined"
                case .denied: self.notificationsStatus = "Denied"
                case .authorized, .provisional, .ephemeral: self.notificationsStatus = "Granted"
                @unknown default: self.notificationsStatus = "Unknown"
                }
            }
        }
    }
}
