# Text
- modifier(.___)로 원하는 글씨 특성을 커스텀할 수 있다.

<br/>

## **글씨 색, 크기, 폰트 특성**
<br/>



<p align="center">
  <img src="https://user-images.githubusercontent.com/126866283/230378671-57ff8d3a-a768-49e7-a8eb-b405aa38a829.png">
</p>

[https://youtu.be/RKfkG01x79w?t=570](https://youtu.be/RKfkG01x79w?t=570)

```swift
Text(" ")
	.font(.body)                       // 글씨 크기
	.fontWeight(.semibold)             // 글씨 두께
	.bold()                            // 빠른 볼드체
	.underline()                       // 빠른 밑줄
	.underline(Bool, color: Color?)    // 밑줄 색까지 지정 가능
	.foregroundColor(.red)             // 글씨 색

	.font(.system(size:_, weight:_, design:_)
	// 폰트 크기, 두께, 폰트 종류(default, monospaced, rounded, serif...) 커스텀
```

**폰트를 커스텀하는 것은 그리 추천하지 않는다.** 

크기를 예로 들자면, 나는 폰트크기 24가 좋아서 맞춰놓더라도 눈이 안좋은 부모님이 글씨를 키우려고 할 때에는 크기가 24에서 고정되어 바뀌지 않는 불편함이 있다. 

→ 따라서, 특수한 경우가 아닌 이상 **.font(._)** 를 이용해 크기 조절하는 것 추천! Title, body처럼 분류를 해둔 후, 화면에서 확대/축소를 하면 전체적으로 유동적인 크기 변화가 가능하다.

<br/>
<br/>

#

## **문단 특성**
<br/>

### **대문자/소문자 설정**

<p align="center">
  <img src="https://user-images.githubusercontent.com/126866283/230378094-b4e1ef14-aaee-473c-8748-55846f5919d4.png">
</p>

[https://youtu.be/RKfkG01x79w?t=969](https://youtu.be/RKfkG01x79w?t=969)

```swift
Text("Hello, world!".uppercased())   // 모든 글자 대문자 - HELLO, WORLD
Text("Hello, world!".lowercased())   // 모든 글자 소문자 - hello, world
Text("Hello, world!".capitalized)    // 단어 첫글자 대문자 - Hello, World
```
<br/>
<br/>

### **문단 행간, 자간, 정렬**

<p align="center">
  <img src="https://user-images.githubusercontent.com/126866283/230377108-c7d53896-49f1-4409-9ab0-cb537c88ea41.png">
</p>

[https://youtu.be/RKfkG01x79w?t=653](https://youtu.be/RKfkG01x79w?t=653)

```swift
Text(" ")
	.baselineOffset(50.0)             // 행간 조절. 음수면 첫 줄 앞에 여백 생성
	.kerning(1.0)                     // 자간 조절
	.multilineTextAlignment(.center)  // 문단 정렬 형식(center,leading,trailing)
```

<br/>
<br/>

### **문단 프레임 설정**

<p align="center">
  <img src="https://user-images.githubusercontent.com/126866283/230378397-b77fbeca-270c-4245-b8db-0a310d271480.png">
</p>

[https://youtu.be/RKfkG01x79w](https://youtu.be/RKfkG01x79w)

```swift
Text(" ")
	.frame(width: 200, height: 100, alignment: .center)
	// 문단 파란색 프레임 면적 조절
	.minimumScaleFactor(0.1)
	// 글씨 크기를 10% 줄여서 문단의 모든 글씨가 프레임 안에 들어올 수 있게끔 만들기
```