# **#9 Backgrounds & Overlays**


## **Backgrounds**

- 요소의 뒷 배경에 다른 요소를 추가할 수 있다.
- background로 도형을 넣을 시, frame 면적을 최대한 채울 수 있는 크기로 그려진다.

![image.jpg1](https://user-images.githubusercontent.com/126866283/233783919-a15767a2-c5c8-453f-870a-d5889fd7ed83.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/233784003-5e1dd966-bfac-4b36-b313-d0124f0004da.png) |![image.jpg3](https://user-images.githubusercontent.com/126866283/233784030-fe2770e5-32fe-4d69-81ce-b0379b995136.png) |![image.jpg4](https://user-images.githubusercontent.com/126866283/233784044-4b1d5949-de26-41e9-a82f-82f4c3513804.png)
--- | --- | --- | --- |

```swift
Text("Hello, World!")
	.frame(width: 100, height: 100, alignment: .center)
  	.background(
		// #1 정사각형 frame 빨간색으로 채우기
		Color.red

		// #2 정사각형 frame에 '왼쪽(빨강)->오른쪽(파랑)' 그라데이션 적용
		LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)

		// #3 정사각형 frame 안에 파란색 원 그리기
		Circle()
		    .fill(Color.blue)
	)

	// #4 첫번째 frame 뒤에 또다른 frame 만든 후, 빨간색 원으로 채워넣기
	.frame(width: 120, height: 120, alignment: .center)
  	.background(
	  	Circle()
	   		.fill(Color.red)
  	)
```
<br>

- 한 가지 background 안에 여러 도형과 그에 맞는 frame을 각각 설정할 수도 있다.

<img src="https://user-images.githubusercontent.com/126866283/233784794-eb744630-9728-4310-b222-cae144c0b790.png">

```swift
Text("Hello, World!")
	// 안쪽 원
	.background(
		Circle()
			.fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
      		.frame(width: 100, height: 100, alignment: .center)
  	)
	// 바깥쪽 원
  	.background(
	  	Circle()
	    	.fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.red]), startPoint: .leading, endPoint: .trailing))
      		.frame(width: 120, height: 120, alignment: .center)
    )
```

<br>

## **Overlays**

- 요소의 앞에 다른 요소를 추가할 수 있다.

<img src="https://user-images.githubusercontent.com/126866283/233786375-f1c6c7f1-ca1c-4d07-9c90-2b8970a2c18c.png">

```swift
Circle()
	.fill(Color.pink)
	.frame(width: 100, height: 100, alignment: .center)
  	.overlay(
	  	Text("1")
	    	.font(.largeTitle)
	   		.foregroundColor(.white)
  )
```
<br>

## **Backgrounds & Overlays 동시 응용**

![image.jpg1](https://user-images.githubusercontent.com/126866283/233786791-848c0874-ea3e-4985-8202-fc5508a6b78f.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/233786967-dc33f1e2-b7a2-4bed-9e4f-36e0232458ed.png) 
--- | --- |


```swift
// 까만 사각형
Rectangle()
	.frame(width: 100, height: 100)

	// #1 overlay - 왼쪽 상단에 파란 사각형
  	.overlay(
		Rectangle()
			.fill(Color.blue)
		    .frame(width: 50, height: 50)
	    , alignment: .topLeading
  	)
  
	// #2 background - 오른쪽 아래 모서리 기준으로 정렬된 큰 빨간 사각형
	.background(
		Rectangle()
		    .fill(Color.red)
          	.frame(width: 150, height: 150)
        , alignment: .bottomTrailing
    )
```
<br>

## **Backgrounds & Overlays 실제 활용 예시**
- 한가지 background / overlay 안에는 여러 겹의 background / overlay가 존재할 수 있다.

![image.jpg1](https://user-images.githubusercontent.com/126866283/233789527-1755aa90-de88-4ecf-baad-3a9bd63c90b5.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/233789548-91327673-3628-43ca-81e2-03613149e871.png) |![image.jpg3](https://user-images.githubusercontent.com/126866283/233789565-7eac9d0e-078b-45d9-9b79-eda5890358f9.png) 
--- | --- | --- |

```swift
/* #0 흰색 하트 아이콘 */
Image(systemName: "heart.fill")
	.font(.system(size: 40))
	.foregroundColor(.white)

	/* #1 background - 보라색 그라데이션 원 */
	.background(
		Circle()
			.fill(
				LinearGradient(
					gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))]),
					startPoint: .topLeading,
					endPoint: .bottomTrailing
				)
			)
			.frame(width: 100, height: 100)
			.shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 0.5)), radius: 10, x: 0.0, y: 10)
			      
			/* #2 overlay - 파란색 알림 원 */
			.overlay(
				Circle()
					.fill(Color.blue)
						.frame(width: 35, height: 35)

						/* #3 overlay - 알림 숫자 */
					    .overlay(
							Text("5")
								.font(.headline)
							    .foregroundColor(.white)
						)
					    .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 0.5)), radius: 10, x: 0.0, y: 10)
				, alignment: .bottomTrailing // 파란색 원을 보라색 원의 오른쪽 아래로 정렬
			)
	)
```
