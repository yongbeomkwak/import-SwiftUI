# @EnvironmentObject
- 앱 전역에서 공유되는 객체 데이터를 설정할 수 있는 프로퍼티 래퍼

### 뷰 간 데이터 공유
- `ObservableObject`를 채택한 객체 데이터를 `@StateObject`와 `@ObservedObject`를 통해 뷰 간에 공유할 수 있다.
- 하지만 이 방법은 직접적으로 데이터를 사용하지 않더라도 전달만을 위해 인스턴스를 생성해야하는 상황이 발생한다.
```swift
// 공유할 데이터
class EnvironmentViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    init() {
        getData()
    }
    
    func getData() {
        self.dataArray.append(contentsOf: ["iPhone", "iPad", "iMac"])
    }
}

// 첫 번째 뷰
struct FirstView: View {
    
    // 데이터 생성
    @StateObject var viewModel: EnvironmentViewModel = EnvironmentViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.dataArray, id: \.self) { item in
                    NavigationLink {
                        SecondView(viewModel: viewModel, selectedItem: item)
                    } label: {
                        Text(item)
                    }
                }
            }
        }
    }
}

// 두 번째 뷰
struct SecondView: View {
    
    // 불필요한 데이터 전달
    @ObservedObject var viewModel: EnvironmentViewModel
    let selectedItem: String
    
    var body: some View {
        NavigationLink {
            ThirdView(viewModel: viewModel)
        } label: {
            Text(selectedItem)
        }
    }
}

// 세 번째 뷰
struct ThirdView: View {
    
    // 데이터 공유
    @ObservedObject var viewModel: EnvironmentViewModel

    var body: some View {
        ForEach(viewModel.dataArray, id: \.self) { item in
            Text(item)
        }
    }
}
```
![](https://velog.velcdn.com/images/snack/post/5b9de427-15ff-448a-8b47-921a6de75939/image.png)

### @EnvironmentObject
- `@StateObject`로 생성한 객체 데이터를 `.environmentObject()`를 통해 하위 뷰 전역에 공유할 수 있다.
- 공유 받은 하위 뷰에서는 데이터가 필요한 특정 뷰까지의 불필요한 전달없이 `@EnvironmentObject`를 통해 바로 사용할 수 있다.
```swift
struct FirstView: View {
    
    // 데이터 생성
    @StateObject var viewModel: EnvironmentViewModel = EnvironmentViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.dataArray, id: \.self) { item in
                    NavigationLink {
                        SecondView(selectedItem: item)
                    } label: {
                        Text(item)
                    }
                }
            }
        }
        // 하위 뷰 전역에 데이터 공유
        .environmentObject(viewModel)
    }
}

struct SecondView: View {
    
    // 불필요한 전달 없음
    let selectedItem: String
    
    var body: some View {
        NavigationLink {
            ThirdView()
        } label: {
            Text(selectedItem)
        }
    }
}

struct ThirdView: View {
    
    // 데이터 공유
    @EnvironmentObject var viewModel: EnvironmentViewModel
    
    var body: some View {
        ForEach(viewModel.dataArray, id: \.self) { item in
            Text(item)
        }
    }
}
```
![](https://velog.velcdn.com/images/snack/post/bb522be3-3afb-48bf-9e04-79669eaede2a/image.png)
