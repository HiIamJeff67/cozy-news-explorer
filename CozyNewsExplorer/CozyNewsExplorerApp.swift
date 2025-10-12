//
//  CozyNewsExplorerApp.swift
//  CozyNewsExplorer
//
//  Created by HiIamJeff on 2025/10/12.
//

import SwiftUI

@main
struct CozyNewsExplorerApp: App {
    @StateObject private var theme = ThemeManager()
    @StateObject private var player = PlayerStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(theme)
                .environmentObject(player)
        }
    }
}
