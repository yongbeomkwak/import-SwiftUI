# #10 PreferenceKey

<br>

## PreferenceKey는 무엇일까?

프리퍼런스 키(Preference Key):
프리퍼런스 키는 주로 SwiftUI의 레이아웃 시스템과 뷰 계층 구조에서 사용자 정의 데이터를 공유하고 전달하는 데 사용됩니다. 뷰 계층 구조 내에서 뷰의 계층 구조를 검색하면서 특정 데이터를 수집하고 전달하는 용도로 사용됩니다. 예를 들어, 뷰 계층에서 가장 높은 수준의 뷰부터 특정 뷰까지의 경로에 대한 정보를 수집하고 해당 정보를 기반으로 레이아웃을 조정하는 데 유용합니다.

<br>

PreferenceKey를 사용하면 자식 뷰에서 데이터를 수집하여 부모 뷰로 전달하고, 필요에 따라 상위 뷰에서 해당 데이터를 사용할 수 있습니다. 이를 통해 뷰 계층 구조 내에서 데이터를 공유하고 뷰들 간에 상태를 유지하면서 레이아웃을 조정하는 등의 작업을 할 수 있습니다. PreferenceKey를 사용하여 뷰 계층을 유연하게 제어하고 데이터를 전달하는 기능은 SwiftUI의 강력한 기능 중 하나입니다 :)

<br>

따라서, `@State와 @Binding은 뷰 내에서 상태를 관리하고 데이터를 전달하기 위해 사용`되는 반면, `프리퍼런스 키는 뷰 계층에서 데이터를 공유하고 전달하는 데 사용되며, 다른 뷰들이 해당 데이터에 접근할 수 있게 해줍니다.` 각각의 래퍼는 서로 다른 상황에 맞춰 적절하게 사용되어야 합니다!!.

<br>

## PreferenceKey를 사용하는 이유는 무엇일까?

1. 데이터 유지: 앱 내에서 일시적인 데이터나 설정값을 저장하여 앱을 다시 시작하거나 다른 화면으로 이동해도 데이터가 유지될 수 있습니다. 이를 통해 사용자 경험을 향상시킬 수 있습니다.

2. 사용자 환경 설정 저장: 사용자가 앱의 설정을 변경하면 이러한 변경 사항을 기억하기 위해 프리퍼런스 키를 사용할 수 있습니다. 예를 들어, 언어 설정, 테마 설정, 또는 알림 설정과 같은 사용자 정의 설정을 저장할 수 있습니다.

3. 사용자 상태 저장: 사용자가 앱을 사용하는 동안의 상태를 저장할 수 있습니다. 예를 들어, 사용자가 마지막으로 열었던 페이지나 마지막으로 선택한 옵션을 기억하는 데 사용됩니다.

4. 앱 간 데이터 공유: 프리퍼런스 키를 사용하면 앱 간에 데이터를 간단하게 공유할 수 있습니다. 하나의 앱에서 설정된 정보를 다른 앱에서도 읽고 사용할 수 있습니다.

<br>

## PreferenceKey는 어떻게 사용할까?

1. Preference Key 정의: 먼저, Preference Key를 정의해야 합니다. 이는 프로토콜로서 사용자 정의 데이터 유형과 기본값, 그리고 데이터를 조합하는 로직을 정의합니다.

2. 데이터 수집: 자식 뷰에서 해당 Preference Key를 사용하여 데이터를 수집합니다. 이 데이터는 상위 뷰로 전달됩니다.

3. 데이터 사용: 상위 뷰에서 수집된 데이터를 사용합니다. 이 데이터를 기반으로 뷰 레이아웃을 조정하거나 원하는 작업을 수행합니다.


<br>

```swift
import SwiftUI

struct PreferenceKeyBootcamp: View {
    
    @State private var text: String = "Hello, world!" // *** 상위(부모) 뷰
    
    var body: some View {
        NavigationView {
            VStack {
                SecondaryScreen(text: text) // *** 하위(자식) 뷰,
                    .navigationTitle(text) // 자식수준에서 값이 나오게 됨
                // 부모에서 자식으로 이동하는 대신 -> 자식에서 부모로 값을 전달.
            }
        }
    }
}
```

<br>


<br>

```swift
struct SecondaryScreen: View { // 하위(자식)뷰 ***
    
    let text: String
    @State private var newValue: String = ""
    
    var body: some View {
        VStack{
            Text(text)
        }
    }
}
```

