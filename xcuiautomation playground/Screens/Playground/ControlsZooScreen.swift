import SwiftUI

struct ControlsZooScreen: View {
    @State private var selectedSegment = 0
    @State private var sliderValue: Double = 50
    @State private var stepperValue: Int = 1
    @State private var toggleOn: Bool = false

    var body: some View {
        Form {
            Section("Button") {
                Button("Tap me") {
                    // no-op demo
                }
                .accessibilityIdentifier(AccessibilityIDs.controlsButton)
            }

            Section("Segmented") {
                Picker("Options", selection: $selectedSegment) {
                    Text("One").tag(0)
                    Text("Two").tag(1)
                    Text("Three").tag(2)
                }
                .pickerStyle(.segmented)
                .accessibilityIdentifier(AccessibilityIDs.controlsSegment)
            }

            Section("Slider") {
                Slider(value: $sliderValue, in: 0...100, step: 1)
                    .accessibilityIdentifier(AccessibilityIDs.controlsSlider)
                Text("Value: \(Int(sliderValue))")
                    .accessibilityIdentifier(AccessibilityIDs.controlsSliderValue)
            }

            Section("Stepper") {
                Stepper("Quantity: \(stepperValue)", value: $stepperValue, in: 0...10)
                    .accessibilityIdentifier(AccessibilityIDs.controlsStepper)
            }

            Section("Toggle & Progress") {
                Toggle("Enable", isOn: $toggleOn)
                    .accessibilityIdentifier(AccessibilityIDs.controlsToggle)

                ProgressView(value: toggleOn ? 1.0 : 0.3)
                    .accessibilityIdentifier(AccessibilityIDs.controlsProgress)
            }
        }
        .navigationTitle("Controls Zoo")
    }
}
