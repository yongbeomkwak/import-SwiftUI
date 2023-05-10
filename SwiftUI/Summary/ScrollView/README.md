# **#15 ScrollView**


```swift
    var body: some View {
        ScrollView {
            VStack {
                Rectangle()
                    .frame(height: 300)
                Rectangle()
                    .frame(height: 300)
                Rectangle()
                    .frame(height: 300)
            }
        }
    }
```
<img width="736" alt="스크린샷 2023-04-27 오후 12 53 53" src="https://user-images.githubusercontent.com/87987002/234755336-c541fe90-b594-4aa0-97e4-e520b20727a8.png">

스크롤 가능한 뷰가 됨. 

<br>
<br>
<br>
 


## ForEach문으로 반복



```swift
        ScrollView {
            VStack {
                ForEach(0..<50) { index in
                    Rectangle()
                        .fill(Color.blue)
                        .frame(height: 300)
                }


            }
        }
```
<img width="733" alt="스크린샷 2023-04-27 오후 1 01 39" src="https://user-images.githubusercontent.com/87987002/234756364-96630412-b877-4b8e-a5fa-5804e7943c9f.png">

50개의 사각형을 스크롤 할 수 있음. 

<br>
<br>

## 우측 스크롤바 지우고 싶다면  

```swift
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(0..<50) { index in
                    Rectangle()
                        .fill(Color.blue)
                        .frame(height: 300)
                }
            }
        }
```

scrollView의 매개변수 showIndicators의 값을 false로 하면됨. 

<br>
<br>

## 가로로 스크롤

```swift
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<50) { index in
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 300,height: 300)
                }
            }
        }
``` 
<img width="734" alt="스크린샷 2023-04-27 오후 1 10 55" src="https://user-images.githubusercontent.com/87987002/234757550-40f2afb5-ccf5-4794-ae42-109d734b7f8f.png">

ScrollView의 축을 horizontal로 바꾸고 Vstack을 Hstack으로 바꿔주면 됨. width값도 추가. 


<br>
<br>

## SccrollView 안에 ScrollView 넣기

```swift
        ScrollView {
            VStack {
                ForEach(0..<10) { index in
                    ScrollView(.horizontal, showsIndicators: false,
                    content: {
                        HStack {
                            ForEach(0..<20) { index in
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.white)
                                    .frame(width: 200, height: 150)
                                    .shadow(radius: 10)
                                    .padding()
                            }
                        }
                    })
                }
            }
        }
````

<img width="729" alt="스크린샷 2023-04-27 오후 1 24 49" src="https://user-images.githubusercontent.com/87987002/234759004-34b41d66-f6a7-433c-8b82-529d152264b3.png">

세로로 10개의 Hstack을 스크롤 할 수 있고, 각 Hstack 마다 20개의 사각형을 가로로 스크롤할 수 있게됨. 