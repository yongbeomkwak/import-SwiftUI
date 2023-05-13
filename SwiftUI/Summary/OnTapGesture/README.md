# OnTapGesture
- 뷰에 탭 제스처를 설정하여 사용자가 화면을 탭 했을 때 설정한 코드 실행

### onTapGesture
- 사용자가 특정 뷰를 탭하면 실행할 코드를 지정하여, 제스처가 인식되면 지정된 코드 블럭을 실행한다.
- 일반 버튼과 다르게 뷰가 탭 됐을 때 하이라이트 되지 않는다.
```swift
struct TapGestureStudy: View {
    
    @State var isSelected: Bool = false
    
    var body: some View {
        VStack(spacing: 40){
            RoundedRectangle(cornerRadius: 32)
                .foregroundColor(isSelected ? .green : .yellow)
                .frame(height: 200)
            // 일반 버튼
            Button {
                isSelected.toggle()
            } label: {
                Text("Button")
                    .foregroundColor(.white)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(25)
            }
            // 버튼 형태의 Text뷰
            Text("Tap Gesture")
                .foregroundColor(.white)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(25)
                // 탭 제스처 인식 시 해당 코드 실행
                .onTapGesture {
                    isSelected.toggle()
                }
        }
        .padding()
    }
}
```

### Count
- `count` 파라미터를 통해 인식될 탭 횟수를 지정할 수 있다. 사용자는 지정된 횟수만큼 연속으로 탭해야 코드가 실행된다.
```swift
struct TapGestureStudy: View {
    
    @State var isSelected: Bool = false
    
    var body: some View {
        VStack(spacing: 40){
            RoundedRectangle(cornerRadius: 32)
                .foregroundColor(isSelected ? .green : .yellow)
                .frame(height: 200)
            Text("Tap Gesture")
                .foregroundColor(.white)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(25)
                // 연속을 3번 탭해야 코드 실행
                .onTapGesture(count: 3) {
                    isSelected.toggle()
                }
        }
        .padding()
    }
}
```
