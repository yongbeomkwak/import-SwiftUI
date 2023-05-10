# OnAppear, OnDisappear
- 뷰가 나타나거나 사라질 때 입력된 코드를 실행

### onAppear
- 뷰가 화면 상에 나타날 때 입력된 코드를 실행한다.
```swift
struct OnAppearStudy: View {
    
    @State var myText: String = "Star Text"
    
    var body: some View {
        Text(myText)
            .font(.largeTitle)
            // 뷰가 나타난 직후 해당 코드 실행
            .onAppear(perform: {
                // 3초 후 해당 코드 실행
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    myText = "Next Text"
                }
            })
    }
}
```
- LazyVStack으로 화면에 나타난 후에 데이터를 로드하면, 화면에 나타날 때 `onAppear`내의 코드가 실행된다.
```swift
struct OnAppearStudy: View {

    @State var count: Int = 0
    
    var body: some View {
        NavigationView {
            ScrollView {
                // 화면에 나타날 때 데이터 로드
                LazyVStack {
                    ForEach(0..<20) { _ in
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 200)
                            .padding()
                            // 화면에 나타날 때 해당 코드 실행
                            .onAppear {
                                count += 1
                            }
                    }
                }
            }
            .navigationTitle("On Appear \(count)")
        }
    }
}
```
![](https://velog.velcdn.com/images/snack/post/94fadc9f-ede4-417c-a211-f3e2a4244ec0/image.png)

### onDisappear
- 뷰가 화면 상에서 사라질 때 입력된 코드를 실행한다.
```swift
struct OnAppearStudy: View {
    
    @State var myText: String = "Star Text"
    
    var body: some View {
        Text(myText)
            .font(.largeTitle)
            // 뷰가 사라진 직후 해당 코드 실행
            .onDisappear(perform: {
                myText = "End Text"
            })
    }
}
```
