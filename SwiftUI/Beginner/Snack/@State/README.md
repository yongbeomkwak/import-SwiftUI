# @State
- 값의 변화를 추적하고 해당 값이 변경될 때마다 뷰를 자동으로 업데이트하는 프로퍼티 래퍼

### Struct내의 @State
- `Struct`는 값 타입이여서 `Struct`내의 값을 변경할 수 없지만, `@State`를 통해 값을 변경할 수 있다.
- 선언된 변수의 값을 관찰하고 값의 변화가 있을 때 해당 뷰를 업데이트 한다.
- 뷰의 `body`에서만 접근해야되기 때문에 `private`으로 선언하는 것을 권장한다.
```swift
struct StateStudy: View {
    
    // 값의 변화 추적
    @State private var count: Int = 0
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Current Count is \(count)")
            Button("Click to Count") {
                count += 1
            }
        }
    }
}
```
![](https://velog.velcdn.com/images/snack/post/826df3e8-b50e-4a20-b777-d2471aa71de4/image.gif)
