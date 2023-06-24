# Group

## 사용 이유
- 별도의 뷰를 생성하지 않고 Modifier를 적용하고 싶을 때 사용합니다.


<br>

#### 1. 가장 바깥 뷰에 Modifier를 적용하면 자식 뷰도 해당 속성을 따라간다.
#### 2. 별도의 Modifier를 적용하기 위해서는 다시한번 뷰로 감싸야 한다.
#### 3. Group을 사용하면 불필요한 뷰를 만들어 랜더링 할 필요가 없다.

```swift
VStack{
            
    Text("Hello")
    Text("Hello")
    Text("Hello")
            
}
.foregroundColor(.red)
.font(.largeTitle)
```

```swift
VStack{
            
    Text("Hello")
    VStack{
        Text("Hello")
        Text("Hello")
    }
    .foregroundColor(.blue)
    .font(.caption)            
}
.foregroundColor(.red)
.font(.largeTitle)
```

```swift
VStack{
            
    Text("Hello")
    Group{
        Text("Hello")
        Text("Hello")
    }
    .foregroundColor(.blue)
    .font(.caption)            
}
.foregroundColor(.red)
.font(.largeTitle)
```

<p align ="center">

<img width = "250" height = "500" src ="https://github.com/yongbeomkwak/SwiftUI-Study/assets/48616183/2ca5b8a8-699f-40eb-a401-6165b84a21ea">

<img width = "250" height = "500" src ="https://github.com/yongbeomkwak/SwiftUI-Study/assets/48616183/860cb557-018a-4943-bdcc-b4898967dab0">

<img width = "250" height = "500" src ="https://github.com/yongbeomkwak/SwiftUI-Study/assets/48616183/860cb557-018a-4943-bdcc-b4898967dab0">
</p>
