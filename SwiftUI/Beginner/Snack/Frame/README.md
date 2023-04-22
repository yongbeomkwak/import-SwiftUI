# Frame
- 화면의 여러 뷰들을 감싸는 사각형의 영역

### Frame 영역
- frame 영역을 지정해주지 않으면 콘텐츠 자체가 차지하는 영역이 기본 영역이다.
```swift
Text("Hello, World!")
    .background(Color.red) // text 자체의 영역
```
- frame 영역을 지정해주면 지정해준 넓이만큼 화면의 공간을 차지하게된다.
```swift
Text("Hello, World!")
    .background(Color.red) // text 자체의 영역
    .frame(width: 200, height: 200) // text의 frame 영역
    .background(Color.green)
```

### Frame 정렬
- frame 영역을 기준으로 frame 내부의 뷰들을 정렬할 수 있다.
```swift
Text("Hello, World!")
    .background(Color.red)
    .frame(width: 200, height: 200, alignment: .leading) // 왼쪽 정렬
    .frame(width: 200, height: 200, alignment: .center) // 중앙 정렬
    .frame(width: 200, height: 200, alignment: .trailing) // 오른쪽 정렬
    .background(Color.green)
```

### Frame 크기
- frame의 크기를 유동적으로 지정할 수 있다.
```swift
Text("Hello, World!")
    .background(Color.red)
     .frame(
        minWidth: 10, // 최소 너비 지정
        idealWidth: 300, // 최적 너비 지정
        maxWidth: .infinity, // 최대 너비 지정
        minHeight: 10, // 최소 높이 지정
        idealHeight: 300, // 최적 높이 지정
        maxHeight: .infinity, // 최대 높이 지정
        alignment: .center
        )
```
- fixedSize modifier를 통해 maxWidth와 maxHeight에 상관없이 영역을 고정할 수 있다.
-  idealWidth와 idealHeight이 지정되어 있을 경우 그 크기로 고정되며, 지정되어 있지 않을 경우 내부 콘텐츠의 크기로 고정된다.
```swift
.fixedSize(horizontal: true, vertical: true)
```
