# Stack
- 한 개 이상의 뷰를 묶어서 배치

### HStack
- 한 개 이상의 뷰를 수평 방향으로 배치할 수 있다.
- 수직 방향으로 정렬할 수 있다.
- 뷰간의 간격을 조절할 수 있다.(기본값 8)
```swift
HStack (alignment: .bottom, spacing: 10) { // 아래쪽 정렬, 간격 10
    Circle() // 왼쪽
        .fill(Color.red)
        .frame(width: 150, height: 150)
    Circle() // 가운데
        .fill(Color.green)
        .frame(width: 100, height: 100)
    Circle() // 오른쪽
        .fill(Color.blue)
        .frame(width: 50, height: 50)
}
```

### VStack
- 한 개 이상의 뷰를 수직 방향으로 배치할 수 있다.
- 수평 방향으로 정렬할 수 있다.
- 뷰간의 간격을 조절할 수 있다.(기본값 8)
```swift
VStack (alignment: .leading, spacing: 10) { // 왼쪽 정렬, 간격 10
    Circle() // 위쪽
        .fill(Color.red)
        .frame(width: 150, height: 150)
    Circle() // 가운데
        .fill(Color.green)
        .frame(width: 100, height: 100)
    Circle() // 아래쪽
        .fill(Color.blue)
        .frame(width: 50, height: 50)
}
```

### ZStack
- 한 개 이상의 뷰를 Z축 방향으로 배치할 수 있다.
- 수직, 수평 방향으로 정렬할 수 있다.
```swift
ZStack (alignment: .topLeading) { // 왼쪽 위 정렬
    Circle() // 뒤쪽
        .fill(Color.red)
        .frame(width: 150, height: 150)
    Circle() // 가운데
        .fill(Color.green)
        .frame(width: 100, height: 100)
    Circle() // 앞쪽
        .fill(Color.blue)
        .frame(width: 50, height: 50)
}
```
