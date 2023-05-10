# @FocusState

## 사용 이유
- 텍스트 필드와 같이 포커싱 여부에 따른 키보드 팝업 등 관리를 코드단에서 관리하기 위해서 사용합니다.

<br>

## 사용 방법

<img width="679" alt="스크린샷 2023-05-10 오후 11 21 14" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/48616183/9f1472c5-6b26-443d-a543-bda60f41a05d">

<br>

### 1. focused(_ condition)
-   Boolean 타입의 @FocusState를 바인딩하여 포커스를 감지할 수 있다.

### 2. focused(_ bindnig:equals:)
-   Enum을 이용한 @FocusState를 바인딩하여 , equals에 지정된 특정 case가 될 때 focus를 준다. 
**여기서 중요한 것은 해당 Enum은 **Hashable**을 채택해야한다.**

<br><br>

### 1. focused(_ condition)

```swift
struct ContentView: View {
    
    @State var text:String = ""
    @FocusState private var nameIsFocus: Bool
    
    var body: some View {
        VStack{
            TextField("Name",text:$text)
                .focused($nameIsFocus) //  자동으로 텍스트 필드 focus를 감지함
                .padding(.leading)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
            
            
            Button {
                nameIsFocus = false // 버튼을 통해 포커싱 해제
            } label: {
                Text("Hide Keyboard")
            }

        }
        .padding(40)

    }

}
```

<br><br>

<p align ="center"> <img height = "400" src ="https://github.com/yongbeomkwak/SwiftUI-Study/assets/48616183/2280caf7-10cd-411a-bfa4-2dcaaff0ed72"> </p>


<br><br>

### 2. focused(_ condition)
```swift
struct ContentView: View {
    
    enum FocusField:Hashable {
        case textField1
        case textField2
    }
    
    
    @State var text:String = ""
    @State var text2:String = ""
    @FocusState private var focusField:  FocusField?
    
    var body: some View {
        VStack{
            TextField("Name",text:$text)
                .focused($focusField, equals: .textField1) // 현재 focusField 값이 , .textField1 이면 포커싱
                .padding(.leading)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
            
            TextField("Name2",text:$text2)
                .focused($focusField, equals: .textField2)// 현재 focusField 값이 , .textField2 이면 포커싱
                .padding(.leading)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
            
            
            Button {
                focusField = .textField2
            } label: {
                Text("Change focus to textField2")
            }

        }
        .padding(40)

    }

}
```

<br><br>

<p align ="center"> <img height = "400" src ="https://github.com/yongbeomkwak/SwiftUI-Study/assets/48616183/0a6dc3c3-8f5f-4e42-868a-bf3d6b1b5fd7"> </p>



