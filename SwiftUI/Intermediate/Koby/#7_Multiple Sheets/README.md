# **#7 Multiple Sheetes**

버튼을 누르면 각각 다른 랜덤 시트가 나오도록 만든 코드. 
<br>각 시트의 타이틀인 ONE, TWO가 텍스트로 써져야 하는데 처음 버튼을 클릭하면 "STATING TITLE"이 나오는 문제점. (다시 누를때는 정상 작동함)

```swift
struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title:String
}

struct MultipleSheetes: View {
    
    @State var selectedModel: RandomModel = RandomModel(title: "STARTING TITLE")
    @State var showSheet: Bool = false
    
    var body: some View {
        VStack(spacing:20) {
            Button("Button 1") {
                selectedModel = RandomModel(title: "ONE")   //이거는 메모리에 이렇게 저장한다는 뜻이지? init도 함수니까 이거도 함수인가
                showSheet.toggle()
            }
            Button("Button 2") {
                selectedModel = RandomModel(title: "TWO")
                showSheet.toggle()
            }
        }
        .sheet(isPresented: $showSheet) {
            NextScreen(selectedModel: selectedModel)  //state 프로퍼티도 타입으로 쓸 수 있는거임?
                                                      //selectedModel 타입을 지정해서 변하는 값이 들어가도록 함
        }
    }
    
}

struct NextScreen: View {
    
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}
```

<img width="1417" alt="스크린샷 2023-05-30 오전 12 42 56" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/f3cf8eef-f8fe-42f3-ac2c-dadca94fbede">

문제는 sheet 수정자가 스크린에 추가되는 동시에 nextScreen 컨텐츠가 만들어지기 때문에 일어난다. </br>
그니까 버튼을 누르는 등의 상호작용 전에는 "STARTING TITLE"상태이기 때문에 그렇게 보여지는 것. </br>



그렇기 때문에 sheet의 content 클로저에 로직을 넣는 걸 되도록 피한다.

</br>
</br>
</br>


## 해결방법 **1) Binding** 사용
```swift
struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title:String
}

struct MultipleSheetes: View {
    
    @State var selectedModel: RandomModel = RandomModel(title: "STARTING TITLE")
    @State var showSheet: Bool = false
    
    var body: some View {
        VStack(spacing:20) {
            Button("Button 1") {
                selectedModel = RandomModel(title: "ONE")
                showSheet.toggle()
            }
            Button("Button 2") {
                selectedModel = RandomModel(title: "TWO")
                showSheet.toggle()
            }
        }
        .sheet(isPresented: $showSheet) {
            NextScreen(selectedModel: $selectedModel)  //바인딩한다는 뜻의 $만 붙이면 끝!
        }
    }
    
}

struct NextScreen: View {
    
    // let selectedModel: RandomModel        //상수를 쓰는 대신 
    @Binding var selectedModel: RandomModel  //State 변수에 변화가 생기면 NextScreen에 자동으로 업데이트 되도록 함
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}
```
<img width="1443" alt="스크린샷 2023-05-30 오전 1 20 33" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/b8822e69-64ac-49e5-a4d8-5a1ed70637ae">

문제해결!

</br>
</br>

## 해결방법 **2) Multiple .sheets** 사용
한 위계 당 하나의 .sheet 수정자만 가져야 한다.  
부모-자식 위계가 아니고 같은 레벨에서는 여러 개 가질 수 있음. 

```swift
struct MultipleSheetes: View {
    
    @State var selectedModel: RandomModel = RandomModel(title: "STARTING TITLE")
    @State var showSheet: Bool = false
    @State var showSheet2: Bool = false   //Button 2에대한 isPresented 변수 생성
    
    var body: some View {
        VStack(spacing:20) {
            Button("Button 1") {
                showSheet.toggle()
            }
            .sheet(isPresented: $showSheet) {
                NextScreen(selectedModel: RandomModel(title: "ONE"))  //Button 1에 title "ONE"인 뷰 생성
            }
            Button("Button 2") {
                showSheet2.toggle()
            }
            .sheet(isPresented: $showSheet2) {
                NextScreen(selectedModel: RandomModel(title: "TWO"))  //Button 2에 title "TWO"인 뷰 생성
            }
            }
        }
    }
}

struct NextScreen: View {
    
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}
```


두세개의 아이템일때만 적용할 수 있는 방법. 

</br>
</br>

## 해결방법 3) $item 사용
막 100개의 아이템과 시트가 있을 때에는 매번 .sheet와 변수를 만드는게 불가능함. 
그럴때 이 방법을 사용. 
```swift
        .sheet(isPresented: Binding<Bool>, content: )      //ispresented 매개변수 대신 
        
        .sheet(item: Binding<Identifiable?>, content: )    //item 매개변수를 사용 
```
어떤 변수를 바인딩하는데, 그 변수는 Identifiable하고 Optional임. 

</br>


```swift
struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title:String
}

struct MultipleSheetes: View {
    
    @State var selectedModel: RandomModel? = nil  //옵셔널 사용
    
    var body: some View {
        VStack(spacing:20) {
            Button("Button 1") {
                selectedModel = RandomModel(title: "ONE")
            }
            
            Button("Button 2") {
                selectedModel = RandomModel(title: "TWO")
            }
        }
        .sheet(item: $selectedModel) { model in
            NextScreen(selectedModel: model)
        }
    }
}
```
selectedModel을 업데이트할 때마다, (모델이 바뀔 때마다) 새로 그려주도록 selectedModel을 업데이트함. <br>


</br>
</br>

```swift
            VStack(spacing:20) {
                ForEach(0..<50) { index in
                    Button("Button \(index)") {
                        selectedModel = RandomModel(title: "\(index)")
                    }
                }
            }
            .sheet(item: $selectedModel) { model in
                NextScreen(selectedModel: model)
            }
```
이런식으로 여러개의 아이템에 적용할 수 있다. 

<img width="888" alt="스크린샷 2023-05-30 오전 3 31 20" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/907645c8-fcd6-42c4-9f30-1c779ab2ff1f">