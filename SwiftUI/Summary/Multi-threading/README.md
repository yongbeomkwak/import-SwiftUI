# Multi Thread

### 들어가기 전 알아야할 개념
- 스레드(thread)란 프로세스(process) 내에서 실제로 작업을 수행하는 주체를 의미합니다.

- 모든 프로세스에는 한 개 이상의 스레드가 존재하여 작업을 수행합니다.

- 또한, 두 개 이상의 스레드를 가지는 프로세스를 멀티스레드 프로세스(multi-threaded process)라고 합니다.

<br>

## 코드 구성

### View
```swift
struct ContentView: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        
        ScrollView{
            
            VStack(spacing:10){
                Text("Load data".capitalized)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray,id: \.self) { item in
                    
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                    
                }
            }
            
        }
            
    }
}
```

<br>

### ViewModel
```swift
lass BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    
    func fetchData() {
        
        let newData = downloadData()
        dataArray = newData
    }
}
```

<br><br>

해당 탭을 이용하면 CPU 상황을 볼 수 있다.

<img width="270" alt="스크린샷 2023-06-08 오전 11 51 39" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/48616183/2dd5cd39-74ad-4a48-92ec-4a178c544d7e">

<br><br>

### 1. 메인스레드

<br>

```swift
  func fetchData() {
        
        let newData = downloadData()
        dataArray = newData
}

```

해당 코드는 따로 스레드를 지정해주지 않아, 메인 스레드 실행된다.

그러면 다음과 같은 결과를 얻게 된다.

<br>

![ezgif com-video-to-gif](https://github.com/yongbeomkwak/SwiftUI-Study/assets/48616183/c4bb4266-1b9b-4846-a4d8-cfd55a1d8815)


<br>

### 해석
    위 영상을 보면 , LoadData를 누를 때 그래프가튀고 스크롤하면 또 굉장히 많이 튄다.
    MainThread는 UI와 굉장히 밀접한 관련이 있는 스레드이다.
    그러므로 MainThread에 무거운 작업이 실행되면, 
    유저가 느끼는 앱의 속도가 굉장히 저하된다.

<br><br>

### 별도의 백그라운드 스레드

<br>

```swift
DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            self.dataArray = newData
}
```
<br>

![ezgif com-video-to-gif (1)](https://github.com/yongbeomkwak/SwiftUI-Study/assets/48616183/ee56d06a-dcc8-4c8e-b769-32f29db931d5)

### 해석
    위 영상을 보면 , LoadData를 누를 때 그래프가튀고 Thread9가 생긴 후 그래프가 튄다.
    데이터를 별도의 스레드를 이용해서 가져오는 것을 확인할 수 있다.

<br><br>

**하지만 여기서 중요한 에러가나온다.**

<img width="1014" alt="스크린샷 2023-06-08 오후 12 09 44" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/48616183/eed6ca77-2d3b-43fc-b8b7-a465264fe5db">

<br>

해당 에러는 UI작업은 mainThread에서 반드시 하라고 나온다.

그렇다면 어디에 UI 작업이 있었을까?

<br>

### 수정 전 코드

```swift
DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()

    //여기서 dataArray는 Published 이므로 UI와 밀접환 관계가 있는 변수이다. 
     //그렇기 때문에 해당 코드가 Main Thread에서 실행되야한다.
            self.dataArray = newData
}
```
<br>

### 수정 후 코드

```swift
DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            DispatchQueue.main.async { // 메인스레드
                self.dataArray = newData
            }
            
}
```
<br><br>

### 현재 실행되는 스레드를 알고 싶을 경우

```swift
func fetchData() {
        
    DispatchQueue.global(qos: .background).async {
        print("#1 is MainThread: \(Thread.isMainThread)")
        print("#1 CurrentThread: \(Thread.current)")
        let newData = self.downloadData()
        
        DispatchQueue.main.async {
            print("#2 is MainThread: \(Thread.isMainThread)")
            print("#2 CurrentThread: \(Thread.current)")
            self.dataArray = newData
        }
        
    }
}

```

<img width="563" alt="스크린샷 2023-06-08 오후 12 21 38" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/48616183/ff1c90f7-83cd-45b1-9d91-61e1c3a69946">


<br><br>

### DispatchQueue 종류

1. main queue (serial queue)
2. global queue (concurernt, qos 설정 가능)
3. custom queue (디폴트는 serial이며 concurrent로 변경 가능)
         

<br>

#### DispatchQoS.QoSClass 종류

```swift
// 애니메이션과 같은 UI 즉시 업데이트가 필요하며, 멈춘것처럼 보이지 않는 작업들 (유저의 반응)
DispatchQueue.global(qos: .userInteactive)

// 저장된 문서를 열거나, 유저가 무언가 클릭했을 때 작업을 수행하고 즉각 보여주어야 하는 것 (몇초)
DispatchQueue.global(qos: .userInitiated)

// 기본 서비스 (일반적인 경우 - userInitiated와 utility의 중간정도의 우선순위)
DispatchQueue.global(qos: .default)

// 보통 프로그레스바를 같이 사용하는 작업
DispatchQueue.global(qos: .utility)

// 유저에게 표시되지 않는 동기화, 안정화, 백업과 같은 일
DispatchQueue.global(qos: .background)
```
<br>

qos에 따라 다른 내부 동작 방법

우선순위가 높은 작업일수록 해당 작업이 빠르게 실행도려고 하고, 우선순위가 낮을수록 더 효율적인 CPU 코어를 절약하려고 시도

<br>

#### Custom Queue
- DispatchQueue(label:attributes:) 형태

- label에는 큐의 이름을 정의 (로깅할때 어떤 큐인지 구분에 유리)

- 디폴트는 serial queue이지만 attributes 파라미터에 .concurrent를 넣으면 concurrent queue로 사용

```swift
let mySerialQueue = DispatchQueue(label: "myQueue")
let myConcurrentQueue = DispatchQueue(label: "myQueue", attributes: .concurrent)
```
