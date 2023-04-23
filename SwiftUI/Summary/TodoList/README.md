# TODO List

## 목차
1. [UI](#uiview)
2. [Model](#model)
3. [ViewModel](#viewmodel)

---

<br>

## UI(View)
### 1. List
```swift
List {
    ForEach(items,id: \.self){ item in
            ListRowView(title: item)
            
        }
}
        .listStyle(PlainListStyle()) // 밑줄 구분자 있는 스타일


```

<br>

### 2. NavigationView
```swift
.navigationTitle("Todo List ✏️")
.toolbar {
    ToolbarItem(placement:.navigationBarLeading) {
        EditButton()
    }
    
    ToolbarItem(placement:.navigationBarTrailing) {
        NavigationLink("Add", destination: {
            AddView()
        })
    }
}
```

---

<br>

## Model
```swift
struct ItemModel:Identifiable {
    
    let id:String = UUID().uuidString
    let title: String
    let isCompleted: Bool
    
    
}
```

### 1. Identifiable 프로토콜
- 채택하면 해쉬 타입으로 만들어줌

### 2. UUID
- 해쉬 아이디값 만들어줌

---
<br>

## ViewModel

### `ObservableObject` 프로토콜

-   정의

    ```swift

    이 프로토콜을 채택하면 말그대로 관측할 수 있는 객체가 되고, objectWillChange 라는 Publisher를 가지고 있게 된다. 
        
    이 Publishser에는 개발자가 직접 접근할 일은 매우 적어서, 사실상 잊고 살아도 무방하긴 하다.
        
    위에 있는 @Published 프로퍼티 래퍼가 붙어있는 변수가 변경될 때 objectWillChange Publisher가 할 일이 생긴다.

    View 계층에서 이 ViewModel을 바라보고 있고, 그 중에서도 @Published 프로퍼티 래퍼를 사용하고 있다면 Publisher의 영향을 받는다.
        
    해당 변수 가 변화하면, 이를 지켜보고 있는 View에게 ViewModel이 변경되었음을 알려주고, View는 새로운 객체를 바탕으로 View를 refresh한다.

    ```

<br>

### `@ObservedObject` 프로퍼티 래퍼

-   ObservedObject에서 가끔 만나는 문제점 🆘
    
    상황
    
    -   상위의 State 변수가 변화하면, 해당 변수를 사용하고 있는 하위 View들은 모두 초기화된다. 
    -   그러면 하위에 있떤 ViewModel 도 초기화된다.

<br><br>

### `@StateObject` 프로퍼티 래퍼

-   이런 문제점을 애플도 인식하고 있어서인지, iOS 14부터는 StateObject가 등장했다.

-   StateObject의 공식 문서의 소개는 아래처럼 되어있다.
    >   A state object behaves like an observed object, except that SwiftUI knows to create and manage a single object instance for a given view instance, regardless of how many times it recreates the view.

- 이 문장을 보면 StateObject는 ObservedObject와 거의 똑같으나, 이 StateObject는 하나의 객체로 만들어지고, View가 얼마나 초기화되든지 상관없이 별개의 객체로 관리된다.

-   StateObject로 생성된 객체는 View의 라이프 사이클에 상관없이, SwiftUI가 View와 별개의 메모리 공간에 저장해 데이터를 안전하게 보관하도록 할 것이다.

- 애플이 추천하는 StateObject와 ObservedObject의 사용법은 Observable Object를 처음 초기화할 때는 StateObject를 사용하고, 이미 객체화된 것을 넘겨 받을 때 ObservedObject의 사용을 추천하고 있다. 약간 아래와 같은 느낌일 것이다.

<br>

```swift
struct UpperView: View {
  @StateObject var viewModel: ViewModel = ViewModel()
  var body: some View {
    LowerView(viewModel: viewModel)
  }
}
struct LowerView: View {
  @ObservedObject var viewModel: ViewModel
  var body: some View {
    Text("Hello")
  }
}
```

-   이런 식으로 상위 View에서 객체로 만들어서 따로 저장해두고, 하위 View도 이 Observable Object의 변화를 감지하고, 같은 정보에 접근할 수 있도록 할 수 있을 것이다.

-   약간 State-Binding 관계와 StateObject-ObservedObject 관계가 유사하다고 생각할 수 있을 것 같다. Binding을 먼저 만들고 State를 만드는 느낌

-  #### 결론
    -   StateObject는 ObservedObject 와 같이 동작합니다. 
    - 차이점은 SwiftUI가 뷰를 몇번이나 다시 만드는 지 상관없이 주어진 view instance에 대해 single object instance를 만들고 관리한다는 점입니다. 

