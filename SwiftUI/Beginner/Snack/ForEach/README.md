# ForEach
- 한 개 이상의 뷰를 반복할 수 있는 뷰

### 단순 반복
- 반복할 범위(횟수)를 지정해주고 반복할 뷰를 작성하여 원하는 만큼 뷰를 반복한다.
```swift
VStack {
    ForEach(0..<10) { index in // 반복 횟수 지정
        Text("Hi, my index is \(index)") // 반복할 뷰
    }
}
```

### Array 활용
- Array를 활용하여 반복할 횟수와 반복할 데이터를 전달한다.
- `.indices`는 컬렉션의 인덱스 범위를 나타내는 `Range<Int>`를 반환한다.
- `id: \.self`는 SwiftUI가 Array의 각 요소를 고유하게 식별할 수 있도록 한다.
```swift
struct ForEachStudy: View {
    
    let data: [String] = ["Hi", "Hello", "Hey"]
    
    var body: some View {
        VStack {
            ForEach(data.indices, id: \.self) { index in // Array 갯수 만큼 반복
                Text("\(index) is \(data[index])") // 반복 순서 별 Array 데이터 활용
            }
        }
    }
}
```
