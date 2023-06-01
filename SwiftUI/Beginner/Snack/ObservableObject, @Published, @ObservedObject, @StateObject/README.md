# ObservableObject, @Published, @ObservedObject, @StateObject
- 뷰모델을 분리하기 위해 객체의 상태를 관찰하고 업데이트할 수 있는 프로토콜과, 프로퍼티 래퍼

### 코드 분리의 필요성
- 코드의 양이 많아지고 복잡해짐에 따라 협업과 유지보수, 확장성 측면에서 코드를 분리하여 관리해야 한다.
- 코드의 각 목적에 따라 데이터 모델, 인터페이스 뷰, 데이터 기능 등 세 부분으로 나눌 수 있다.
```swift
// 데이터 모델 부분
struct FruitModel: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let count: Int
}

struct ViewModelStudy: View {
    
    @State var fruitArray: [FruitModel] = [
        FruitModel(name: "Apple", count: 5)
    ]
    
    // 인터페이스 뷰 부분
    var body: some View {
        NavigationStack {
            List {
                ForEach(fruitArray) { fruit in
                    HStack {
                        Text("\(fruit.count)")
                            .foregroundColor(.red)
                        Text(fruit.name)
                    }
                }
                .onDelete { indexSet in
                    deleteFruit(index: indexSet)
                }
            }
            .onAppear {
                getFruits()
            }
        }
    }
    
    // 로직 및 기능 부분
    func getFruits() {
        let fruit1 = FruitModel(name: "Banana", count: 7)
        let fruit2 = FruitModel(name: "Carrot", count: 3)
        fruitArray.append(fruit1)
        fruitArray.append(fruit2)
    }
    func deleteFruit(index: IndexSet) {
        fruitArray.remove(atOffsets: index)
    }
}
```
![](https://velog.velcdn.com/images/snack/post/e188fd4d-3617-4cf2-a9c1-84f7d73053b0/image.png)

>**MVVM Architecture**
SwiftUI에서는 보통 MVVM 디자인 패턴에 따라 코드를 분리하여 관리한다.

![](https://velog.velcdn.com/images/snack/post/57bda0a1-6d60-4b9b-9e6b-5f8903d4d63e/image.png)

### 데이터 모델 분리(Model)
- 앱에 필요한 데이터를 `Array`, `Struct`등으로 분리하여 관리한다.
```swift
struct FruitModel: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let count: Int
}
```

### 로직 및 기능 분리(ViewModel)
- 앱에 필요한 로직 및 기능들을 `Class`를 통해 분리하여 관리한다.
- 이 때 뷰모델은 `ObservableObject` 프로토콜을 채택(Class에서만 가능)하여 데이터 모델을 관찰하고 변경사항을 뷰에 알리는 역할을 한다.
- 뷰모델 내의 프로퍼티는 `@Published`를 통해 선언한다.

>**@Published**
해당 객체에 변경사항이 있을 때 자동으로 뷰에 알리고, 뷰를 업데이트하는 역할을 한다.


```swift
class FruitViewModel: ObservableObject {
    
    // 데이터 모델 관찰
    @Published var fruitArray: [FruitModel] = [
        FruitModel(name: "Apple", count: 5)
    ]
    
    init() {
        getFruits()
    }
    
    func getFruits() {
        let fruit1 = FruitModel(name: "Banana", count: 7)
        let fruit2 = FruitModel(name: "Carrot", count: 3)
        fruitArray.append(fruit1)
        fruitArray.append(fruit2)
    }
    func deleteFruit(index: IndexSet) {
        fruitArray.remove(atOffsets: index)
    }
}
```

### 인터페이스 뷰 분리(View)
- 사용자가 직접 보고 인터랙션하는 부분을 `View`를 통해 분리하여 관리한다.
- 이 때 분리한 뷰모델을 `@ObservedObjcet`를 통해 관찰 가능한 인스턴스로 생성한다.
```swift
struct ViewModelStudy: View {
    
    // 뷰모델이 관찰 가능한 인스턴스
    @ObservedObject var fruitViewModel: FruitViewModel = FruitViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(fruitViewModel.fruitArray) { fruit in
                    HStack {
                        Text("\(fruit.count)")
                            .foregroundColor(.red)
                        Text(fruit.name)
                    }
                }
                .onDelete(perform: fruitViewModel.deleteFruit)
            }
        }
    }
}
```

### @ObservedObject와 @StateObject
- `@ObservedObject`와 `@StateObject` 모두 기본적으로 뷰 내부에서 관찰 가능한 객체의 인스턴스를 저장하기 위해 사용된다.

|차이|@ObservedObject|@StateObject|
|---|---|---|
|데이터 변화|데이터 변화가 있을 때 뷰를 처음부터 다시 그린다.|데이터 변화가 있을 때 변화가 있는 부분의 뷰만 다시 그린다.
|생명주기|뷰가 사라지고 다시 그려짐에 따라, 인스턴스도 사라지고 다시 생성된다.|초기에 인스턴스가 생성되고 뷰와 상관없이 유지된다.|
|사용|보통 다루는 데이터가 달라지는 하위 뷰에서 사용한다.|보통 데이터를 유지해야하고 초기에 생성되는 상위 뷰에서 사용된다.|
```swift
struct ViewModelStudy: View {
    
    // 초기에 생성되는 상위 뷰이므로 @StateObject 인스턴스
    @StateObject var fruitViewModel: FruitViewModel = FruitViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(fruitViewModel.fruitArray) { fruit in
                    HStack {
                        Text("\(fruit.count)")
                            .foregroundColor(.red)
                        Text(fruit.name)
                    }
                }
                .onDelete(perform: fruitViewModel.deleteFruit)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        // 하위 뷰 이동 및 동일한 뷰모델(데이터) 전달
                        RandomScreen(fruitViewModel: fruitViewModel)
                    } label: {
                        Image(systemName: "arrow.right")
                    }

                }
            }
        }
    }
}

struct RandomScreen: View {
       
    // 하위 뷰이므로 @ObservedObject 인스턴스
    @ObservedObject var fruitViewModel: FruitViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            ForEach(fruitViewModel.fruitArray) { fruit in
                Text(fruit.name)
            }
        }
    }
}
```
![](https://velog.velcdn.com/images/snack/post/f103807a-6945-4143-bb31-bc85dc9b7d6b/image.png)
