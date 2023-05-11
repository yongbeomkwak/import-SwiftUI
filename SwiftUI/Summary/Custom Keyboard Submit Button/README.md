# Custom Keyboard Submit Button

## 설명

1. .onSubmit 
    -   클로저를 통해 return을 누르는 순간을 알 수 있다.
2. .submitLabel
    -   reutrn key를 해당 속성 값으로 바꿀 수 있다.
    -    속성 종류
    <img width="380" alt="스크린샷 2023-05-11 오전 8 53 03" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/48616183/3322f220-6622-4e86-a7ed-b23296be3bc9">

```swift
import SwiftUI

struct ContentView: View {
    

    
    @State var text1:String = ""
    @State var text2:String = ""

    
    var body: some View {
        VStack{
            TextField("Name1",text:$text1)
                .submitLabel(.return)
                .padding(.leading)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
                .onSubmit {
                    print("Name1")
                }
            
            TextField("Name2",text:$text2)
                .submitLabel(.search)
                .padding(.leading)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
                .onSubmit {
                    print("Name2")
                }



        }
        .padding(40)

    }

}
```

### 포커싱 되는 텍스트 필드마다 리턴 버튼이 return <-> search로 변한다.

<p align ="center"> <img height = "400" src ="https://github.com/yongbeomkwak/SwiftUI-Study/assets/48616183/66119cd4-0f92-4ef4-9c7f-f3638cceb0fa"> </p>