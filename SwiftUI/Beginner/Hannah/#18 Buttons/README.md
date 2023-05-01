# **#18 Buttons**

## Button 생성 및 동작

![image.jpg1](https://user-images.githubusercontent.com/126866283/235300862-1bf0a41c-056d-41a6-9d16-d1fe70331209.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/235300883-26127abc-1e27-4882-97b2-faa7a5dc3e3e.png) |![image.jpg3](https://user-images.githubusercontent.com/126866283/235300899-71f417f4-dcff-48c4-852b-2de804d5da87.png)
--- | --- | --- 


- **Button(title: *StringProtocol*, action: *() → Void*)** 형식
    - Button(”버튼 이름”, [버튼 눌렀을 시 나오는 action])

```swift
struct ButtonsBootcamp: View {
	@State var title: String = "This is my title" // (1)
    
	var body: some View {
		VStack(spacing: 20) { // 간격 20

			// (2) 'Press me!'를 누르면 'This is my title' -> 'BUTTON WAS PRESSED'로 바뀜
			Text(title)
			Button("Press me!") {
				self.title = "BUTTON WAS PRESSED" 
      }
			.accentColor(.red) // 버튼 글씨 빨갛게 바꾸기
```

빨간 “Press me!” 버튼을 누르면 ‘This is my title’ → ‘BUTTON WAS PRESSED’ 로 바뀐다.

<br>

- ⭐️⭐️⭐️**Button(action: *{ }*, label: *() → Void*)** 형식

```swift
			// (3) 'Button'을 누르면 'BUTTON WAS PRESSED' -> 'Button #2 was pressed' 로 바뀜
			Button(action: {
	      self.title = "Button #2 was pressed"
      }, label: {
        Text("Button") 
      })

	  }
  }
}
```

파란 “Button” 버튼을 누르면 ‘BUTTON WAS PRESSED’ → ‘Button #2 was pressed’ 로 바뀐다.

<br>
<br>

## Customize Button Design

<img src="https://user-images.githubusercontent.com/126866283/235301096-e637feec-8a9c-4fe9-ac32-0f74d12960a9.png" width=300>

```swift
Button(action: {
	self.title = "Button #2 was pressed"
}, label: {
	Text("Save".uppercased())
		.font(.headline)
    .fontWeight(.semibold)
		.foregroundColor(.white)
		.padding() // frame 영역 넓어지게 (디폴트값 상하좌우 8)
		.padding(.horizontal, 20) // frame 가로 길이 길어지게
		.background(
		  Color.blue // frame 파란 배경 입히기
				.cornerRadius(10) // 모서리 10만큼 둥글게
        .shadow(radius: 10) // 10만큼 그림자
    ) 
})
```

let myColor = #colorLiteral() 선언 후,

<br>

<img src="https://user-images.githubusercontent.com/126866283/235301172-be21120e-0fa5-49fa-8c07-efe51602638d.png" width=60>


```swift
// 하트 버튼
Button(action: {
	self.title = "Button #3"
}, label: {
	Circle()
		.fill(Color.white)
    .frame(width: 75, height:75)
    .shadow(radius: 10)
    .overlay(
	    Image(systemName: "heart.fill") // 하트 아이콘
	      .font(.largeTitle) // 아이콘은 font로 크기조절
        .foregroundColor(Color(myColor)) // 아이콘 색상 변경
    )
})
```


<img src="https://user-images.githubusercontent.com/126866283/235301216-2ba6c68d-60da-4500-acad-d7c187dce382.png" width=100>

```swift
// FINISH 버튼
Button(action: {
	self.title = "Button #4"
}, label: {
	Text("Finish".uppercased())
		.font(.caption)
		.bold()
    .foregroundColor(.gray)
    .padding()
    .padding(.horizontal, 10)
    .background(
		  Capsule()
      .stroke(Color.gray, lineWidth: 2.0)
	  )
})
```

