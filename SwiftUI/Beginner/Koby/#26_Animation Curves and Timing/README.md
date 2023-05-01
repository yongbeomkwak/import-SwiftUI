# **#26 Animation Curves and Timing**

```swift
 @State var isAnimating: Bool = false
    let timing:Double = 5.0        //애니메이션 진행 시간을 지정하는 변수
    
    var body: some View {
        VStack {
            Button("Button") {
                isAnimating.toggle()
            }
            RoundedRectangle(cornerRadius: 20)
                .frame(width: isAnimating ? 350 : 50, height: 100)
                .animation(Animation
                      .linear(duration: timing)       //일정한 속도
                      .easeIn(duration: timing)       //느림-빠름
                      .easeInOut(duration: timing)    //느림-빠름-느림
                      .easeOut(duration: timing)      //빠름-느림
                )}
    }
```
![화면 기록 2023-05-02 오전 1 35 33](https://user-images.githubusercontent.com/87987002/235489079-3c6d7e73-1158-49f9-92e9-a1632eb36c4c.gif)

커브는 애니메이션의 속도를 조정하고 duration은 애니메이션이 진행되는 시간을 지정한다.
<br>
<br>
<br>

## Spring Curves
```swift
    .animation(.spring(
                response: 0.5,              //애니메이션 경과 시간
                dampingFraction: 0.7,       //스프링의 강도, 값이 낮을 수록 강도가 높아짐.
                blendDuration: 1.0))        //보통 1.0 
```

![화면 기록 2023-05-02 오전 1 49 13](https://user-images.githubusercontent.com/87987002/235491276-497f9105-bdb1-4552-b83c-fb55a62b3822.gif)

유용하게 쓸수 있는 애니메이션. 기본값으로도 많이 쓰고 커스텀해서도 쓸 수 있다. 

