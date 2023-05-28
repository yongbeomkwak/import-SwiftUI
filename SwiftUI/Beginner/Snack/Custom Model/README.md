# Custom Model
- `Struct`를 활용하여 사용자 인터페이스를 작성하는 데에 필요한 데이터 모델을 관리

### Array 형식
- `Array` 형식으로 동일한 타입의 데이터를 선형적으로(순서대로) 정리할 수 있다.
- `index`를 통해 개별 요소에 접근할 수 있다.
```swift
struct CustomModelStudy: View {
    
    // Array 형식의 데이터 모델
    @State var users: [String] = [
        "Snack", "Koby", "Hannah", "Kayle", "Goggins"
    ]
    
    var body: some View {
        List {
            // index를 통해 개별 요소에 접근
            ForEach(users, id: \.self) { name in
                HStack(spacing: 16) {
                    Circle()
                        .frame(width: 32, height: 32)
                    Text(name)
                }
                .padding(.vertical, 4)
            }
        }
    }
}
```
![](https://velog.velcdn.com/images/snack/post/14a199bf-e05b-41de-8f2e-685e45681b50/image.png)

### Struct 형식
- `struct` 형식으로 여러가지 타입의 데이터를 캡슐화하여 정리할 수 있다.
- 각 인스턴스의 고유한 식별을 위해 `Identifiable` 프로토콜을 준수할 수 있고, 이를 위해 `UUID`를 사용한다.

> **UUID**
Universally Unique IDentifier의 약자로, 128비트의 값을 갖으며 고유한 식별자로 사용된다.
`E621E1F8-C36C-495A-93FC-0C247A3E6E5F`와 같이 보통 32개의 16진수 숫자와 하이픈으로 구성된 형태로 표현된다.

```swift
struct UserModel: Identifiable {
    // UUID를 String 타입으로 생성
    let id: String = UUID().uuidString
    let displayName: String
    let userName: String
    let followerCount: Int
    let isVerified: Bool
}

struct CustomModelStudy: View {
    
    @State var users: [UserModel] = [
           // 각 데이터에 따른 인스턴스 생성
        UserModel(displayName: "Snack", userName: "snack123", followerCount: 100, isVerified: false),
        UserModel(displayName: "Koby", userName: "koby123", followerCount: 200, isVerified: true),
        UserModel(displayName: "Hannah", userName: "hannah123", followerCount: 300, isVerified: false)
    ]
    
    var body: some View {
        List {
            ForEach(users) { user in
                // 여러가지 타입의 데이터 표현
                HStack(spacing: 16) {
                    Circle()
                        .frame(width: 40, height: 40)
                    VStack(alignment: .leading) {
                        Text(user.displayName)
                        Text("@\(user.userName)")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    if user.isVerified {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    VStack {
                        Text("\(user.followerCount)")
                            .font(.headline)
                        Text("Followers")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }
}
```
![](https://velog.velcdn.com/images/snack/post/ce373842-eead-4781-bcae-dd51bd5fbc1f/image.png)
