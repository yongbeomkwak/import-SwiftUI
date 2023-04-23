# Image
- 이미지를 추가할 수 있는 뷰

### Image 사이즈
- 이미지를 frame을 기준으로 사이즈를 조정할 수 있다.
```swift
Image("testImage")
    .resizable() // 사이즈 조정 가능
    .frame(width: 300, height: 250) // 이미지 뷰 frame 사이즈 조정
```
- 원본 이미지 비율을 유지하면서 이미지 사이즈를 조정할 수 있다.
```swift
Image("testImage")
    .resizable()
    .aspectRatio(contentMode: .fill) // 원본 비율을 유지하면서 프레임 사이즈에 맞게 조정(프레임 초과 가능)
    .scaledToFill() // aspectRatio와 동일 효과
    .frame(width: 300, height: 250)
```
![업로드중..](blob:https://velog.io/05f02712-0a52-4e76-9015-e3911d085fe9)
```swift
Image("testImage")
    .resizable()
    .aspectRatio(contentMode: .fit) // 원본 비율을 유지하면서 프레임 사이즈에 맞게 조정(프레임 초과 불가능)
    .scaledToFit() // aspectRatio와 동일 효과
    .frame(width: 300, height: 250)
```
![업로드중..](blob:https://velog.io/d8cc5c9e-75e8-4916-aac2-addf1179d77d)

### Image 클리핑 마스크
- 이미지를 원하는 모양으로 클리핑 마스크를 씌울 수 있다.
```swift
Image("testImage")
    .resizable()
    .aspectRatio(contentMode: .fill)
    .scaledToFill()
    .frame(width: 300, height: 250)
    .clipped() // 프레임을 초과한 부분 자르기
    .cornerRadius(24) // 프레임의 둥근 모서리 모양으로 초과한 부분 자르기
    .clipShape(Circle()) // Shape 모양으로 자르기
```

### RenderingMode
- 이미지의 불투명 영역의 색상을 임의로 변경할 수 있다.
```swift
Image("apple")
    .renderingMode(.template) // 이미지의 렌더링 모드를 template 모드로 변경
    .resizable()
    .aspectRatio(contentMode: .fit)
    .frame(width: 300, height: 200)
    .foregroundColor(.green) // template 모드 이미지의 불투명 영역 색상을 변경
```
- 이미지 에셋의 Attributes inspector에서 이미지의 렌더링 모드를 사전에 설정할 수 있다.
- 렌더링 모드를 사전에 설정하면 `.renderingMode(.template)`을 입력하지 않아도 template 모드가 적용된다.

![업로드중..](blob:https://velog.io/d75975b2-64dd-486f-940f-fcdb8621e3b7)
