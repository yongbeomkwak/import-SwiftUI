# **#3 Rotation Gesture**

- 두 손가락을 이용해 화면 속 요소를 회전시키는 제스처.
- 두 손가락 터치패드: xcode 시뮬레이터 상에서 option 버튼을 누른 상태로 마우스로 화면을 드래그

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/97403ced-28b4-4497-811b-67a0dde3a688" width=300>

```swift
struct RotationGestureBootcamp: View {
    
	@State var angle: Angle = Angle(degrees: 0) 
	// Angle이라는 SwiftUI 타입으로 angle 설정 후, 각도는 0도로 초기화시켜준다.
    
 	var body: some View {
		// 파란 사각형 UI 코드
	  	Text("Hello, World!")
	    	.font(.largeTitle)
      		.fontWeight(.semibold)
      		.foregroundColor(.white)
      		.padding(50)
      		.background(Color.blue.cornerRadius(10))

      	// Rotation 관련 코드
      		.rotationEffect(angle) // 실제로 입력된 각도에 따라 rotation 인터랙션을 실행시키는 함수
      		.gesture(
	      		RotationGesture()
	        		.onChanged { value in  // 두 손가락으로 돌리면 그 각도를 받아옴
	          			angle = value 
          			}
          			.onEnded { value in    // 손가락을 떼면 튕기는 애니메이션과 함께 각도값 0을 받아옴
	          			withAnimation(.spring()) {
		          			angle = Angle(degrees: 0)
            			}
          			}
      		)
   	}
}
```
<br>

### **rotationEffect()**

- 실제로 rotation 동작을 실행시키는 함수
- angle: Angle type의 매개 변수, anchor: UnitPoint type의 매개변수를 받아 실행됨

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/a84b8eaf-57ad-4856-8bab-d51b4adab749">

<br>

### **RotationGesture()에서의 value 값**

- 두 손가락으로 요소를 돌렸을 때, 그 각도를 radian 값으로 받아옴.

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/01a00369-7e33-4385-9843-658f10012283" width=300>

<br>

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/9baee918-6603-4e74-864e-06b6a2519845" >

*Angle 관련 definition*

