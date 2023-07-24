# **#8 Generics**


## 1) Array도 generic 타입이다. 

```swift
//vm
class GenericsViewmodel: ObservableObject {
//ObservableObject 프로토콜 채택한 객체는 관찰 가능한 속성을 가짐
    
    @Published var dataArray: [String] = []
    //@Published 데이터가 바뀔 때마다 GenericsViewmodel을 다시 그리게 된다.
    
    init() { 
        dataArray = ["one", "two", "three"]
    }
    
    func removeDataFromDataArray() {
        dataArray.removeAll()
    }
}

//view
struct Generics: View {
    
    @StateObject private var vm = GenericsViewmodel()
    
    var body: some View {
        VStack {
            ForEach(vm.dataArray, id: \.self) { item in
                Text(item)
                    .onTapGesture {
                        vm.removeDataFromDataArray()
                    }
            }
        }
    }
}
```

<img width="713" alt="스크린샷 2023-07-18 오후 11 22 34" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/dd9ee914-6529-451a-9227-d26fe82676dc"><br>
클릭하면 사라지는 뷰

- removeAll 함수는 어떤 dataArray배열이 어떤 타입이든지 쓰일 수 있다. 

- 왜냐하면 배열타입이 제네릭 타입을 포함하기 때문에 배열 안에 어떤 타입을 넣어도 함수가 작동한다.


<br>
<br>


## 제네릭 타입을 가지는 제네릭 모델 형성

string 타입을 가지는 model
```swift
//model
struct StringModel {
    
    let info: String?
    
    func removeInfo() -> StringModel {
        StringModel(info: nil)
    }
}

//viewModel
class GenericsViewmodel: ObservableObject {

    @Published var stringModel = StringModel(info: "Hello, world!")
    
    func removeData() {
        stringModel = stringModel.removeInfo()
    }
    
}

//view
struct Generics: View {
    
    @StateObject private var vm = GenericsViewmodel()
    
    var body: some View {
        VStack {
            Text(vm.stringModel.info ?? "no data")
                .onTapGesture {
                    vm.removeData()
                }
        }
    }
}
```
<img width="709" alt="스크린샷 2023-07-19 오전 12 16 00" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/73c53ad3-28af-4fdd-8555-a67f6c25aa4d">

💡 같은 struct과 데이터 모델에서 string타입 대신 bool타입을 가져가고 싶다면?<br>
bool 타입의 info를 가진 BoolModel struct를 새로 만들고 bool 타입 버전의 뷰모델과 뷰를 그리는 방법이 있지만 비효율적임. 

그래서 제네릭 모델을 만들게 되면 무슨 타입이든 포함하는 제네릭 타입을 가질 수 있다. 

<br>
<br>

```swift
struct GenericModel<CustomType> {

    let info: CustomType?

//struct GenericModel<T>  //실무에선 이렇게 많이 쓰인다. type을 뜻함
//  let info: T?
    
    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
    }
}


class GenericsViewmodel: ObservableObject {

    @Published var genericStringModel = GenericModel(info: "Hello, world!")
    @Published var genericBoolModel = GenericModel(info: true)
    //같은 모델을 쓰면서도 다른 타입의 info를 적을 수 있다. 다른 타입도 같은 방식으로 적용됨. 
    
    func removeData() {
        genericStringModel = genericStringModel.removeInfo()
        genericBoolModel = genericBoolModel.removeInfo()
    }
    
}


struct Generics: View {
    
    @StateObject private var vm = GenericsViewmodel()
    
    var body: some View {
        VStack {
            Text(vm.genericStringModel.info ?? "no data")
            Text(vm.genericBoolModel.info?.description ?? "no data")
        }
        .onTapGesture {
            vm.removeData()
        }
    }
}
```
<img width="1282" alt="스크린샷 2023-07-19 오전 12 41 42" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/aa2c14c8-0962-45e6-909c-1c59a248ff95">


<br>
<br>
<br>

## 프로토콜을 형식을 따르는 제네릭 타입

```swift
struct GenericView: View {
    
    //let content: View
    let title: String
    
    var body: some View {
        Text(title)
    }
}
``````
다른 뷰에 컨텐츠를 전달하고 싶을 때 view 프로토콜을 타입으로 쓰려면 제네릭 타입을 지정해주면 된다. 

```swift
struct GenericView<T:View>: View {
//:View라고 쓰지 않으면 오류가 남. 제네릭 타입이 view 프로토콜을 따른다고 써주면 다른 타입들은 쓰지 못하게 제한할 수 있다. 
    
    let content: T
    let title: String
    
    var body: some View {
        Text(title)
        content
    }
}

struct Generics: View {
    
    @StateObject private var vm = GenericsViewmodel()
    
    var body: some View {
        VStack {
            GenericView(content: Text("hi~"), title: "New View!")
        }
    }
}
```



- view 프로토콜을 따르기 때문에 스크린에 직접적으로 컨텐츠로 넣을 수 있다.
text 뿐만아니라 screen, button 등 뷰에 해당되는 어떤 종류든지 content안에 들어갈 수 있다. 

- String, Bool 같은 다른 타입은 view 프로토콜을 따르지 않기 때문에 여기서는 쓸 수 없다. 