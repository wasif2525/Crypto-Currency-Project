//
//  CoinRowView.swift
//  CryptoTrends
//
//  Created by Bhuiyan Wasif on 12/11/24.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            
            Spacer()
            
            if showHoldingsColumn{
                centerColumn
            }
            
            rightColumn
            
        }
        .font(.subheadline)
    }
}

#Preview {
    Group{
        CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingsColumn: true)
        
        CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingsColumn: true)
            .preferredColorScheme(.dark)
    }
    
}

extension CoinRowView{
    private var leftColumn: some View{
        HStack{
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
                .frame(minWidth: 30)
            CachedImageView(urlString: coin.image)
                .frame(width: 30, height: 30)
                .padding(.leading, 4)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            
        }
    }
    
    private var centerColumn: some View{
        VStack(alignment: .leading){
            Text(coin.currentHoldingsAmount.asCurrecnyWith2DecimalString())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundStyle(Color.theme.accent)
    }
    
    private var rightColumn: some View{
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrecnyWith6DecimalString())
                        .bold()
                        .foregroundColor(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                        .foregroundColor(
                            (coin.priceChangePercentage24H ?? 0 >= 0) ?
                            Color.theme.green :
                            Color.theme.red
                        )
                }
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
