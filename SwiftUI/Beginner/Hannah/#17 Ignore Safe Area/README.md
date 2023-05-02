# **#17 Ignore Safe Area**


- **시스템에 의해 가려질 수 있는 부분(ex.노치)의 마진을 자체적으로 주는 것**
    - 즉, 기기의 물리적인 요소에 의해 가려질 위험이 없는, 기기 화면 중 view를 보여주기에 안전한 영역
    - iOS 14.3부터 .edgesIgnoringSafeArea(.____) → .ignoreSafeArea(edges: .____)로 바뀜
- 기기 종류마다 지정된 safe area 가 다르다.


![image.jpg1](https://user-images.githubusercontent.com/126866283/235299126-07d89c0e-4250-4a86-8559-3840527a2ddf.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/235299154-8d8a2bf6-7f1f-43c0-b510-2191f1e1426d.png) |
--- | --- |


<br>
<br>

## IgnoresSafeArea

- frame의 크기를 safe area를 무시하고 더 넓게 설정할 수도 있다.

![image.jpg1](https://user-images.githubusercontent.com/126866283/235299272-df22bd08-b8bb-4a1a-a0f4-558b986cacda.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/235299296-8bf77a85-dcb2-42c6-a49e-be3395148aea.png) |![image.jpg3](https://user-images.githubusercontent.com/126866283/235299332-1029952c-748a-492e-8885-72b72732870d.png) |![image.jpg4](https://user-images.githubusercontent.com/126866283/235299421-c65e0bdc-82ee-461e-8af5-60352ca7dc33.png) 
--- | --- | --- | --- 

```swift
Text("Hello, World!")
	.frame(maxWidth: .infinity, maxHeight: .infinity) 
	// 너비, 높이가 safe area 내에서의 최대 길이
	.background{Color.red}

  .ignoresSafeArea(edges: .top)    // safe area 위의 빈 부분까지 포함한 화면
  .ignoresSafeArea(edges: .bottom) // safe area 아랫부분까지 포함한 화면
  .ignoresSafeArea(edges: .all)    // 화면 전체
```
<br>

> **.background{ }라고 쓰는 이유**
> 
> 
> 기존에 쓰던 `.background()`를 쓰게 되면 자동으로 safe area를 무시하고 전체 화면이 빨간색으로 선택된다. 그 이유는,
> 
> ```swift
> func background<S>(_ style: S, ignoresSafeAreaEdges edges: Edge.Set = .all) -> some View where S : ShapeStyle위 
> ```
> 
> background modifier의 정의를 살펴보면 `ignoresSafeAreaEdges`의 기본 디폴트 값으로 `.all`이 설정되어 있기 때문이다. 이를 해결하기 위해서는 **.background의 괄호를 ( ) 에서 { }로 바꿔주면 된다.**
> 
> [Why does View background extend into safe area? – SwiftUI – Hacking with Swift forums](https://www.hackingwithswift.com/forums/swiftui/why-does-view-background-extend-into-safe-area/13473)
> 

<br>
<br>


## Background와 foreground 별로 SafeArea 영역 구분하기


![image.jpg1](https://user-images.githubusercontent.com/126866283/235299674-2026fe74-ffcc-404b-a529-a55fc0a833dd.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/235299695-0afe8f03-f498-44ca-8ae0-f6b68617f42c.png)
--- | --- |


```swift
VStack {
	Text("Hello, World!")
		.padding(.top, 50) // padding 값으로 글씨 내리기
	Spacer()
}
.frame(maxWidth: .infinity, maxHeight: .infinity) 
.background{Color.red}
.ignoresSafeArea(edges: .all)
```

text가 상단 까만 부분에 가려져서 보이지 않을 때가 있다.

이럴 때 frame에 top padding 값을 주어서 text를 수동으로 내릴 수도 있지만, 그렇게 되면 기기가 무엇인지에 따라 safe area의 값이 전부 달라지기 때문에 일일이 수치를 알고 수정하기 불가능하다.

<br>

```swift
ZStack {
	// background
	Color.blue
		.ignoresSafeArea(edges: .all)

	// Foreground
	VStack {
		Text("Hello, World!")
		Spacer()
	}
	.frame(maxWidth: .infinity, maxHeight: .infinity) 
	.background{Color.red}
```

<img src="https://user-images.githubusercontent.com/126866283/235299809-bc0e9af7-98cd-4472-8164-b5f22d1f355e.png" width=100>

이럴 때 ZStack 안에 VStack을 넣어서 **background와 foreground를 나누고**,

VStack에 걸어두었던 **.ignoresSafeArea(edges: .all)** 를 ZStack의 파란 background에 걸어주면 기기마다 다른 safeArea에 맞게끔 자동으로 text가 보일 수 있게 설정할 수 있다.

**text 외의 다른 버튼이나 요소들이 있어도, VStack안에 들어있으면 safe area를 벗어나지 않는다.*


<br>
<br>

## ScrollView와 SafeArea

<img src="https://user-images.githubusercontent.com/126866283/235300288-5860897b-e1e3-4f40-b15a-8f81256aafab.png" width=100>


```swift
ScrollView {
	VStack {
	  Text("Title goes here")
	    .font(.largeTitle)
	    .frame(maxWidth: .infinity, alignment: .leading)
                
    ForEach(0..<10) { index in // 10번 반복해서 박스 그리기
	    RoundedRectangle(cornerRadius: 25.0)
	      .fill(Color.white)
        .frame(height: 150)
        .shadow(radius: 10)
        .padding(20)
    }
	} // ----- VStack end
} // ----- ScrollView end
.background{Color.red}
.ignoresSafeArea(edges: .all)
```

<img src="https://user-images.githubusercontent.com/126866283/235300434-684e0012-f223-4284-b62a-f614a5c9ca89.png" width=100>


```swift
ScrollView {
	VStack {
	  Text("Title goes here")
	    .font(.largeTitle)
	    .frame(maxWidth: .infinity, alignment: .leading)
                
    ForEach(0..<10) { index in // 10번 반복해서 박스 그리기
	    RoundedRectangle(cornerRadius: 25.0)
	      .fill(Color.white)
        .frame(height: 150)
        .shadow(radius: 10)
        .padding(20)
    }
	} // ----- VStack end
} // ----- ScrollView end
.background{
	Color.red
		.ignoresSafeArea(edges: .all)
}
```

글씨와 사각형 요소들이 Safe area 안에 있도록 하기 위해 ‘ignoresSafeArea(edges: .all)’의 위치를 .background() 안으로 옮겼다.

기존엔 scroll view 자체가 전체 화면을 차지 → **위치 변경 이후엔 배경 red color만 전체화면 차지**