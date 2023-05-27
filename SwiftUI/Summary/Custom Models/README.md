# **#49 Custom Models**

- int, bool, string 같은 basic type 외에도 특별한 상황에 맞는 model을 직접 만들고 사용할 수 있다.

<br>
<br>

## **한 가지 정보만 담는 List 생성(Array)**

기존 basic type의 배열을 이용한 list를 생성했다면 이렇게 했을 것이다.

```swift
@State var users: [String] = [
	"Hannah", "Koby", "Snack", "Goggins", "Kayle"
]

var body: some View {
	NavigationView {
		List {
			ForEach(users, id: \.self) { name in
				HStack(spacing: 15.0) {
	        Circle()        // 사용자 프로필 용 circle
	          .frame(width: 35, height: 35)
          Text(user)        // 사용자 이름
        }
        .padding(.vertical, 10)
		}
	}
}
```

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/bc55d1eb-c5bf-4fd5-96fb-2340c62f17be" width=300>

<br>
<br>

## **여러 가지 정보를 한 번에 담는 List 생성(Custom Model)**

- 보통의 경우, 한 사람 당 실제 이름 외에도 아이디, 팔로워 수 등과 같은 다른 정보들도 함께 제공이 된다.
- 이럴 때, custom **model**을 만들어 관련 정보를 한 번에 저장하고 꺼내 쓸 수 있다.

<br>

우선, user list에 표기되어야 하는 정보들을 UserModel이라는 모델 안에 나열해주자.

```swift
struct UserModel: Identifiable {
    let id: String = UUID().uuidString 
    // UserModel을 쓸 때마다 랜덤한 string type의 unique id를 생성해주는 함수

    let displayName: String
    let userName: String
    let followerCount: Int
    let isVerified: Bool
}
```

`List`에 `identifiable` 프로토콜을 적용하지 않았을 경우에 컴파일러가 어느 것을 식별자로 사용해야 하는지 알 수 없기 때문에 `id`로 사용할 항목을 매개 변수에 전달해줘야 한다.

```swift
@State var users: [UserModel] = [
	UserModel(displayName: "Nick", userName: "nick123", followerCount: 100, isVerified: true),
    UserModel(displayName: "Emily", userName: "itsemily1995", followerCount: 55, isVerified: false),
    UserModel(displayName: "Samantha", userName: "ninja", followerCount: 355, isVerified: false),
    UserModel(displayName: "Chris", userName: "chrish2009", followerCount: 88, isVerified: true)
] 
// 기존에는 displayName: 전에 id:도 각각 설정을 해주어야 하지만,
// UserModel에 id = UUID().uuidString으로 id를 자동으로 생성하게 만들었기 때문에 필요 없어짐

var body: some View {
	NavigationView {
		List {
			ForEach(users) { user in
	            HStack(spacing: 15.0) {
	                Circle()
	                    .frame(width: 35, height: 35)
                Text(user.id)  // user별로 다르게 설정된 unique id 확인
                }
                .padding(.vertical, 10)
	        }
		}
	}
}
```

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/63f9aa76-ac73-476d-9264-f3ab089712a1" width=300>

→ user 별로 다른 고유 id가 생성된 것 확인됨.

<br>
<br>

**실제 사용되는 user list 처럼 위의 Text() 부분에 이름과 아이디를 표기해보자.**

```swift
List {
	ForEach(users) { user in

		HStack(spacing: 15.0) {
		    Circle()
		        .frame(width: 35, height: 35)

        VStack(alignment: .leading) {
			Text(user.displayName)         // 실제 이름
				.font(.headline)
			Text("@\(user.userName)")      // 아이디
				.foregroundColor(.gray)   
				.font(.caption)
		}

		Spacer()

		if user.isVerified {               // isVerified == true인 사람들은 공인 마크
	        Image(systemName: "checkmark.seal.fill")
	            .foregroundColor(.blue)
        }

		VStack {
	        Text("\(user.followerCount)")  // 팔로워 수
	            .font(.headline)
            Text("Followers")              // "Followers" 글씨
                .foregroundColor(.gray)
                .font(.caption)
        }
    }
    .padding(.vertical, 10)
	}
}
```

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/bbd7937b-34e5-43ca-997d-13b0de7f64db" width=300>
