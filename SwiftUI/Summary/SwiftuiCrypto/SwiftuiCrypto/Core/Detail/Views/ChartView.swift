//
//  ChartView.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/04/30.
//

import SwiftUI

struct ChartView: View {
    
    let data: [Double]
    let maxY: Double
    let minY: Double
    let lineColor: Color
    
    init(coin:CoinModel) {
        self.data = coin.sparklineIn7D?.price ?? []
        self.maxY = data.max() ?? 0
        self.minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0 )
        lineColor = priceChange > 0 ? Color.theme.green : .theme.red
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
            .stroke(lineColor,style: StrokeStyle(lineWidth: 2,lineCap: .round,lineJoin: .round))
            
        }
    }
    
}
