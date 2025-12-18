import SwiftUI

struct CountryCity: Identifiable, Hashable {
    let id = UUID()
    let country: String
    let cities: [String]
}

struct PickersScreen: View {
    @State private var date = Date()
    @State private var countryIndex = 0
    @State private var cityIndex = 0
    @State private var resultText: String = ""

    private let data: [CountryCity] = [
        .init(country: "USA", cities: ["New York", "San Francisco", "Chicago"]),
        .init(country: "UK", cities: ["London", "Manchester", "Bristol"]),
        .init(country: "Japan", cities: ["Tokyo", "Osaka", "Kyoto"])
    ]

    var body: some View {
        Form {
            Section("Date") {
                DatePicker("Select date", selection: $date, displayedComponents: .date)
                    .accessibilityIdentifier(AccessibilityIDs.pickersDate)
            }

            Section("Country / City") {
                Picker("Country", selection: $countryIndex) {
                    ForEach(data.indices, id: \.self) { index in
                        Text(data[index].country).tag(index)
                    }
                }
                .onChange(of: countryIndex) { _ in cityIndex = 0 }

                Picker("City", selection: $cityIndex) {
                    ForEach(data[countryIndex].cities.indices, id: \.self) { index in
                        Text(data[countryIndex].cities[index]).tag(index)
                    }
                }
            }
            .accessibilityIdentifier(AccessibilityIDs.pickersCountryCity)

            Section("Result") {
                Button("Apply") {
                    let formatter = DateFormatter()
                    formatter.dateStyle = .medium
                    let dateString = formatter.string(from: date)
                    resultText = "Date: \(dateString) | \(data[countryIndex].country) - \(data[countryIndex].cities[cityIndex])"
                }
                .accessibilityIdentifier(AccessibilityIDs.pickersApply)

                Text(resultText.isEmpty ? "No selection yet" : resultText)
                    .accessibilityIdentifier(AccessibilityIDs.pickersResult)
            }
        }
        .navigationTitle("Pickers")
    }
}
