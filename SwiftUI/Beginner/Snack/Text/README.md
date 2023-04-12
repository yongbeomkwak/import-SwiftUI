# Text
- 텍스트 입력하고 표시할 수 있는 componet

### Modifiers
- modifiers를 통해 components의 여러 속성들을 추가 및 변경할 수 있다.
```swift
Text("Hello, World!")
    .font(.title)
```

### Text 속성
- modifiers를 통해 text의 다양한 속성을 추가할 수 있다.
```swift
Text("Hello, World!")
    .font(.body) // body형식의 텍스트
    .fontWeight(.bold) // bold체
    .bold() // bold형식의 텍스트
    .foregroundColor(.blue) // 색상 변경
    .underline() // 텍스트 밑줄
    .underline(true, color: Color.red) // 빨간색의 텍스트 밑줄
    .strikethrough(true, color: Color.green) // 초록색의 텍스트 취소선
    .italic() // italic 형식의 텍스트
```

### System Text
- .font modifier를 통해 시스템 폰트를 활용할 수 있다.
```swift
Text("Hello, World!")
    .font(.system(size: 24, weight: .semibold, design: .serif))
    // sysetm 폰트의 크기 24, semibold체, serif 디자인
```
- 크기 24를 정해두면 dynamic type이 적용되지 않는다. 반면, .font(.body)처럼 기본 font style을 적용하면 dynamic type이 지원된다.

### Formatting Text
- 텍스트의 정렬 및 간격을 조정할 수 있다.
```swift
Text("Hello, World!")
    .multilineTextAlignment(.leading) // 왼쪽 정렬
    .multilineTextAlignment(.center) // 중앙 정렬
    .multilineTextAlignment(.trailing) // 오른쪽 정렬
    .baselineOffset(8.0) // 텍스트 baseline 기준 아래쪽 간격 추가
    .baselineOffset(-8.0) // 음수일 경우 위쪽 간격 추가
    .lineSpacing(8) // 행간 조정
    .kerning(8) // 자간 조정
```

### Frame
- 텍스트의 너비 및 높이를 조정한다.
- 따로 조정해주지 않으면 텍스트 내용에 따라 사이즈가 정해진다.
```swift
Text("Hello, World!")
    .frame(width: 200, height: 100, alignment: .center) // 너비 및 높이 고정, 중앙 정렬
    .minimumScaleFactor(0.1) // frame에 텍스트를 모두 입력하기 위해 자동으로 텍스트 크기를 줄일 최소 비율 지정
```

### Text 형식
- 입력된 text와 상관없이 text의 형식을 변경할 수 있다.
```swift
Text("Hello, World!".lowercased()) // 소문자로 변경
Text("Hello, World!".uppercased()) // 대문자로 변경
Text("Hello, World!".capitalized()) // 첫번째 문자를 대문자, 나머지 문자를 소문자로 변경
```
