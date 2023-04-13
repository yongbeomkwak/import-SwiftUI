# Color
- Components의 색상을 변경

### System Color
- 시스템에서 미리 지정된 색상을 사용할 수 있다.
```swift
RoundedRectangle(cornerRadius: 24.0)
    .frame(width: 300, height: 200)
    .fill(Color.red) // 시스템 red 색상
    .fill(Color.primary) // 시스템 primary 색상(시스템 디스플레이 모드에 따라 변경)
    .fill(Color(UIColor.secondarySystemBackground) // UIKit의 system 색상(시스템 디스플레이 모드에 따라 변경)
```

### Custom Color
* 원하는 색상을 미리 지정하고 색상 이름으로 적용할 수 있다.
1. Assets 폴더의 새로운 Color Set 추가 및 이름 지정
2. inspector에서 Appearance별 색상 지정(디스플레이 모드에 상관 없이 한 가지의 색상으로 지정하고 싶을 경우, Appearances를 'None'으로 설정)
3. 색상 이름(String)으로 색상 적용

![](https://velog.velcdn.com/images/snack/post/c4895b51-0a35-4ab7-ba95-f292790af2be/image.png)
![](https://velog.velcdn.com/images/snack/post/e191ba24-6be4-4677-a458-3e3bf69793e2/image.png)
```swift
RoundedRectangle(cornerRadius: 24.0)
    .frame(width: 300, height: 200)
    .fill(Color("customColor")) // 미리 지정한 "customColor" 색상
```

### Shadow
* 원하는 색상으로 오브젝트에 그림자를 추가할 수 있다.
```swift
Rectangle()
    .frame(width: 300, height: 200)
    .shadow(color: Color("customColor"), radius: 16, x: 8, y: 8) // "customColor" 색상의 그림자
```
