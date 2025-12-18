import Foundation

struct CartItem: Identifiable, Hashable {
    let id: UUID
    var title: String
    var quantity: Int

    init(id: UUID = UUID(), title: String, quantity: Int = 1) {
        self.id = id
        self.title = title
        self.quantity = quantity
    }
}
