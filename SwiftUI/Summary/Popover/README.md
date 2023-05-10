#  3 Ways to Make Popovers**

- Sheets에서 다룬 예제처럼 첫번째 화면에서 버튼을 누르면 두번째 화면이 pop-up 되고, 두번째 창에서 ‘x’ 버튼을 누르면 다시 첫번째 창으로 넘어오는 동작을 **세가지 다른 방법**으로 구현할 수 있다.
- **Sheets / Transitions / Offsets** 를 이용한 세 방법

![image.jpg1](https://user-images.githubusercontent.com/126866283/235685283-7fcae2c2-77fc-4825-b4e2-b1aeeca02792.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/235685446-bd068d83-8734-4e1f-a18b-e42a54e2df6f.png)
--- | ---



우선 아래의 코드로 주황색 화면을 그려놓자.

```swift
struct PopoverBootcamp: View {
	@State var showNewScreen: Bool = false
    
	var body: some View {
		ZStack {
			Color.orange.edgesIgnoringSafeArea(.all)
            
			VStack {
				Button("BUTTON"){
					showNewScreen.toggle()
        }
				.font(.largeTitle)
				Spacer()
			}
```
<br>
<br>

## **1. Sheet 을 이용한 방법**

위의 코드에 아래의 코드를 덧붙인다.

```swift
			// METHOD 1 - SHEET
			.sheet(isPresented: $showNewScreen, content: {
			  // showNewScreen의 값이 true라면
				NewScreen()
      })
		}
	}
}
```

새로운 struct view를 만들어 아래의 코드를 적는다.

```swift
struct NewScreen: View {
    @Environment(\.dismiss) var dismiss
		// 현재 바라보고 있는 화면을 변수로 설정    

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.purple.edgesIgnoringSafeArea(.all)
            
			      // 'x' 버튼 누르면 화면 나가게 하기
            Button(action: {
                dismiss()
								// 지금 떠있는 화면에서 나가라!
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(20)
            })
        }
    }
}
```
<br>
<br>

## **2. Transition 을 이용한 방법**

![image.jpg1](https://user-images.githubusercontent.com/126866283/235685283-7fcae2c2-77fc-4825-b4e2-b1aeeca02792.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/235686339-d093ce51-eb3f-4f7f-b810-5a0d2eb436f5.png)
--- | ---

아래의 코드를 덧붙인다.

```swift
// METHOD 2 - TRANSITION
			if showNewScreen {
				NewScreen(showNewScreen: $showNewScreen) // @Binding을 통해 
					.padding(.top, 100) // 위부터 100 만큼 띄우기
				  transition(.move(edge: .bottom)) // 아래에서부터 올라오는 움직임
				    .animation(.spring()) // 튕기는 애니메이션
			}
```

근데 이러면 보라색 창이 뜰 땐 인터랙션이 부드럽게 올라오지만, ‘x’ 버튼을 눌러 보라색 창을 내릴 땐 **주황색 화면이 갑자기 올라오면서 인터랙션이 끊긴다.**

이 때, ZStack 안에 if문 전체를 넣어준 후, `.zIndex(2.0)`이라고 설정해서 **언제나 보라색 창이 전체 ZStack 상에서 주황색 화면보다 위에 있도록 설정**해두면, 보라색 창이 자연스럽게 아래로 내려가서 사라질 때까지 인터랙션이 끊기지 않는다.

```swift
// METHOD 2 - TRANSITION
			ZStack {
				if showNewScreen {
					NewScreen(showNewScreen: $showNewScreen)
						.padding(.top, 100) // 위부터 100 만큼 떨어지기
					  transition(.move(edge: .bottom)) // 아래에서부터 올라오는 움직임
					    .animation(.spring()) // 튕기는 애니메이션
				}
      }
			.zIndex(2.0)
```

마지막으로, NewScreen view를 아래와 같이 수정한다.

```swift
struct NewScreen: View {
    @Binding var showNewScreen: Bool
		// 다른 view @State에서 showNewScreen의 값 가져오기  

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.purple.edgesIgnoringSafeArea(.all)
            
            Button(action: {
                showNewScreen.toggle() // 토글을 반대로 밀어라(showNewScreen = false)
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(20)
            })
        }
    }
}
```

<br>
<br>

## **3. Animation Offset 을 이용한 방법**

위의 `METHOD 2` 부분 대신 아래의 코드를 넣어보자.

![image.jpg1](https://user-images.githubusercontent.com/126866283/235686339-d093ce51-eb3f-4f7f-b810-5a0d2eb436f5.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/235685283-7fcae2c2-77fc-4825-b4e2-b1aeeca02792.png)
--- | ---



```swift
// METHOD 3 - ANIMATION OFFSET
			NewScreen(showNewScreen: $showNewScreen)
	      // (1) 보라색 화면이 위에서부터 100 아래로 내려와있음
				.padding(.top, 100) 

				// (2) showNewScreen = true면 0, false면 화면 높이만큼 y축 방향으로 내려라!
        .offset(y: showNewScreen ? 0 : UIScreen.main.bounds.height)
        .animation(.spring())
```
