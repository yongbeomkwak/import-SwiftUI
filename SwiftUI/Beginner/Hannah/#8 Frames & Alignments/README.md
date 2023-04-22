# Frames
- 한 텍스트 뒤에 여러 frame을 넣을 수 있다.
- background와 frame 여러 개를 한 번에 겹겹이 쌓을 수 있다.

<br>

## Text의 기본 frame

- frame의 크기를 정해주지 않는다면 text의 기본 영역 자체가 frame이 된다.

<img src="https://user-images.githubusercontent.com/126866283/233776079-941304ca-9af1-4040-b6e1-020ed7a7e8e7.png" width="200"/>


```swift
Text("Hello, World!")
  .background(Color.green)
```
<br>

## 여러 겹으로 쌓을 수 있는 frame

- frame은 밑에 쓴 코드일수록 화면상 제일 밑에 깔린다. (위의 요소들을 전부 담는 쟁반이라고 생각하면 편함)
- **.infinity -** 화면 내에서의 최대 길이

<img src="https://user-images.githubusercontent.com/126866283/233776208-d2fe9c40-4d2c-426b-9345-4263cc335ae1.png" width="200"/>


```swift
Text("Hello, World!")
	.background(Color.green)

  .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) 
  .background(Color.red)
	// "Hello, World!"와 초록 배경은 빨간 frame 안의 content(요소)들이다
```
<br>

## 여러 frame의 활용과 정렬

![image.jpg1](https://user-images.githubusercontent.com/126866283/233776382-7419ab70-e0d3-42cd-ab6a-793e5728d6df.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/233776415-bd708024-212a-4a4a-a15d-d45443b20886.png) |![image.jpg3](https://user-images.githubusercontent.com/126866283/233776622-16a8e08d-e68f-44e2-9d16-d7a2905182ee.png) |![image.jpg4](https://user-images.githubusercontent.com/126866283/233777053-9af3b98d-0444-4f2b-aaef-093370aa6865.png) |![image.jpg5](https://user-images.githubusercontent.com/126866283/233777096-bfc92ff9-3205-4ec8-9f6d-38abf289dcc5.png)
--- | --- | --- | --- | --- |


```swift
Text("Hello, World!")
	.background(Color.green)

	// (1) 텍스트상자를 상단 정렬로 포함하는, 높이가 100인 orange frame
  .frame(height: 100, alignment: .top)
  .background(Color.orange)
	
	// (2) 위의 모든 요소를 (가운데 정렬로) 포함하는, 너비가 150인 purple frame
	.frame(width: 150)
  .background(Color.purple)

	// (3) 위의 모든 요소들을 왼쪽 정렬로 포함하는, 너비가 화면 너비만한 pink frame
	.frame(maxWidth: .infinity, alignment: .leading) 
  .background(Color.pink) 

	// (4) 위의 모든 요소들을 (가운데 정렬로) 포함하는, 높이가 400인 green frame
	.frame(height: 400)
  .background(Color.green)

	// (5) 위의 모든 요소들을 상단 정렬로 포함하는, 높이가 화면 높이만한 yellow frame
	.frame(maxHeight: .infinity, alignment: .top)
  .background(Color.yellow)
```





