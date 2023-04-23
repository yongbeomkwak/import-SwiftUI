# TODO List

## 목차
1. [UI](#uiview)
2. [Model](#model)

---

<br>

## UI(View)
### 1. List
```swift
List {
    ForEach(items,id: \.self){ item in
            ListRowView(title: item)
            
        }
}
        .listStyle(PlainListStyle()) // 밑줄 구분자 있는 스타일


```

<br>

### 2. NavigationView
```swift
.navigationTitle("Todo List ✏️")
.toolbar {
    ToolbarItem(placement:.navigationBarLeading) {
        EditButton()
    }
    
    ToolbarItem(placement:.navigationBarTrailing) {
        NavigationLink("Add", destination: {
            AddView()
        })
    }
}
```

---

<br>

## Model
```swift
struct ItemModel:Identifiable {
    
    let id:String = UUID().uuidString
    let title: String
    let isCompleted: Bool
    
    
}
```

### 1. Identifiable 프로토콜
- 채택하면 해쉬 타입으로 만들어줌

### 2. UUID
- 해쉬 아이디값 만들어줌
