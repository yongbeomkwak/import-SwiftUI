# ScrollView

- 내부의 여러 뷰들을 스크롤 가능하게 담는 뷰

### Vertical
- ScrollView는 기본적으로 수직 방향이다.
- VStack, ForEach를 활용하여 반복되는 동일한 뷰를 표현할 수 있다.
```swift
ScrollView { // 수직 방향 스크롤 뷰
    VStack {
        ForEach(0..<20) { index in
            Rectangle()
                .fill(Color.blue)
                .frame(height: 200)
        }
    }
}
```
### Horizontal
- `axes` 파라미터를 전달하여 ScrollView를 수평 방형으로 변경할 수 있다.
- `showsIndicators` 파라미터를 전달하여 스크롤바를 숨길 수 있다.
```swift
// 수평 방향 스크롤 뷰, 스크롤 바 숨김
ScrollView(.horizontal, showsIndicators: false, content: {
    HStack {
        ForEach(0..<20) { index in
            Rectangle()
                .fill(Color.blue)
                .frame(width: 300)
        }
    }
})
```
