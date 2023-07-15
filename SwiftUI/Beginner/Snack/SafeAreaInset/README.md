# SafeAreaInset
- 디바이스 화면 SafeArea에 콘텐츠 뷰 추가

### safeAreaInset
- 디바이스 화면의 가장자리 등 SafeArea에 여백을 추가하여 뷰를 배치할 수 있다.
```swift
struct SafeAreaInsetStudy: View {
    var body: some View {
        NavigationStack {
            List(0..<10) { _ in
                Rectangle()
                    .frame(height: 200)
            }
            .navigationTitle("Safe Area")
            // 하단 SafeArea에 뷰 추가
            .safeAreaInset(edge: .bottom, alignment: .center, spacing: nil) {
                Button("test") {
                    // test button code
                }
                .frame(maxWidth: .infinity)
                .background(Color.green)
            }
        }
    }
}
```
![](https://velog.velcdn.com/images/snack/post/0d34550a-5a68-4db5-9175-413862dc56f8/image.png)
- `navigationTitle`이 존재하는 상황에서 상단에 뷰를 추가할 경우, `navigationTitle` 영역을 포함한다.
```swift
struct SafeAreaInsetStudy: View {
    var body: some View {
        NavigationStack {
            List(0..<10) { _ in
                Rectangle()
                    .frame(height: 200)
            }
            .navigationTitle("Safe Area")
            // 상단 SafeArea에 뷰 추가
            .safeAreaInset(edge: .top, alignment: .center, spacing: nil) {
                Button("test") {
                    
                }
                .frame(maxWidth: .infinity)
                .background(Color.green)
            }
        }
    }
}
```
![](https://velog.velcdn.com/images/snack/post/5cfd948e-b816-40f8-9b91-5f227ec0aba4/image.png)
- 그러나 추가하는 뷰 하단의 SafeArea를 무시하는 경우, `navigationTitle` 영역을 포함하지 않는다.
```swift
struct SafeAreaInsetStudy: View {
    var body: some View {
        NavigationStack {
            List(0..<10) { _ in
                Rectangle()
                    .frame(height: 200)
            }
            .navigationTitle("Safe Area")
            .safeAreaInset(edge: .top, alignment: .center, spacing: nil) {
                Button("test") {
                    // test button code
                }
                .frame(maxWidth: .infinity)
                // 추가하는 뷰 하단의 SafeArea 무시
                .background(Color.green.edgesIgnoringSafeArea(.bottom))
            }
        }
    }
}
```
![](https://velog.velcdn.com/images/snack/post/2fd3435d-e9ac-4e94-8785-f1133305d597/image.png)
