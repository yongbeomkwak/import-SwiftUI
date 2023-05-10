# If Let, Guard Let
- 옵셔널 값을 안전하게 추출하는 옵셔널 바인딩 방법

### if let
- 조건문 안의 옵셔널 값이 `nil`인지 체크하고, 각 경우에 대한 처리를 안전하게 수행한다.
- 보통 각 조건에 따른 처리를 위해 사용되지만, `else`문을 생략하고 사용할 수 있다.
- 옵셔널 바인딩 된 상수 `if`문 안에서만 사용할 수 있다.
```swift
struct UnwrapStudy: View {
    
    @State var currentUserID: String? = "Snack"
    @State var displayText: String? = nil
    @State var isLoading: Bool = false
    
    var body: some View {
        VStack {
            // displayText가 nil이 아닌 경우
            if let text = displayText {
                Text(text)
                    .font(.title)
            }
            if isLoading {
                ProgressView()
            }
        }
        .onAppear {
            loadData()
        }
    }
    
    func loadData() {
        // currentUserID가 nil이 아닌 경우
        if let userID = currentUserID {
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                displayText = "The username is \(userID)."
                isLoading = false
            }
        // currentUserID가 nil인 경우
        } else {
            displayText = "There is no user data."
        }
    }
}
```

### guard let
- 블록 내부에서만 사용되며, 옵셔널 값을 체크하여 `nil`인 경우에 대한 처리를 `guard` 절 안에서 바로 수행한다.
- `return`, `break`, `continue`, `throw` 등의 제어문 전환 명령어를 필수로 입력한다.
- 옵셔널 바인딩 된 상수를 `else`문을 제외한 블록 내에서 사용할 수 있다.
- 예외사항 처리를 먼저 수행하여 코드의 안정성과 가독성이 향상된다.
```swift
struct UnwrapStudy: View {
    
    @State var currentUserID: String? = "Snack"
    @State var displayText: String? = nil
    @State var isLoading: Bool = false
    
    var body: some View {
        VStack {
            // displayText가 nil이 아닌 경우
            if let text = displayText {
                Text(text)
                    .font(.title)
            }
            if isLoading {
                ProgressView()
            }
        }
        .onAppear {
            loadData()
        }
    }
    
    func loadData() {
        guard let userID = currentUserID else {
            // currentUserID가 nil인 경우
            displayText = "There is no user data."
            return // 함수 종료
        }
        // currentUserID가 nil이 아닌 경우
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            displayText = "The username is \(userID)."
            isLoading = false
        }
    }
}
```
