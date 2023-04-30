# @Binding
- 데이터의 값을 변경하고 다른 뷰와 동기화하는 프로퍼티 래퍼(property wrapper)

### @State와 @Binding
- `@State`에서 저장된 뷰의 상태를 다른 뷰와 공유하고 변경할 수 있게 한다.
- `@State`는 값이 변경될 때 뷰를 다시 그리고, `@Binding`은 값이 변경될 때 뷰 간의 데이터를 동기화합니다.
- `@Binding`을 선언할 때에는 `$`를 붙여 사용한다.
```swift
struct BindingStudy: View { // 부모 뷰
    
    @State var backgroundColor: Color = Color.green // State 변수 선언
    
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            ButtonView(backgroundColor: $backgroundColor) // $를 통해 Binding

        }
    }
}

struct ButtonView: View { // 자식 뷰
    
    @Binding var backgroundColor: Color // @Binding을 통해 State 변수 Binding
    
    var body: some View {
        Button {
            backgroundColor = Color.orange // Binding된 변수 값 변경
        } label: {
            Text("Button")
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal)
                .background(.blue)
                .cornerRadius(10)
        }
    }
}
```
