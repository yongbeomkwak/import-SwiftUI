# Resizable Sheet
- `presentationDetents`를 이용해 `sheet`의 사이즈 조정

### presentationDetents
- `presentationDetents`를 이용하여 원하는 크기로 `sheet`의 사이즈를 조정할 수 있다.
- 사용자가 조정 가능한 사이즈의 범위를 set 형태로 지정한다.
- 가능한 사이즈의 범위가 2개 이상일 경우 `sheet` 상단에 DragIndicator가 나타나는데, `presentationDragIndicator`를 이용해 제거할 수 있다.
- 나타난 `sheet`는 Drag 및 Background Touch 등의 인터랙션으로 사라지게 할 수 있는데, `interactiveDismissDisabled`를 이용해 인터랙션을 비활성화할 수 있다.
```swift
struct SheetStudy: View {
    
    @State var showSheet: Bool = false
    
    var body: some View {
        
        Button("Click Me") {
            showSheet.toggle()
        }
        .sheet(isPresented: $showSheet) {
            ModalView()
                .presentationDetents([
                    .fraction(0.1), // 임의 비율
                    .height(300), // 임의 높이
                    .medium, // 중간 높이
                    .large // 전체 높이
                    ])
                // DragIndicatior 비활성화
                .presentationDragIndicator(.hidden)
                // 인터랙션 비활성화
                .interactiveDismissDisabled()
        }
        .onAppear {
            showSheet = true
        }
    }
}
```

### Selection
- `selection` 파라미터의 바인딩 값을 통해 사용자가 선택한 화면 높이를 추적한다.
- `presentationDetents` set 안에 있는 높이만 선택할 수 있기 때문에, 그 외의 값을 선택하면 높이 변화가 없다.
```swift
struct SheetStudy: View {
    
    @State var showSheet: Bool = false
    @State var detents: PresentationDetent = .medium
    
    var body: some View {
        
        Button("Click Me") {
            showSheet.toggle()
            detents = .large
        }
        .sheet(isPresented: $showSheet) {
            ModalView(detents: $detents)
                // 높이 선택 값 바인딩
                .presentationDetents([.medium, .large], selection: $detents)
        }
        .onAppear {
            showSheet = true
        }
    }
    
}

struct ModalView: View {
    
    @Binding var detents: PresentationDetent
    
    var body: some View {
        ZStack {
            Color(.green).ignoresSafeArea()
            VStack {
                Button("medium") {
                    detents = .medium // 중간 높이 선택
                }
                Button("large") {
                    detents = .large // 전체 높이 선택
                }
            }
        }
    }
}
```
![](https://velog.velcdn.com/images/snack/post/1abf0c3b-eba5-4ce3-b0f8-76cfeb4a0198/image.png)
