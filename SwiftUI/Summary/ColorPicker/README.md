# ColorPicker

## 정의

선택지가 정해져 있고 거기에서 하나의 요소를 선택할 때 사용한다.

<br>
<br>

## 구성 요소

ColorPicker(titleKey: StringProtocol, selection: Binding Color)

- titleKey: Label과 같은 역할 
- selection: 현재 선택된 색을 가르킬 바인딩 가능한 변수
- supportsOpacity: 투명도 사용 여부, default = true


```swift
import SwiftUI

struct ContentView: View {
    
    @State var backgroundColor:Color = .green
    
    
    var body: some View {
        ZStack{
            
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            ColorPicker("Select a Color", selection: $backgroundColor,supportsOpacity: true)
                .padding()
                .background(.black)
                .cornerRadius(10)
                .foregroundColor(.white) // TitleKey 색깔
            
            
        }
    }

}
```


<p align = "center"> <img height = "400" src="https://github.com/wakmusic/wakmusic-iOS/assets/48616183/12f55eab-adb0-4cbf-9e2f-22c8a0526134">  <img height = "400" src = "https://github.com/wakmusic/wakmusic-iOS/assets/48616183/31716e29-c4bc-4a00-b665-7f5604fdd31b">  </p>



