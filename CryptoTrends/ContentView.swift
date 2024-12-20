//
//  ContentView.swift
//  CryptoTrends
//
//  Created by Bhuiyan Wasif on 12/9/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var coordinator = MainCoordinator()

        var body: some View {
            NavigationStack(path: $coordinator.path) {
                coordinator.build(screen: .welcome) // Initial Screen
                
                // Navigation Destination
                .navigationDestination(for: Screen.self) { screen in
                    coordinator.build(screen: screen)
                }
            }
            .environmentObject(coordinator)
        }
}

#Preview {
    ContentView()
}