<br>

<br>

### 1. Preference Key 정의
<br>

```swift
// 단계 1: Preference Key 정의

struct CustomTitlePreferenceKey: PreferenceKey {
    
    static var defaultValue: String = ""
    // static var defaultValue 선언, <- defaultValue <- de 로 자동완성 기능
    
    static func reduce(value: inout String, nextValue: () -> String) {
        // inout 입력 형식 문자열이 있음. <- 이 값을 매개 변수로 가져올 것임
        // 기본적으로 현재 값을 업데이트 하는 옵션이 있음
        
        value = nextValue()
        // 기본 값인 defaultValue(value)를 nextValue로 바꾸어주는 작업
    }    
}
```

<br>

<br>
<img width="40%" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/108869319/bb1cb031-3545-4af0-bd92-6941cdc2e998">

<br>

### 2. 데이터 수집

### 3. 데이터 사용

<br>

```swift
import SwiftUI

struct PreferenceKeyBootcamp: View {
    
    @State private var text: String = "Hello, world!" // *** 상위(부모) 뷰
    
    var body: some View {
        NavigationView {
            VStack {
                SecondaryScreen(text: text) // *** 하위(자식) 뷰,
                    .navigationTitle("Navigation Title") // 자식수준에서 값이 나오게 됨
                // 부모에서 자식으로 이동하는 대신 -> 자식에서 부모로 값을 전달.
            }
        }
        .onPreferenceChange(CustomTitlePreferenceKey.self, perform: { value in
            self.text = value
        }) 
        //CustomTitlePreferenceKey를 관찰하고 새 값이 없데이트 되거나 변경될 때 그 값을 가져온다.
    }
}
```

<br>

<br>

```swift
.onPreferenceChange(CustomTitlePreferenceKey.self, perform: { value in
   self.text = value
})
//CustomTitlePreferenceKey를 관찰하고 새 값이 없데이트 되거나 변경될 때 그 값을 가져온다.
```

<br>

위의 코드로 인해서 SecondaryScreen(하위)뷰의 텍스트 값이 “”로 변경됨.

<br>
<img width="40%" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/108869319/756d4a66-35ff-48fc-87dd-90712b62513c"/>

<br>

<br>

```swift
import SwiftUI

struct PreferenceKeyBootcamp: View {
    
    @State private var text: String = "Hello, world!" // *** 상위(부모) 뷰
    
    var body: some View {
        NavigationView {
            VStack {
                SecondaryScreen(text: text) // *** 하위(자식) 뷰,
                    .navigationTitle("Navigation Title") // 자식수준에서 값이 나오게 됨
                // 부모에서 자식으로 이동하는 대신 -> 자식에서 부모로 값을 전달.
                    .preference(key: CustomTitlePreferenceKey.self, value:  "NewValue")
                // 하위뷰의 밸류값을 "NewValue"로 변경
            }
        }
        .onPreferenceChange(CustomTitlePreferenceKey.self, perform: { value in
            self.text = value
        })
        //CustomTitlePreferenceKey를 관찰하고 새 값이 없데이트 되거나 변경될 때 그 값을 가져온다.
    }
}
```

<br>

하위뷰의 밸류값을 "NewValue"로 변경

<br>

```swift
.preference(key: CustomTitlePreferenceKey.self, value:  "NewValue")
```

<br>

<br>
<img width="40%" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/108869319/7a01cf42-8cde-4b48-ac70-41668ec40a3f"/>

<br>

customTitle 함수 만들어서 사용하기!.

<br>

```swift
import SwiftUI

struct PreferenceKeyBootcamp: View {
    
    @State private var text: String = "Hello, world!" // *** 상위(부모) 뷰
    
    var body: some View {
        NavigationView {
            VStack {
                SecondaryScreen(text: text) // *** 하위(자식) 뷰,
                    .navigationTitle("Navigation Title") // 자식수준에서 값이 나오게 됨
                // 부모에서 자식으로 이동하는 대신 -> 자식에서 부모로 값을 전달.
                    .customTitle("New Value!!!!")
            }
        }
        .onPreferenceChange(CustomTitlePreferenceKey.self, perform: { value in
            self.text = value
        })
        //CustomTitlePreferenceKey를 관찰하고 새 값이 없데이트 되거나 변경될 때 그 값을 가져온다.
    }
}

extension View {
    
    func customTitle(_ text: String) -> some View { //  *(사용자 정의 제목)
        preference(key: CustomTitlePreferenceKey.self, value: text)
    }
}
```

