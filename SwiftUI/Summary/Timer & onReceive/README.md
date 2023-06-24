# **24 Timer & onReceive**

## **1. 현재 시간 나타내기**

실시간적인 시간의 변화를 화면에 나타내보자.

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/e69835e2-e298-4e20-ab37-f1554fce3b18" width = 400>

```swift
struct TimerBootcamp: View {
	let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
	@State var currentDate: Date = Date() // Date(): 지금 현재의 date를 뜻함
```
### `Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()`

- `every:` : 몇 초마다? *-> 1.0초마다*
- `on:` : 어떤 thread에서 timer를 run 할 것인지 *-> main thread에서(UI 그리는 것과 관련이 있기 때문)*
- `in:` : .common, .default, .trackin
- `.autoconnect()` : 해당 publisher(timer)를 뷰를 초기화하고 다시 로드할 때마다 자동으로 멈추고 다시 시작시키는 기능

```swift
	var body: some View {
	  	ZStack {
			// 배경색
	    	RadialGradient(
	      		gradient: Gradient(colors: [Color(.blue), Color(.black)]),
        		center: .center,
        		startRadius: 5,
        		endRadius: 500)
	    	.ignoresSafeArea()

      		// 타이머 글씨
      		Text(currentDate.description)
	      		.font(.system(size: 100, weight: .semibold, design: .rounded))
        		.foregroundColor(.white)
        		.lineLimit(1)             // 글이 길어져도 한 줄에 다 적히도록 설정
        		.minimumScaleFactor(0.1)  // 글씨가 너무 커질 시 한 줄에 글이 적힐 수 있도록 scale down 하게끔 만들어줌
      	}
		// SUBSCRIBER - PUBLISHED된 값의 변화를 감지할 때마다 특정 action을 실행
      	.onReceive(timer) { value in
	      	currentDate = value       // timer로 받아온 현재 시간 정보를 currentDate 안에 넣어주자
      	}
	}
}
```

### `.onReceive(publisher:perform)`
<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/5c1bba21-da6a-4c51-b95f-b7ba53a4eaa2" width = 600>

- `publisher`: 특정 값을 내보내는 publisher면 다 쓸 수 있음 (ex. timer)
- `perform`: **{ _ in  }** 의 형태로 작성.
    
    → 이 때, _에는 해당 publisher로 받아온 값이 들어오게 된다.
    
<br>

### **Custom Timer**

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/ce0b4dae-04f9-4608-8bf1-4dfc114daee6" width = 400>

```swift
struct TimerBootcamp: View {

	@State var currentDate: Date = Date() // Date(): 지금 현재의 date를 뜻함
	
	var dateFormatter: DateFormatter {
	  	let formatter = DateFormatter()
    	formatter.dateStyle = .medium       // 날짜 형식
    	formatter.timeStyle = .medium       // 시간 형식
    	return formatter
  	}

	var body: some View {
		...
		Text(dateFormatter.string(from: currentDate))
		...
	}
}
```

*Date Formatter에 대한 상세 내용은 Bootcamp <#40 Date Picker> 참고!*

<br>
<br>

---

## **2. 10초 카운트다운하기**

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/ec214330-14e7-4fb9-90d0-a3205339f4c8" width = 400>

1초마다 1씩 감소하는 10초 카운트다운 타이머를 만들어보자. (완료 시 “Wow!” 메세지 띄우기)

```swift
struct TimerBootcamp: View {
	let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
	@State var count: Int = 10             // 시작 시간 설정
  	@State var finishedText: String? = nil // 처음에는 값이 없다가 끝났을 때 생기게끔
```

```swift
	var body: some View {
	  	ZStack {
			// 배경색
	    	RadialGradient(
	      		gradient: Gradient(colors: [Color(.blue), Color(.black)]),
        		center: .center,
        		startRadius: 5,
        		endRadius: 500)
	    	.ignoresSafeArea()

      		// 타이머 글씨
      		Text(finishedText ?? "\(count)") // finishedText 값은 optional. finishedText에 값이 없다면 count의 값을 넣어라.
	      		.font(.system(size: 100, weight: .semibold, design: .rounded))
        		.foregroundColor(.white)
        		.lineLimit(1)
        		.minimumScaleFactor(0.1)
      	}
		// SUBSCRIBER - PUBLISHED된 값의 변화를 감지할 때마다 특정 action을 실행
      	.onReceive(timer) { _ in
	      	if count <= 1 {                // 10 카운트다운이 끝났을 경우, wow 표시 해주기
	        	finishedText = "Wow!"
        	} else {                       // 아닌 경우 1씩 감소시키기
	        	count -= 1
        	}
      	}
	}
}
```
<br>
<br>

---

## **3. 24시간 타이머 만들기**

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/7b727f25-ae78-431e-a147-a20d104a0960" width = 400>

24시간 타이머를 설정해두고 1초씩 감소하게 만들어보자.

```swift
struct TimerBootcamp: View {
	let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
	@State var timeRemaining: String = ""  // 남은 시간
  	let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
  	// 만약 Calendar.current.date의 값이 없을 시, 현재 실시간 시각을 나타내라 (Date())

	// 1초마다 새로 불러올 함수 (현재 남은 시간 보여주기)
  	func updateTimeRemaining() {
	  	let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
    	let hour = remaining.hour ?? 0
    	let minute = remaining.minute ?? 0
    	let second = remaining.second ?? 0
    	timeRemaining = "\(hour):\(minute):\(second)"
  	}
```

