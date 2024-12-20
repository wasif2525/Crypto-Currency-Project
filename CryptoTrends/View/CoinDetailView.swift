//
//  CoinDetailView.swift
//  CryptoTrends
//
//  Created by Bhuiyan Wasif on 12/14/24.
//

import SwiftUI

struct CoinDetailView: View {
    var coin: CoinModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                //chart at top
                ChartView(coin: coin)
                    .padding(.bottom, 40)
                
                // Header with image and name
                headerView
                
                Divider()
                    .background(Color.theme.accent)
                
                // Price and Market Information
                priceInfoSection
                
                Divider()
                    .background(Color.theme.accent)
                
                // 24h Price Stats
                priceStatsSection
                
                Divider()
                    .background(Color.theme.accent)
                
                // All-Time High/Low Stats
                allTimeStatsSection
                
                Divider()
                    .background(Color.theme.accent)
                
                // Market Cap Information
                marketCapSection
            }
            .padding()
        }
        .navigationTitle(coin.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var headerView: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: coin.image)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else {
                    Color.gray.opacity(0.3) // Placeholder
                }
            }
            .frame(width: 60, height: 60)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 5) {
                Text(coin.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.theme.accent)
                Text(coin.symbol.uppercased())
                    .font(.headline)
                    .foregroundColor(Color.theme.secondaryTextColor)
            }
            Spacer()
        }
    }
    
    private var priceInfoSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Current Price")
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            Text(coin.currentPrice.asCurrecnyWith2DecimalString())
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color.theme.accent)
            
            HStack {
                Text("24h Change:")
                    .font(.subheadline)
                    .foregroundStyle(Color.theme.secondaryTextColor)
                Text((coin.priceChangePercentage24H ?? 0).asPercentString())
                    .foregroundColor(coin.priceChangePercentage24H ?? 0 >= 0 ? Color.theme.green : Color.theme.red)
            }
        }
    }
    
    private var priceStatsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("24h High / Low")
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .fontWeight(.bold)
            HStack {
                Text("High: \((coin.high24H ?? 0).asCurrecnyWith2DecimalString())")
                    .foregroundStyle(Color.theme.green)
                    .font(.headline)
                Spacer()
                Text("Low: \((coin.low24H ?? 0).asCurrecnyWith2DecimalString())")
                    .foregroundStyle(Color.theme.red)
                    .font(.headline)
            }
            .font(.subheadline)
        }
    }
    
    private var allTimeStatsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("All-Time Stats")
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("ATH: \((coin.ath ?? 0).asCurrecnyWith2DecimalString())")
                    .foregroundColor(Color.theme.green)
                Text("ATH Change: \((coin.athChangePercentage ?? 0).asPercentString())")
                    .foregroundColor(coin.athChangePercentage ?? 0 >= 0 ? Color.theme.green : Color.theme.red)
                Text("ATH Date: \(formattedDate(from: coin.athDate ?? ""))")
                    .foregroundColor(.gray)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("ATL: \((coin.atl ?? 0).asCurrecnyWith2DecimalString())")
                    .foregroundColor(Color.theme.red)
                Text("ATL Change: \((coin.atlChangePercentage ?? 0).asPercentString())")
                    .foregroundColor(coin.atlChangePercentage ?? 0 >= 0 ? Color.theme.green : Color.theme.red)
                Text("ATL Date: \(formattedDate(from: coin.atlDate ?? ""))")
                    .foregroundColor(.gray)
            }
        }
    }
    
    private var marketCapSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Market Information")
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .fontWeight(.bold)
            VStack(alignment: .leading, spacing: 5) {
                Text("Market Cap: \((coin.marketCap ?? 0).asCurrecnyWith2DecimalString())")
                    .foregroundStyle(Color.theme.accent)
                Text("Rank: #\((coin.marketCapRank ?? 0).asNumberString())")
                    .foregroundStyle(Color.theme.accent)
                Text("Total Volume: \((coin.totalVolume ?? 0).asCurrecnyWith2DecimalString())")
                    .foregroundStyle(Color.theme.accent)
            }
            .font(.subheadline)
        }
    }
    
    // Helper method to format dates
    private func formattedDate(from dateString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        if let date = isoFormatter.date(from: dateString) {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }
        return "N/A"
    }
}


#Preview {
    CoinDetailView(coin: DeveloperPreview.instance.coin)
}
