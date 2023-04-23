# Init, Enum
- 뷰 내부에 변수를 생성하고, Enum을 활용하여 초기화하여 뷰의 재사용성 향상

### 프로퍼티 기본값
- 뷰(구조체)의 재사용성을 높이기 위해 `title`, `backgroundColor`이라는 변수(프로퍼티)를 생성한다.
- 생성한 프로퍼티에 기본값을 할당한다.
```swift
struct TestView: View {
    
    // 프로퍼티 기본값 할당
    let backgroundColor: Color = .red
    let title: String = "Apple"
    
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .frame(width: 150, height: 150)
        .background(backgroundColor)
        .cornerRadius(30)
    }
}
struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView() // 인스턴스 생성
    }
}
```

### 이니셜라이저 Init
- 프로퍼티 기본값을 지정하지 않을 경우, 이니셜라이저 `init`을 이용해 인스턴스가 갖어야 할 초기값을 전달한다.
- `self`는 현재의 인스턴스를 가르키므로 `self.backgroundColor`는 인스턴스 뷰 내부의 `let backgroundColor: Color`를 가르킨다.
- SwiftUI에서는 이니셜라이저를 따로 작성하지 않아도 자동으로 초기화가 진행된다.
```swift
struct TestView: View {
    
    let backgroundColor: Color
    let title: String
    
    // 이니셜라이저
    init(backgroundColor: Color, title: String) {
        self.backgroundColor = backgroundColor
        self.title = title
    }
    
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .frame(width: 150, height: 150)
        .background(backgroundColor)
        .cornerRadius(30)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(backgroundColor: .red, title: "Apple") // 인스턴스를 생성하며 초기값 전달
    }
}
```
- 관련 있는 프로퍼티끼리 연관지어서 초기화 할 수 있다.
```swift
struct TestView: View {
    
    let backgroundColor: Color
    let title: String
    
    init(title: String) {
        self.title = title
        //title에 따라 backgroundColor 초기화
        if title == "Apple" {
            self.backgroundColor = .red
        } else {
            self.backgroundColor = .orange
        }
    }
    
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .frame(width: 150, height: 150)
        .background(backgroundColor)
        .cornerRadius(30)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(title: "Orage") // 인스턴스를 생성하며 초기값 전달
    }
}
```

### 열거형 Enum
- 연관된 프로퍼티끼리 열거형 `enum`을 활용하여 타입을 정의하고, 제한된 파라미터 내에서 초기화 진행할 수 있다.
```swift
struct TestView: View {
    
    let backgroundColor: Color
    let title: String
    
    // 연관된 프로퍼티들의 케이스를 타입으로 지정
    enum Fruit {
        case apple
        case orange
        case grape
    }
    
    init(fruit: Fruit) { // 제한된 파라미터로 초기화 진행
        // 전달 받은 파라미터에 따라 모든 프로퍼티 초기화
        if fruit == .apple {
            self.title = "Apple"
            self.backgroundColor = .red
        } else if fruit == .orange {
            self.title = "Orange"
            self.backgroundColor = .orange
        } else {
            self.title = "Grape"
            self.backgroundColor = .purple
        }
    }
    
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .frame(width: 150, height: 150)
        .background(backgroundColor)
        .cornerRadius(30)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TestView(fruit: .grape) // 인스턴스 생성 후 grape 케이스의 초기화 진행
            TestView(fruit: .apple) // 인스턴스 생성 후 apple 케이스의 초기화 진행
        }
    }
}
```
