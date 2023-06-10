# **#4 Rotation Gesture**

### **Hashable하다는 것?**

- 정수 해시값 생성이 가능한, Hash가 가능한 타입

**해시값(Hash Value = unique id)이란?** 

- **원본 데이터**를 특정 규칙에 따라 처리하여 **간단한 숫자**로 만든 것
- 원본 데이터 (객체)를 해쉬 함수 (hash function)을 사용하여 64bit의 Int값으로 변환한 것

<br>
<br>

## **1. Hash Value 부여하기**

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/7fd96fbb-f527-46f9-b474-6686818e73ca" width = 300>

```swift
struct HashableBootcamp: View {
    
	let data: [String] = [
	  "ONE", "TWO", "THREE", "FOUR", "FIVE"
  	]

	var body: some View {
		ScrollView {
		  	VStack(spacing: 20) {
				ForEach(data, id: \.self) { item in
					Text(item)               		 // data 배열 속 값들을 출력해보기
		        		.font(.headline)
	        		Text(item.hashValue.description) // string마다 다르게 부여된 hash value 보기
	          			.font(.caption)
	      		}
			}
	  	}
	}
}

```

**data라는 데이터에서 \.self를 쓸 수 있는 이유** 

- `data`는 String이고, String, Int 타입은 Hashable이라는 protocol을 따르기 때문에 자동으로 hashable 하다.
- `\.self` : 배열 속 각 string마다 hash value(unique id)를 부여해줌.

<br>

**데이터가 동일하면 해쉬값도 동일하다**

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/54403135-0dcd-482e-aeef-8dcf7c118109" width = 400>

만약 위 예제에서 data 배열의 string 값 중 `“TWO”`를 `“ONE”`으로 바꾼다면, 첫 번째 “ONE”과 두 번째 “ONE”의 hash value는 서로 같아진다.

*단, 두 개의 서로 다른 데이터가 동일한 해쉬값을 가질 수도 있다. 해쉬값은 일정 크기의 Int값이므로 유한하고, 데이터 양은 무한하기 때문에 해쉬값이 충분하지 않기 때문이다.*

<br>
<br>

## **2. Custom Model에서 Hash Value 부여하기**

이전까지 쓰던 방법으로는, `Identifiable` / `UUID()`를 활용하는 방법이 있었다.

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/8b007256-7260-4b1a-ae43-de4cfb1acaf2" width = 300>

```swift
struct MyCustomModel: Identifiable {
	let id = UUID().uuidString 
	// UUID(): 랜덤한 string type의 unique id를 생성해주는 함수
  	let title: String
}

struct HashableBootcamp: View {
    
	let data: [MyCustomModel] = [
	  	MyCustomModel(title: "ONE"),
    	MyCustomModel(title: "TWO"),
    	MyCustomModel(title: "THREE"),
    	MyCustomModel(title: "FOUR"),
    	MyCustomModel(title: "FIVE")
  	]
    
 	var body: some View {
	  	ScrollView {
	    	VStack(spacing: 20) {
	      		ForEach(data) { item in   // id는 모델 안에서 자동으로 생성된 상태
	        		Text(item.title)      // item의 title 값 출력
	          			.font(.headline)
          			Text(item.id)         // item의 id 값 출력 -> 코드가 간결해짐
            			.font(.caption)
        		}
      		}
    	}
  	}
}
```
<br>
<br>

## **3. Hashable Protocol 사용하기**

내가 만든 custom model 안에 `id`를 생성하는 코드를 굳이 넣고 싶지 않을 때가 있을 수 있다.

위 코드에서 `identifiable` 대신 `Hashable`을 쓰고, 아래와 같이 수정해보자.

```swift
struct MyCustomModel: Hashable {
	
  	let title: String

	func hash(into hasher: inout Hasher) {
	  	hasher.combine(title) // title의 값에 따라 hash value를 생성하는 hasher
  	}
}

struct HashableBootcamp: View {
    
	let data: [MyCustomModel] = [
	 	MyCustomModel(title: "ONE"),
    	MyCustomModel(title: "TWO"),
    	MyCustomModel(title: "THREE"),
    	MyCustomModel(title: "FOUR"),
 		MyCustomModel(title: "FIVE")
  	]

	var body: some View {
		ScrollView {
		  	VStack(spacing: 20) {
				ForEach(data, id: \.self) { item in
					Text(item.title)
		        		.font(.headline)
	        		Text(item.hashValue.description)
	          			.font(.caption)
		    	}
			}
		}
	}
}
```
<br>

### **Hashable Protocol**

다음의 형식을 지켜야 한다.

```swift
public protocol Hashable : Equatable {
	/* 
	var hashValue: Int { get } // deprecated 
	*/
	func hash(into hasher: inout Hasher) {
		hasher.combine(title)  // title의 값에 따라 hash value를 생성하는 hasher
	}
}
```

`Equatable`
- 두 가지 값이 서로 같은지를 판별해서 bool type으로 return 해주는 역할.

`combine(bytes: UnsafeRawBufferPointer)` 
- hash 상태를 완료하고 hash value를 반환하는 역할.

<br>

만약 `MyCustomModel` 안에 `title` 외에 `subtitle`이라는 속성도 있다면, 아래처럼 그 둘을 모두 고려해서 unique id를 생성하게끔 만들어줄 수도 있다.

```swift
func hash(into hasher: inout Hasher) {
	hasher.combine(title + subtitle)
}
```

이렇게 하면 `title`만 가지고 id를 생성했을 때보다 다른 데이터와 값이 겹칠 가능성이 적어지기 때문에 id가 더 unique 해지는 효과를 얻을 수 있다.