//
//  MainCoordinator.swift
//  CryptoTrends
//
//  Created by Bhuiyan Wasif on 12/16/24.
//
import SwiftUI
//Here, the associated value coin is of type CoinModel. For Swift to compare two Screen.coinDetail cases (to determine if they're the same), CoinModel must also conform to Equatable. So, we want to make CoinModel conform to the Equatable protocol. let screen1 = Screen.coinDetail(coin: coinModel1)
//let screen2 = Screen.coinDetail(coin: coinModel2)


// Enum for Screens
enum Screen: Identifiable, Hashable {
    case welcome
    case home
    case coinDetail(coin: CoinModel)

    var id: String {
        switch self {
        case .welcome: return "welcome"
        case .home: return "home"
        case .coinDetail(let coin): return "coinDetail_\(coin.id)"
        }
    }
}

final class MainCoordinator: ObservableObject {
    @Published var path: [Screen] = [] // Stack of screens

    // Function to push a screen
    func push(_ screen: Screen) {
        path.append(screen)
    }

    // Function to pop the last screen
    func pop() {
        _ = path.popLast()
    }

    // ViewBuilder to build the destination views
    @ViewBuilder
    func build(screen: Screen) -> some View {
        switch screen {
        case .welcome:
            WelcomePage()
        case .home:
            HomeView()
        case .coinDetail(let coin):
            CoinDetailView(coin: coin)
        }
    }
}

