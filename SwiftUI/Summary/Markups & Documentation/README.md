# **#45 Adding markups and documentation**
- 협업할 때 코드에 코멘트 남기는 법, 문서화하는 법에 대한 강의

- 코드가 길 때에는 어떻게 구성되있는지 읽기 어려울 수 있음. 그래서 이를 정리하기 위해 마크업과 문서화를 사용한다. 


## **Markups**
```swift
import SwiftUI

struct Documentation: View {
    
    //MARK: PROPERTIES
    @State var data: [String] = [
    "Apples", "Oranges", "Bananas"
    ]
    
    @State var showAlert: Bool = false
    
    //MARK: BODY
    var body: some View {
        NavigationView {
            ScrollView{
                Text("Hello")
                ForEach(data, id: \.self) { name in
                    Text(name)
                        .font(.headline)
                }

            }
            .navigationTitle("Documentation")
            .navigationBarItems(trailing:
                                    Button("ALERT", action: {
                                    showAlert.toggle()
            })
            )
            .alert(isPresented: $showAlert) {
                getAlert(text: "This is alert!")
            }
        }
    }
    
    //MARK: FUNCTIONS
    func getAlert(text: String) -> Alert {
        return Alert(title: Text(text))
    }
}

    //MARK: PREVIEW
struct Documentation_Previews: PreviewProvider {
    static var previews: some View {
        Documentation()
    }
}

```
<img width="653" alt="스크린샷 2023-05-13 오후 8 37 27" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/bec384cd-6ba2-4423-9d57-d11cb8f2f017">

MARK한 내용을 미니맵에서 프리뷰로 볼 수 있음. 미니맵에서 클릭해서 해당 코드로 바로 이동할 수 있다. <br>
미니맵에서 cmd를 누르면 전체 목차 표시됨. 
<br>
<br>

## **Comments**

- 여러 코드를 주석처리 할 때에는 /* */를 통해 할 수 있음
```swift
    //코비 - 오늘의 할일
    /*
    1. 제목 수정
    2. alert 수정
    3. 폰트 수정
    */
```


<img width="739" alt="스크린샷 2023-05-13 오후 8 58 25" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/ad21c2a2-b89a-4efd-9487-9bff08e513f8">

이렇게 쓴 코멘트는 ```cmd + opt + ←``` 를 눌러서 fold 처리할 수 있다.  ```cmd + opt + →``` 는 접힌 코드 열기. 다른 괄호에도 같은 단축키로 적용가능 <br>
제목만 //로 주석처리 하면 접었을 때 무슨 내용인지 알 수 있음. 
협업할 때는 자기 이름을 써주면 좋음.

<br>
<br>

- body에 내용이 많을 경우에는 현재 어떤 괄호 안에 있는지 헷갈릴 수 있음. 그래서 구간의 시작과 끝을 적어주기도 한다. 

```swift
    var body: some View {
        NavigationView { //START: NAV
            ScrollView{ //START: SCROLLV
                Text("Hello")
                ForEach(data, id: \.self) { name in
                    Text(name)
                        .font(.headline)
                }

            } //END: SCROLV
            .navigationTitle("Documentation")
            .navigationBarItems(trailing:
                                    Button("ALERT", action: {
                                    showAlert.toggle()
            })
            )
            .alert(isPresented: $showAlert) {
                getAlert(text: "This is alert!")
            }
        } //END: NAV
    }
```
<br>
<br>


## **Documentation**

- opt누르고 코드 클릭하면 문서가 나온다. 
**summary, declaration, parameter** 등이 있고 참고하면 좋음


<img width="848" alt="스크린샷 2023-05-13 오후 10 54 11" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/75331ef6-98a7-4f24-9d7c-f299e199bafe">

<br>
<br>

- 내가 만든 변수, 뷰, 기능 등에는 summary가 없다. 이를 추가하려면 ///로 쓰면 됨
```swift
    ///This is foregroundLayer that holds a scrollView.
    private var foregroundLayer: some View {
        ScrollView{ 
            Text("Hello")
            ForEach(data, id: \.self) { name in
                Text(name)
                    .font(.headline)
            }
        }
    }
```
<img width="822" alt="스크린샷 2023-05-13 오후 11 01 34" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/e02711b9-25de-4a43-b738-ec9a48c6c677">

이렇게 적용됨. 다른 개발자와 협업할 때 이해를 도울 수 있음.

<br>
<br>

## Add Documentation
- cmd누르고 클릭하면 문서를 추가할 수 있다. 직접 문서의 항목을 커스텀할 수 있음. 

<img width="729" alt="스크린샷 2023-05-13 오후 11 11 25" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/606a8ee8-dfec-494f-9181-df3717562350">



> Discussion 추가 - Summary 아래에 한줄 띄우고 자유롭고 솔직한 설명을 적으면 됨.

> 예제 추가 - ``` 사이에 적으면 됨. 

> Warning, parameter, Return도 추가할 수 있음. 


<img width="677" alt="스크린샷 2023-05-13 오후 11 38 50" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/a1a08072-d512-4b96-82b9-9cffd7e59e4b">


<br>


<img width="700" alt="스크린샷 2023-05-13 오후 11 38 12" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/20fceee2-0a4c-401d-ade6-1263f6be1656">

적용된 문서의 모습
