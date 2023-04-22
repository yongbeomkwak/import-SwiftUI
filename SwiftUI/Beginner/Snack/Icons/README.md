# Icons
- Image 뷰를 이용해 원하는 아이콘 생성

### System Icons
- Apple의 SF Symbols를 활용해 기본 시스템 아이콘을 사용할 수 있다.
- SF Symbols의 아이콘 이름을 systemName으로 입력하여 사용할 수 있다.
- SF Symbols (https://developer.apple.com/sf-symbols/)
```swift
Image(systemName: "heart.fill") // SF Symbols의 시스템 아이콘 사용
```
![](https://velog.velcdn.com/images/snack/post/09e2d92d-0a7a-4c64-b147-b29d92277235/image.png)

### Icons 속성
- modifiers를 통해 Icon에 다양한 속성을 추가할 수 있다.
```swift
Image(systemName: "heart.fill")
    .font(.title) // 폰트 시스템에 따라 아이콘 크기 변경
    .font(.system(size: 200)) // 폰트 사이즈 200으로 아이콘 사이즈 변경
    .foregroundColor(.green) // 초록색으로 색상 변경
    .resizable() // 크기 변경 가능
    .aspectRatio(contentMode: .fit) // 프레임에 맞게 비율 조정
    .scaledToFill() // 프레임에 맞게 비율 조정
    .frame(width: 200, height: 200) // 가로 200, 세로 200으로 크기 변경
    .clipped() // 프레임 클립핑 마스크 적용
```

### Multi-Color Icons
- SF Symbols의 Multi-Color Icons를 사용할 수 있다.
- 초록색과 빨간색 같은 시스템 강조색은 변경할 수 없다.
```swift
Image(systemName: "person.fill.badge.plus")
    .font(.largeTitle)
    .symbolRenderingMode(.multicolor) // multicolor로 렌더링 모드 변경
```
