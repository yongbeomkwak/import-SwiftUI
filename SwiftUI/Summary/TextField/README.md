# TextField & TextEditor

## TextField

### 특징
- 텍스트를 입력 받을 수 있는 필드
- 1줄 입력만 가능

### 종류
1. 가장 기본적인 셋팅
```swift

titleKey: 플레이스 홀더(입력이 없을 때 보여줄 텍스트)
text: 현재 텍스트필드의 입력된 문자들

TextField(_ titleKey:String,text:Binding<String>)
```

2. 축과 함께
```swift

titleKey: 플레이스 홀더(입력이 없을 때 보여줄 텍스트)
text: 현재 텍스트필드의 입력된 문자들
axis: 텍스트 필드 width를 넘었을 때 쌓일 방향 (기본 .horizontal)

TextField(_ titleKey:String,text:Binding<String>,axis:Axis)

왼쪽.vertical , 오른쪽 .horizontal  


```

<p style="width:50%;height:400px;float:left;overflow:hidden;">
<img width="248" alt="스크린샷 2023-05-03 오후 5 29 02" src="https://user-images.githubusercontent.com/48616183/235866924-8c1dd99f-3aff-47ef-af8c-660a42d2a000.png"> 
</p>
<p style="width:50%;height:400px;overflow:hidden;">
<img width="253" alt="스크린샷 2023-05-03 오후 5 28 34" src="https://user-images.githubusercontent.com/48616183/235866848-676f3504-46f8-42de-8997-bbbeb871ec97.png">
</p>

### 속성
#### 1. .foregroundColor(Color) : 글자색
#### 2. .font : 폰트지정
#### 3.  .keyboardType(_ type:UIKeyboardType): 텍스트 필드를 누를 시 나올 키보드 종류 설정
#### 4. .onSubmit : 완료 버튼 누를 때 동작할 함수
#### 5. .textInputAutocapitalization(.never) : 첫 글자를 자동으로 대문자로 설정하는 기능 비활성화
#### 6. .disableAutocorrection(true): 자동 맞춤법 수정 비활성화
#### 7. .textFieldStyle(.roundedBorder): 텍스트 필드 rounded 윤곽선 표출

<br><br>

---

## TextEditor

### 특징
- 여러줄의 많은  텍스트를 받을 때
- 내장 스크롤이 있음

```swift
 TextEditor(text: $text)
            .colorMultiply(.red) //텍스트 에디터 색깔을 변경하기위함
            .background() ,.forgroundColor 모두 안먹음
            .foregroundColor(.orange)  //글자 색 변경
            /* 글자의 색깔이 바뀌지만 위 
            .colorMultiply 색상의 영향으로 색깔이 변질될 수 있다.
            */
```