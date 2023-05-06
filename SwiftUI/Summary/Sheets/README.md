# **#28 Sheets**

- `.sheet(isPresented: __, content: __)`
- `.sheet` modifier : 한 view 안에 **한 번만** 사용할 수 있다.
- .sheet { } 안에 `if {} else {}` 를 사용해 상황 별로 다른 sheet을 호출하는 ~~**conditional logic은 절대 쓰면 안됨**~~

<br>

## **Display Pop-up Sheets**

버튼을 누르면 현재 화면이 뒤로 밀리면서, 새로운 팝업 형태의 화면이 뜨게끔 만들어 보자.

![image.jpg1](https://user-images.githubusercontent.com/126866283/235476385-fec5eaf2-cde4-4dda-bf70-d54f3118ad3f.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/235476481-ccff0b38-aad0-45b4-8fdf-17630970ddbd.png)
--- | ---

```swift
struct SheetsBootcamp: View {
	@State var showSheet: Bool = false
    
  var body: some View {
		ZStack {
			Color.green // (1) 초록 배경에 흰색 버튼 화면
				.edgesIgnoringSafeArea(.all)

      Button(action: { // 흰색 버튼
				showSheet.toggle()
      }, label: {
	      Text("Button")
	        .foregroundColor(.green)
          .font(.headline)
          .padding(20)
          .background(Color.white.cornerRadius(10))
      })
      .sheet(isPresented: $showSheet, content: { // (2) 흰색 Pop-up sheet
	      Text("HELLO THERE")
      })
    }
  }
}
```

> 여기**서 `isPresented:` Bool의 값이 true여야만 작동하는 판별기 
<br>
`content:` true일 때 보여주는 결과** → showSheet의 값을 읽어와서`$showSheet`이 true인 경우, sheet을 한 장 덮고 거기에는 “HELLO THERE” 이라고 쓰여있음
> 
<br>
<br>

## **Dismiss Screen**

- 현재 띄워져 있는 화면을 dismiss 시켜보자
- 위의 코드 중 `.sheet()`에 해당하는 부분에 `SecondScreen()`을 넣은 후,

```swift
.sheet(isPresented: $showSheet, content: {
	SecondScreen()
})
```

![image.jpg1](https://user-images.githubusercontent.com/126866283/235476385-fec5eaf2-cde4-4dda-bf70-d54f3118ad3f.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/235477181-2ae8ec09-a36e-4f18-aabd-abeba97ada5f.png)
--- | ---

초록 화면의 버튼을 누르면 pop-up 됐다가, ‘x’ 버튼을 누르면 dismiss 되는 빨간 창을 새로운 struct View를 통해 생성한다.

```swift
struct SecondScreen: View {
    
	@Environment(\.dismiss) var dismiss
  // 현재 띄워져 있는 화면에서 나가게끔 하는 기능
    
  var body: some View {
	  ZStack(alignment: .topLeading) {
	    Color.red
	      .edgesIgnoringSafeArea(.all)
            
      Button(action: {
	      dismiss()
        // 현재 띄워져 있는 화면을 dismiss 해라!
      }, label: {
		    Image(systemName: "xmark")
	        .foregroundColor(.white)
          .font(.largeTitle)
          .padding(20)
      })
    }
  }
}
```

<br>
<br>

## **FullScreenCovers**

- `.sheet` 은 화면을 밑으로 스와이프 하면 화면이 사라진다.
- 하지만 `.fullScreenCover` 는 화면 전체를 차지하기 때문에 스와이프로 화면을 사라지게 할 수 없다.
- .sheet() 대신에 아래처럼 입력해보자.

```swift
.fullScreenCover(isPresented: $showSheet, content: {
	SecondScreen()
})
```

<img src="https://user-images.githubusercontent.com/126866283/235477825-9a5276d8-03c1-493b-9f13-49554ab3cd2e.png" width=200>

