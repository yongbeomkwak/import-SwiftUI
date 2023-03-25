# 함수

- 특정 기능을 수행하는 코드의 묶음
- 함수는 인수(argument)를 전달하여 일을 처리한 후 반환 값(return value)을 출력
```swift
[함수의 기본형태]

func plusFour(x: Int) -> Int {
    return x + 4
}

func 함수이름(매개변수)) -> 반환값 타입 {
    실행코드
    return 반환값
}

```
- 반환값이 없을 경우 반환값 타입을 Void로 지정, 혹은 생략
- 매개변수가 없을 경우 매개변수 생략
```swift
[반환값과 매개변수가 없을 경우]

func printMyName() {
    print("Hi, my name is Snack.")
}

func 함수이름() -> Void {
    실행코드
}

func 함수이름() {
    실행코드
}
```
