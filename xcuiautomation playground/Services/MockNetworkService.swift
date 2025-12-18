import Foundation
import Combine

final class MockNetworkService: ObservableObject {
    let config: TestConfiguration

    init(config: TestConfiguration) {
        self.config = config
    }

    func fetchDemoItems(count: Int) async throws -> [String] {
        let latency = max(config.latencyMs, 0)
        if latency > 0 {
            try await Task.sleep(nanoseconds: UInt64(latency) * 1_000_000)
        }
        return (0..<count).map { "Item \($0 + 1)" }
    }
}
