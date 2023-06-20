# High Order Function

고차함수는 다른 함수를 인자로 받거나, 함수의 결과로 함수를 반환하는 함수를 의미합니다. 

스위프트에서는 map, filter, reduce 가 콜렉션 타입 내에 정의되어 있습니다.

<br>

### Test Model

```swift
struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String
    let points: Int
    let isVerified: Bool
}
```

### 1. sorted
```swift
// 내림차순 정렬

filteredArray = dataArray.sorted(by: { u1, u2 in
            return u1.points > u2.points
})
        
filteredArray = dataArray.sorted(by: {$0.points > $1.points})
```

### 2. filter
```swift
//인증된 인원

filteredArray = dataArray.filter({ user in
            user.isVerified
})

filteredArray = dataArray.filter({$0.isVerified})
        
```

### 3. map
```swift
//유저의 이름만 필요

mappedArray = dataArray.map({ user -> String in
    return user.name
})
```

### 4. compactMap
``` swift
// 유저 이름 중 nil이 있는 것은 알아서 필터링

mappedArray = dataArray.compactMap({$0.name})

```
