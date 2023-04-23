# TODO List

## 목차
1. [UI](#uiview)

---


## UI(View)

<br>

### 1. List
```swift
List {
    ForEach(items,id: \.self){ item in
            ListRowView(title: item)
            
        }
}
        .listStyle(PlainListStyle()) // 밑줄 구분자 있는 스타일


```

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

