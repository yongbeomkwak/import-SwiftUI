# MagnificationGesture

## MagnificationGesture란?
확대하는 제스처 기능


<br>

`onChanged`: 확대 시에 적용되는 코드
<br>

`onEnded`: 손을 놓을 시에 적용되는 코드

<br>

### 코드 예시

두 손가락으로 버튼을 확대하는 제스처를 가능하게 해준다. 

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/108869319/800f9fc9-2984-4066-9784-f072f4d04583" width=300 >

<br>

```swift
 import SwiftUI

struct MagnificationGestureTwo: View {
    
    @State var currentAmount: CGFloat = 0

    var body: some View {
        Text("Hello, World!")
            .font(.title)
            .padding(40)
            .background(Color.red.cornerRadius(10))
            .scaleEffect(1 + currentAmount)
            // scaleEffect에서 1은 100% 비율을 의미
            .gesture(
                MagnificationGesture()
                    .onChanged { value in // 확대할 때, value의 값이 증가
                        currentAmount = value - 1
                        // -1 하는 이유는 -1 하지 않을 경우에 확대시 바로 2배 이상으로 커짐
                    }
            )
    }
}

struct MagnificationGestureTwo_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureTwo()
    }
}
```
<br>

### MagnificationGesture의 추가적인 설명

```swift
.gesture(
      MagnificationGesture()
          .onChanged { value in // 확대할 때 동작, value의 값이 증가
              currentAmount = value - 1
              // -1 하는 이유는 -1 하지 않을 경우에 확대시 바로 2배 이상으로 커짐
          }
          .onEnded { value in // 손가락을 놓았을 때, 크기를 그대로 고정
              lastAmount += currentAmount
              currentAmount = 0
          }
  )
```

`onChanged`: 확대 시에 적용되는 코드

`onEnded`: 손을 놓을 시에 적용되는 코드

<br>
<br>
<br>


<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/108869319/3dbf634b-b5a9-4c8a-99a4-732f966c8793" width=300 >

<br>

#### 확대 시 크기가 증가하고 손을 놓을 시, 부드러운 애니메이션 효과로 사각형이 원래 크기로 돌아가는 코드

<br>


```swift

import SwiftUI

struct MagnificationGestureBootcamp: View {
    @State private var currentAmount: CGFloat = 0
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Circle().frame(width: 35, height: 35)
                Text("Swiftful Thinking")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            Rectangle().frame(height: 300)
                .frame(height: 300)
                .scaleEffect(1 + currentAmount)
                // scaleEffect에서 1은 100% 비율을 의미함.
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in // 확대할 때, value의 값이 증가
                            currentAmount = value - 1
                            // -1을 하지 않으면 확대 시 바로 두 배 이상으로 증가
                        }
                        .onEnded { value in // 손을 놓을 시, 사각형이 원래 크기로 변화
                            withAnimation(.spring()) { // 스프링과 같이 부드러운 애니메이션 효과
                                currentAmount = 0
                            }
                        }
                )
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding(.horizontal)
            .font(.headline)
            Text("This is the caption for my photo.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
    }
}


struct MagnificationGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureBootcamp()
    }
}
```