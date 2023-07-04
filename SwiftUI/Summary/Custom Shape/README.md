# CustomShape

## 사용 이유

- 기본으로 주어진 Shape를 사용하지 않고 상황에 맞는 Shape를 만들기 위함

<br>

## 구현 순서
1. Shpae 프로토콜을 채택한다. 
2. path함수를 구현한다

<br>

### func path
- 매개변수로 rect가 넘어온다. 
- 그려질 캔버스라고 생각하면 된다.
- Path를 만들어 그린다.

```swift
 func path(in rect: CGRect) -> Path {

}

```
<br>


## Rect
<img width="708" alt="스크린샷 2023-07-04 오후 9 26 59" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/48616183/5214229f-1297-4ba5-b6d6-1ab6d986c6cb">

<br>


## Path의 메소드


### 1. path.move(to:CGPoint)
- 커서를 해당 CGPoint로 옮긴다.

### 2. path.addLine(to:CGPoint)
- 현재 커서 위치부터 해당 CGPoint까지 직선을 그린다.



<br>

삼각형 그리기

```swift
struct Triangle : Shape {
    
    func path(in rect: CGRect) -> Path {
         
        Path{ path in
            
            path.move(to: CGPoint(x: rect.midX, y: rect.minY)) // X: 중앙, Y: 위
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // X: 오른쪽끝, Y: 아래
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // X: 왼쪽끝, Y: 아래
            path.addLine(to:CGPoint(x: rect.midX, y: rect.minY)) // 원래 지점으로
            
        }
    }
    
    



```
