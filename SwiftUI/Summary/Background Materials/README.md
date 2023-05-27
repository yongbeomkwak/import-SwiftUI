# **#55  Background Materials**


### **`iOS 15에서 사용 가능한 Background Materials`**
쉽게 말해서 배경에 블러처리와 같은 고급효과를 만들어 줄 수 있음

<br>

<img src="https://github.com/HunyongSeong/SwiftUIStudy/assets/108869319/cca95520-b5de-492c-812d-b930510a00d9">

```swift
//
//  BackgroundMaterialsBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/05/25.
//

import SwiftUI

struct BackgroundMaterialsBootcamp: View {
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                RoundedRectangle(cornerRadius: 4) 
                    .frame(width: 50, height: 4)
                    .padding()
                Spacer()
            }
            .frame(height: 350)
            .frame(maxWidth: .infinity)
//            .background(Color.white.opacity(0.5)) <- 일반적인 방식
//            .background(.thinMaterial) <- Material
//            .background(.thickMaterial)
//            .background(.regularMaterial)
//            .background(.ultraThickMaterial)
            .background(.ultraThinMaterial)


            .cornerRadius(30)
        }
        .ignoresSafeArea()
        .background(
            Image("jaypark")
        )
    }
}

struct BackgroundMaterialsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundMaterialsBootcamp()
    }
}
```

`ultraThickMaterial ← 가장 두꺼운 블러처리 느낌을 줄 수 있음`

`ultraThinMaterial ← 가장 옅은 블러처리 느낌을 줄 수 있음`