<br>

<br>
<img width="40%" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/108869319/c2b14932-8a3c-4211-9f4b-63fb56c6c09e
">

<br>

<br>

```swift
struct SecondaryScreen: View { // 하위(자식)뷰 ***
    
    let text: String
    @State private var newValue: String = ""
    
    var body: some View {
        VStack{
            Text(text)
                .onAppear(perform: getDataFromDatabase)
                .customTitle(newValue) // 위치 SecondaryScreen로 옮기기.!!
        }
        
    }
    
    func getDataFromDatabase() { // 2초 후에 self.newValue를 변경하는 함수
        // download FAKE
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.newValue = "NEW VALUE FROM DATABASE"
        }
    }
}
```

<br>


## 지오메트리 사용

프리퍼런스 키를 사용하여 지오메트리 정보를 활용하여 사각형의 크기를 알아낼 수 있습니다. SwiftUI에서 뷰의 크기와 위치 정보를 가져오기 위해서는 GeometryReader를 사용할 수 있습니다. GeometryReader는 자식 뷰의 크기 및 위치를 제공하므로, 이를 활용하여 사각형의 크기를 알아낼 수 있습니다.



<br>
<img width="40%" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/108869319/650a1417-2768-4022-8c84-1c96b53df437"/>

<br>

<br>

```swift
//
//  GeometryPreferenceKeyBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/07/19.
//

import SwiftUI

struct GeometryPreferenceKeyBootcamp: View {
    var body: some View {
        VStack {
            HStack {
                
            }
            Text("Hello world!")
                .background(Color.blue)
            Spacer()
            HStack {
                Rectangle()
                Rectangle()
                Rectangle()
            }
            .frame(height: 55)
        }
    }
}

struct GeometryPreferenceKeyBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryPreferenceKeyBootcamp()
    }
}
```

<br>

<br>
<img width="40%" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/108869319/54d5d219-4c7d-4e20-b27e-9af62aa4f7d7"/>

<br>

### 지오메트리로 사각형 사이즈 알아내기

<br>

```swift
import SwiftUI

struct GeometryPreferenceKeyBootcamp: View {
    var body: some View {
        VStack {
            HStack {
                
            }
            Text("Hello world!")
                .background(Color.blue)
            Spacer()
            HStack {
                Rectangle()
                
                GeometryReader { geo in
                    Rectangle()
                        .overlay( // 지오메트리로 사각형의 사이즈 알아내기
                            Text("\(geo.size.width)").foregroundColor(.white)
                        ) // 부모 -> 자식으로 값을 전달하는 형태임
                    // 하지만 우리가 원하는 것은 이 값을 전체 뷰에서 접근할 수 있도록 하는 것

                }
                Rectangle()
            }
            .frame(height: 55)
        }
    }
}

struct GeometryPreferenceKeyBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryPreferenceKeyBootcamp()
    }
}
```

<br>

<br>
<img width="40%" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/108869319/523c7976-1315-4192-95bb-18597c1e3d56"/>

<br>

### 지오메트리로 알아낸 검은색 사각형 사이즈→  파란색 사각형에 적용하기

<br>

```swift
//
//  GeometryPreferenceKeyBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/07/19.
//

import SwiftUI

struct GeometryPreferenceKeyBootcamp: View {
    
    @State private var rectSize: CGSize = .zero
    
    var body: some View {
        VStack {
            Text("Hello world!")
                .frame(width: rectSize.width, height: rectSize.height) // *** 3. 값을 사용
                .background(Color.blue)
            Spacer()
            HStack {
                Rectangle()
                
                GeometryReader { geo in
                    Rectangle()
                        .updateRectangleGeosize(geo.size) // -> 함수 사용
                    // 지오메트리로 알아낸 사이즈를 적용하기 위한 코드
                }
                Rectangle()
            }
            .frame(height: 55)
        }
        .onPreferenceChange(RectangleGeometrySizePreferenceKey.self, perform: { value in
            self.rectSize = value
        })
        //RectangleGeometrySizePreferenceKey를 관찰하고 새 값이 없데이트 되거나 변경될 때 그 값을 가져온다.

    }
}

// ***2. updateRectangleGeosize 사각형의 사이즈를 알아내는 함수 만들기.
extension View { // updateRectangleGeosize -> 함수 만들기
     
    func updateRectangleGeosize(_ size: CGSize) -> some View { // *(size)**
        preference(key: RectangleGeometrySizePreferenceKey.self, value: size)
        
    }
}

// ***1.Preference Key 정의
struct RectangleGeometrySizePreferenceKey: PreferenceKey {
    
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}



struct GeometryPreferenceKeyBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryPreferenceKeyBootcamp()
    }
}
```

