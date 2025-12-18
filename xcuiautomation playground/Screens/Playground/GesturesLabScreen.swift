import SwiftUI

struct GesturesLabScreen: View {
    @State private var scale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastTapLocation: CGPoint? = nil

    var body: some View {
        VStack(spacing: 24) {
            Text("Pinch / Drag / Tap the square")

            Rectangle()
                .fill(Color.blue.opacity(0.3))
                .frame(width: 200, height: 200)
                .scaleEffect(scale)
                .offset(offset)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            scale = value
                        }
                )
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            offset = value.translation
                        }
                )
                .simultaneousGesture(
                    TapGesture()
                        .onEnded { location in
                            // location is in local coordinates (no direct value), use center
                            lastTapLocation = CGPoint(x: 100, y: 100)
                        }
                )
                .accessibilityIdentifier(AccessibilityIDs.gesturesCanvas)

            Text("Scale: \(String(format: "%.2f", scale))")
                .accessibilityIdentifier(AccessibilityIDs.gesturesZoom)

            Text("Last tap: \(lastTapLocation.map { "(\($0.x), \($0.y))" } ?? "none")")
                .accessibilityIdentifier(AccessibilityIDs.gesturesCoords)

            Button("Reset") {
                scale = 1.0
                offset = .zero
                lastTapLocation = nil
            }
            .accessibilityIdentifier(AccessibilityIDs.gesturesReset)

            Spacer()
        }
        .padding()
        .navigationTitle("Gestures Lab")
    }
}
