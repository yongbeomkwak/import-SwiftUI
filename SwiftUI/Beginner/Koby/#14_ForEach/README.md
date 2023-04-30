# **#14 ForEach**




```swift
        VStack {
            ForEach(0..<10) { index in           //index는 반복되는 횟수임. 
                Text("Hi: \(index)")
            }            
        }
```
<img width="735" alt="스크린샷 2023-04-27 오전 3 41 32" src="https://user-images.githubusercontent.com/87987002/234672072-9f46b054-6127-40c6-a60d-c97c659ccac5.png">

<br>
<br>
<br>
 


## 데이터 삽입



```swift
    let data: [String] = ["Hi", "Hello", "Hey everyone"]     //String 타입의 배열 
    let myString: String = "Hello"
    
    var body: some View {
        VStack {
            ForEach(data.indices) { index in
                Text("\(data[index]) : \(index)")     //한가지로 정한다면 data[0] 이렇게 쓰면 됨
            }
        }
    }
```
<img width="737" alt="스크린샷 2023-04-27 오전 4 33 30" src="https://user-images.githubusercontent.com/87987002/234683501-bd05846a-f66d-44dd-903a-86fe38fbc8c4.png">
data 항목이 세개이므로 세번 반복됨. data 배열 안의 item들이 index 순으로 적용됨. 