<br>


## ScrollViewOffsetPreferenceKey

<br>
<img width="40%" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/108869319/707cc7c0-cff1-40c1-ad1b-545fe06cd43c"/>

<br>

<br>

```swift
import SwiftUI

struct ScrollViewOffsetPreferenceKeyBootCamp: View {
    
    let title: String = "New title here!!!!"
    
    var body: some View {
        ScrollView {
            VStack {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ForEach(0..<30) { _ in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.red.opacity(0.3))
                        .frame(width: 300, height: 200)
                }
            }
            .padding()
        }
        .overlay(
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color.blue)
            
            , alignment: .top
        )
    }
}

struct ScrollViewOffsetPreferenceKeyBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewOffsetPreferenceKeyBootCamp()
    }
}
```

<br>

위 코드를 아래와 같이 정리

<br>

```swift
//
//  SwiftUIViewOffsetPreferenceKeyBootCamp.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/07/19.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKeyBootCamp: View {
    
    let title: String = "New title here!!!!"
    
    var body: some View {
        ScrollView {
            VStack {
                titleLayer
                
                contentLayer
            }
            .padding()
        }
        .overlay(navBarLayer, alignment: .top)
    }
}

struct ScrollViewOffsetPreferenceKeyBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewOffsetPreferenceKeyBootCamp()
    }
}

extension ScrollViewOffsetPreferenceKeyBootCamp {
    private var titleLayer: some View { // 제목
        Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var contentLayer: some View {
        ForEach(0..<30) { _ in
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red.opacity(0.3))
                .frame(width: 300, height: 200)
        }
    }
    
    private var navBarLayer: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.blue)
    }
}
```

<br>

<br>
<img width="40%" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/108869319/bfac270a-7dde-434f-b79e-9e7ef0aef0e3"/>

<br>




<br>

```swift
//
//  SwiftUIViewOffsetPreferenceKeyBootCamp.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/07/19.
//

import SwiftUI

// *** 1. Preference Key 정의
struct ScrollViewOffsetPreferenceKey: PreferenceKey { 
    
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ScrollViewOffsetPreferenceKeyBootCamp: View {
    
    let title: String = "New title here!!!!"
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack {
                titleLayer
                    .opacity(Double(scrollViewOffset) / 63.0) // *** 3.데이터 사용 scrollViewOffset이 적어질 수록 타이틀이 사라지게 됨
                    .background(
                        GeometryReader { geo in // 지오메트리로 옵셋 값 확인 *(3)
                            Text("")
                                .preference(key: ScrollViewOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
                        }
                    )
                
                contentLayer
            }
            .padding()
        }
        .overlay(Text("\(scrollViewOffset)")) // 스크롤 뷰 옵셋 확인용


				// *** 2. 데이터 수집:
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self, perform: {
            value in
            scrollViewOffset = value
						// scrollViewOffset의 업데이트 값을 계속해서 가져옴
        })
        .overlay(navBarLayer  // scrollViewOffset 값이 40보다 클 경우 네비게이션 바 사라짐!
            .opacity(scrollViewOffset < 40 ? 1.0 : 0.0) // opacity = 0 으로 만들어서 제거!
        , alignment: .top)
    }
}

struct ScrollViewOffsetPreferenceKeyBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewOffsetPreferenceKeyBootCamp()
    }
}

extension ScrollViewOffsetPreferenceKeyBootCamp {
    private var titleLayer: some View { // 타이틀
        Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var contentLayer: some View { // 스크롤뷰 컨텐츠
        ForEach(0..<30) { _ in
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red.opacity(0.3))
                .frame(width: 300, height: 200)
        }
    }
    
    private var navBarLayer: some View { // 네비바
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.blue)
    }
}
```

<br>


