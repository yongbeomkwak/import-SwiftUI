# Custom Shape Animation


## animatableData 적용 전


### 0. Content View
```swift
struct ContentView: View {
    
    @State var animate: Bool = false
  
    
    var body: some View {
        
        ZStack{
            //애니메이션 토글 시 cornerRadius 변경
            RectangleWithSingleCornerAnimation(cornerRadius: animate ? 60 :0)
                .frame(width:250,height: 250)
        }
        .onAppear{
            // 평생 애니메이션 토글 
            withAnimation(Animation.linear(duration: 2.0).repeatForever()) {
                animate.toggle()
            }
            
        }
    


    }

}


```

### 1. Custom Shape
```swift
struct RectangleWithSingleCornerAnimation : Shape {
    
    var cornerRadius: CGFloat
        
    func path(in rect: CGRect) -> Path {
        
        Path{ path in
            
            path.move(to: .zero)
            path.addLine(to: CGPoint(x:rect.maxX,y:rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))

            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: false)
            
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY))
            
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
        }
        
    }
    
}

```

<br>

### 결과
- 전혀 변화가 없음
- 이유: cornerRadius변수는 뷰가 변화를 알아챌 수 있는 프로퍼티 래퍼가 없기 때문에


## 개선 
- Shape 프로토콜을 채택하면 animatableData 변수가 존재함
- animatableData변수는 뷰가 알아차릴 수 있는 변수

<img width="387" alt="스크린샷 2023-07-13 오후 12 30 23" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/48616183/76646f21-9dd4-4dcf-986d-9e89aedd0e20">


<br>

### 1. Custom Shape
```swift

struct RectangleWithSingleCornerAnimation : Shape {
    
    var cornerRadius: CGFloat
    
    var animatableData: CGFloat {
        
        get {
            cornerRadius
        }
        
        set {
            cornerRadius = newValue
        }
        
    }
    
    
    func path(in rect: CGRect) -> Path {
        
        Path{ path in
            
            path.move(to: .zero)
            path.addLine(to: CGPoint(x:rect.maxX,y:rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: false)
            
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY))
            
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
        }
        
    }
    
}

```

<img width="387" alt="스크린샷 2023-07-13 오후 12 30 23" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/48616183/fc1024a8-da7f-4b4c-a0b6-5f1167bba32e">

