# **#9 @ViewBuilder**

- 일반적으로 'ViewBuilder'를 하위 뷰 생성 클로저의 매개변수 속성으로 사용하여 해당 클로저가 여러 하위 뷰를 제공할 수 있도록 합니다.

<br>

## (1) Custom View 만들기

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/9ce8f023-0bfc-44bf-99bf-e433f56a0f2f" width=300>

정해둔 header 포맷을 어디서나 불러쓸 수 있게 따로 view로 만들어보자.

```swift
// HeaderViewRegular() 만들기
struct HeaderViewRegular: View {
    
	let title: String
	let description: String? // description - 있어도, 없어도 됨 (optional)
	let iconName: String?    // icon - 있어도, 없어도 됨 (optional)
    
    var body: some View {
	    VStack(alignment: .leading) {
	        Text(title)
	            .font(.largeTitle)
                .fontWeight(.semibold)
            if let description = description {
	            Text(description)
	                .font(.callout)
            }
			if let iconName = iconName {
	            Image(systemName: iconName)
            }
            RoundedRectangle(cornerRadius: 5) // 구분선
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}
```

```swift
// HeaderViewRegular() 사용해서 메인 뷰 그리기
struct ViewBuilderBootcamp: View {
	var body: some View {
	    VStack {
	        HeaderViewRegular(title: "New Title", description: "Hello", iconName: "heart.fill")
            
            HeaderViewRegular(title: "Another Title", description: nil, iconName: nil)
            
            Spacer()
        }
    }
}
```

이 방법은 원하는 대로 커스텀한 요소를 여기저기서 불러올 수 있다는 장점이 있다.

*하지만, 만약에 아이콘을 한 개가 아닌 여러 개를 넣고 싶다면? 아이콘, 텍스트, 이미지 마구잡이로 넣고 싶다면?*

위 방법으로는 원하는 모든 것을 구현하기가 생각보다 어려울 수 있다. 더 다양한 커스텀을 가능하게 하려면, **view 안에 view를 넣는 형식**을 이용해야 한다.

<br>
<br>

## (2) Generic View

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/aea96c25-2e37-4de7-bf68-7103173a46f8" width=300>

```swift
struct HeaderViewGeneric<Content:View>: View {
	// <Content:View>
    // : Content가 View 타입이라고 설정해줘야 아래 body에서 content를 사용했을 때 화면에 보여지게 할 수 있다.
    
	let title: String
    let content: Content // Content = custom type = 아무거나 될 수 있다
    
    var body: some View {
		// Title
	    VStack(alignment: .leading) {
	        Text(title)
	            .font(.largeTitle)
                .fontWeight(.semibold)

        // 내용
        content
      
		// 구분선
        RoundedRectangle(cornerRadius: 5)
	        .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}
```

```swift
// HeaderViewGeneric() 사용해서 메인 뷰 그리기
struct ViewBuilderBootcamp: View {
	var body: some View {
	    HeaderViewGeneric(title: "Generic Title", content: Text("hello"))
        HeaderViewGeneric(title: "Generic Title 2", content: Image(systemName: "heart.fill"))
        HeaderViewGeneric(title: "Generic Title", content:
	                    VStack (alignment: .leading){
	                        HStack {
	                            Text("hello")
                                Image(systemName: "bolt.fill")
                                Image(systemName: "heart.fill")
                            }
                            Text("Nice to meet you")
                        }
                    )
    }
}
```

하지만 이 방법대로 한다면, content: 에 해당되는 내용이 길어질수록 지저분하고 보기 편하지 않다.

<br>
<br>

## (3) Initializer 안에서의 @ViewBuilder 응용

- 위 content도 `HStack { }` 처럼 closure로 만들어 둔다면 사용할 때 편리하고 깔끔하게 볼 수 있다!

- 우선, @ViewBuilder를 이용해 `HeaderViewGeneric()`의 custom initializer를 추가해주자.

```swift
init(title: String, @ViewBuilder content: () -> Content) {
    // content는 Content 타입의 무언가를 뱉어내는 함수이다.
    self.title = title
    self.content = content()
}
```

content 앞에 @ViewBuilder를 써줌으로써, content의 형식을 값이 아닌 함수의 형태로 입력받을 수 있게 된다.

이제 실제로 뷰에 `HeaderViewGeneric()` 을 사용하게 되면, 아래처럼 closure의 형태로 뜨게 된다.

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/e296d195-1cc4-439e-a30a-30cdd58a53d5" width=500>

<br>

위 `init(title: String, @ViewBuilder content: () -> Content)`에서 ()에 해당하는 함수가 아래 대괄호 { } 안에 들어가는 내용과 같다.

```swift
HeaderViewGeneric(title: "Generic Title") {
	HStack {
	    Text("Hi")
        Image(systemName: "heart.fill")
        Text("Hi")
    }
}
```

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/a7923d65-2477-4f9a-bee2-a7cd7609b01d" width=300>

<br>
<br>

## (4) 그 외 @ViewBuilder 의 응용
아래와 같이, `type`이 `one, two, three`일 때 각각 다른 view가 나오게 만들어보자.

![image.jpg1](https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/0dc35f17-5e54-4058-9b7e-185d4a4efa19) |![image.jpg2](https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/e33a2614-41c1-4940-afb8-7fcb160302ab) |![image.jpg3](https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/f9e805c5-4024-46a3-a1bc-a61389480f35)
--- | --- | --- |


```swift
struct LocalViewBuilder: View {
    
	enum ViewType {
		case one, two, three
	}
	let type: ViewType
    
    var body: some View {
	    VStack {
	        headerSection
        }
    }
    
    private var headerSection: some View { 
		// return 값이 필요하다고(?) 뜸 -> @ViewBuilder로 해결
	    switch type {
	        case .one:
	            viewOne
            case .two:
	            viewTwo
            case .three:
	            viewThree
        }
	}

    // 1. type == one일 때의 View
    private var viewOne: some View {
	    Text("One!")
    }
    // 2. type == two일 때의 View
    private var viewTwo: some View {
	    VStack {
	        Text("Two")
            Image(systemName: "heart.fill")
        }
    }
    // 3. type == three일 때의 View
    private var viewThree: some View {
	    Image(systemName: "heart.fill")
    }
}
```

```swift
// 프리뷰
struct ViewBuilderBootcamp_Previews: PreviewProvider {
	static var previews: some View {
	    ViewBuilderBootcamp()
        LocalViewBuilder(type: .one) // 이외에도 .two, .three 있음
    }
}
```
위의 경우, headerSection()에서 return 값의 형태가 불분명하다는 에러가 뜬다.
즉, case별로 다른 view를 내밷는 것처럼 여러 가지 return 값이 존재할 수 없다는 뜻이다.

이 경우, switch 문을 특정 Stack(H,V,Z) 안에 넣게 되면 해당 에러가 해결이 된다. Stack들은 여러 하위 뷰를 허용하는 view builder의 특성을 가지고 있기 때문이다.

하지만 Stack을 활용할 것이 아니라면, headerSection() 자체를 view builder로 정의해주면 문제가 해결된다.

```swift  
@ViewBuilder private var headerSection: some View { 
	// @ViewBuilder를 붙여서 해결
	switch type {
	    case .one:
	        viewOne
        case .two:
	        viewTwo
        case .three:
	        viewThree
    }
}
```