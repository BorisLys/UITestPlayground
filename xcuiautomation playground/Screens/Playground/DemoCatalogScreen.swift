import SwiftUI

struct DemoCatalogItem: Identifiable {
    let id: String
    let title: String
    let route: AppRoute
}

struct DemoCatalogScreen: View {
    @EnvironmentObject var router: DeepLinkRouter

    @State private var query: String = ""
    @State private var isGrid: Bool = false

    private var items: [DemoCatalogItem] = [
        .init(id: "login", title: "Login", route: .login),
        .init(id: "otp", title: "OTP + Timer", route: .otp),
        .init(id: "controls", title: "Controls Zoo", route: .controls),
        .init(id: "pickers", title: "Pickers", route: .pickers),
        .init(id: "list", title: "List Editing", route: .listEditing),
        .init(id: "grid", title: "Grid + Context Menu", route: .grid),
        .init(id: "alerts", title: "Alerts & Sheets", route: .alerts),
        .init(id: "modals", title: "Modals", route: .modals),
        .init(id: "web", title: "WebView Lab", route: .webView),
        .init(id: "gestures", title: "Gestures Lab", route: .gestures),
        .init(id: "permissions", title: "Permissions Lab", route: .permissions),
        .init(id: "flaky", title: "Flaky Lab", route: .flaky),
        .init(id: "settings", title: "Settings / Test Menu", route: .settings)
    ]

    private var filteredItems: [DemoCatalogItem] {
        guard !query.isEmpty else { return items }
        return items.filter { $0.title.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        VStack {
            searchBar
            toggleViewMode

            if isGrid {
                gridView
                    .accessibilityIdentifier(AccessibilityIDs.catalogGrid)
            } else {
                listView
                    .accessibilityIdentifier(AccessibilityIDs.catalogList)
            }
        }
        .navigationTitle("Demo Catalog")
        .refreshable {
            await Task.sleep(500_000_000) // 0.5s demo
        }
    }

    private var searchBar: some View {
        TextField("Search", text: $query)
            .textFieldStyle(.roundedBorder)
            .padding([.horizontal, .top])
            .accessibilityIdentifier(AccessibilityIDs.catalogSearch)
    }

    private var toggleViewMode: some View {
        HStack {
            Text(isGrid ? "Grid" : "List")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer()
            Toggle("Grid mode", isOn: $isGrid)
                .labelsHidden()
        }
        .padding(.horizontal)
    }

    private var listView: some View {
        List {
            Section("Screens") {
                ForEach(filteredItems) { item in
                    Button {
                        router.path.append(item.route)
                    } label: {
                        HStack {
                            Text(item.title)
                            Spacer()
                        }
                    }
                    .accessibilityIdentifier("catalog.cell.\(item.id)")
                }
            }
        }
        .listStyle(.insetGrouped)
    }

    private var gridView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(filteredItems) { item in
                    Button {
                        router.path.append(item.route)
                    } label: {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue.opacity(0.1))
                            .overlay(
                                Text(item.title)
                                    .multilineTextAlignment(.center)
                                    .padding()
                            )
                            .frame(height: 80)
                    }
                    .accessibilityIdentifier("catalog.cell.\(item.id)")
                }
            }
            .padding()
        }
    }
}
