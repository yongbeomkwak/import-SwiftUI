# Codable, Decodable, and Encodable 



### 1. Encodable 프로토콜
- 원하는 형태로 바꾸어줌 $f(x)$ 함수와 같다
- 스위프트의 struct구조의 *객체*를 **json형식**으로 변한 하는 것
- 자기 자신을 외부 표현으로 encode 할 수 있는 타입


<br>

### 2. Decodable 프로토콜
- 그 형태를 해석해줌 $f^-(x)$  역함수와 같다
- **json형식**을 *객체*로 변환
- 자기 자신을 외부 표현으로 encode 할 수 있는 타입

<br>

### 3. Codable
- Codable = Encodable + Decodable

<br>

### 4. CodingKeys
- 디코딩 과정에서 json key가 아닌 내가 원하는 이름으로 지정해줄 수 있게 해주는 프로토콜입니다.

<br>

```swift

/*
반드시 모든 변수가 enum안에 명시되어야함 

바뀔 키값들은 아래와 같은 형식으로 사용됨

case 바뀐 결과값 = 바뀌기 전 값

*/

struct User: Codable {
	var userName: String
	var userEmail: String
    	var tmp : String

	enum CodingKeys: String, CodingKey {

		case userName = "user_name"  //user_name -> userName
		case userEmail = "user_email" // user_email -> userEmail
   		case tmp // 키값이 같은 경우 tmp -> tmp 
	}
}


```
