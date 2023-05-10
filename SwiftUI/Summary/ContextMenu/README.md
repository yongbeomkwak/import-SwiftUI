# Context Menu

iOS 13 이후부터 인터페이스를 복잡하게 만들지 않고, onscreen items 와 관련된 추가 기능에 액세스할 수 있도록 할 수 있습니다.

다양한/여러 개의 버튼을 사용자에게 보여주는 방식 중 하나!<br>
사용자가 object를 click & hold 하면 object 옆으로 여러 버튼으로 이루어진 context menu가 나타남<br><br>

버튼이 나타날 때는 UI bounce 효과가 살짝 있고, 버튼들의 list가 나타남<br><br>

(alert 와 actionsheet보단 덜 유명한 방식)<br>
(점점 더 자주 쓰이게 되고 있음)


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

<br>
Context Menu의 버튼 항목은 title(Text)와 icon만 넣을 수 있게 되어있음<br>
그래서 menu 자체를 customize 하는 건 불가함.