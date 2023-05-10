# **#13 inits and enums**
## **init**
초기화를 의미하며 뷰가 만들어질 때 실행되는 함수. 커스텀 변수로 init 함수를 정의할 수 있다. <br>






<br>
<br>

<img width="736" alt="스크린샷 2023-04-26 오후 10 42 51" src="https://user-images.githubusercontent.com/87987002/234594656-e534b599-8dbc-40f4-b905-aa61504c1161.png">

```swift
 var body: some View {
        VStack(spacing: 12) {
            Text("5")
                .font(.largeTitle)
                .foregroundColor(.white)
                .underline()
            Text("Apples")
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(width: 150, height: 150)
        .background(Color.red)
        .cornerRadius(10)
    }

```

위의 코드에서는 "Apple", 빨간색같은 변수들을 String으로 직접 작성했지만 코드 외부에서 변수를 만들 수 있다. 

<br>
<br>


```swift
 let backgroundColor: Color = Color.red   //코드 외부에서 변수를 지정해서 background값에 넣어주었음. 
                                          //타입은 Color
    
    var body: some View {
        VStack(spacing: 12) {
            Text("5")
                .font(.largeTitle)
                .foregroundColor(.white)
                .underline()
            Text("Apples")
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(width: 150, height: 150)
        .background(backgroundColor)  //이제 코드에서 텍스트를 입력하는 대신 변수를 참조할 수 있다. 
        .cornerRadius(10)
    }
```


이렇게 만든 변수는 배경색 빨간색이 필요한 다른 곳에도 활용할 수 있다. 코드를 모두 검토하는 것보다 변경 및 수정에 용이함. <br>지금은 배경색을 빨간색으로 뷰를 초기화하고 있지만, 앱에서 이 뷰를 여러번 재사용한다면 (파란색이나 주황색도 사용하고 싶다면) 기본값을 제공하지 않으면 됨. 

<br>
<br>


## 기본값 삭제

```swift
struct Initializer: View {
    
    let backgroundColor: Color       //기본값(default variable) 지움
    
    var body: some View {
        VStack(spacing: 12) {
            Text("5")
                .font(.largeTitle)
                .foregroundColor(.white)
                .underline()
            Text("Apples")
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(width: 150, height: 150)
        .background(backgroundColor)
        .cornerRadius(10)
    }
}

struct Initializer_Previews: PreviewProvider {
    static var previews: some View {
        Initializer(backgroundColor: .purple)   //배경색을 요청하는 매개변수를 지정해야 함.안 그럼 오류뜸
    }
}
```
<img width="732" alt="스크린샷 2023-04-26 오후 11 25 04" src="https://user-images.githubusercontent.com/87987002/234606712-dbbcaec1-46a5-4494-b9eb-dbb6591c375a.png">

기본값을 제공하지 않으면, 해당 Initializer View를 초기화할 때마다 Background Color를 요청함.<br> 따라서 하단의 프리뷰에서 배경색을 요청하는 매개변수를 지정해야 함. 뷰를 호출할 때마다 색상을 변경할 수 있다. 
<br>
<br>

## 다른 변수들도 지정

```swift
struct Initializer: View {
    
    let backgroundColor: Color
    let count: Int                //Int 변수 지정
    let title: String             //문자 변수 지정
    
    
    var body: some View {
        VStack(spacing: 12) {
            Text("\(count)")
                .font(.largeTitle)
                .foregroundColor(.white)
                .underline()
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(width: 150, height: 150)
        .background(backgroundColor)
        .cornerRadius(10)
    }
}

struct Initializer_Previews: PreviewProvider {
    static var previews: some View {
        Initializer(backgroundColor: .orange, count: 55, title: "Oranges")
    }
}

```

<img width="737" alt="스크린샷 2023-04-27 오전 12 22 49" src="https://user-images.githubusercontent.com/87987002/234623715-eea15d79-d0b4-43d9-9ab6-04ec7ab05448.png">

body 안에 있는 무슨 항목이든 이러한 변수를 만들 수 있다.
이제 뷰가 초기화될 때마다 backgroundColor, count, title 을 요청함. <br>


<br>
<br>

## 기본 init 함수

```swift
    init(backgroundColor: Color, count: Int, title: String) {
        self.backgroundColor = backgroundColor
        self.count = count
        self.title = title
    }
```

init은 뷰가 생성되자마자 실행되는 초기 함수로, 뷰를 업데이트하고 생성한다. <br>
위의 함수는 하단의 preview에서 view가 호출될 때 실제로 실행되는 함수임. <br>
SwiftUI에서는 이니셜라이저를 따로 작성하지 않아도 자동으로 초기화가 진행되므로 따로 추가하지 않아도 됨

<br>
<br>


## init 함수 커스텀 

```swift
    struct Initializer: View {
    
    let backgroundColor: Color
    let count: Int
    let title: String
    
    init(count: Int, title: String) {      //init 함수는 이제 count와 title만 요청함
        self.count = count
        self.title = title
        
        if title ==  "Apples"{
            self.backgroundColor = .red
        } else {
            self.backgroundColor = .orange
        }
    }
    
    
    var body: some View {
        VStack(spacing: 12) {
            Text("\(count)")
                .font(.largeTitle)
                .foregroundColor(.white)
                .underline()
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(width: 150, height: 150)
        .background(backgroundColor)
        .cornerRadius(10)
    }
}

struct Initializer_Previews: PreviewProvider {
    static var previews: some View {
        Initializer(count: 5, title: "Apples")     //title 매개변수에 Appples를 입력하면 배경이 빨간색으로 변한다
    }
}

```
<img width="740" alt="스크린샷 2023-04-27 오전 12 20 53" src="https://user-images.githubusercontent.com/87987002/234623216-7d202f42-030e-43fa-a1a7-5342fcf53e10.png">


init 함수로 init을 커스텀화할 수도 있다. <br>
사과라고 쓸 때마다 빨간색을, 오렌지라고 쓸 때마다 주황색을 사용하고 싶을 때 커스텀 init을 생성할 수 있음. 






<br>
<br>
<br>

--------------------
<br>
<br>
<br>




## **enum**

열거형은 항목을 쉽게 카테고리화하는 방법이다. <br>
예를 들어서 동서남북을 문자열타입으로 입력하는 대신 enum에 4개의 case를 만들 수 있다. 오타를 줄일 수 있고 코드를 간소화하고 효율적으로 만들게 해줌. 

```swift
init(count: Int, fruit: Fruit) {
        self.count = count

        if fruit == .apple {
            self.title = "Apples"
            self.backgroundColor = .red
        } else {
            self.title = "Oranges"
            self.backgroundColor = .orange
        }
    }
    
    enum Fruit {
        case apple
        case orange
    }
```



```swift
struct Initializer_Previews: PreviewProvider {
    static var previews: some View {
        Initializer(count: 100, fruit: .apple)
    }
}
```
<img width="739" alt="스크린샷 2023-04-27 오전 12 44 31" src="https://user-images.githubusercontent.com/87987002/234629712-9e81bf69-023b-44ab-a7f4-80ab498c5ccd.png">

하단에서 Color나 title을 지정해줄 필요가 없음. 단지 .apple만 입력하면 커스텀된 init 함수가 title과 배경색을 지정해준다. 
