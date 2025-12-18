import Foundation
import Combine

/// Конфигурация запуска приложения для UI-тестов.
/// Значения читаются из `ProcessInfo.processInfo.arguments`, но могут меняться во время работы через экран Settings.
final class TestConfiguration: ObservableObject {
    @Published var isUITesting: Bool
    @Published var useMockNetwork: Bool
    @Published var seed: String
    @Published var latencyMs: Int
    @Published var disableAnimations: Bool
    @Published var deepLink: URL?
    @Published var shouldResetState: Bool

    init(
        isUITesting: Bool = false,
        useMockNetwork: Bool = true,
        seed: String = "empty",
        latencyMs: Int = 0,
        disableAnimations: Bool = false,
        deepLink: URL? = nil,
        shouldResetState: Bool = false
    ) {
        self.isUITesting = isUITesting
        self.useMockNetwork = useMockNetwork
        self.seed = seed
        self.latencyMs = latencyMs
        self.disableAnimations = disableAnimations
        self.deepLink = deepLink
        self.shouldResetState = shouldResetState
    }

    static func fromProcessInfo() -> TestConfiguration {
        let args = ProcessInfo.processInfo.arguments

        func hasFlag(_ flag: String) -> Bool {
            args.contains(flag)
        }

        func value(for flag: String) -> String? {
            guard let index = args.firstIndex(of: flag), index + 1 < args.count else { return nil }
            return args[index + 1]
        }

        let isUITesting = hasFlag("-uiTesting")
        let useMockNetwork = hasFlag("-mockNetwork") || !isUITesting // по умолчанию true в обычном режиме
        let seedValue = value(for: "-seed") ?? "empty"
        let latencyMs = Int(value(for: "-latencyMs") ?? "0") ?? 0
        let disableAnimations = hasFlag("-disableAnimations")
        let deepLinkString = value(for: "-deepLink")
        let deepLinkURL = deepLinkString.flatMap { URL(string: $0) }
        let resetState = hasFlag("-resetState")

        return TestConfiguration(
            isUITesting: isUITesting,
            useMockNetwork: useMockNetwork,
            seed: seedValue,
            latencyMs: latencyMs,
            disableAnimations: disableAnimations,
            deepLink: deepLinkURL,
            shouldResetState: resetState
        )
    }
}
