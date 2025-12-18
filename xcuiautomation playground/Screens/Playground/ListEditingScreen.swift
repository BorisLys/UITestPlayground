import SwiftUI

struct ListEditingScreen: View {
    @State private var items: [String] = (1...10).map { "Row \($0)" }
    @State private var isEditing: Bool = false

    var body: some View {
        VStack {
            List {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                delete(item: item)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
                .onMove(perform: move)
            }
            .environment(\.editMode, .constant(isEditing ? .active : .inactive))
            .accessibilityIdentifier(AccessibilityIDs.tableList)

            HStack {
                Button(isEditing ? "Done" : "Edit") {
                    isEditing.toggle()
                }
                .accessibilityIdentifier(AccessibilityIDs.tableEdit)

                Spacer()

                Button("Load more") {
                    loadMore()
                }
                .accessibilityIdentifier(AccessibilityIDs.tableLoadMore)
            }
            .padding()
        }
        .navigationTitle("List Editing")
    }

    private func delete(item: String) {
        items.removeAll { $0 == item }
    }

    private func move(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }

    private func loadMore() {
        let start = items.count + 1
        let newItems = (start..<(start + 5)).map { "Row \($0)" }
        items.append(contentsOf: newItems)
    }
}
