//
//  ChartView.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/04/30.
//

import SwiftUI

struct ChartView: View {
    
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingData: Date
    private let endingData: Date
    @State private var percentage:CGFloat = 0
    
    init(coin:CoinModel) {
        self.data = coin.sparklineIn7D?.price ?? []
        self.maxY = data.max() ?? 0
        self.minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0 )
        lineColor = priceChange > 0 ? Color.theme.green : .theme.red
        
        endingData = Date(coinGeckoString:coin.lastUpdated ?? "")
        startingData =  endingData.addingTimeInterval(-7*24*60*60)
        
    }
    
    /*
      60,000 - maxY
      50,000 - minY
       
      60,000 - 50,000 = 10,000 - yAxis
      
      52,000 - data Point
      52,000 - 50,000 = 2000 / 10,000 = 20%
     
     
     */
    
    var body: some View {
        
        VStack{
            chartView
                .frame(height: 200)
                .background(
                    chartBackground
                )
                .overlay(chartYAxis.padding(.horizontal,4),alignment: .leading)
                    
                chartDateLabel
                .padding(.horizontal,4)
        }
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
        
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
        
    }
}

extension ChartView {
    
    private var chartView: some View {
        GeometryReader{ geometry in
            Path{ path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let yPosition = (1  - CGFloat((data[index] - minY)) / yAxis) * geometry.size.height
                    
                    if  index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition)) //커서 이동
                    }
                    
                    path.addLine(to: CGPoint(x:xPosition,y:yPosition)) // 선그리기
                    
                    
                }
            }
            .trim(from: 0,to: percentage) //모양에 대한 획 또는 채우기의 일부만 그릴 수 있습니다. 이 수정자는 시작 값( from )과 끝 값( to ), 둘 다 CGFloat 0 과 1 사이로 저장되는 두 매개 변수를 사용합니다 .
            .stroke(lineColor,style: StrokeStyle(lineWidth: 2,lineCap: .round,lineJoin: .round))
            .shadow(color: lineColor, radius: 10,x: 0,y: 0)
            .shadow(color: lineColor.opacity(0.5), radius: 10,x:0,y:20)
            .shadow(color: lineColor.opacity(0.2), radius: 10,x:0,y:30)
            .shadow(color: lineColor.opacity(0.1), radius: 10,x:0,y:40)
            
        }
    }
    
    private var chartBackground: some View{
        VStack{
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis : some View {
        VStack{
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartDateLabel: some View {
        HStack{
            Text(startingData.asShortDateString())
            Spacer()
            Text(endingData.asShortDateString())
        }
    }
}
