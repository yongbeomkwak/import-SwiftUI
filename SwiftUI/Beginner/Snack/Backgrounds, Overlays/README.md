# Backgrounds, Overlays
- 요소 뒷면 혹은 앞면에 다양한 요소를 추가할 수 있는 modifier

### Backgrounds
- 요소 뒷면에 다양한 요소들을 추가할 수 있다.
```swift
Text("Hello, World!")
    .background(
        Color.red // 색상 추가
        LinearGradient(
        gradient: Gradient(colors: [Color.red, Color.blue]),
        startPoint: .leading,
        endPoint: .trailing
        ) // 그라디언트 추가
        Circle() // 도형 추가
    )
```
- 여러개를 복수로 추가할 수 있다.(Overlays도 동일)
```swift
Text("Hello, World!")
    .background(
        Circle()
            .fill(
                LinearGradient(
                gradient: Gradient(colors: [Color.red, Color.blue]),
                startPoint: .leading,
                endPoint: .trailing
                )
            )
            .frame(width: 100, height: 100, alignment: .center)
    )
    .background(
        Circle()
            .fill(
                LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.red]),
                startPoint: .leading,
                endPoint: .trailing
                )
            )
            .frame(width: 120, height: 120, alignment: .center)
    )
```

### Overlays
- 요소 앞면에 다양한 요소들을 추가할 수 있다.
```swift
Circle()
    .fill(Color.pink)
    .frame(width: 100, height: 100)
    .overlay(
        Text("A") // 텍스트 추가
            .font(.largeTitle)
            .foregroundColor(.white)
        Circle() // 도형 추가
    )
```
- Overlay안의 요소에 Overlay를 추가할 수 있다.(Backgrounds도 동일)
- 요소를 기준으로 Overlay를 정렬할 수 있다.(Backgrounds도 동일)
```swift
Circle()
    .frame(width: 100, height: 100)
    .foregroundColor(.red)
    .overlay( // 첫 번째 Overlay
        Circle()
            .frame(width: 40, height: 40)
            .overlay ( // 두 번째 Overlay
                Text("1")
                    .foregroundColor(.white)
            )
        , alignment: .bottomTrailing) // 요소 기준 정렬
```
