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


<br>
<br>
<br>


## ⭐️ id를 활용하는 방법
```swift
    let data: [String] = ["Hi", "Hello", "Hey everyone"]   
    
    var body: some View {
        VStack {
            
            ForEach(data, id:\.self){ String in   
                Text("\(String)")
            }
            
        }
    }
```
<img width="733" alt="스크린샷 2023-04-28 오전 12 19 22" src="https://user-images.githubusercontent.com/87987002/234908834-83bb11ab-fb3d-4670-a4df-7e80f58925f1.png">


forEach의 범위에 data 배열 자체를 넣고, ```id:\.self```를 통해 배열 안의 아이템에 고유한 속성을 부여하는 방식. <br>
이렇게 쓸 때에는 데이터의 타입이 구별할 수 있는 타입이어야 함. 만약 구별할 수 없는 타입일 때는 데이터 타입을 **Hashable**로 지정해야 한다. 해셔블 프로토콜을 준수하라는 의미임.