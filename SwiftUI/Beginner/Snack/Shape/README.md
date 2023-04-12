# Shape
- 여러가지 모양의 도형을 생성할 수 있는 component

### Shape 속성
- modifiers를 통해 shape의 다양한 속성을 추가할 수 있다.
```swift
Circle()
    .fill(Color.green) // 초록색 색상
    .foregroundColor(.pink) // 분홍색 색상
    .stroke() // 선 형태
    .stroke(Color.red) // 빨간색 외곽선
    .stroke(Color.blue, lineWidth: 20) // 두께 20의 파란색 외곽선
    .stroke(Color.orange, style: StrokeStyle(lineWidth: 30), lineCap: .round, dash: [30])) // 둥근 형태의 두께 30, 간격 30의 점선 스타일 주황색 외곽선
    .trim(from: 0.2, to: 1.0) // 원 둘레의 0.2 지점부터 1.0 지점까지 자르기
    .frame(width: 200, height: 100) // 가로 200, 세로 100의 크기 지정
```

### Shape 종류
- shape의 모든 종류는 관련된 modifiers를 동일하게 적용할 수 있다.
```swift
Circle() // 원
Ellipse() // 타원
Capsule(style: .circular) // 원형 캡슐
Capsule(style: .continuous) // 부드러운 원형 캡슐
Rectangle() // 직사각형
RoundedRectangle(cornerRadius: 16) // 둥근 모서리의 직사각형
```