### `Calendar.current.date(byAdding:value:to:) ?? Date()`

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/f85a7d84-dd72-41ba-bd95-f379fba66442" width = 600>

- `Calendar.current.date()`: 시간을 불러오자
- `byAdding:`: 시간의 단위 - .day(일 단위) / .hour(시간 단위) / .minute(분 단위) / .second(초 단위) … 로
- `value:`: 타이머의 초기값 (Int 값)
- `to:` : 시작 시간(Date 값) → 현재는 임의로 Date()라고 설정해 놓았지만, 실제 응용 상황에 따라 언제 24시간 카운트를 멈출지 설정해두면 된다.

### `Calendar.current.dateComponents(_ components:from:to:)`

**→ 입력된 두 시간 간의 차이값을 return 해주는 함수.**

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/d8d4e860-de37-4675-88c0-cb63da3186f7" width = 600>

- `components`: 시간, 날짜와 관련된 값들. [ ] 안에 필요한 요소들을 나열해주면 된다.
- `from:`: 시작 날짜 or 시간
- `to:`: 도달하고자 하는 날짜 or 시간

```swift
	var body: some View {
	  	ZStack {
			// 배경색
	    	RadialGradient(
	      		gradient: Gradient(colors: [Color(.blue), Color(.black)]),
        		center: .center,
        		startRadius: 5,
        		endRadius: 500)
	    	.ignoresSafeArea()

      		// 타이머 글씨
      		Text(timeRemaining)
	      		.font(.system(size: 100, weight: .semibold, design: .rounded))
        		.foregroundColor(.white)
        		.lineLimit(1)
        		.minimumScaleFactor(0.1)
      	}
		// SUBSCRIBER - PUBLISHED된 값의 변화를 감지할 때마다 특정 action을 실행
      	.onReceive(timer) { _ in
	      	updateTimeRemaining()  // timer의 값이 바뀔 때마다(1초마다) 함수 실행
      	}
	}
}
```
<br>
<br>

---

## **4. 로딩 애니메이션 만들기**

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/d55ca32e-6587-493c-85b9-5256bcb95ee7" width = 400>

```swift
struct TimerBootcamp: View {
	let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
	@State var count: Int = 0
```

```swift
	var body: some View {
	  	ZStack {
			// 배경색
	    	RadialGradient(
	      		gradient: Gradient(colors: [Color(.blue), Color(.black)]),
        		center: .center,
        		startRadius: 5,
        		endRadius: 500)
	    	.ignoresSafeArea()
			
			// 원 3개
      		HStack(spacing: 15) {
	      		Circle()
	        		.offset(y: count == 1 ? -20 : 0) // count가 1일 때 y를 -20만큼 움직이기
        		Circle()
	        		.offset(y: count == 2 ? -20 : 0) // count가 2일 때 y를 -20만큼 움직이기
        		Circle()
	        		.offset(y: count == 3 ? -20 : 0) // count가 3일 때 y를 -20만큼 움직이기
      		}
      		.frame(width: 100)
      		.foregroundColor(.white)
	  	}
		.onReceive(timer) { _ in
	    withAnimation(.easeInOut(duration:  0.5)) {
	      	count = count == 3 ? 0 : count + 1 
			// count가 3이 되면 count = 0 으로 바꾸고, 3이 아닐 땐 count += 1 해라!
      	}
    }
}
```
<br>
<br>

---

## **5. 타이머를 이용한 Tab View 만들기**

앱 속 광고들을 보면, 몇 초 후 자동으로 다음 광고로 넘어가는 tab view 화면들로 이루어져 있다.

5개의 view가 3초 후 자동으로 다음 슬라이드로 넘어가는 tab view를 만들어보자.

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/975c2d2e-cd41-41d2-8c38-a52cedd6c5e3" width = 400>

```swift
struct TimerBootcamp: View {
	let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
	// 3초마다 다음 광고로 넘어가게 하자!
	@State var count: Int = 1
```

```swift
	var body: some View {
	  	ZStack {
			// 배경색
	    	RadialGradient(
	      		gradient: Gradient(colors: [Color(.blue), Color(.black)]),
        		center: .center,
        		startRadius: 5,
        		endRadius: 500)
		    .ignoresSafeArea()
			
			// 5개의 광고 view
      		TabView(selection: $count) {
	      		Rectangle()
	        		.foregroundColor(.red)
          			.tag(1)
				Rectangle()
					.foregroundColor(.blue)
					.tag(2)
				Rectangle()
					.foregroundColor(.green)
					.tag(3)
				Rectangle()
					.foregroundColor(.orange)
					.tag(4)
				Rectangle()
					.foregroundColor(.pink)
					.tag(5)
      		}
			.frame(height: 200)
			.tabViewStyle(PageTabViewStyle())
	  	}
		.onReceive(timer) { _ in
	    	withAnimation(.default) {
	      		count = count == 5 ? 1 : count + 1 
				// count가 5이 되면 count = 1 으로 바꾸고, 5이 아닐 땐 count += 1 해라!
      		}
    	}
	}
}
```

위 예제에서는 TabView 안에 서로 다른 색의 rectangle 5가지를 넣었지만, 실제 앱에서는 직접 만든 custom view 혹은 나타내고자 하는 특정 이미지를 넣어주면 된다. 그 때는 forEach를 써서 loop을 돌려서 동작시키는 것이 좋다.