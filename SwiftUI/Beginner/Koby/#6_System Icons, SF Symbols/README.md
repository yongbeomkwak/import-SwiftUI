# #6 System Icons, SF Symbols
## LinearGradient

```swift
RoundedRectangle(cornerRadius: 25)
            .fill(
                LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]),
                               startPoint: .leading,
                               endPoint: .trailing)
            )

            //       startPoint: .top, endPoint: .bottom
            //       startPoint: .topLeading, endPoint: .bottomtrailing
            //       startPoint: .top, endPoint: .bottom
            //       startPoint: .topLeading, enPoint: .bottom - 이게 자주 사용됨
```
그라디언트 매개변수 내의 색상은 배열임. 

<br>


```swift
RoundedRectangle(cornerRadius: 25)
            .fill(
                LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue, Color.orange, Color.purple]),
                               startPoint: .leading,
                               endPoint: .trailing)
            )
```
색상은 이렇게 계속 추가할 수 있음. 

<br>
<br>

## RadialGradient

```swift
RoundedRectangle(cornerRadius: 25)
            .fill(
                RadialGradient(
                    gradient: Gradient(colors: [Color.red, Color.blue]),
                    center: .topLeading,
                    startRadius: 5,
                    endRadius: 400)
            )
```
<img width="701" alt="스크린샷 2023-04-20 오후 6 18 23" src="https://user-images.githubusercontent.com/87987002/233320288-638f06dc-63ad-45d3-a4e5-6a2bdf98b390.png">

<br>
<br>

## AngularGradient
```swift
RoundedRectangle(cornerRadius: 25)
            .fill(
                AngularGradient(gradient: Gradient(colors: [Color.red, Color.blue]),
                                center: .center,
                                angle: .degrees(180 + 45))
            )
```

<img width="707" alt="스크린샷 2023-04-20 오후 6 28 47" src="https://user-images.githubusercontent.com/87987002/233323227-9b4d9ae6-74ee-489d-8ca1-f94e8f986510.png">


중심점의 위치를 좌상단으로 옮기면

```swift
RoundedRectangle(cornerRadius: 25)
            .fill(
                AngularGradient(gradient: Gradient(colors: [Color.red, Color.blue]),
                                center: .topLeading,
                                angle: .degrees(180 + 45))
            )
```
<img width="711" alt="스크린샷 2023-04-20 오후 6 30 00" src="https://user-images.githubusercontent.com/87987002/233323527-81638b86-9b11-42cc-957e-c37899a8b463.png">

