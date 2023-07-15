# MatchedGeometryEffect
- 서로 다른 두 뷰 사이에 애니메이션 효과를 줄 수 있는 기능

### MatchedGeometryEffect
- 일반적인 애니메이션 효과는 단일 뷰의 변화를 감지하여 그 변화에 애니메이션을 적용한다.
- `matchedGeometryEffect`를 이용하여 두 뷰 사이의 변화에 애니메이션 효과를 적용할 수 있다.
- `matchedGeometryEffect`를 적용하기 위해선 같은 뷰로 인식할 고유한 `id`값과 이 정보를 기억할 `@Namespace`라는 프로퍼티 래퍼가 필요하다.
```swift
struct MatchedGeometryEffectStudy: View {
    
    @State private var isClicked: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        VStack {
            if !isClicked {
                RoundedRectangle(cornerRadius: 12)
                    // 애니메이션을 적용할 뷰 지정
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 100, height: 100)
            }
            Spacer()
            if isClicked {
                RoundedRectangle(cornerRadius: 12)
                    // 애니메이션을 적용할 뷰 지정
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 200, height: 200)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.red)
        .onTapGesture {
            withAnimation(.easeInOut) {
                isClicked.toggle()
            }
        }
    }
}
```
![](https://velog.velcdn.com/images/snack/post/b6c2c9ae-509c-47e8-bc11-177aece3fb2d/image.gif)
- 이를 활용하여 SegmentedControl과 같은 효과를 구현할 수 있다.
```swift
struct MatchedGeometryEffectStudy2: View {
    
    let categories: [String] = ["Home", "Popular", "Saved"]
    @State private var selected: String = "Home"
    @Namespace private var namespace2
    
    var body: some View {
        HStack {
            ForEach(categories, id: \.self) { category in
                ZStack {
                    if selected == category {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue).opacity(0.3)
                            // 애니메이션을 적용할 뷰 지정
                            .matchedGeometryEffect(id: "category", in: namespace2)
                    }
                    Text(category)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selected = category
                    }
                }
            }
        }
    }
}
```
![](https://velog.velcdn.com/images/snack/post/e7eda39d-92d1-4269-af2f-72f78c8c381b/image.gif)
