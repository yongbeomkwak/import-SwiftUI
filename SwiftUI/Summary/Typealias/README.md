# **#19 Typealias**

- 앱 속에 이미 존재하는 model / type들에 sub name을 붙여줄 때 쓰인다.

<br>
<br>

**넷플릭스** 같은 앱을 만든다고 해보자. 

앱 안에는 동일한 포맷의 수많은 영화 컨텐츠들이 나열될 것이기 때문에, 영화와 관련된 custom model을 만들고 이를 view에서 불러오면서 화면을 채워나갈 것이다.

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/2bc149f2-a33b-4870-bac2-94722dc911d9" width = 300>

```swift
struct MovieModel {
	let title: String     // 영화 제목
  	let director: String  // 감독 이름
  	let count: Int        // 해당 영화를 좋아하는 user 수
}

struct TypealiasBootcamp: View {
    
  	@State var item: MovieModel = MovieModel(title: "Interstellar", director: "Christopher Edward Nolan", count: 100)
  
	var body: some View {
	  	VStack {
	    	Text(item.title)
				.font(.title)
      		Text(item.director)
      		Text("\(item.count)")
    	}
  	}
}
```

<br>

하지만, 넷플릭스에는 영화 뿐 아니라 TV 방송 콘텐츠들도 있다. 

TV 콘텐츠도 영화와 동일하게 title, director, count라는 정보를 제공한다면, 그냥 `MovieModel`을 똑같이 복붙해서 추가하고 이름만 `TVModel`로 바꾼 후 사용해도 된다.

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/554a008f-35ae-43f0-8395-b2f814752294" width = 300>

```swift
struct MovieModel {
	let title: String     // 영화 제목
  	let director: String  // 감독 이름
  	let count: Int        // 해당 영화를 좋아하는 user 수
}

struct TVModel {
	let title: String     // TV 콘텐츠 제목
  	let director: String  // 작가 이름
  	let count: Int        // 해당 TV 콘텐츠를 좋아하는 user 수
}

struct TypealiasBootcamp: View {
    
  	@State var movieItem: MovieModel = MovieModel(title: "Interstellar", director: "Christopher Edward Nolan", count: 100)
  	@State var tvItem: TVModel = TVModel(title: "더 글로리", director: "김은숙", count: 150)
    
  	var body: some View {
	  	VStack {
	    	Text(movieItem.title)
	      		.font(.title)
      		Text(movieItem.director)
      		Text("\(movieItem.count)")
	      		.padding(.bottom, 20)
            
      		Text(tvItem.title)
	      		.font(.title)
      		Text(tvItem.director)
      		Text("\(tvItem.count)")
    	}
  	}
}
```

하지만 이렇게 된다면 동일한 구조의 model을 두 번이나 만들어주어야 하고, 같은 구조의 다른 model이 더 추가되거나 model이 복잡한 경우 코드가 알아보기 힘들 정도로 길어진다는 문제점이 생긴다.

<br>
<br>

## **Typealias 사용하기**

동일한 구조지만 서로 이름만 다른 모델일 경우, `typealias`를 사용하여 같은 구조의 모델을 반복 생성하지 않고 코드를 간단하게 정리할 수 있다.

`typealias (새로운 model 명) = (이 모델이 따르는 model type 명)`

```swift
struct MovieModel {
	let title: String     // 영화 제목
  	let director: String  // 감독 이름
  	let count: Int        // 해당 영화를 좋아하는 user 수
}

typealias TVModel = MovieModel

struct TypealiasBootcamp: View {
    
  	@State var movieItem: MovieModel = MovieModel(title: "Interstellar", director: "Christopher Edward Nolan", count: 100)
  	@State var tvItem: TVModel = TVModel(title: "더 글로리", director: "김은숙", count: 150)
    
  	var body: some View {
	  	VStack {
	    	Text(movieItem.title)
	      		.font(.title)
      		Text(movieItem.director)
      		Text("\(movieItem.count)")
	      		.padding(.bottom, 20)
            
      		Text(tvItem.title)
	      		.font(.title)
      		Text(tvItem.director)
      		Text("\(tvItem.count)")
    	}
  	}
}
```
