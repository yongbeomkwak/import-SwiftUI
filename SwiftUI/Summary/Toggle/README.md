# Toggle

### 특징
1. 스위치 형태의 끄고 키는 형태
2. @State Bool 타입으 값을 바인딩 시켜 사용한다.
3. 스위치 색은 tint로 글자색은 foregroundColor로 변경한다.

### 사용 
1. 기본 형태

```swift
@State var toggleIsOne:Bool = false
    
    
    var body: some View {
        VStack{
            Toggle(isOn: $toggleIsOne) {
                Text("DarkMode")
            }
        }
    }

```
<img width="293" alt="스크린샷 2023-05-10 오후 3 42 24" src="https://github.com/wakmusic/waktaverseMusic-iOS/assets/48616183/3c80066d-34a9-46db-8733-9a0bcfe6ee79">

2. 색 변경

```swift
Toggle(isOn: $toggleIsOne) {
    Text("DarkMode")
        .foregroundColor(.green)
}
.toggleStyle(.switch)
.tint(.red)

```

<img width="293" alt="스크린샷 2023-05-10 오후 3 46 15" src="https://github.com/wakmusic/waktaverseMusic-iOS/assets/48616183/a1133f06-1632-400d-9de0-fc912f352496">

