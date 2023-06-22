# Publishers, Subscribers
- 데이터의 흐름을 관찰하고 반응하는 데에 주로 사용되며, 변화하는 데이터를 생성하고 해당 데이터에 대한 응답을 처리

### Publisher, Subscriber
- `Publisher`는 데이터 스트림을 생성하는 타입으로, 특정 데이터 소스에서 새로운 값이나 이벤트를 발생시킬 수 있다.
- `Subscriber`는 `Publisher`에서 발생한 데이터 스트림을 수신하는 타입입니다.
```swift
class SubscriberViewModel: ObservableObject {
    
    @Published var count: Int = 0
    // AnyCancellable 타입의 인스턴스 저장
    var timer: AnyCancellable?
    
    init() {
        setUpTimer()
    }
    
    func setUpTimer() {
        // 시간 간격으로 이벤트를 생성하는 Publisher
        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            // 발생한 이벤트를 수신하여 처리하는 Subscriber
            .sink { [weak self] _ in
                self?.count += 1
                if let count = self?.count, count >= 10 {
                    // 구독 취소 및 이벤트 생성 중단
                    self?.timer?.cancel()
                }
            }
    }
}
```
- `AnyCancellable` 배열과 `store` 메서드를 이용해서 구독 취소와 이벤트 생성을 중단할 수 있다.
```swift
class SubscriberViewModel: ObservableObject {
    
    @Published var count: Int = 0
    // AnyCancellable 타입의 인스턴스들을 저장
    var cancellables = Set<AnyCancellable>()
    
    init() {
        setUpTimer()
    }
    
    func setUpTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                // guard let을 통한 옵셔널 바인딩
                guard let self = self else { return }
                self.count += 1
                if self.count >= 10 {
                    // 구독 취소 및 이벤트 생성 중단
                    for item in self.cancellables {
                        item.cancel()
                    }
                }
            }
            // sink 연산자가 반환하는 AnyCancellable 인스턴스를 cancellables 변수에 저장
            .store(in: &cancellables)
    }
}
```
- `map` 메서드를 이용하여 입력 스트림에서 값을 가져와서 다른 형식이나 다른 값으로 변환할 수 있다.
- `assign` 메서드를 이용하여 `Publisher`의 값을 특정 속성에 할당할 수 있다.
- `sink` 메서드에서는 `[weak self]`를 사용하여 메모리 누수를 방지할 수 있다.
- `debounce` 메서드를 이용하여 최신 값 전달을 입력이 없는 주어진 시간동안 지연시킬 수 있다.
```swift
class SubscriberViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    
    init() {
        addTextFieldSubscriber()
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            // 최신 값 전달 지연
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            // 다른 형식으로 값 변환
            .map { text -> Bool in
                if text.count > 3 {
                    return true
                }
                return false
            }
            // `Publisher`의 값을 특정 속성에 할당
            // .assign(to: \.textIsValid, on: self)
            // [weak self]를 사용하여 메모리 누수를 방지
            .sink(receiveValue: { [weak self] isValid in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
}
```
- `combineLatest` 메서드를 이용해서 두 개 이상의 `Publisher`를 결합하여, 각 `Publisher`의 최신 값을 기반으로 새로운 값을 생성할 수 있다.
```swift
class SubscriberViewModel: ObservableObject {
    
    @Published var count: Int = 0
    var cancellables = Set<AnyCancellable>()
    
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    
    @Published var showButton: Bool = false
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    func setUpTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.count += 1
            }
            .store(in: &cancellables)
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { text -> Bool in
                if text.count > 3 {
                    return true
                }
                return false
            }
        //            .assign(to: \.textIsValid, on: self)
            .sink(receiveValue: { [weak self] isValid in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $textIsValid
            // 두 개의 Publisher 결합
            .combineLatest($count)
            .sink { [weak self] isValid, count in
                guard let self = self else { return }
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
}
```
![](https://velog.velcdn.com/images/snack/post/c458e4b2-8df3-411b-9b7d-4866ae2601f0/image.png)


