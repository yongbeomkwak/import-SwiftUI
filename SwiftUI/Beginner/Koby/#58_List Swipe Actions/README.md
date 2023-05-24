# **#58 List Swipe Actions**

https://github.com/yongbeomkwak/SwiftUI-Study/tree/main/SwiftUI/Summary/List
<br>List 강좌 참고. 
- delete에 사용되는 swipe외에도 list에 적용 가능한 swipeAction들이 있다. 

## 기존의 delete 할 수 있는 리스트

```swift
struct ListSwipeActionsView: View {
    
    @State var fruits: [String] = [
        "apple", "orange", "banana","peach"
    ]
    
    var body: some View {
        List {
            ForEach(fruits, id: \.self) {
                Text($0.capitalized)
            }
            .onDelete(perform: delete)
        }
    }
    
    func delete(indexSet: IndexSet) {
        
    }
}
```
<img width="515" alt="스크린샷 2023-05-24 오후 11 36 12" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/da445a3c-cbf0-4791-bbee-4f47173b7967">

<br>
<br>
<br>


## 커스텀 스와이프 코드

```swift
struct ListSwipeActionsView: View {
    
    @State var fruits: [String] = [
        "apple", "orange", "banana","peach"
    ]
    
    var body: some View {
        List {
            ForEach(fruits, id: \.self) {
                Text($0.capitalized)
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {  //오른쪽에서 스와이프
                        Button("Archive") { }
                            .tint(.green)
                        Button("Save") { }
                            .tint(.blue)
                        Button("Junk") { }    
                            .tint(.black)
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {    //왼쪽에서 스와이프
                        Button("Share") { }
                            .tint(.yellow)
                    }
            }
        }
    }
        func delete(indexSet: IndexSet) {
        
    }
}
```
버튼이 여러개일때는 allowFullSwipe: false로 하기를 추천. 

![화면 기록 2023-05-24 오후 9 10 08](https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/17566fab-3523-42e0-a3df-ba218d5cdc19)


