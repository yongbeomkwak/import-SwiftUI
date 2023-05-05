# Transition
- 뷰가 화면에서 등장하거나 사라질 때의 전환 효과

### Animation Transition 효과
- 먼저 뷰에 애니메이션을 적용시킨 후, 조건문을 활용하여 뷰에 전환 효과를 적용시킬 수 있다.

```swift
struct TransitionStudy: View {
    
    @State var isAnimation: Bool = false
    
    var body: some View {
        VStack {
            Button("Button") {
                // animation 효과 적용
                withAnimation {
                    isAnimation.toggle()
                }
            }
            Spacer()
            if isAnimation {
                RoundedRectangle(cornerRadius: 24)
                    .frame(height: UIScreen.main.bounds.height / 2)
                    // transition 효과 적용
                    .transition(.slide)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
```
![](https://velog.velcdn.com/images/snack/post/9bc45134-648f-4fce-a5bf-91c3c4272c4e/image.gif)

### Transition 종류
- AnyTransition의 다양한 전환 효과를 적용시킬 수 있다.
```swift
.transition(.opacity)
.transition(.scale)
.transition(.slide)
.transition(.move(edge: .leading))
.transition(.push(from: .leading))
.transition(.offset(y: 100))
```
- `asymmetric`을 활용하여 등장과 퇴장할 때의 전환 효과를 다르게 적용시킬 수 있다.
```swift
.transition(.asymmetric(
    insertion: .move(edge: .leading), // 등장 효과
    removal: .opacity // 퇴장 효과
))
```
- `combined`을 활용하여 서로 다른 전환 효과를 동시에 적용시킬 수 있다.
```swift
.transition(.opacity.combined(with: .scale))
```

### Removal Transition 오류
- Removal Transition 시 `zIndex`가 0으로 변경되어, 애니메이션 적용이 안되는 것 처럼 보이는 경우가 있다.
- 이 때, `zIndex`를 명시적으로 설정하여 해결할 수 있다.
```swift
struct TransitionStudy: View {
    
    @State var isAnimating = false
    
    var body: some View {
        ZStack {
            Color.green
                .zIndex(-1) // 배경의 zIndex를 설정할 경우
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        isAnimating.toggle()
                    }
                }
            if isAnimating {
                RoundedRectangle(cornerRadius: 24)
                    .zIndex(1) // 전경의 zIndex를 설정할 경우
                    .transition(.move(edge: .bottom))
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            isAnimating.toggle()
                        }
                    }
            }
        }
    }
}
```
