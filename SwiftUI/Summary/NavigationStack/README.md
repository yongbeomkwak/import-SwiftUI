# NavigationStack
- 화면 간의 이동과 탐색 기록을 관리하는 데 사용되는 스택(stack) 개념의 컨테이너 뷰

### NavigationLink
- 다른 화면으로 이동하며 네비게이션 스택에 새로운 뷰를 푸시(push)하고 이전 뷰로 돌아갈 수 있는 탐색 기능을 제공한다.
```swift
NavigationStack {
    List {
        // 각각의 새로운 뷰로 이동
        NavigationLink("Red", destination: Text("Red"))
        NavigationLink("Green", destination: Text("Green"))
        NavigationLink("Blue", destination: Text("Blue"))
    }
    .navigationTitle("Colors") // 네비게이션 제목
}
```

### NavigationDestination
- `DestinationView`를 `NaviationLink`에서 제시된 데이터 타입과 연결해준다.
```swift
NavigationStack {
    List {
        NavigationLink("Red", value: Color.red)
        NavigationLink("Green", value: Color.green)
        NavigationLink("Blue", value: Color.blue)
    }
    // value 값에 따라 모든 네비게이션의 다음 뷰 지정
    .navigationDestination(for: Color.self, destination: { color in
        ColorDetail(color: color)
    })
    .navigationTitle("Colors")
}
```
- `NavigationLink`에서 제시된 데이터 타입과 `NavigationDestination`의 데이터 타입이 같지 않으면 화면이 이동하지 않는다.
```swift
struct ColorDetail: View {

    var color: Color
    
    var body: some View {
            Text("\(self.color.description)")
    }
}
```
- 데이터 타입이 여러 종류일 경우, `NavigationDestination` 여러 개 사용하면 된다.
```swift
NavigationStack {
    List {
        NavigationLink("Red", value: Color.red)
        NavigationLink("Green", value: Color.green)
        NavigationLink("Blue", value: "blue")
    }
    .navigationDestination(for: Color.self, destination: { color in
        ColorDetailForColor(color: color) // Color 타입
    })
    .navigationDestination(for: String.self, destination: { color in
        ColorDetailForString(color: color) // String 타입
    })
    .navigationTitle("Colors")
}
```

### Navigation State
- `NavigationStack`은 상태를 관리하여 스택 내의 뷰들을 추적 관리할 수 있다.
- `NavigationPath` 타입의 `State`변수를 만들어 화면 간 네비게이션 경로를 저장할 수 있다.
- 스택의 마지막 요소를 제거하여 이전 화면으로 돌아가거나, 스택을 초기화해 최초 뷰로 이동할 수 있다.
```swift
struct NavigationStackStudy: View {
    
    // 네비게이션 경로 추적
    @State var stack: NavigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $stack) {
            List {
                NavigationLink("Red", value: Color.red)
                NavigationLink("Green", value: Color.green)
                NavigationLink("Blue", value: Color.blue)
            }
            .navigationDestination(for: Color.self, destination: { color in
                ColorDetail(stack: $stack, color: color)
                NavigationLink("Yellow", value: Color.yellow) // 무한히 쌓이는 스택

            })
            .navigationTitle("Colors")
        }
    }
}

struct ColorDetail: View {
    
    @Binding var stack: NavigationPath
    var color: Color
    
    var body: some View {
        Text("\(self.color.description)")
        Button("Back") {
            stack.removeLast() // 이전 화면으로 돌아가기
        }
        Button("First") {
            stack = .init() // 최초 화면으로 돌아가기
        }
    }
}
```
- 네비게이션 경로 값을 직접 입력하여 원하는 경로의 뷰로 바로 이동(딥링크) 및 복귀 할 수 있다.
```swift
struct NavigationStackStudy: View {
    
    // 네비게이션 경로 추적
    @State var stack: [Color] = []
    
    var body: some View {
        NavigationStack(path: $stack) {
            List {
                NavigationLink("Red", value: Color.red)
                NavigationLink("Green", value: Color.green)
                NavigationLink("Blue", value: Color.blue)
                Button("Go to Yellow") {
                    // 경로 직접 입력
                    stack = [.red, .green, .blue, .yellow]
                }
            }
            .navigationDestination(for: Color.self, destination: { color in
                ColorDetail(color: color)
            })
            .navigationTitle("Colors")
        }
    }
}

struct ColorDetail: View {
    
    var color: Color
    
    var body: some View {
        Text("\(self.color.description)")
    }
}
```
