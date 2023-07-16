# **#27 Transition**

- 화면 안으로 또는 외부로의 변화를 주고 싶다면 Transition을 쓰고,
이미 화면에 있는 상태에서 변화를 주려면 Animation을 쓰면됨. 
<br>

## slide, move transition에 animation 적용하기
### 방법 1: animation에 **value** 값 적기


```swift
struct TransitionView: View {
    
    @State private var Showview: Bool = false
    
    var body: some View {

            ZStack(alignment: .bottom) {
                VStack {
                    Button("Button") {
                            Showview.toggle()
                    }
                    Spacer()
                }
                if Showview {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(height: UIScreen.main.bounds.height/2)
                        .transition(.slide)      //slide - 좌우로만 움직이는 트랜지션
                }
            }
            .animation(.easeInOut,value: Showview)   
            //ios15부터 animation이 duprecated되서 value값까지 써줘야 함. 
            .edgesIgnoringSafeArea(.bottom)
    }
}

<br>

```
- value값이 적용되는 버튼까지 포괄하는 범위에 애니메이션 적용한다. 
- 캔버스에서는 오류가 나서 안 보임. 시뮬레이터로 봐야 한다.  <br>
- duprecated 된 버전의 animation 수정자는 뷰에서 일어나는 모든 변화에 같은 애니메이션이 적용되었지만, <br> value 매개변수를 사용하면 애니메이션을 적용하고 싶은 곳에만 적용할 수 있다.

 <br>
 <img height = 400 src = "https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/32864737-543d-4453-a9bd-a833b932c798">

### 방법2: **withanimation** 사용하기
```swift
struct TransitionView: View {
    
    @State private var Showview: Bool = false
    
    var body: some View {

            ZStack(alignment: .bottom) {
                VStack {
                    Button("Button") {
                        withAnimation(.easeInOut) {
                            Showview.toggle()
                        }
                    }
                    Spacer()
                }
                if Showview {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(height: UIScreen.main.bounds.height/2)
                        .transition(.move(edge: .bottom))    //move - 트랜지션 방향을 설정할 수 있음. 
                }
            }
        .edgesIgnoringSafeArea(.bottom)
    }
}
```

![화면 기록 2023-05-02 오전 3 02 28](https://user-images.githubusercontent.com/87987002/235502550-ebdb9dbe-f104-411d-9be4-a09b8ad0bc49.gif)

변화하는 값을 withAnimation으로 감싸주면 정상 작동함


<br>
<br>

## opacity Transition

```swift
 RoundedRectangle(cornerRadius: 30)
                    .frame(height: UIScreen.main.bounds.height/2)
                    .transition(
                        AnyTransition.opacity.animation(.easeInOut)
                    )
```




![화면 기록 2023-05-02 오전 3 07 51](https://user-images.githubusercontent.com/87987002/235503307-7eb46785-3f92-49ed-a901-52a770ef5c3e.gif)

anyTransition을 호출하면 opacity를 쓸 수 있음. 그리고 애니메이션도 바로 적용

<br>
<br>
<br>

## Asymmetric Transition
- 트랜지션의 시작과 끝을 다르게 설정할 수 있음

```swift
  RoundedRectangle(cornerRadius: 30)
      .frame(height: UIScreen.main.bounds.height/2)
      .transition(.asymmetric(
          insertion: .move(edge: .bottom),                         //시작 - move
          removal: AnyTransition.opacity.animation(.easeInOut)))   //끝 - opacity
      .animation(.easeInOut)
```

![화면 기록 2023-05-02 오전 3 15 20](https://user-images.githubusercontent.com/87987002/235504551-81152c0e-ad4e-45ca-bb6c-25f9cbbbad98.gif)

<br>
<br>
<br>


## [추가] **베지어 타이밍 커브 애니메이션** 
![Animation-timingCurve-1@2x](https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/0a64bcc4-5fbf-4fb1-8d94-e62e50991204)

- 베지어 커브를 통해 애니메이션의 속도를 조정할 수 있다. 
- 시작점은 (0,0), 끝점은 (1,1)이라고 했을 때 첫번째 컨트롤 포인트와 두번째 컨트롤 포인트의 위치(x,y)를 지정함으로써 곡선을 조정할 수 있다. 
- 경사가 급하면 애니메이션이 빠르게 실행되고 경사가 완만하면 느리게 실행된다. 위의 예시 곡선은 빠르게-느리게-빠르게 순서로 애니메이션이 나타난다. 

```swift
struct ContentView: View {
    @State private var scale = 1.0


    var body: some View {
        VStack {
            Circle()
                .scaleEffect(scale)
                .animation(
                    .timingCurve(0.1, 0.75, 0.85, 0.35, duration: 2.0),
                    value: scale)
        }
    }
}
```
