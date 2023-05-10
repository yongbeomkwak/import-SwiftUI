# Picker

## 정의

선택지가 정해져 있고 거기에서 하나의 요소를 선택할 때 사용한다.

<br>
<br>

## 구성 요소

Picker(title: StringProtocol, selection: Binding Hashable, content: View)

- title: Label과 같은 역할 
- selection: 현재 선택된 것을 가르킬 Binding 가능 변수
- content: 피커 안에서 보여 줄 요소


## 종류

### 1. WheelPickerStyle
- 이름에서 유추할 수 있게 바퀴 처럼 감싸지는 느낌의 피커 스타일 입니다.

```swift

struct ContentView: View {
    
    @State var selectedNumber:Int = 0

    
    
    var body: some View {
        VStack
        {
            Text("\(selectedNumber)")
            
            
            
            Picker("랜덤 숫자", selection: $selectedNumber) {
                ForEach((0..<10)) { i in
                    Text("\(i)")
                        .foregroundColor(.red)
                        .tag(i) // 유니크한 id 값을 부여
                }
            }
            .pickerStyle(WheelPickerStyle())
            .background(Color.gray.opacity(0.5))
        }
    }

}

```

<br><br>

<p align = "center"> <img height = "400" src="https://github.com/wakmusic/wakmusic-iOS/assets/48616183/4774dcf0-eb51-4ac4-9baf-b164c9cfa580"> </p>

<br><br>

### 2. MenuPickerStyle
- 컨텍스트 메뉴와 같은 느낌입니다
- 처음 버튼에 보여지는 요소는 배열의 첫 번째 값입니다.

```swift
import SwiftUI

struct ContentView: View {
    
    @State var selected:String = ""
    
    let category:[String]  = ["포항","서울","인천"]
    
    
    var body: some View {
        VStack
        {
            Text("\(selected)")
            
            
            
            Picker("랜덤 숫자", selection: $selected) {
                ForEach(category,id: \.self) { cat in
                    Text("\(cat)")
                        .foregroundColor(.red)
                        .tag(cat) // 유니크한 id 값을 부여
                }
            }
            .pickerStyle(MenuPickerStyle())
            
        }
    }

}
```

<br><br>

<p align = "center"> <img height = "400" src="https://github.com/wakmusic/wakmusic-iOS/assets/48616183/0391d2af-5677-4acb-8ba9-fe2055a8ded3"> </p>

<br><br>

### 2. SegmentedPickerStyle
- 탭 타입의 피커 스타일 입니다.

```swift
import SwiftUI

struct ContentView: View {
    
    @State var selected:String = ""
    
    let category:[String]  = ["포항","서울","인천"]
    
    
    var body: some View {
        VStack
        {
            Text("\(selected)")
            
            
            
            Picker("랜덤 숫자", selection: $selected) {
                ForEach(category,id: \.self) { cat in
                    Text("\(cat)")
                        .foregroundColor(.red)
                        .tag(cat) // 유니크한 id 값을 부여
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
        }
    }

}

```

<br><br>

<p align = "center"> <img height = "400" src="https://github.com/wakmusic/wakmusic-iOS/assets/48616183/857ba203-f922-4e27-b7ca-c96d67e5a34f"> </p>
