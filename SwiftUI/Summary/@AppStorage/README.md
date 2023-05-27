# @AppStorage
- 사용자 설정과 같은 간단한 데이터를 저장하고 검색할 수 있는 프로퍼티 래퍼

### UserDefaults
- 앱의 설정 데이터, 사용자 기본값 같은 간단한 상태 정보 등을 저장하고 검색하는 데 사용되는 인터페이스이다.
- `key-value` 형식으로 데이터를 저장하며, 각 데이터 항목에는 유일한 키와 해당 데이터의 값이 포함된다.
```swift
// 값 저장
UserDefaults.standard.set(true, forKey: "isOnboardingShown")
UserDefaults.standard.set(10, forKey: "tapCount")
UserDefaults.standard.set("Snack", forKey: "userName")

// 값 검색
let isOnboardingShown = UserDefaults.standard.bool(forKey: "isOnboardingShown") // true
let tapCount = UserDefaults.standard.integer(forKey: "tapCount") // 10
let userName = UserDefaults.standard.string(forKey: "userName") // "Snack"
```
- 저장된 데이터는 앱이 종료되어도 유지된다.
```swift
struct AppStorageStudy: View {
    
    @State var currentUserName: String?
    
    var body: some View {
        VStack(spacing: 20) {
            Text(currentUserName ?? "DefaultName")
            Button("Save") {
                // 저장할 데이터
                let name: String = "Snack"
                currentUserName = name
                // 키 값으로 데이터 저장
                UserDefaults.standard.set(name, forKey: "userName")
            }
        }
        .onAppear {
            // 키 값에 따른 데이터 검색
            currentUserName = UserDefaults.standard.string(forKey: "userName")
        }
    }
}
```

### @AppStorage
- `@AppStorage`를 사용하면 영구적으로 유지할 데이터가 `UserDefaults`에 자동으로 저장되고 검색할 수 있다.
- `@AppStorage` 키워드와 함께 해당 데이터를 식별할 키값을 같이 선언한다.
```swift
struct AppStorageStudy: View {
    // 키 값으로 데이터 저장
    @AppStorage("userName") var currentUserName: String?
    
    var body: some View {
        VStack(spacing: 20) {
            Text(currentUserName ?? "DefaultName")
            Button("Save") {
                let name: String = "Snack"
                currentUserName = name
            }
        }
    }
}
```
- `@AppStorage`로 선언된 프로퍼티는 값을 읽거나 변경할 때마다 `UserDefaults`가 자동으로 업데이트되고 해당 값을 사용할 수 있다.
