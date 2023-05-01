# **#25 Animations**

```swift
     @State var isanimated: Bool = false
    
    var body: some View {
        VStack {
            Button("Button") {
                withAnimation(.default) {     //defeult는 fade 효과
                    isanimated.toggle()
                }

            }
            Spacer()
            RoundedRectangle(cornerRadius: isanimated ? 50 : 25)    //코너값 변화
                .fill(isanimated ? Color.red : Color.gray)    //컬러 변화
                .frame(
                    width: isanimated ? 100 : 300,    //가로 변화
                    height: isanimated ? 100 : 300)    //세로 변화
            Spacer() 
        }
    }
```
![화면 기록 2023-05-01 오후 11 17 28](https://user-images.githubusercontent.com/87987002/235465755-77f1ed95-f79b-4663-baa7-37d502c5363d.gif)

디폴트 애니메이션은 fade. **삼항 연산자(tenary operation)** 와 **@State** 를 통해 바뀌는 속성을 확인하고 뷰를 새로 그린다. 

<br>
<br>
<br>
 


## 애니메이션 커스터마이즈

```swift
            withAnimation(
                Animation
                    .default                              //디폴트는 fade 변환
                    .delay(2.0)                           //지정된 시간만큼 딜레이
                    .repeatCount(5, autoreverses: true)   //지정된 횟수만큼 반복
                    .repeatForever(autoreverses: true)    //영원히 반복
                    ){
                isanimated.toggle()
            }
```
애니메이션 종류를 나열한 것. 실제로는 이렇게 쓰면 오류가 남. 속성 앞에 Animation이라고 써줘야 오류가 안 뜸. <br>autoreverses는 바뀌기 전 상태로 되돌아가는 것.

![화면 기록 2023-05-02 오전 12 13 21](https://user-images.githubusercontent.com/87987002/235475126-38c8e8b1-d12e-46f3-80c9-48cec408ab08.gif)
```.repeatCount(5, autoreverses: true)``` 를 실행했을 때 모습. 5번 바뀐다. 

<br>
<br>
<br>


## 객체에 직접 애니메이션 추가하기
```swift
  RoundedRectangle(cornerRadius: isanimated ? 50 : 25)
      .fill(isanimated ? Color.red : Color.gray)
      .frame(
          width: isanimated ? 100 : 300,
          height: isanimated ? 100 : 300)
      .rotationEffect(Angle(degrees: isanimated ? 360 : 0))

      .animation(Animation
          .default
          .repeatForever(autoreverses: true))
```
변수를 이용할 때에는 변수가 적용된 모든 객체에 애니메이션이 적용되지만 유일한 객체에만 애니메이션을 주고 싶으면 객체에 추가하면 됨. 이  방식은 애니메이션을 멈추거나 수정할 수 없다. 그래서 위의 방법인 변수를 이용하기를 추천. 

