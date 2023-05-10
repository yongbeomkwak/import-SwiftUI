# LazyStack
- 스택 내의 아이템들이 화면에 렌더링 될 때 생성되는 뷰

### LazyV(H)Stack
- 일반 Stack의 경우 화면에 나타나기 전 모든 데이터를 로드하지만, LazyStack의 경우 화면에 나타난 후에 데이터를 로드한다.
```swift
ScrollView {
    LazyVStack(alignment: .leading) {
        ForEach(0..<100) { index in
            Text("LazyStack \(index)")
        }
    }
    .background(.blue)
}
```
- LazyStack은 유연하게 너비를 갖기 때문에 일반 스택과 다르게 자동으로 여유 공간을 차지한다.

![](https://velog.velcdn.com/images/snack/post/944703c3-964d-4b7f-aefd-a77508089ad0/image.png)
