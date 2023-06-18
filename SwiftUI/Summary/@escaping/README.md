# @escaping
- 클로저가 함수의 파라미터로 전달될 때 함수를 벗어나서(함수의 실행이 종료된 후) 실행되는 클로저

### Non-Escaping Closure
- 일반적으로 함수의 파라미터로 전달된 클로저는 함수 내에서만 실행되며, 함수의 범위를 벗어나면 자동으로 소멸한다.
```swift
class EscapingViewModel: ObservableObject {
    
    @Published var text: String = "Hello"
    
    func getData() {
        downloadData { data in
            text = data
        }
    }
    
    func downloadData(completion: (_ data: String) -> Void) {
        // 클로저 실행 후 함수 종료
        completion("New Data!")
    }
}
```

### Escaping Closure
- `@escaping` 속성이 지정된 클로저는 함수의 범위를 벗어나도 계속해서 실행될 수 있다.
- 주로 클로저가 비동기(asynchronous) 작업을 수행하는 경우, `@escaping` 속성을 사용하여 클로저가 함수의 범위를 벗어날 수 있도록 허용할 수 있다.
```swift
class EscapingViewModel: ObservableObject {
    
    @Published var text: String = "Hello"
    
    func getData() {
        // 비동기 처리를 위한 약한 참조 처리
        downloadData { [weak self] data in
            self?.text = data
        }
    }
    
    func downloadData(completion: @escaping (_ data: String) -> Void) {
        // 함수 종료 후 2초 뒤 클로저 실행
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completion("New Data!")
        }
    }
}
```

### Model 생성 및 Typealias 활용
- 데이터 모델을 생성하여 여러 데이터에 더 쉽게 접근할 수 있다.
```swift
class EscapingViewModel: ObservableObject {
    
    @Published var text: String = "Hello"
    
    func getData() {
        downloadData { [weak self] DownloadResult in
            // 데이터 접근
            self?.text = DownloadResult.data
        }
    }
    
    func downloadData(completion: @escaping (DownloadResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New Data")
            completion(result)
        }
    }
}

// 데이터 모델 생성
struct DownloadResult {
    let data: String
}
```
- `typealias`를 활용하여 코드를 더 간결하게 정리할 수 있다.
```swift
class EscapingViewModel: ObservableObject {
    
    @Published var text: String = "Hello"
    
    func getData() {
        downloadData { [weak self] DownloadResult in
            self?.text = DownloadResult.data
        }
    }
    
    // 지정한 타입의 클로저 파라미터
    func downloadData(completion: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New Data")
            completion(result)
        }
    }
}

struct DownloadResult {
    let data: String
}

// 임의 타입명 지정
typealias DownloadCompletion = (DownloadResult) -> Void
```
