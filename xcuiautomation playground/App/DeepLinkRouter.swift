import Foundation
import SwiftUI
import Combine

/// Отвечает за глобальный роутинг и обработку диплинков вида `uitest://open/...`.
final class DeepLinkRouter: ObservableObject {
    @Published var path: [AppRoute] = []
    @Published var selectedTab: RootTab = .playground

    func handle(url: URL) {
        guard url.scheme == "uitest" else { return }
        guard url.host == "open" else { return }

        let pathComponent = url.path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))

        switch pathComponent {
        case "login":
            selectedTab = .flows
            path = [.login]
        case "controls":
            selectedTab = .playground
            path = [.controls]
        case "pickers":
            selectedTab = .playground
            path = [.pickers]
        case "flaky":
            selectedTab = .flakyLab
            path = []
        case "settings":
            selectedTab = .settings
            path = []
        default:
            break
        }
    }

    func applyInitialDeepLink(_ url: URL?) {
        guard let url else { return }
        handle(url: url)
    }
}
