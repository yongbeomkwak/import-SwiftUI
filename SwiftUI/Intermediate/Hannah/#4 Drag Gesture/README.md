# **#4 Rotation Gesture**

- 한 손가락을 이용해 원하는 곳으로 요소를 drag해서 이동시키는 gesture.
- SwiftUI Gesture 중 가장 중요하고 자주 쓰이는 기능이다.

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/d27ce7a6-c706-472c-85ef-96b54e0bdb2e" width = 300>


```swift
struct DragGestureBootcamp: View {
    
	@State var offset: CGSize = .zero        // 드래그 값을 0으로 초기화

  	var body: some View {
	  	RoundedRectangle(cornerRadius: 20)
	    	.frame(width: 100, height: 100)
      		.offset(offset)
      		.gesture(
	    		DragGesture()
	        		.onChanged { value in    // 드래그 중일 때, 손가락 위치로 사각형 이동
	          			withAnimation(.spring()) {
	            			offset = value.translation
            			}
         			}
          			.onEnded { value in      // 손을 뗐을 때, 원래 위치로 이동
	          			withAnimation(.spring()) {
	            			offset = .zero   // CGSize(width: 0, height: 0)와 같은 말
            			}
          			}
      		)
  	}
}
```

**`value`와 `value.translation`의 차이점**

-> 아래처럼 입력해보고 출력값을 구분해보자.

```swift
print(value)
print(value.translation) 
```
<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/1cf668a8-4c40-4763-91c4-b7b3352f8d3c" >


- `value`: 사각형을 이동시킬 때 나오는 여러 데이터를 한번에 보여줌 (time, location, startLocation, velocity)
- `value.translation`: x축과 y축으로 각각 얼마나 움직였는지를 좌표값으로 나타내줌 (location - startLocation 값)

<br>
<br>

## **Example 1) 틴더 앱의 카드 인터랙션**

- 카드를 좌우로 넘기면 크기가 살짝 작아지면서 드래그 하는 방향으로 회전을 한다.

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/49a83d10-7916-4ada-b03e-0bf1fbb73053" width = 250>

View 안에 다음 코드를 적어보자.

```swift
@State var offset: CGSize = .zero        // 원래 위치에서 얼만큼 이동시킬 것인지 (x,y)
    
var body: some View {
	ZStack {

	  	VStack {
	    	Text("\(offset.width)")
      		Spacer()
    	}
            
    	RoundedRectangle(cornerRadius: 20)
	    	.frame(width: 300, height: 500)
      		.offset(offset).                // offset 변수값 만큼 카드를 움직여라!
      		.scaleEffect(getScaleAmount())  // 크기 변경
      		.rotationEffect(Angle(degrees: getRotationAmount())) // 각도 비틀기
      		.gesture(
		    	DragGesture()
	        		.onChanged { value in   // 드래그 중일 때, 손가락 위치로 사각형 이동
	          			withAnimation(.spring()) {
		          			offset = value.translation
            			}
          			}
          			.onEnded { value in     // 손을 뗐을 때, 원래 위치로 이동
	          			withAnimation(.spring()) {
	            			offset = .zero  // CGSize(width: 0, height: 0)와 같은 말
            			}
          			}
	    	)
  	}
}
```

위 .scaleEffect()와 .rotationEffect에 쓰인 함수 `getScaleAmount()`와 `getRotationAmount()`를 View 아래에다가 정의해주자.

```swift
func getScaleAmount() -> CGFloat { // CGFloat - 위에 .scaleEffect에서 취급하는 데이터 단위
	
	let max = UIScreen.main.bounds.width / 2    
		// 카드가 이동할 수 있는 x좌표값의 최대치 = 화면 width 상 절반까지
  	let currentAmount = abs(offset.width)       
		// |(현재 카드의 위치의 x좌표)-(중앙의 x좌표)|
		// 카드가 왼쪽으로 가면 offset.width는 음수가 나오기 때문에, 해당 값의 절대값이 나오도록 abs 붙이기
  	let percentage = currentAmount / max
  	return 1.0 - min(percentage, 0.5) * 0.5     
		// 카드가 최대 0.5*0.5 까지만 작아지게끔. min(x,y): x와 y 중 더 작은 것을 내보냄. x=y일 때 x를 내보냄
}
```

