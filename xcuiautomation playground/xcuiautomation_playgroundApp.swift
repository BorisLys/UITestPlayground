//
//  xcuiautomation_playgroundApp.swift
//  xcuiautomation playground
//
//  Created by Борис Лысиков on 18.12.2025.
//

import SwiftUI

@main
struct UITestPlaygroundApp: App {
    @StateObject private var appState: AppState
    @StateObject private var config: TestConfiguration
    @StateObject private var router = DeepLinkRouter()
    @StateObject private var networkService: MockNetworkService

    init() {
        let config = TestConfiguration.fromProcessInfo()
        let appState = AppState()

        // Применяем сид при запуске
        SeedService.apply(seed: config.seed, to: appState)

        _config = StateObject(wrappedValue: config)
        _appState = StateObject(wrappedValue: appState)
        _networkService = StateObject(wrappedValue: MockNetworkService(config: config))

        // Обрабатываем возможный диплинк из аргументов
        router.applyInitialDeepLink(config.deepLink)
    }

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(appState)
                .environmentObject(config)
                .environmentObject(router)
                .environmentObject(networkService)
                .onOpenURL { url in
                    router.handle(url: url)
                }
        }
    }
}
