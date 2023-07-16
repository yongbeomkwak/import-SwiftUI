# **#1 ViewModifier**

<img width="1008" alt="스크린샷 2023-07-12 오전 1 29 34" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/b224764a-4065-4387-814c-6ad5256bb26a">
여러 가지 수정자가 붙은 버튼을 앱에서 여러번 쓰고 싶을 때, 여러 줄의 코드를 반복해서 써야 한다. 코드의 효율성을 위해서 ViewModifier를 쓰는 것. 
<br>그러고 세팅한 버튼들에서 수정이 있을 때 각각의 버튼 수정자들을 모두 바꿔줘야 할 수도 있음. 


<br>
<br>

```swift
struct DefaultButtonViewModifer: ViewModifier {
    func body(content: Content) -> some View {    //body를 만들면 content 매개변수가 있는 body가 생성됨. 
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
    }
}

struct ViewModifer: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .modifier(DefaultButtonViewModifer()) //일케 단축해서 한 줄로만 쓸 수 있음. 
            
            Text("Hello, everyone!")
                .modifier(DefaultButtonViewModifer())
            
            Text("Hello, learners!")
                .modifier(DefaultButtonViewModifer())
        }
    }
}
```
<img width="753" alt="스크린샷 2023-07-12 오전 1 58 33" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/3932de35-3d03-4af2-970f-26633a0a9180">

.modifer는 DefaultButtonViewModifer의 수정자를 포함한 content를 반환하게 됨. 
<br>버튼의 세팅을 바꾸고 싶을 때 ViewModifer에서 바꿔주면 적용한 버튼들이 한번에 바뀜

<br>
<br>
modifier라고 써야 하는 이유는 저 modifer를 위한 view extension을 만들지 않았기 때문에.

```swift
extension View {
    
    func DefaultButtonFormatting() -> some View {   //some View를 리턴한다.
        self    //현재 뷰를 리턴. 없어도 됨.
            .modifier(DefaultButtonViewModifer())
    }
}



struct ViewModifer: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
//                .modifier(DefaultButtonViewModifer())
                  .DefaultButtonFormatting()
        }
    }
}
```
modifer라고 안쓰고 DefaultButtonFormatting 함수로 바로 쓸 수 있다. 

<br>
<br>

## Viewmodifer 커스텀 하는 예시


```swift
struct DefaultButtonViewModifer: ViewModifier {
    
    let backgroundColor: Color    //프로퍼티 생성
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
    }
}

extension View {
    
    func DefaultButtonFormatting(backgroundColor: Color) -> some View {   //some View를 리턴한다.
            modifier(DefaultButtonViewModifer(backgroundColor: backgroundColor)) 
            //초기화할 때 프로퍼티에 값을 넣어준다. 
    }
}

struct ViewModifer: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
//                .modifier(DefaultButtonViewModifer())
                .DefaultButtonFormatting(backgroundColor: .blue)
        }
    }
}
```