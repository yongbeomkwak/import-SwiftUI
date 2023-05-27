# **#51 @EnvironmentObject**

- `@StateObject`와 비슷한 기능.
- Environment에서 한 번 언급을 해주면, 같은 위계 상에 있는 모든 뷰들은 해당 object에 접근이 가능해진다.

<br>
<br>

세 개의 뷰를 연결시킨다고 가정해보자.

짧은 플로우의 화면이라면 `@Published`, `@StateObject`, `@ObservedObject`를 이용할 것이다.

![image.jpg1](https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/8b4d0550-0708-4f95-bc24-74b5aaf4b5e4) |![image.jpg2](https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/6af246b1-be34-46d7-afda-1c4483626905) |![image.jpg3](https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/1edc4676-ca65-4055-a4ca-29a6152c8199)
--- | --- | --- |

데이터만을 다루는 model을 먼저 만든다.

```swift
class EnvironmentViewModel: ObservableObject {
    
	@Published var dataArray: [String] = []
    
	init() {
		getData() // 모델이 초기화 될 때마다 dataArray에 아래 4개의 string이 추가된다.
    }
    
    func getData() { // dataArray 배열 안에 들어갈 string 데이터를 받는 함수
	    self.dataArray.append(contentsOf: ["iPhone", "iPad", "iMac", "Apple Watch"])
		// self.dataArray.append("iPhone") -> 데이터를 하나씩 추가할 수도 있다.
    }
}
```

그 후, list가 있는 첫번째 view 화면을 그린다.

```swift
struct EnvironmentObjectBootcamp: View {
    
	@StateObject var viewModel: EnvironmentViewModel = EnvironmentViewModel()
    // EnvironmentViewModel()을 처음 선언하고 initialize하기 때문에 StateObject 사용
    
    var body: some View {
	    NavigationView {
	        List {
	            ForEach(viewModel.dataArray, id: \.self) { item in // id: \.self -> dataArray의 각 값마다 고유 id를 부여함.
	                NavigationLink(
	                    destination: DetailView(viewModel: viewModel, selectedItem: item),
                        label: {
	                    Text(item)
                        })
                }
            }
            .navigationTitle("iOS Devices")
        }
    }
}
```

list의 기기 중 하나를 누르면 나오는, 두번째 주황색 view를 그린다.

```swift
struct DetailView: View {
    
	@ObservedObject var viewModel: EnvironmentViewModel
  let selectedItem: String
    
  var body: some View {
	  ZStack {
	    // background
      Color.orange.ignoresSafeArea()
            
      //foreground
      NavigationLink(
	      destination: FinalView(viewModel: viewModel),
        label: {
	        Text(selectedItem)
	          .font(.headline)
            .foregroundColor(.orange)
            .padding()
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(30)
      })
    }
  }
}
```

주황색 화면의 흰색 버튼을 누르면 나오는, 마지막 남색 view를 그린다.

```swift
struct FinalView: View {
    
	@ObservedObject var viewModel: EnvironmentViewModel
    
    var body: some View {
	    ZStack {
	    //background
        LinearGradient(
	        gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)), Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))]), // #colorLiteral()
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
	    .ignoresSafeArea()
            
        //foreground
        ScrollView {
	        VStack(spacing: 20) {
	            ForEach(viewModel.dataArray, id: \.self) { item in
	                Text(item)
                }
            }
            .foregroundColor(.white)
            .font(.largeTitle)
        }
    }
  
}
```

지금은 view가 세개밖에 없기 때문에 `@ObservedObject`를 매 view마다 언급해주고 다음 view에 매개변수와 값을 전달해주는 코드를 짜는 것이 어렵지 않지만, **view가 많아질수록 이 작업은 매우 귀찮아진다.**

*심지어 두번째 DetailView 안에서는 `viewModel` 을 직접적으로 쓰지 않지만, 고작 다음 FinalView로 데이터를 전달해줘야 한다는 이유만으로 `@ObservedObject` 를 언급해줘야 한다.*

<br>
<br>

## **@EnvironmentObject의 사용**

view들이 연속적으로 연결되어 있는 경우에도, 해당 변수나 모델이 필요한 view에만 데이터를 불러오고, 필요하지 않은 view에는 따로 언급을 하지 않아도 된다.

<br>

**위 코드를 @EnvironmentObject를 사용하여 바꿔보자!**

- 위의 EnvironmentObjectBootcamp view에서 `NavigationView {}` 가 끝나는 지점에 `.environmentObject(viewModel)` 을 달아보자.
    
    → 해당 뷰와 연결되는 모든 뷰에 `viewModel`을 선택적으로 불러올 수 있게 됨.
    
    → **매개변수와 그 값을 다음 뷰로 전달해주는 것도 필요 없다!**
    
    ```swift
    struct EnvironmentObjectBootcamp: View {
        
    	@StateObject var viewModel: EnvironmentViewModel = EnvironmentViewModel()
        
        var body: some View {
    	    NavigationView {
    	        List {
    	            ForEach(viewModel.dataArray, id: \.self) { item in 
                        NavigationLink(
	                        destination: DetailView(viewModel: viewModel, selectedItem: item),
                            label: {
	                            Text(item)
                            })
                    }
                }
                .navigationTitle("iOS Devices")
            }
		    .environmentObject(viewModel)
        }
    }
                
    ```
    <br>

- DetailView에서는 viewModel을 쓰지 않으므로 아무것도 쓰지 않아도 된다.
    
    ```swift
    struct DetailView: View {
        
        let selectedItem: String
        
        var body: some View {
    	    ZStack {
    	        // background
                Color.orange.ignoresSafeArea()
                
                //foreground
                NavigationLink(
    	            destination: FinalView(~~viewModel: viewModel~~),
                    label: {
    	                Text(selectedItem)
    	                    .font(.headline)
                            .foregroundColor(.orange)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.white)
                            .cornerRadius(30)
                    }
                )
            }
        }
    }
    ```
    
<br>

- FinalView에서는 `@ObservedObject` 대신에 `@EnvironmentObject` 를 넣어보자.
    
    ```swift
    struct FinalView: View {
        
    	@EnvironmentObject var viewModel: EnvironmentViewModel
        
        var body: some View {
    	    ZStack {
    	        //background
                LinearGradient(
    	            gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)), Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))]), // #colorLiteral()
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
    	        .ignoresSafeArea()
                
                //foreground
                ScrollView {
    	            VStack(spacing: 20) {
    	                ForEach(viewModel.dataArray, id: \.self) { item in
    	                    Text(item)
                        }
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                }
            }
        }
    }
    ```
    
<br>
<br>

## **@ObservedObject와 @EnvironmentObject의 차이점**

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/f67f5a77-2a52-4dd3-a56d-4e5b3b4260bc">
<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/0885cbc6-46c0-4d00-b971-d4e7bedca59f">
