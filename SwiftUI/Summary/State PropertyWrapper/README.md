# @State PropertyWrapper

View는 @State 값을 관찰하고 있다가 값이 변화면 뷰를 새로 그린다.

```swift

struct SwiftUIView: View {
    
    @State var count:Int = 0
    
    var body: some View {
        ZStack{
            Color.red
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing:20){
                Text("Title")
                Text("Count: \(count)")
                
                HStack(spacing: 20) {
                    Button("증가") {
                        count += 1
                    }
                }
                
            }
        }
    }
}

```