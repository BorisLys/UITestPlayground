import Foundation
import Combine

final class AppState: ObservableObject {
    @Published var isLoggedIn: Bool
    @Published var cartItems: [CartItem]
    @Published var favorites: Set<String>
    @Published var currentSeed: String

    init(
        isLoggedIn: Bool = false,
        cartItems: [CartItem] = [],
        favorites: Set<String> = [],
        currentSeed: String = "empty"
    ) {
        self.isLoggedIn = isLoggedIn
        self.cartItems = cartItems
        self.favorites = favorites
        self.currentSeed = currentSeed
    }
}
