import SwiftUI

struct GridContextMenuScreen: View {
    private let items = Array(1...20)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 12)], spacing: 12) {
                ForEach(items, id: \.self) { item in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.blue.opacity(0.1))
                        .overlay(
                            Text("Item \(item)")
                                .padding(8)
                        )
                        .frame(height: 80)
                        .contextMenu {
                            Button("Favorite") { /* no-op demo */ }
                            Button("Delete", role: .destructive) { /* no-op demo */ }
                        }
                        .accessibilityIdentifier("collection.cell.\(item)")
                }
            }
            .padding()
        }
        .navigationTitle("Grid + Context Menu")
        .accessibilityIdentifier(AccessibilityIDs.collectionGrid)
    }
}
