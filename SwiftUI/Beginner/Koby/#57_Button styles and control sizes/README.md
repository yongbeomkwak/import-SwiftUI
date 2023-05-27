# **#57 Button styles and control sizes**
- ios 15에서는 기본 수정자로 버튼 스타일을 지정할 수 있다. 

<br>

## **buttonStyle**


```swift
  VStack{
            Button("Button Title") {
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .buttonStyle(.plain)                //기본 버튼 사이즈, AccentColor(blue) 없음
            
            Button("Button Title") {
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .buttonStyle(.bordered)             // 폰트에 AccentColor, secondary background
            
            Button("Button Title") {
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .buttonStyle(.borderedProminent)    //배경이 AccentColor가 됨.
            
            Button("Button Title") {  
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .buttonStyle(.borderless)           //폰트에 AccentColor, 버튼 경계가 안보임
        }
```
AccentColor는 Assets파일에서 원하는 컬러로 지정할 수 있음. 


<img width="731" alt="스크린샷 2023-05-22 오전 4 04 56" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/d4ec460d-c38d-4811-999e-ff0c1c507a80">

<br>
<br>
<br>

## **controllSize**
버튼의 사이즈 조정
```swift
        VStack{
            Button("Button Title") {
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .buttonStyle(.borderedProminent)
            .controlSize(.large)                //순서대로 large, regular, small, mini
        }
```
controlSize와 buttonStyle은 버튼 자체에 적용되는 게 아니라 버튼 내부의 label에 적용되는 것. 디폴트 label에 .large가 적용됨

<img width="733" alt="스크린샷 2023-05-22 오전 4 31 37" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/5bf0a54c-a20e-4bea-a9e3-4bdd122d30c8">

<br>
<br>
<br>


```swift
 Button {
  } label: {
      Text("Button Title")
          .frame(height: 55)
          .frame(maxWidth: .infinity)
      
  }
  .controlSize(.large)
  .buttonStyle(.borderedProminent)
```


그래서 label을 커스텀할 수 있는 버튼을 만든다면, 프레임이 지정된 label에 controlSize와 buttonStyle을 적용할 수도 있다. <br>이렇게 버튼의 크기를 리사이징할 수 있음.


<img width="729" alt="스크린샷 2023-05-22 오전 4 49 32" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/5de0bc00-0d0f-4d6c-afa2-f651f70624c7">


<br>
<br>
<br>

## **buttonBorderShape**
```swift
            Button {
            } label: {
                Text("Button Title")
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                
            }
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)      //캡슐형태
```

<img width="736" alt="스크린샷 2023-05-22 오전 4 56 57" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/0aec9931-9a08-4b1a-8e87-a6e693e72b3c">
