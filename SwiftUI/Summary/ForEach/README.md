# **#14 ForEach**

동일한 View에 다른 데이터를 반복해서 만들고 싶을 때 사용합니다.
 
```swift
ForEach(data:,id:,content) 
```
기본 형태는 이렇습니다.

### 매개변수
-   data: 배열과 같은 반복가능한 객체입니다.
-   id: data의 요소 중 , 절대 겹치지않는 Hashable 값을 지정해 줍니다.
-   content: 반복될 뷰를 넣어줍니다.

사용 예)
```swift
import SwiftUI



struct Student : Hashable{ 
    //절대 겹치지 않는 값을 갖고 있다는 Hashable 프로토콜을 채택해준다
    static func == (lhs: Student, rhs: Student) -> Bool {
        lhs.id == rhs.id // 아이디가 같으면 같은 객체로 인식
    }
    
    var id:Int = UUID().hashValue // 절대 겹치지 않을 값은 id로
    var name:String //학생 이름 (겹칠 수 있음)
    var grade:Int //학생 학년(겹칠 수 있음)
    
    
}


struct SwiftUIView: View {
    var data:[Student] = [Student(name: "해나", grade: 1),Student(name: "스낵", grade: 2),Student(name: "클레어", grade: 1),Student(name: "코비", grade: 1)]
    
    var body: some View {
        VStack{
            //\.id는 -> Student 구조체 안의 id를 으미
            //info는 Student 객체를 의미함

            ForEach(data,id:\.id){ info in 
                VStack{
                    Text("\(info.id)") //해쉬한 id 값과
                    Text("\(info.name)") // 학생이름을 보여준다.
                }
                
            }
        }
        
        
    }
}
```

### 결과
<img width="216" alt="스크린샷 2023-04-29 오전 11 32 15" src="https://user-images.githubusercontent.com/48616183/235279606-09000a43-f31b-4440-9908-c22b590a3488.png">

