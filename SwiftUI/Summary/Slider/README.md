# **#42 Slider**


### **`Slider(value: Binding<BinaryFloatingPoint>)`**

- slider의 value만을 받아서 만들 때 사용
- `BinaryFloatingPoint` : 보통 숫자를 의미함

<br>

slider의 값으로 설정할 변수를 만들자.

```swift
@State var sliderValue: Double = 10
```

그 후 view에 VStack을 이용해 Slider()를 생성한다.

```swift
VStack {
	Text("Rating:")
	Text("\(sliderValue)")
	Slider(value: $sliderValue)
		.tint(.red)  // Slider 색상 파란색 -> 빨간색
}
```
<img src="https://user-images.githubusercontent.com/126866283/236785564-a1e881bf-a355-49ff-8696-4d89b3ef283c.gif" width=300>

<br>
<br>


### **`Slider(value:in)`**

- slider 조작부의 처음 시작 위치를 지정해두고, 움직일 범위를 따로 설정하고 싶을 때 사용
- `value:` 에는 Binding 값, `in:` 에는 closedRange 값 넣기

```swift
Slider(value: $sliderValue, in: 0...100) // slider의 가동범위는 0부터 100까지
	.tint(.red)
```

<img src="https://user-images.githubusercontent.com/126866283/236785866-205437f3-2912-487a-8cae-35c1572fbe80.gif" width=300>

sliderValue에 넣어둔 초기값(10)의 위치에 조작부가 멈춰있고, 0부터 100까지 slider를 움직일 수 있다.

<br>
<br>

### **`Slider(value:in:step)`**

- slider가 double 값 모두 선택 가능한 것이 아니라, 전체 범위 중 **특정 구간에만 멈출 수 있게** 할 때 사용
- `value:` 에는 Binding 값, `in:` 에는 closedRange 값, step:에는 구간 값 넣기

```swift
Slider(value: $sliderValue, in: 1...10, step: 1.0) // 1.0마다 slider 멈추기
	.tint(.red)
```
<img src="https://user-images.githubusercontent.com/126866283/236786132-dcc94afc-2b19-4946-8db1-060fe758c5d5.gif" width=300>

<br>
<br>

### **`Slider(value:in:step:label:minimumValueLabel:maximumValueLabel:onEditingChanged:)`**

- slider 주변에 label을 달아 커스텀하고, slider value 값이 변경됐을 때의 action을 주고 싶을 때 사용

```swift
@State var sliderValue: Double = 10
@State var color: Color = .red
```

```swift
VStack {
	Text("Rating:")
	Text(String(format: "%.2f", sliderValue))
		.foregroundColor(color)

Slider(
	value: $sliderValue,
	in: 0...10,
	step: 1.0) {
		Text("Title")            // 'label:'에 해당하는 내용. 나타나지 않음
  } minimumValueLabel: {         // slider의 왼쪽 끝에 나타낼 label
	  Text("0")
  } maximumValueLabel: {         // slider의 오른쪽 끝에 나타낼 label
	  Text("10")
  } onEditingChanged: { (_) in   // slider value가 바뀌는 경우 어떤 동작이 일어나는지
    // _ 대신 default 값으로는 Bool이 설정되어 있는데, Bool을 쓰지 않는 경우 _로 처리 가능
	  color = .green             // 동작: 숫자 글씨 색 초록색으로 바꾸기
  } 
}
```
<img src="https://user-images.githubusercontent.com/126866283/236786384-acfea433-2c18-49ae-84f4-4b6d2dd2edc3.gif" width=300>

<br>
<br>
<br>

## **숫자의 format 변경하는 법**

- 나타나는 숫자의 소수점들이 거슬릴 때 → 소수점 몇째 자리까지 나타낼 것인지 설정할 수 있다.
- `String(format:argument)`
- `format:` 소수점 몇째 자리까지 나타낼 것인지, `argument:` 변경할 대상(변수) 넣기

```swift
Text(
	String(format: "%.2f", sliderValue) // sliderValue의 값을 소수점 두자리까지 표기하기
)
```
<img src="https://user-images.githubusercontent.com/126866283/236786745-8a50bba3-60d3-48b4-b521-2801ac8f2ebc.png" width=300>
