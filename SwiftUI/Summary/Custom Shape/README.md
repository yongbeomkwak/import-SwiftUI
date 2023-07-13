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

### 3. addArc()

```swift

func addArc(
arcCenter center: CGPoint,  // Arc의 중심점
radius: CGFloat, // radius : Arc의 반지름
startAngle: CGFloat, // startAngle : Arc의 시작 위치
endAngle: CGFloat,  // endAngle : Arc의 종료 위치
clockwise: Bool //  Arc를 그릴 방향 (true : 시계 방향, false : 시계 반대 방향)

)

```

<br>

### Angle 방향 참고 자료

![Group 1](https://github.com/yongbeomkwak/SwiftUI-Study/assets/48616183/699c0fcd-8dbd-4fe3-85bb-4d9513edf75d)

화살표 방향은 반시계 방향을 나타냅니다. 

SwiftUI 의 좌표공간에서는 일반 좌표계 기준으로 반시계 방향이 시계방향인 것을 알 수 있습니다.

<br>

```swift

Path { path in
            
    path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
    path.addArc(
        center: CGPoint(x: rect.midX, y: rect.midY),
        radius: rect.height/2,
        startAngle: Angle(degrees: 10),
        endAngle: Angle(degrees: 40),
        clockwise: false) // 반시계 방향
            
}

Path { path in
            
    path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
    path.addArc(
        center: CGPoint(x: rect.midX, y: rect.midY),
        radius: rect.height/2,
        startAngle: Angle(degrees: 10),
        endAngle: Angle(degrees: 40),
        clockwise: true) // 시계 방향
            
}

```

<br>

### 결과
<p align ="center">
<img height = "300" src ="https://github.com/yongbeomkwak/SwiftUI-Study/assets/48616183/01387b78-7917-48fb-af3e-e5d67e8e55c9">
<img height = "300" src = "https://github.com/yongbeomkwak/SwiftUI-Study/assets/48616183/fd7fadf3-d1d4-4804-8f76-7d0190a15d82">

 </p>

### 4. addCurve(), addQuadCurve()

```swift
addCurve(to endPoint: CGPoint,controlPoint1: CGPoint,
controlPoint2: CGPoint) 
    
    3차 베지어 곡선 그리기

    - start point: 현재 커서 위치
    -  to == end point
    -   controlPoint1 : start point에 영향을 주는 
    -   controlPoint2 : end point에 영향을 주는 
```


<p align ="center"> <img width="375" alt="스크린샷 2023-04-30 오후 10 17 38" src="https://user-images.githubusercontent.com/48616183/235354929-c0e792e0-1730-44e9-b044-ee7554827130.png"> </p>

```swift
 addQuadCurve(to endPoint: CGPoint,controlPoint: CGPoint)

  2차 베지어 곡선
```

<p align ="center"> <img width="617" alt="스크린샷 2023-04-30 오후 10 19 54" src="https://user-images.githubusercontent.com/48616183/235355036-d3994a8e-acae-495f-b3fd-8051274e56f8.png"> </p>

<br>

```swift
struct ArcSample: Shape {
    func path(in rect: CGRect) -> Path {
        
        Path { path in
            
            path.move(to: .zero)
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY),
            control: CGPoint(x: rect.minX, y: rect.maxY) )
            
            
        }
        
    }
    
    
}
```

### 결과

<img width="171" alt="스크린샷 2023-07-05 오전 10 03 45" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/48616183/73e6795d-554a-4dc1-a327-95579f4d76f0">

