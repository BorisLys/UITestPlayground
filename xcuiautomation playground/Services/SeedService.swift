import Foundation

/// Отвечает за применение сидов к `AppState`.
enum SeedType: String, CaseIterable {
    case empty
    case loggedIn
    case items100 = "100items"
}

struct SeedService {
    static func apply(seed: String, to appState: AppState) {
        let type = SeedType(rawValue: seed) ?? .empty

        switch type {
        case .empty:
            appState.isLoggedIn = false
            appState.cartItems = []
            appState.favorites = []
            appState.currentSeed = SeedType.empty.rawValue

        case .loggedIn:
            appState.isLoggedIn = true
            appState.cartItems = [
                CartItem(title: "Welcome Pack", quantity: 1)
            ]
            appState.favorites = ["item_1", "item_2"]
            appState.currentSeed = SeedType.loggedIn.rawValue

        case .items100:
            appState.isLoggedIn = true
            appState.cartItems = (0..<100).map {
                CartItem(title: "Item \($0 + 1)", quantity: 1)
            }
            appState.favorites = []
            appState.currentSeed = SeedType.items100.rawValue
        }
    }
}
