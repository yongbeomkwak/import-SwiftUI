# **#63 Toolbar**

- 기존에 쓰던 `.navigationBarItems()` →  `.toolbar{ToolbarItem()}`으로 바뀌었다.
- `.navigationBarHidden(bool)` → `.toolbar(visibility: for)`

<br>

## `.toolbar{ToolbarItem()}`

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/c45969f1-17bc-4833-b4d8-0896dff07935" width=200>


```swift
NavigationStack {
	ZStack {
		Color.indigo.ignoresSafeArea()
                
	  	Text("Hey 👀")
	    	.foregroundColor(.white)
  	}
  	.navigationTitle("Toolbar")
	.toolbar {
		ToolbarItem(placement: .navigationBarLeading) {
	    	Image(systemName: "heart.fill")
    	}
    	ToolbarItem(placement: .navigationBarTrailing) {
	    	Image(systemName: "gear")
    	}
	}

/* 기존 방식 */
//	.navigationBarItems(
//		leading: Image(systemName: "heart.fill"),
//		trailing: Image(systemName: "gear")
//	)
}
```

### `(placement:)`

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/92c47cdd-a343-4753-a4ee-c3a9f34fabba" width=300>

- 기기(iPhone, iMac, iPad 등)에 따라 적절한 곳에다가 toolbar를 배치할 수 있게끔 여러가지 옵션을 제공하여 선택을 하게 한다.
- 툴바의 위치를 상황 별로 다른 곳에 수동으로 배치시켜야 했던 번거로움을 줄여준다.

예시로 `(placement: .keyboard)`의 결과를 확인해보자.

```swift
.toolbar {
	ToolbarItem(placement: .keyboard) { // 키보드가 올라올 시 키보드 상단에 나오게끔 설정
	    Image(systemName: "gear")       // 톱니바퀴 이미지
    }
}
```
<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/662bfccb-a024-4c61-b0af-4bc44b91eeb2" width=200>

<br>

### **다른 예시**
- 순서대로 `.bottomBar`, `.cancellationAction`, `.principal`, `.status`, `.secondaryAction`

![image.jpg1](https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/59d0f422-154f-4873-920a-a5eea75ddd50) |![image.jpg2](https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/2a6cdc7f-ee06-47f5-b9a7-a3861bfba5fd) |![image.jpg3](https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/233943a7-f83c-48ec-8e45-eeda6d1d64dd) |![image.jpg4](https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/6f00b1a9-4b7f-420d-853c-9dc9db9003b8) |![image.jpg5](https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/2c56a580-9353-4e35-bc09-0ff118901297)
--- | --- | --- | --- | ---

<br>
<br>

## `.toolbar(visibility:for:)`

- 원하는 toolbar를 선택하여 숨길 수 있는 기능

```swift
.toolbar(.hidden, for: .navigationBar)

/* 기존 방식 */
// .navigationBarHidden(true)
```
<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/7881c5a2-0a14-4540-b7b5-465119dca0d6" width=200>

<br>
<br>

## `.toolbarBackground(style:for:)`

- scroll view를 위로 스크롤 할 시의 toolBar의 배경 스타일 변경을 하고 싶을 때 사용한다.

![image.jpg1](https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/b784ae5a-2ab3-4eb9-b511-3199f914852b) |![image.jpg2](https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/87964c39-5576-4bdf-9471-c3e9739793b0)
--- | ---

```swift
struct ToolbarBootcamp: View {
    
	@State private var text: String = ""
    
  	var body: some View {
	  	NavigationStack {
	    	ZStack {
	      		Color.white.ignoresSafeArea()
                
        		ScrollView {
	        		TextField("Placeholder", text: $text)
                    
          			ForEach(0..<50) {_ in
	          			Rectangle()
	            			.fill(Color.blue)
              				.frame(width: 200, height: 200)
          			}
        		}
      		}
		...
```

기본값은 scrollview를 위로 스크롤했을 때, navigationBar의 형태가 바뀌면서 불투명한 흰색 상단바가 생긴다.

상단바 배경을 없애고 싶다면, ZStack이 끝난 직후에 아래 코드를 써넣으면 된다.

```swift
.toolbarBackground(.hidden, for: .navigationBar)
```

<br>
<br>

## `.toolbarColorScheme(colorScheme:for:)`

- toolBar의 배경 색을 변경하고 싶을 때 사용한다. (light or dark mode)

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/9142bfac-a9d9-44b9-b959-743d88ebbe63" width=200>

위 코드와 마찬가지로, ZStack이 끝난 직후에 아래 코드를 붙여주면 된다.

```swift
.toolbarColorScheme(.dark, for: .navigationBar)
// 원하는 색상 모드, for: 어디에 적용할 것인지
```

<br>
<br>

## `.toolbarTitleMenu`

- 툴바의 제목 옆에 드롭다운 버튼을 생성하여, 원하는 옵션의 행동이나 뷰로 쉽게 넘어갈 수 있게 해준다.

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/3c5434f9-c752-4ca5-b3f1-2fa6e2980313" width=300>

```swift
struct ToolbarBootcamp: View {
    
	@State private var text: String = ""
	@State private var paths: [String] = [] 
	// 이 NavigationStack이 새로운 destination string을 받아올 때마다, (맨 아래 navigationDestination으로)
    
  	var body: some View {
	  	NavigationStack(path: $paths) {           // paths를 binding 함
	    	ZStack {
	      		Color.white.ignoresSafeArea()
                
        		ScrollView {
	        		TextField("Placeholder", text: $text)
                    
          			ForEach(0..<50) {_ in
	          			Rectangle()
	            			.fill(Color.blue)
              				.frame(width: 200, height: 200)
          			}
        		}
      		}
			.navigationBarTitleDisplayMode(.inline) // navigation bar title 보기를 inline(작게)으로 설정
      		.toolbarTitleMenu {                     // title 옆에 드롭다운 메뉴가 생겨난다
	      		Button("Screen 1") {
	        		paths.append("Screen 1")
        		}
        		Button("Screen 2") {
	        		paths.append("Screen 2")
        		}
      		}
      		.navigationDestination(for: String.self) { value in
	      		Text("New screen: \(value)")
				// 들어온 paths의 string 값을 value 안에 넣어서 출력해준다.
     		}
		...
```
