//
//  HomeView.swift
//  CryptoTrends
//
//  Created by Bhuiyan Wasif on 12/9/24.
//

import SwiftUI

struct HomeView: View {
    @State private var showPortfolio: Bool = false
    @StateObject var vm: HomeViewModel = HomeViewModel(networkManager: NetworkManager())
    @EnvironmentObject var coordinator: MainCoordinator
    
    var body: some View {
        
            ZStack{
                //background layer
                Color.theme.background
                    .ignoresSafeArea()
                
                //content layer
                VStack{
                    homeHeader
                    
                    columnTitles
                    
                    SearchBar(searchText: $vm.searchText)
                    
                    if !showPortfolio {
                        allCoinsList
                        .transition(.move(edge: .leading))
                    } else {
                        allCoinsList
                            .transition(.move(edge: .trailing))
                    }
                    
                    
                    Spacer(minLength: 0)
                }
            }
        }
        
    
        
}

#Preview {
    NavigationStack{
        HomeView()
            .navigationBarHidden(true)
    }
//    .environmentObject(DeveloperPreview.instance.vm)
}

extension HomeView {
    private var homeHeader: some View{
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .background(CircleButtonAnimation(animate: $showPortfolio))
                
            Spacer()
            
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
            
            Spacer()
            
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring())
                    {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
    
    private var allCoinsList: some View{
        List{
            ForEach(vm.allCoins) { coin in
//                NavigationLink {
//                    CoinDetailView(coin: coin)
//                } label: {
//                    CoinRowView(coin: coin, showHoldingsColumn: false)
//                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
//                }
                Button {
                    coordinator.push(.coinDetail(coin: coin))
                } label: {
                    CoinRowView(coin: coin, showHoldingsColumn: false)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                }

                
            }
            
        }
        .listStyle(PlainListStyle())
    }
    private var portfolioCoinsList: some View{
        List{
            ForEach(vm.portfolioCoins) { coin in
//                NavigationLink {
//                    CoinDetailView(coin: coin)
//                } label: {
//                    CoinRowView(coin: coin, showHoldingsColumn: true)
//                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
//                }
                Button {
                    coordinator.push(.coinDetail(coin: coin))
                } label: {
                    CoinRowView(coin: coin, showHoldingsColumn: false)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                }

                
            }
            
        }
        .listStyle(PlainListStyle())
    }
    
    private var columnTitles: some View{
        HStack(){
            Text("Coin")
            Spacer()
            if showPortfolio{
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .padding(.horizontal)
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryTextColor)
    }
}
