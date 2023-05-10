# **#41 Stepper**


## **기본 Stepper**

- `Stepper(title: StringProtocol, value: Binding<Strideable>)`
- **Strideable** 뜻 : continuous and one-dimensional value that can be offset and measured
    - **숫자**처럼 값을 올리고 내릴 수 있는 것!

<br>

따라서 Integer 값으로 변수를 설정해주고,

```swift
@State var stepperValue : Int = 10
```

View 안에 Stepper()를 사용해준다.

```swift
var body: some View {
	Stepper("Stepper: \(stepperValue)", value: $stepperValue)
		.padding(50)
}
```

<img src="https://user-images.githubusercontent.com/126866283/236770324-5ee63984-d6b1-4e3c-be93-9c94a5794893.gif" width=300>

<br>
<br>
<br>


## **Customized Stepper**

- `Stepper(title:onIncrement:onDecrement)`
- Stepper의 증가와 감소 속성을 커스텀 할 수 있다.

<br>

CGFloat Type의 변수를 설정해준 후,

```swift
@State var widthIncrement: CGFloat = 0
```

View에서는 VStack을 이용해 RoundedRectangle의 너비를 Customized Stepper를 이용해 조절해보겠다.

```swift
VStack {
	RoundedRectangle(cornerRadius: 25.0)
		.frame(width: 100 + widthIncrement, height: 100)
	            
	Stepper("Stepper 2") {
		// increment
		widthIncrement += 10  // '+' 누르면 10씩 증가
	} onDecrement: {
		// decrement
		widthIncrement -= 10  // '-' 누르면 10씩 감소
	}
}
```
<img src="https://user-images.githubusercontent.com/126866283/236770744-5803cbf0-8386-4b13-8057-26b4ad77059d.gif" width=300>

<br>

사각형의 움직임이 너무 딱딱하다 느껴질 땐, animation을 적용하여 움직임을 부드럽게 만들 수 있다.

`var** body: **some** View { }` 아래에 함수를 하나 만들자.

```swift
func incrementWidth(amount: CGFloat) { // CGFloat의 값을 받기
	withAnimation(.easeInOut) {          // ease in & out animation 적용
		widthIncrement += amount           // 한 번에 amount 값 만큼 너비 증가
  }
}
```

그리고 아까 `Stepper() {}` 부분을 이 함수로 대체하자.

```swift
Stepper("Stepper 2") {
	// increment
	incrementWidth(amount: 10)  // '+' 누르면 10씩 증가
} onDecrement: {
	// decrement
	incrementWidth(amount: -10)  // '-' 누르면 10씩 감소
}
```

<img src="https://user-images.githubusercontent.com/126866283/236771017-a6761ff2-6333-4072-9bc2-b2afdf8851db.gif" width=300>

움직임이 부드러워졌다! amount의 값이 커질수록 더 smooth 해진다.