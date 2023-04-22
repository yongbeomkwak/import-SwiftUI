# Gradients
- 뷰의 색상을 그라디언트로 변경

### LinearGradient
- 선형 그라디언트를 추가할 수 있다.
```swift
 RoundedRectangle(cornerRadius: 16.0)
    .fill(
        LinearGradient( // Linear그라디언트
            colors: [Color.red, Color.blue], // 시작색 빨강, 끝색 파랑(색상 배열)
            startPoint: .topLeading, // 시작지점 왼쪽 위
            endPoint: .bottomTrailing // 끝지점 오른쪽 밑
            )
        )
        .frame(width: 300, height: 200)
```

### RadialGradient
- 원형 그라디언트를 추가할 수 있다.
```swift
 RoundedRectangle(cornerRadius: 16.0)
    .fill(
        RadialGradient( // 원형 그라디언트
            colors: [Color.red, Color.blue], // 시작색 빨강, 끝색 파랑(색상 배열)
            center: .center, // 중앙 위치
            startRadius: 80.0, // 시작 반지름
            endRadius: 160.0) // 끝 반지름
            )
        )
        .frame(width: 300, height: 200)
```

### AngularGradient
- 회전형 그라디언트를 추가할 수 있다.
```swift
 RoundedRectangle(cornerRadius: 16.0)
    .fill(
        AngularGradient(
            colors: [Color.red, Color.blue], // 시작색 빨강, 끝색 파랑(색상 배열)
            center: .center, // 중앙 위치
            angle: .degrees(180) // 회전 각도
            )
        )
        .frame(width: 300, height: 200)
```
