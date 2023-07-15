# **#3 Custom AnyTransition**

## **(1) 기본 Transition `.transition(_:)`**

- 뷰를 보여지게할때와 사라지게할때의 애니메이션

버튼을 누르면 까만 사각형이 왼쪽 옆에서 슬라이드 해서 화면 가운데로 들어오는 애니메이션을 구현해보자.

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/9a5aa4a0-d94a-41d5-bad7-39e400c1af7d" width = 300>

```swift
struct AnyTransitionBootcamp: View {

	@State private var showRectangle: Bool = false

  	var body: some View {
	  	VStack {
	    	Spacer()
            
	    	if showRectangle { // 'showRectangle == true' 일 때만 검은 사각형 나타내기
	      		RoundedRectangle(cornerRadius: 25)
	        		.frame(width: 250, height: 350)
	        		.frame(maxWidth: .infinity, maxHeight: .infinity) 
					// transition이 화면 가장자리부터 시작하게끔 frame 설정
          			.transition(.move(edge: .leading)) // 화면 왼쪽 가장자리에서 동작이 시작하고 끝남
        	}
            
        	Spacer()
            
        	Button {
                
        	} label: {
	        	ZStack {
					// 버튼 UI
	          		RoundedRectangle(cornerRadius: 15)
	            		.frame(width: 300, height: 50)
	            		.shadow(radius: 5)
            		Text("Click Me!")
	            		.foregroundColor(.white)
          		}
          		.onTapGesture {
	          		withAnimation(.easeInOut) {
	            		showRectangle.toggle() // 버튼 누르면 showRectangle의 bool 값이 바뀜
            		}
          		}
        	}
      	}
    }
	}
}
```

### **AnyTransition**

- `.transition(_:)`에 들어가는 인수
- extension으로 offset, scale, opacity, slide, combined, move(), modifier<> … 등의 다양한 애니메이션 속성을 가지고 있다.

위의 transition 코드를 아래 코드로 대체하면 아래와 같이 scale 속성을 이용한 더 동적인 애니메이션을 구현할 수 있다.

```swift
.transition(AnyTransition.scale.animation(.easeInOut))
```

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/454c6143-be08-428f-925e-2783ad84be74" width = 300>

<br>
<br>

# **(2) Custom Transition**

- 나만의 transition을 커스텀해서 만들 수 있다.

<br>

버튼을 누르면 화면의 오른쪽 아래에서 검은 사각형이 왼쪽으로 180도 돌면서 나타나고, 다시 버튼을 누르면 오른쪽으로 180도 돌면서 아래로 사라지는 transition을 구현해보자.

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/a270c75e-7d62-4e23-87b4-673e8a072e2e" width = 300>

우선 custom view modifier를 만들어 rotate 인터랙션을 위한 modifier를 만들고,

AnyTransition의 extension을 새로 만들어 transition을 만들어보자.

```swift
// Custom View Modifier
struct RotateViewModifier: ViewModifier {       // 모든 ViewModifier는 body 필요
  	let rotation: Double
  
	func body(content: Content) -> some View {    // content를 rotate 시키는 함수
		content
			.rotationEffect(Angle(degrees: rotation)) // rotation 값 만큼 돌아감
			.offset(
	     		x: rotation != 0 ? UIScreen.main.bounds.width : 0, 
        		y: rotation != 0 ? UIScreen.main.bounds.height : 0
				// rotation이 0도가 아니라면 x(y)좌표를 화면 (너비)높이만큼 offset하고, 0도라면 offset하지 말아라.
      		)
  	}
}

// Transition
extension AnyTransition {
  	// (1) rotating (variable) - 각도 180도 고정
	static var rotating: AnyTransition {
	  	return AnyTransition.modifier(
	    	active: RotateViewModifier(rotation: 180), // 동작의 완료 시점 (돌아감)
	    	identity: RotateViewModifier(rotation: 0)) // 동작의 시작 시점 (제자리)
  	}
	
	// (2) rotating (method) - 각도 값 그때그때 받아오기
	static func rotating(rotation: Double) -> AnyTransition {
	  	return AnyTransition.modifier(
	    	active: RotateViewModifier(rotation: rotation),
      	identity: RotateViewModifier(rotation: 0))
  	}
}
```

### `.modifier(active:identity:)`

active modifier와 identity modifier 사이에 정의된 transition을 return 한다.

- active: ViewModifier
- identity: ViewModifier

<br>

### **1. (1) `rotating`(variable)을 이용한 transition**

위의 AnyTransition의 extension으로 만들어준 (1) rotating(variable)을 이용해 나의 custom transition을 활용할 수 있다.

```swift
struct AnyTransitionBootcamp: View {

	@State private var showRectangle: Bool = false

  	var body: some View {
	  	VStack {
	    	Spacer()
            
	    	if showRectangle { // 'showRectangle == true' 일 때만 검은 사각형 나타내기
	      		RoundedRectangle(cornerRadius: 25)
	        		.frame(width: 250, height: 350)
	        		.frame(maxWidth: .infinity, maxHeight: .infinity) 
					// transition이 화면 가장자리부터 시작하게끔 frame 설정
          			.transition(AnyTransition.rotating.animation(.easeInOut))
        	}
            
        	Spacer()
            
        	Button {
                
        	} label: {
	        	ZStack {
					// 버튼 UI
	          		RoundedRectangle(cornerRadius: 15)
	            		.frame(width: 300, height: 50)
	            		.shadow(radius: 5)
            		Text("Click Me!")
	            		.foregroundColor(.white)
          		}
          		.onTapGesture {
	          		withAnimation(.easeInOut) {
	            		showRectangle.toggle() // 버튼 누르면 showRectangle의 bool 값이 바뀜
            		}
          		}
        	}
      	}
    }
}
```

<br>

### **2. (2) `rotating(rotation:)`을 이용한 transition**

rotating(variable)은 rotation 값이 180도로 고정이 되어있다. 180도 외에 상황 별로 그때 그때 다른 rotation 값을 받아 사각형을 돌리고 싶다면 만들어둔 rotating method를 사용하자.

위에 썼던 코드에서 transition 부분만 아래처럼 바꿔보자. 임의로 사각형을 1080도 회전시킨다고 가정해보자.

```swift
.transition(.rotating(rotation: 1080))
```

같은 시간 안에 1080도를 돌게 되면 너무 빠르기 때문에, `onTapGesture`의 애니메이션 시간을 5초로 설정하자.

```swift
.onTapGesture {
	withAnimation(.easeInOut(duration: 5.0)) {
	  	showRectangle.toggle()
  	}
}
```
<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/ba1e21b5-3135-4efa-9d4d-68f574aef425" width = 300>

<br>

### **3. Asymmetric Transition**

- 화면에 나타낼 때의 transition과 제거할 때의 transition이 다를 때 사용한다.

AnyTransition extension에 아래 속성을 하나 더 추가해보자.

```swift
static var rotateOn: AnyTransition {
	return AnyTransition.asymmetric(
	  	insertion: .rotating,           // 돌면서 화면으로 들어오고,
    	removal: .move(edge: .leading)) // 왼쪽 가장자리로 화면을 나간다
}
```

그리고 메인 뷰의 transition 부분을 아래처럼 바꿔서 rotateOn transition을 사용해보자.
```swift
.transition(.rotateOn)
```

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/2e36677f-ab16-42e6-99e5-97b7607a4f05" width = 300>
