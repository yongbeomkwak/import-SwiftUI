# **Dark Mode**
```swift
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(spacing: 20) {
                    Text("This color is PRIMARY")
                        .foregroundColor(.primary)  //라이트모드에서는 black, 다크모드에서는 white로 변함
                    Text("This color is SECONDARY")
                        .foregroundColor(.secondary)  //라이트모드와 다크모드 둘 다에서 연한 회색
                    Text("This color is BLACK")
                        .foregroundColor(.black)
                    Text("This color is WHITE")
                        .foregroundColor(.white)
                }
            }
            .navigationTitle(Text("Dark Mode Bootcamp"))
        }
    }
```
- primary와 secondary 컬러는 라이트 모드와 다크모드에서 자동으로 조정됨. 
![화면 기록 2023-05-09 오전 5 46 33](https://user-images.githubusercontent.com/87987002/236931563-94304a79-7649-41d8-819c-7466e2a885f1.gif)

<br>
<br>

## Globally adapted Color

asset → New Color Set → 이름 설정 →  Appearances →  Any, Dark 로 설정 → 색상 설정

```swift
            Text("This color is globally adapted!")
                .foregroundColor(Color("AdaptiveColor"))
```
<img width="989" alt="스크린샷 2023-05-09 오전 6 02 59" src="https://user-images.githubusercontent.com/87987002/236934523-fc04cdba-042c-4d95-9217-89f08afdae17.png">
<img width="584" alt="스크린샷 2023-05-09 오전 5 58 23" src="https://user-images.githubusercontent.com/87987002/236933613-98e02e3d-208b-4eb1-91ab-ae1e107b9639.png">

<br>
<br>

## 환경변수 추가
- colorScheme은 swiftUI에서 기본으로 제공하는 환경변수임 - light/ Dark

```swift
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(spacing: 20) {
                    Text("This color is locally adaptive!")
                        .foregroundColor(colorScheme == .light ? .green : .orange)  
                        //삼항연산자로 colorScheme이 dark인지 light인지 확인
                }
            }
            .navigationTitle(Text("Dark Mode Bootcamp"))
        }
    }
```
<img width="766" alt="스크린샷 2023-05-09 오전 6 17 10" src="https://user-images.githubusercontent.com/87987002/236937200-be7f336a-6494-49a0-bdb7-f22733606500.png">
