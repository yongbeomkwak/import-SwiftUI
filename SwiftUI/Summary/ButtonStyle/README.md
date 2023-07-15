# #2 ButtonStyle

<br>

## 버튼 스타일
일반적으로 우리가 만드는 버튼은 아래와 같습니다.

<br>
<img width="80%" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/108869319/d200d84b-80b7-4c66-ba74-a99963a07898"/>

<br>
<br>

```swift
//
//  ButtonStyleBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/07/11.
//

import SwiftUI

struct ButtonStyleBootcamp: View {
    var body: some View {
        Button(action: {
            
        }, label: {
            Text("Click Me")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
        })
				// .buttonStyle(PlainButtonStyle())
        .padding(40)
    }
}

struct ButtonStyleBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyleBootcamp()
    }
}
```

<br>
<br>
<img width="80%" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/108869319/1f14890a-fb12-40f0-b19b-70a643db82a7"/>

<br>
<br>

```swift
.buttonStyle(PlainButtonStyle()) // 약한 하이라이트
// .buttonStyle(DefaultButtonStyle()) // 기본 하이라이트
.padding(40)
```
<br>
<br>
<br>
<br>
<br>
<img width="80%" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/108869319/66dddcbd-c6b7-4991-b8fc-474064a06c1d"/>

<br>
<br>

```swift
//
//  ButtonStyleBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/07/11.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle { // ButtonStyle 타입 구조체 *(1)
    func makeBody(configuration: Configuration) -> some View {
        // ButtonStyle 에서는 func makeBody를 필요로 한다.
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
//            .brightness(configuration.isPressed ? 0.2 : 0)
            .opacity(configuration.isPressed ? 0.5 : 1.0)
    }
}

struct ButtonStyleBootcamp: View {
    var body: some View {
        Button(action: {
            
        }, label: {
            Text("Click Me")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
        })
        .buttonStyle(PressableButtonStyle()) // (1)사용
        .padding(40)
    }
}

struct ButtonStyleBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyleBootcamp()
    }
}
```

<br>

```swift
//
//  ButtonStyleBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/07/11.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle { // ButtonStyle 타입 구조체 // *(1)
    
    let scaleAmount: CGFloat //(2)
    
    init(scaleAmount: CGFloat) { //(2) 생성자
        self.scaleAmount = scaleAmount
    }
    
    func makeBody(configuration: Configuration) -> some View {
        // ButtonStyle 에서는 func makeBody를 필요로 한다.
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1.0) //scaleAmount
//            .brightness(configuration.isPressed ? 0.2 : 0)
            .opacity(configuration.isPressed ? 0.5 : 1.0)
    }
}

extension View {
    
    func withPressabledStyle(scaledAmount: CGFloat = 0.9) -> some View { // (2) 넣기
        buttonStyle(PressableButtonStyle(scaleAmount: scaledAmount)) //(1)의 버튼스타일을 가지고 있음
    }
    
}

struct ButtonStyleBootcamp: View {
    var body: some View {
        Button(action: {
            
        }, label: {
            Text("Click Me")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
        })
        .withPressabledStyle(scaledAmount: 0.5) //(1)의 버튼스타일을 가지고 있는 함수 사용
//        .buttonStyle(PressableButtonStyle()) //(1)
        .padding(40)
    }
}

struct ButtonStyleBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyleBootcamp()
    }
}
```