//
//  WelcomePage.swift
//  CryptoTrends
//
//  Created by Bhuiyan Wasif on 12/15/24.
//

import SwiftUI

struct WelcomePage: View {
    @EnvironmentObject var coordinator: MainCoordinator
    
    var body: some View {
        
            ZStack {
                // Background Image
                Image("crypto_background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.7)
                
                // Content
                VStack(spacing: 30) {
                    // App Title
                    Text("Crypto Tracker")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                    
                    // Subtitle
                    Text("Track your favorite crypto in real-time")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    
                    
                    // Navigation Button
//                    NavigationLink(destination: HomeView()) {
//                        Text("View Coins")
//                            .font(.title2)
//                            .fontWeight(.semibold)
//                            .foregroundColor(.white)
//                            .frame(width: 200, height: 50)
//                            .background(Color.blue)
//                            .cornerRadius(12)
//                            .shadow(radius: 5)
//                    }
                    Button{
                        coordinator.push(.home)
                    } label: {
                        Text("View Coins")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }
                }
                .padding()
            }
        }
    
}


#Preview {
    WelcomePage()
}
