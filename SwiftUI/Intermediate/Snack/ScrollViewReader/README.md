# ScrollViewReader
- 스크롤 뷰의 위치를 제어하고 특정 뷰로 스크롤 할 수 있는 뷰

### ScrollView 내부에서 제어
- 일반적으로 `ScrollView` 내부의 포함되는 뷰의 식별자를 사용하여 특정 뷰로 스크롤할 수 있다.
- `id`값을 지정하여 해당 위치의 뷰로 스크롤할 수 있고, `anchor`를 통해 스크롤된 뷰의 위치를 지정할 수 있다.
```swift
ScrollView {
    ScrollViewReader { proxy in
        Button("Click here to go to #49") {
            withAnimation(.spring()) {
                // 특정 id값의 위치로 스크롤
                proxy.scrollTo(30, anchor: .center)
            }
        }
        ForEach(0..<50) { index in
            Text("This is item #\(index)")
                .font(.headline)
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 10)
                .padding()
                .id(index) // id값 생성
        }
    }
}
```
![](https://velog.velcdn.com/images/snack/post/4db81d9b-1d35-4f10-87f0-a3528da42d30/image.png)

### ScrollView 외부에서 제어
- `TextField`와 `onChange`를 활용하여 `ScrollView` 외부에서 스크롤 위치를 제어할 수 있다.
```swift
struct ScrollViewReaderStudy: View {
    
    @State var scrollToIndex: Int = 0
    @State var textFieldText: String = ""
    
    var body: some View {
        VStack {
            // String 타입으로 스크롤할 ScrollView의 특정 위치를 입력
            TextField("scroll number", text: $textFieldText)
                .frame(height: 56)
                .border(.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            Button("Scroll Now") {
                // Int 타입으로 입력받은 위치를 변환
                if let index = Int(textFieldText) {
                    scrollToIndex = index
                }
            }
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(0..<50) { index in
                        Text("This is item #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    // 입력받은 Int 타입의 위치 값이 변할 때 해당 위치로 스크롤
                    .onChange(of: scrollToIndex) { newValue in
                        withAnimation {
                            proxy.scrollTo(newValue, anchor: .center)
                        }
                    }
                }
            }
        }
    }
}
```
![](https://velog.velcdn.com/images/snack/post/1e3dbb79-cc25-4acf-bdfa-8a44c33c3476/image.png)
