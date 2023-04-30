# [Path](https://developer.apple.com/documentation/uikit/uibezierpath)

SwiftUI는 사용자가 원하는 Custom Shape를 그릴 수 있도록 Path를 제공하고 있습니다. 

 
Color, grandient및 shape와 마찬가지로 Path는 그 자체로 View입니다. 

이것은 우리가 TextField와 Image처럼 사용할 수 있다는 소리죠.

- Paths는 위치 값을 가진 선, 곡선 및 기타 정보를 가진 목록입니다. 
- 하지만 Shape는 다른 정보를 미리 알 수 없죠. Shape 내부에 path(in:)
- 메서드가 호출이 끝나야 최종 적인 사이즈를 알 수 있습니다.
- Paths는 절대 경로 안에서 좌표값에 맞춰 도형을 그리지만 
- Shape는 path(in:)에서 주어진 Rect를 기반으로 상대 경로를 받아서 그리게 됩니다.

>
>
> CGPath
>
> - move(to:CGPoint): 커서옮김
>
> - addLine(to:CGPoint) : 직선을 그으며 커서옮김
> 
> - closeSubPath(): 자동으로 Path를 닫음
>
> - addCurve(to endPoint: CGPoint,controlPoint1: CGPoint,
controlPoint2: CGPoint) : 3차 베지어 곡선
>
> - addQuadCurve(to endPoint: CGPoint,controlPoint: CGPoint): 2차 베지어 곡선


## 사각형

Path에 여러 개의 선을 추가하여 사각형을 그려보도록 하겠습니다. 

좌표인 X 및 Y를 사용하여 이것을 그릴 수 있습니다. 첫 번째 선을 그리기 전에 가상의 사각형의 오른쪽 상단 모서리로 커서를 이동하고 오른쪽 하단 모서리로 가는 선을 추가해야 합니다. 그런 다음 addLine을 이용하여 실제 선을 그려줘야 합니다.

```swift
struct PathView: View {
    var body: some View {
        Path { path in
            // 1. 오른쪽 모서리로 커서 이동
            path.move(to: CGPoint(x: 200, y: 0))
            // 2.
            path.addLine(to: CGPoint(x: 200, y: 200))
            // 3.
            path.addLine(to: CGPoint(x: 0, y: 200))
            // 4. 왼쪽 모서리로 커서 이동
            path.addLine(to: CGPoint(x: 0, y: 0))
            // 5. 자동으로 경로를 닫음
            path.closeSubpath()  //자동으로' Path를 닫음
        }
        .stroke()
    }
}

```

<img width="1019" alt="스크린샷 2023-04-30 오후 9 34 44" src="https://user-images.githubusercontent.com/48616183/235353285-15582431-aa3d-4299-868f-2a1f0db0d56f.png">

<br>



## 삼각형
```swift
struct PathView: View {
    var body: some View {
        Path { path in
            // 1. 커서 이동
            path.move(to: CGPoint(x: 200, y: 100))
            // 2.
            path.addLine(to: CGPoint(x: 100, y: 300))
            // 3.
            path.addLine(to: CGPoint(x: 300, y: 300))
            // 4.
            path.addLine(to: CGPoint(x: 200, y: 100))
            // 5.
            path.closeSubpath()
        }
        .stroke(Color.blue, lineWidth: 20)
      //.stroke(Color.blue.opacity(0.3))
    }
}
```
<p align = "center"><img width="277" alt="스크린샷 2023-04-30 오후 9 41 32" src="https://user-images.githubusercontent.com/48616183/235353554-647c9a0d-bdd8-47c3-bad6-894f751ed642.png"> </p>

### 둥근 모서리

```swift
struct PathView: View {
    var body: some View {
        Path { path in
            // 1. 커서 이동
            path.move(to: CGPoint(x: 200, y: 100))
            // 2.
            path.addLine(to: CGPoint(x: 100, y: 300))
            // 3.
            path.addLine(to: CGPoint(x: 300, y: 300))
            // 4.
            path.addLine(to: CGPoint(x: 200, y: 100))
            // 5.
            path.closeSubpath()
        }
        .stroke(Color.blue, style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
    }
}

lineJoin은 선들이 만나는 모서리의 모양을 설정함.
lineCap은 선의 끝 모양을 설정함

```

<p align = "center"> <img width="278" alt="스크린샷 2023-04-30 오후 9 45 34" src="https://user-images.githubusercontent.com/48616183/235353685-c0d8bed8-805e-4f1f-831b-ffcd6b5c1113.png"> </p>

---
## Shape

Shpae도 Path로 구성됩니다. Shape프로토콜을 채택한 Struct를 선언하여 Square Path를 아래와 같은 Shpae로 간단히 변환할 수 있습니다.

```swift
struct MySquare: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.size.width, y: 0))
        path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.width))
        path.addLine(to: CGPoint(x: 0, y: rect.size.width))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.closeSubpath()
        
        return path
    }
}
```

SwiftUI View 내의 MySquare 인스턴스에 .frame 수정자를 추가하여 변환할 수 있도록 동적으로 만들어 줄 수 있습니다.


## 곡선 

- addCurve(to endPoint: CGPoint,controlPoint1: CGPoint,
controlPoint2: CGPoint) 
    - start point: 현재 커서 위치
    -  to == end point
    -   controlPoint1 : start point에 영향을 주는 
    -   controlPoint2 : end point에 영향을 주는 
<p align ="center"> <img width="375" alt="스크린샷 2023-04-30 오후 10 17 38" src="https://user-images.githubusercontent.com/48616183/235354929-c0e792e0-1730-44e9-b044-ee7554827130.png"> </p>


-   addQuadCurve(to endPoint: CGPoint,controlPoint: CGPoint)

<p align ="center"> <img width="617" alt="스크린샷 2023-04-30 오후 10 19 54" src="https://user-images.githubusercontent.com/48616183/235355036-d3994a8e-acae-495f-b3fd-8051274e56f8.png"> </p>
