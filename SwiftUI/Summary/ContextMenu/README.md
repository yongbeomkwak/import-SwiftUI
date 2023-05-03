# Context Menu

iOS 13 이후부터 인터페이스를 복잡하게 만들지 않고, onscreen items 와 관련된 추가 기능에 액세스할 수 있도록 할 수 있습니다.


context menu 를 표시하기 위해서 사람들은 시스템 정의 touch and hold gesture 또는 3D Touch 를 사용할 수 있습니다.

context menu 가 열리면, 아이템의 미리보기와 명령 리스트를 보여줍니다. 사람들은 명령을 선택하거나 항목을 다른 영역, 윈도우, 앱으로 끌 수 있습니다.

밑 함수를 이용한다. 

<br>

```swift
.contextMenu(menuItems:() -> View) 
```

### 사용 예제

```swift
Text("Hello, World!")
            .contextMenu {
                Button(action: {}) {
                 Label("Follow Show", systemImage: "plus.circle")
                }
                 Button(action: {}) {
                     Label("Go to Show", systemImage: "airplayaudio")
                 }
                 Button(action: {}) {
                     Label("Share Show", systemImage: "square.and.arrow.up")
                 }
                 Button(action: {}) {
                     Label("Copy Link", systemImage: "link")
                 }
                 Button(action: {}) {
                     Label("Report a Concern", systemImage: "exclamationmark.bubble")
                 }
            }
```

### 결과

- Hello world! 텍스트 뷰를 꾸욱 누르면 해당 컨텍스트 메뉴가 팝업 된다.

<br>

<p align ="center"><img width="194" alt="스크린샷 2023-05-03 오후 5 07 09" src="https://user-images.githubusercontent.com/48616183/235862699-76b385c2-2a14-461c-96b7-86be834118a6.png"> </p>

