# Padding, Spacer
뷰 자체 혹은 뷰 간의 여백 추가

### Padding
- 뷰 자체의 수직, 수평 방향으로 여백을 추가 할 수 있다.
```swift
Text("Hello World!")
    .background(Color.yellow)
    .padding() // 기본 패딩(모든 방향, 여백 10)
    .padding(.all, 20) // 모든 방향, 여백 20
    .padding(.vertical, 20) // 수직 방향, 여백 20
    .padding(.leading, 20) // 왼쪽 방향, 여백 20
    .background(Color.yellow)
```

### Spacer
- Stack뷰 안에 여백(빈 공간)을 추가할 수 있다.
- Spacer는 크기는 유동적으로 조정되며, 가능한 많은 공간을 차지한다.
```swift
HStack {
    Rectangle()
        .frame(width: 100, height: 100)
        .foregroundColor(Color.blue)
    Spacer() // 화면 양쪽 끝으로 두 사각형 배치
    Rectangle()
        .frame(width: 100, height: 100)
        .foregroundColor(Color.yellow)
}
```
- minLength 파라미터를 통해 최소 여백을 설정할 수 있다.(기본값 8)
```swift
HStack {
    Rectangle()
        .frame(width: 100, height: 100)
        .foregroundColor(Color.blue)
    Spacer(minLength: 20) // 패딩에 따라 너비가 조정될 때, 최소 너비 20
    Rectangle()
        .frame(width: 100, height: 100)
        .foregroundColor(Color.yellow)
}
.padding(.horizontal, 200) // 수평 방향 패딩 200
```
- frame 크기를 지정해 원하는 크기의 여백을 설정할 수 잇다.
```swift
HStack {
    Rectangle()
        .frame(width: 100, height: 100)
        .foregroundColor(Color.blue)
    Spacer()
        .frame(width: 50) // 수평 방향 50의 여백
    Rectangle()
        .frame(width: 100, height: 100)
        .foregroundColor(Color.yellow)
}
```
