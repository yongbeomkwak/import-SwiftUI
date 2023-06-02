# LongPressGesture

## LongPressGesture란 무엇일까?
<br>


### 특징
- 일반 제스처와 다르게 오랫동안 누르고 있어야 실행 됨.

<br>

### 코드 예시

현재 버튼에 LongPressGesture를 적용하여 최소 5초 동안 버튼터치한 상태로 버튼의 사각형 넓이를 기준으로 최대 100 까지는 손가락이 움직여도 작동한다.

<img src="https://github.com/HunyongSeong/SwiftUIStudy/assets/108869319/90944dc9-20fd-447e-bbb5-5a8db13dedd0" width=300 >

<br>

```swift
 import SwiftUI

struct LongPressGestureBootcamp: View {
    @State var isComplete: Bool = false

    var body: some View {
        

        
        Text(isComplete ? "COMPLETED" : "NOT COMPLETE")
            .padding()
            .padding(.horizontal)
            .background(isComplete ? Color.green : Color.gray) 
						// 삼항연산자로 isComplete가 true일때 그린 false일때 gray 
            .cornerRadius(10)


             // 오랫동안 누르고 있어야 작동하는 제스쳐
            .onLongPressGesture(minimumDuration: 5.0, maximumDistance: 100) { 
                isComplete.toggle() 
								// isComplete가 true가 되어 위의 background에 변화를 주게됨
            }
    }
}

struct LongPressGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureBootcamp()
    }
}
```
<br>
// (minimumDuration: 1.0, maximumDistance: 100) 

**최소 5초 동안 버튼을 터치한 상태**에서 **버튼의 사각형 넓이를 기준으로 최대 100** 까지는 손가락이 움직여도 작동한다. 그 이상으로 움직이게 되면은 작동하지 않게 됨.

<br>

<img src="https://github.com/HunyongSeong/SwiftUIStudy/assets/108869319/08579f13-7b39-45cd-b3a5-ed160b5db9e6" width=300 >

#### 최종적으로 버튼을 2초 동안 누르지 않으면 다시 파란색 사각형이 커지다가 되돌아 오게됨 / 2초 동안 누르게되면 사각형이 꽉 채워지고 초록색으로 변함.

<br>


```swift

import SwiftUI

struct LongPressGestureBootcamp: View {
    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false

    var body: some View {
        
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                // isSuccess 참/거짓에 의해 색깔 변경 (삼항연산자)
                .frame(maxWidth: isComplete ? .infinity : 0)
                // isComplete 참 거짓에 의해서 넓이를 조정 true = infinity, false = 0
            
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                // 뒤의 사각형의 크기는 infinity
                .background(Color.gray)


            HStack {
                Text("CLICK HERE")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 2.0, maximumDistance: 50) { (isPressing) in //isPressing: Bool
                        // start of press -> min duration 시작부터 최소 지속 시간.
                        if isPressing { // isPressing == true
                            // isPressing의 역할은 버튼을 클릭할 하는 순간 작동되며, else는 손가락을 떼면 다시 작동된다. (2초 라는 제한 없이 그냥 클릭시 적용!)
                            withAnimation(.easeInOut(duration: 1.0)) { // 시작과 끝을 천천히하는 애니메이션 (1 초 동안 작동)
                                isComplete = true // 파란색 박스의 크기를 조정
                            }
                        } else {  // 손가락을 떼면 적용됨!
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // 0.3초의 지연
                                // 이곳에서 0.3초 지연된다는 것은 클릭시에 0.3초 동안 버튼을 누른것과 같은 효과를 주어서 사각형이 커진다.
                                if !isSuccess { // isSuccess를 먼저 확인 후 성공 못하면 되돌리기 위함.
                                    withAnimation(.easeInOut) {
                                        isComplete = false // 사각형넓이 줄이기
                                    }
                                }
                            } 
                        }

                    } perform: { // <- perform의 역할은 수행하는 역할로, 2초 동안 버튼을 눌렀을 때!.
                        withAnimation(.easeInOut) { // 탭 제스쳐로 성공, 실패
                            isSuccess = true // blue로 컬러변경
                        }
                    }

                Text("RESET")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        isComplete = false // onTapGesture로 리셋버튼을 누르게 되면 바로 사각형 크기가 0이 되고
                        isSuccess = false // 컬러도 blue로 변함. -> 애니메이션 주지 않았기 때문에 바로 바뀜
                    }
            }
        }
    }
}

struct LongPressGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureBootcamp()
    }
}
```

<br>

```swift
func onLongPressGesture(
    minimumDuration: Double = 0.5,
    maximumDistance: CGFloat = 10,
    perform action: @escaping () -> Void,
    onPressingChanged: ((Bool) -> Void)? = nil
) -> some View
```

<br>

### 매개 변수 정보

`minimumDuration` 제스처가 성공하기 전에 경과해야 하는 긴 누르기의 최소 시간.

`maximumDistance` 제스처가 실패하기 전에 길게 누르는 손가락이나 커서가 움직일 수 있는 최대 거리.

`perform action` 긴 압박이 인식될 때 수행할 작업.

`onPressingChanged` 제스처의 누름 상태가 변경될 때 실행할 클로저로, 현재 상태를 매개 변수로 전달합니다. 인식되는 순간 true를 전달하고 바로 false로 변경된다.
