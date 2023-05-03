# **#30 Navigation View & Link**


- 한 화면에서 다른 화면으로 전환하는 방법에는 **Navigation View, Navigation Link** 두 가지가 있다.

<br>


# **Navigation View**

- 좌우로 넘어가는 인터랙션밖에 구현하지 못함

<img src="https://user-images.githubusercontent.com/126866283/235852344-0c7cd1b8-1305-461d-b0fd-dc98ad0a4979.png" width=150>


```swift
NavigationView {
	ScrollView {
		Text("Hello, World!")
    	Text("Hello, World!")
    	Text("Hello, World!")
  	}
}
```

“Hello, World” 글씨 세 번이 safeArea 내에서 가장 위쪽 중앙에 나타난다.

<br>


![image.jpg1](https://user-images.githubusercontent.com/126866283/235852693-97a12139-4157-496d-8562-0fe35e7ad49d.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/235852828-76eb6478-ec1c-4aee-a0ab-252905804f3a.png)
--- | ---


```swift
NavigationView {
	ScrollView {
		Text("Hello, World!")
    	Text("Hello, World!")
    	Text("Hello, World!")
  }
  .navigationTitle("All Inboxes")
  .navigationBarTitleDisplayMode(.automatic)
}
```

scrollView에 `.navigationTitle()` 을 붙이는 순간 해당 화면에 제목을 달 수 있게 된다.

이 제목의 default 값은 `.large` 이기 때문에 큰 볼드체로 좌측정렬이 되어있다.

이 때, `.navigationBarTitleDisplayMode(.automatic)`을 추가함으로써 scrollView를 위로 올려서 글씨가 가려질 때 기존의 `.large` 였던 제목이 `.inline`으로 상황에 맞춰 바뀌게끔 만들 수 있다.

<br>
<br>

# **Navigation Link**

- `NavigationLink(title : String protocol, destination :)` 형태로 사용
- 전 화면의 title은 그대로 다음 화면의 뒤로가기 버튼이 된다

![image.jpg1](https://user-images.githubusercontent.com/126866283/235853306-5c2f88f3-50cd-42b9-adcb-194e6f389128.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/235853377-5d86c671-e2d4-4dca-8576-c46fc352ad17.png) |![image.jpg3](https://user-images.githubusercontent.com/126866283/235853458-67c690fe-4eb9-4a97-87d0-d41923794066.png)
--- | --- | ---



```swift
NavigationView {
	ScrollView {
		// (2) "Hello, World!"를 누르면 "Second screen."이라고 쓰인 화면이 오른쪽에서 나옴
		NavigationLink("Hello, World!",
                   destination: Text("Second screen."))
	  	// (3) "Green Background"를 누르면 MyOtherScreen 화면 호출
		NavigationLink("Green Background",
		               destination: MyOtherScreen())

		Text("Hello, World!")
    	Text("Hello, World!")
    	Text("Hello, World!")
  	}
  	.navigationTitle("All Inboxes")
  	.navigationBarTitleDisplayMode(.automatic)
}
```

아래에 “Green Background”를 눌렀을 때 나타나는 초록 화면을 struct로 나타내준다.

```swift
struct MyOtherScreen : View {
	var body: some View {
		ZStack {
			Color.green.edgesIgnoringSafeArea(.all)
    	}
  	}
}
```
<br>

## **Navigation Link의 응용**

- 한 view에도 여러개의 link를 사용할 수 있다.
- 여러 view들을 link을 이용해 엮어서 연속적인 flow를 만들 수 있다.

![image.jpg1](https://user-images.githubusercontent.com/126866283/235854076-4461cd72-c121-4042-b3fd-d2c5af8b7979.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/235854220-49e5971e-3038-495c-8cdb-ecc7d0f66b80.png)
--- | --- 

```swift
struct MyOtherScreen : View {
	var body: some View {
		ZStack {
			// (1) 초록 화면
			Color.green.edgesIgnoringSafeArea(.all)
				.navigationTitle("Green Screen!")

			// (2) 3rd screen 흰색 화면
	    	NavigationLink("Click here", destination: Text("3rd screen!"))
    	}
  	}
}
```
<br>

## **Navigation 화면의 Customize**

- Navigation에 기본으로 세팅 되어있는 title과 화살표 형태의 back button을 사용하지 않고, 본인만의 **custom back button**을 사용하고 싶다면,
    
<img src="https://user-images.githubusercontent.com/126866283/235854530-94924c92-5e32-4459-ae51-7e14609406a3.png" width=150>

    

```swift
struct MyOtherScreen : View {
	@Environment(\.presentationMode) var presentationMode

	var body: some View {
		ZStack {
			// (1) 초록 화면
			Color.green.edgesIgnoringSafeArea(.all)
			// .navigationTitle("Green Screen!")
			.navigationBarHidden(true)
			
			VStack {
        		Button("BACK BUTTON") { // 누르면 이전 화면으로 전환해주는 back button 만들기
	       			presentationMode.wrappedValue.dismiss() 
        		}
				// (2) 3rd screen 흰색 화면
        		NavigationLink("Click here", destination: Text("3rd screen!"))
      		}
    	}
  	}
}
```

<br>

- Navigation bar의 좌측 양 끝에 **아이콘**을 넣고 싶다면,
    
<img src="https://user-images.githubusercontent.com/126866283/235854750-00c63ec4-40fc-4894-8dd2-9a9e60bd3c5c.png" width=150>
    

```swift
NavigationView {
	ScrollView {
		Text("Hello, World!")
    	Text("Hello, World!")
    	Text("Hello, World!")
  	}
  	.navigationTitle("All Inboxes")
  	.navigationBarTitleDisplayMode(.automatic)
	.navigationBarItems(
	  	leading: Image(systemName: "person.fill"),
    	trailing: Image(systemName: "gear")
  	)
}
```
<br>

- 그 아이콘을 다른 어디론가로 가는 버튼으로 만들고 싶다면, **Image를 navigationLink로 대체**하기!
- 이 때, `NavigationLink(destination:label)` 사용

![image.jpg1](https://user-images.githubusercontent.com/126866283/235855018-18483d36-4873-4148-9009-451d0ab0cb73.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/235855114-63b32b84-09f6-4556-be81-9a8f8466cb2a.png) |![image.jpg3](https://user-images.githubusercontent.com/126866283/235855225-68d33d49-1039-4523-a6ba-44a0d3f7b9d3.png)
--- | --- | ---


```swift
NavigationView {
	ScrollView {
		Text("Hello, World!")
    	Text("Hello, World!")
    	Text("Hello, World!")
  	}
  	.navigationTitle("All Inboxes")
  	.navigationBarTitleDisplayMode(.automatic)
	.navigationBarItems(
		leading:
	    	NavigationLink(
      		destination: Text("Person"),
      		label: {
	      		Image(systemName: "person.fill")
      		}),
   		trailing:
      		NavigationLink(
      		destination: MyOtherScreen(),
      		label: {
	      		Image(systemName: "gear")
      		})
  	)
}
```

<br>

- 좌측 상단에 아이콘을 두개 넣고 싶은 경우, HStack 을 이용하면 된다.


<img src="https://user-images.githubusercontent.com/126866283/235855332-15197e08-e66c-4935-a4f5-924f47af09f1.png" width=150>



```swift
.navigationBarItems(
	leading:
		HStack {
			Image(systemName: "person.fill")
			Image(systemName: "flame.fill")
		}
```