```swift
func getRotationAmount() -> Double {
	
	let max = UIScreen.main.bounds.width / 2
  	let currentAmount = offset.width            
		// 왼쪽으로 가면(-) 왼쪽으로 rotate, 오른쪽으로 가면(+) 오른쪽으로 rotate
  	let percentage = currentAmount / max
  	let percentageAsDouble = Double(percentage)
  	let maxAngle: Double = 10                   
		// 카드를 회전시킬 최대 각도
  	return percentageAsDouble * maxAngle
}
```
<br>
<br>

## **Example 2) 위로 드래그하면 올라오는 팝업 뷰**

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/f3dd8ea9-c4c2-4490-95f9-ed82334146ec" width = 250>

- 배경은 초록색이다.
- 아래에 살짝 보이는 흰색 MySignUpView를 위로 드래그하면, top safe area를 제외한 화면의 모든 부분이 흰색 팝업 뷰로 채워진다.
- 다시 MySignUpView를 아래로 드래그하면 원래 상태대로 뷰가 살짝만 보이게 바뀐다.

<br>

우선, View 아래에 흰색 Sign Up 창과 관련된 `MySignUpView()`를 만들자.
<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/eb2af0aa-ac5a-456e-90aa-3487fef8ec32" width = 250>

```swift
struct MySignUpView: View {
	var body: some View {
	  	VStack(spacing: 20) {
	    	Image(systemName: "chevron.up")
	      		.padding(.top)
      	Text("Sign up")
	      	.font(.headline)
        	.fontWeight(.semibold)
            
      	Image(systemName: "flame.fill")
	      	.resizable()
        	.scaledToFit()
        	.frame(width: 100, height: 100)
            
      	Text("This is the decrption for our app. This is my favorite SwiftUI course and I recommend to all of my friends to subscribe to Swiftful Thinking!")
	     	.multilineTextAlignment(.center)
            
      	Text("CREATE AN ACCOUNT")
	      	.foregroundColor(.white)
        	.font(.headline)
        	.padding()
        	.padding(.horizontal)
        	.background(Color.black.cornerRadius(10))
      	Spacer()
    }
    .frame(maxWidth: .infinity)
    .background(Color.white)
    .cornerRadius(30)
  }
}
```

위 `MySignUpView()` 의 작동법을 다루는 main view를 만들어보자.

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/47d2b3df-84ae-48b3-8408-02b63651d5fc" width = 250>

```swift
struct DragGestureBootcamp2: View {
    
	@State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.85 
	// 처음에 MySignUpView()의 y축 상 시작점
  	@State var currentDragOffsetY: CGFloat = 0  // 현재 drag 중인 손가락의 y 좌표
  	@State var endingOffsetY: CGFloat = 0       // 손을 뗐을 때 MySignUpView()의 y좌표
    
  	var body: some View {
	  	ZStack {
			
	    	Color.green.ignoresSafeArea()
            
      		MySignUpView()
	      		.offset(y: startingOffsetY)
        		.offset(y: currentDragOffsetY)
        		.offset(y: endingOffsetY)
        		.gesture(
	        		DragGesture()
	          			.onChanged { value in // value = 현재 손가락 위치
	            			withAnimation(.spring()) {
	              				currentDragOffsetY = value.translation.height 
								// translation: CGSize로, x와 y 값 전부 가지고 있음. 그 중 우리는 height(x)를 사용
              				}
            			}
            			.onEnded { value in
	            			withAnimation(.spring()) {
	              				if currentDragOffsetY < -150 { 
									// 흰 창이 아래에 있는 상태에서 위로 150 이상 드래그 한다면,
	                				endingOffsetY = -startingOffsetY  // 흰 창을 가장 위로 보내자!
                				} else if ~~endingOffsetY != 0 &&~~ currentDragOffsetY > 150 { 
									// 흰 창이 위에 있는 상태에서 아래로 150 이상 드래그 한다면,
	                				endingOffsetY = 0    // 흰 창을 가장 밑으로 보내자!
                				}
                				currentDragOffsetY = 0   // 현재 손 위치 0으로 초기화
              				}
            			}
        		)
			Text("\(currentDragOffsetY)")
		}
    	.ignoresSafeArea(edges: .bottom)
  	}
}
```

### **offset**

현재 있는 위치부터 얼만큼 움직일지 명령을 줄 수 있다.

```swift
@inlinable public func offset(x: CGFloat = 0, y: CGFloat = 0) -> some View
```

- x값은 양수(+)이면 오른쪽, 음수(-)이면 왼쪽으로 움직이고,
- y값은 양수(+)이면 아래, 음수(-)이면 위로 움직이게 된다.

