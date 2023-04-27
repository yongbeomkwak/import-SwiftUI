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
    

    //서브뷰를 변수로 
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

## xCode 기능을 이용하여 SubView 만들기

1. 추출하고 싶은 가장 바깥뷰를 클릭한 후, command + 클릭을 한다.


<img width="301" alt="스크린샷 2023-04-26 오후 11 02 03" src="https://user-images.githubusercontent.com/48616183/234600678-3384375e-b5e5-4c2b-9719-941c728a694b.png">

2. 아래와 같이 옵션창이 뜰 때 Extract Subview를 눌러 추출한다.

<img width="301" alt="스크린샷 2023-04-26 오후 11 02 14" src="https://user-images.githubusercontent.com/48616183/234600685-44d86f60-79c0-44a3-97ec-7428faf016a6.png">

3. command + shift + A 를 누른 후 rename 을 하게되면 한번에 이름이 바뀐다.