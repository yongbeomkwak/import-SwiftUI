# Extracting functions and subviews

한 뷰에 기능과 뷰를 모두 때려 박으면 선언형 UI 특성상 무지하게 길어진다.

그렇기 때문에 적절하게 분리하여 보기도 좋고 관리하기도 편하다.\


<br>

## Befre Extracting

- 버튼의 기능과 서브 뷰를 나누기 전 입니다.

```swift

struct SwiftUIView: View {
    
    @State var backgroundColor: Color = .pink
    
    var body: some View {
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing:20){
                Text("Title")
              
                Button {
                    backgroundColor = .yellow
                } label: {
                    Text("Press Me")
                        .font(.headline)
                }

            
                
            }
        }
    }
}

```

<br>

## After Extracting

```swift

struct SwiftUIView: View {
    
    @State var backgroundColor: Color = .pink
    
    var body: some View {
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            contentLayer // 본문이 굉장히 짤아졌음
            
        }
    }
    

    //서브뷰
    var contentLayer: some View {
        VStack(spacing:20){
            Text("Title")
          
            Button {
                buttonPress()
            } label: {
                Text("Press Me")
                    .font(.headline)
            }
            
        }
    }
    
    //버튼 기능
    func buttonPress() {
        backgroundColor = .yellow
    }
}

```