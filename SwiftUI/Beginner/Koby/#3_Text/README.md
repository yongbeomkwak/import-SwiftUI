# #2 Adding text
## 폰트 크기 설정

```swift
Text("Hello, World!")
	.font(.body)

// 큰 순서대로
// largeTitle > title > title2 > title3 > headline > body > callout
// subheadline > footnote > caption > caption2
```
<br>

## 폰트 두께 설정

```swift
Text("Hello, World!")
	.fontWeight(.bold)
```
  
그냥 이렇게 할 수도 있음
```swift
Text("Hello, World!")
	.bold
```
<br>


## 밑줄, 취소선

```swift
Text("Hello, World!")
	.underline()
	.italic()
	.strikethrough()
```







<img width="542" alt="스크린샷 2023-04-11 오전 11 35 14" src="https://user-images.githubusercontent.com/87987002/231041450-17303fc9-5866-4051-b1c0-b59db6be8e18.png">


```swift
Text("Hello, World!")
	.underline(true, color: Color.red)
	.strikethrough(true, color:Color.green)
```
 밑줄에 컬러 지정하려면 앞에 true라고만 쓰면 됨. 전달인자 레이블(Argument Label) - from to에서 앞에 생략한거처럼 생략된 형태여서



<br>
<br>

## 폰트 사이즈 지정하려면

```swift
Text("Hello, World!")
	.font(.system(size: 23, weight: .bold, design: .serif))
```
<br>


## 대문자, 소문자

```swift
Text(“Hello” .uppercased)
// uppercased - 대문자
// lowercased - 소문자
// capitalized - 앞글자만 대문자

```



## 문단 정렬 방식

<img width="442" alt="스크린샷 2023-04-11 오전 12 58 23" src="https://user-images.githubusercontent.com/87987002/231042177-c73dfdde-ac94-486c-9072-ca93b9e8e518.png">

```swift
Text("Hello, World! Lorem Ipsum is simply dummy text of the printing and typesetting industry.") 
  .multilineTextAlignment(.trailing)
```
<br>

## 행간 설정
```swift
Text("Hello, World! Lorem Ipsum is simply dummy text of the printing and typesetting industry.") 
  .baselineOffset(10)
```
<br>

## 자간 설정
```swift
Text("Hello, World! Lorem Ipsum is simply dummy text of the printing and typesetting industry.") 
  .kerning(1.0)
```

<br>

## 프레임박스 만들기

<img width="479" alt="스크린샷 2023-04-11 오전 1 15 38" src="https://user-images.githubusercontent.com/87987002/231042286-5edd6d5b-4573-48f7-a50b-159f4e5e77b0.png">

```swift
Text("Hello, World! Lorem Ipsum is simply dummy text of the printing and typesetting industry.") 
  .frame(width: 200,height: 100, alignment: .center)
```

<br>

## 최소 폰트 크기를 10%로 설정. 프레임 사이즈에 맞춰서 조정됨.

```swift
Text("Hello, World! Lorem Ipsum is simply dummy text of the printing and typesetting industry.") 
  .minimumScaleFactor(0.1)
```


