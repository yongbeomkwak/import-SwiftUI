# **#59 Badges**
- list와 tab bar에만 적용된다.

## Tab bar_Badge

```swift
        TabView {
            Color.red
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Hello")
                }
                .badge(3)
        }
````
<img width="724" alt="스크린샷 2023-05-24 오후 9 39 20" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/f516f907-fcb3-4c8c-bcf8-b58f98b98b3a">

숫자뿐 아니라 텍스트로 뱃지에 띄울 수 있음

<br>
<br>
<br>

## List_ Badge

```swift
        List {
            Text("Hello, world!")
                .badge("NEW ITEMS!")
        }
```
<img width="736" alt="스크린샷 2023-05-24 오후 10 59 24" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/c3e92ffd-33ce-4ff7-9a1c-4f7e04555361">

secondary 컬러로 리스트 옆에 텍스트가 써짐. 