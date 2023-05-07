# **#40 DatePicker**



## **`DatePicker(title:selection)`**

- 선택했을 때 색상을 파란색 외에 다른 것으로 바꾸고 싶다면 `.tint()` 사용

<img src="https://user-images.githubusercontent.com/126866283/236687998-831cad3c-c2fe-4799-a99c-0b4807f66372.gif" width=250>


```swift
@State var selectedDate : Date = Date() 
// Date() - 자동으로 현재 날짜를 불러와주는 함수
```

```swift
DatePicker("Select a Date", selection: $selectedDate)
  .tint(Color.red) // .accentColor(Color.red) -> deprecated
```
<br>

### **여러가지 datePicker**

![image.jpg1](https://user-images.githubusercontent.com/126866283/236688095-7bd0cf9c-360e-4b5d-a24c-2e4d9caddaf9.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/236688122-e8779b14-0a6c-401a-a409-a03a79caf58b.png) |![image.jpg3](https://user-images.githubusercontent.com/126866283/236688136-bc44eb52-f976-4647-9573-8527b62e1093.png)
--- | --- | ---


```swift
.datePickerStyle(
	CompactDatePickerStyle()     // datePicker를 불러오면 디폴트 값으로 설정되어 있는 스타일
	GraphicalDatePickerStyle()   // 달력형
	WheelDatePickerStyle()       // wheel형
)
```
<br>
<br>

## **`DatePicker(title:selection:displayedComponents)`**

- DatePickerComponents라는 array의 속성들을 가져와서 사용
- `.date`와 `.hourAndMinute`가 있음

![image.jpg1](https://user-images.githubusercontent.com/126866283/236688201-d226ef3b-f76d-40ab-9cf5-71a951f2bccf.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/236688223-a253615c-4736-4f5c-894f-ab1b108354f1.png) |![image.jpg3](https://user-images.githubusercontent.com/126866283/236688243-31abd04d-348c-49d2-bb86-a633a6aa61a5.png)
--- | --- | ---

```swift
DatePicker("Select a date", selection: $selectedDate,
displayedComponents: [.date, .hourAndMinute])
displayedComponents: [.date])
displayedComponents: [.hourAndMinute])
```
<br>
<br>

## **`DatePicker(title:selection:in range)`**

- range를 지정해서 날짜를 고를 수 있는 범위를 제한하는 것
- 시작 날짜와 마지막 날짜를 정해두어야 한다 → startingDate 와 endingDate 변수 설정하기!
- `Calendar.current.date(from: DateComponents())`를 이용해 많은 날짜 속성들 중 필요한 것을 골라 사용할 수 있다.

	<img src="https://user-images.githubusercontent.com/126866283/236688306-f1f9492f-409f-411f-a932-c4a96bccd36b.png" width=300>

```swift
let startingDate : Date = Calendar.current.date(from: DateComponents(year: 2018)) ?? Date()
let endingDate: Date = Date()
```

**뒤에 `?? Date()` 을 붙인 이유** 

앞에 2018이 년도에 맞는 숫자인지에 대한 확신이 없기 때문에 에러가 뜬다(optional 임). ‘!’를 붙여 optional을 풀 수 있지만 위험하기 때문에, 앞에 숫자가 년도에 맞는 수가 아니라면 현재 날짜로 대체해달라는 의미로 ‘?? Date()’를 붙인다.

<br>

<img src="https://user-images.githubusercontent.com/126866283/236688479-0530dda5-cd77-4813-9e9a-b14353198c67.gif" width=300>


```swift
var body: some View {
	DatePicker("Select a date", selection: $selectedDate, in: startingDate...endingDate)
	// 2018년부터 현재 날짜까지만 선택할 수 있게 범위 설정
}
```

선택 범위를 설정해주면, 위 gif 처럼 wheel picker에서 설정한 시작 년도(2018) 이전은 선택하지 못하고 다시 자동으로 2018에 맞춰진다.

<br>
<br>

## **Customized Date**

<img src="https://user-images.githubusercontent.com/126866283/236688598-7f60aeab-9339-42ad-8ba8-abdbce88b0e5.png" width=300>

```swift
VStack {
	Text("SELECTED DATE IS:")
  Text(selectedDate.description) // selectedDate 변수의 날짜 값을 상세하게 나타내기
	  .font(.title)
```

해당 기능을 좀 더 원하는 모습으로 커스텀하고 싶다면 다음 변수를 선언한 후,

```swift
var dateFormatter : DateFormatter {
	let formatter = DateFormatter() // initializing formatter
	formatter.dateStyle = .short    // dateStyle을 short으로 
	formatter.timeStyle = .medium   // timeStyle을 medium으로
  return formatter
}
```

Text를 사용해 오늘 날짜를 dateFormatter를 이용해 나타내준다.

```swift
Text(dateFormatter.string(from: selectedDate)) 
// 위에서 생성해준 dateFormatter를 통해 selectedDate(현재 날짜)로부터 string을 뽑아낸다.
	.font(.title)
```

![image.jpg1](https://user-images.githubusercontent.com/126866283/236688652-b9edfb55-7916-489e-a226-842d4f388a89.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/236688662-62a37392-7bff-4c92-8148-03f781c5a778.png) |![image.jpg3](https://user-images.githubusercontent.com/126866283/236688671-01af7992-1444-4611-aaa9-3513998899f1.png)
--- | --- | ---

![image.jpg1](https://user-images.githubusercontent.com/126866283/236688680-c4b62e69-7f11-47c9-b55a-86239eaa2f7c.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/236688688-77f3c110-3d6f-42d7-bba5-7bd7878876ad.png) |![image.jpg3](https://user-images.githubusercontent.com/126866283/236688696-b280c4cf-90b9-4f4f-bef2-8887b5899bff.png)
--- | --- | ---

순서대로 date와 time의 .short / .medium / .long
