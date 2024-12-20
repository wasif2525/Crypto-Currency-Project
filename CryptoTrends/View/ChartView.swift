//
//  ChartView.swift
//  CryptoTrends
//
//  Created by Bhuiyan Wasif on 12/15/24.
//

import SwiftUI

struct ChartView: View {
    let data: [Double]
    let maxY: Double
    let minY: Double
    let lineColor: Color
    let startingDate: Date
    let endingDate: Date
    @State private var percentage: CGFloat = 0
    
    init(coin: CoinModel){
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*3600)
    }
    
    var body: some View {
        VStack{
            chartView
                .frame(height: 200)
                .background(chartBackground)
                .overlay(VStack{
                    Text((maxY.formattedWithAbbreviations()))
                    Spacer()
                    Text(((maxY + minY)/2).formattedWithAbbreviations())
                    Spacer()
                    Text((minY).formattedWithAbbreviations())
                }, alignment: .leading)
            
            HStack{
                Text(startingDate.asShortDateString())
                Spacer()
                Text(endingDate.asShortDateString())
            }
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryTextColor)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
    }
}

#Preview {
    ChartView(coin: DeveloperPreview.instance.coin)
        
}
//300 / 100 = 3
// 3 * 1 = 3
// 3* 2 = 6, 3 * 3 = 9....

//max - 60,000
//min - 50,000
//yAxis = 60000 - 50000 = 10,000
// ex: data - 52000
//52,000 - 50,000 = 2,000 from bottom / 10,000 = 20% from bottom


extension ChartView{
    private var chartView: some View{
        GeometryReader { geometry in
            Path{path in
                for index in data.indices{
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0, y: 40)
        }
    }
    
    private var chartBackground: some View{
        VStack{
            Divider()
                .background(Color.theme.accent)
            Spacer()
            Divider()
                .background(Color.theme.accent)
            Spacer()
            Divider()
                .background(Color.theme.accent)
        }
    }
}
