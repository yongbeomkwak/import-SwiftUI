# **#50 @ObservableObject & @StateObject**

ViewModel : 해당 앱의 장면들에 필요한 데이터를 관리하는 class

<br>
<br>

## **일반적인 List 생성**

우선, 과일을 개수별로 나타내는 list를 생성해보자.
일반적으로 이렇게 만들 수 있을 것이다.

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/fbc1a34c-62e3-4e7e-a887-1007ed55c30d" width=300>


```swift
import SwiftUI

struct FruitModel: Identifiable {
    let id: String = UUID().uuidString  // UserModel을 쓸 때마다 랜덤한 string type의 unique id를 생성해주는 함수
    let name: String
    let count: Int
}
```

```swift
struct ViewModelBootcamp: View {
    
	@State var fruitArray: [FruitModel] = []
    
    var body: some View {
		NavigationView {
            List {
                ForEach(fruitArray) { fruit in
                    HStack {
                        Text("\(fruit.count)")
                            .foregroundColor(.red)
                        Text(fruit.name)
                            .font(.headline)
                            .bold()
                    }
                }
                .onDelete (perform: deleteFruit)  // 항목 삭제
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Fruit List")
            .onAppear {
                getFruits()                       // List가 나타날 때 getFruits() 보여주기
            }
        }
    }

    func getFruits() {
        let fruit1 = FruitModel(name: "Orange", count: 1)
        let fruit2 = FruitModel(name: "Banana", count: 2)
        let fruit3 = FruitModel(name: "Watermelon", count: 88)
        
        fruitArray.append(fruit1)             // fruitArray에 과일들 집어넣기
        fruitArray.append(fruit2)
        fruitArray.append(fruit3)
    }
    
    func deleteFruit(index: IndexSet) {
	    fruitArray.remove(atOffsets: index)
		// 해당 index에서 과일을 delete해주는 function
    }
}
```

하지만 위와 같은 경우, View를 나타내는 부분만 실제 화면 UI와 관련이 있지, 그 아래 function 들은 UI와 상관이 없는, 데이터를 다루는 코드이다. **코드가 복잡해질수록 이런 데이터와 관련된 코드들을 view 관련 코드들과 분리하는 것이 좋다.** 

<br>

### **MVVM(Model-View-ViewModel)**
UI 및 비 UI 코드를 분리하기 위한 UI 아키텍처 디자인 패턴
<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/becca0e5-f2bd-41ab-850c-d5af544946d3" width=500>


<br>
<br>

**Class를 이용하여 분리해보자!**
## **Class와 @Published, @ObservedObject / @StateObject**

- struct, view에서 `@State / @Binding` 을 쓰듯이, class에서는 `@Published / @ObservedObject / @StateObject` 를 쓴다. @Binding는 변수 하나하나, @ObservedObject는 class 전체를 통째로 불러온다는 차이점이 있다.
- `@Published` 데이터가 바뀔 때마다 `FruitViewModel`을 다시 그리게 된다.
- 다른 view에서 @ObservedObject로 class의 데이터를 받아오려면, 해당 class에 `: ObservableObject` 를 붙여주어야 한다.

<img src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/971a8af2-c25c-4e30-b87c-2d62717f38e0" width=300>

```swift
class FruitViewModel: ObservableObject { // 과일 데이터 업데이트 사항들은 이곳에 전부 몰아넣기
    
	@Published var fruitArray: [FruitModel] = []
    @Published var isLoading: Bool = false
    
    func getFruits() {
		let fruit1 = FruitModel(name: "Orange", count: 1)
	    let fruit2 = FruitModel(name: "Banana", count: 2)
        let fruit3 = FruitModel(name: "Watermelon", count: 88)
        
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
	        self.fruitArray.append(fruit1)
            self.fruitArray.append(fruit2)
            self.fruitArray.append(fruit3)
            self.isLoading = false
        }
    }
    
    func deleteFruit(index: IndexSet) {
	    fruitArray.remove(atOffsets: index) // 해당 index에서 과일을 delete해주는 function
    }   
}
```

위처럼 class를 이용하여 데이터와 관련된 코드들을 따로 분리하였다.

이 경우, view 코드는 UI 관련 사항만 다루게끔 더 간결해진다. (처음 3초 간 로딩 인터랙션도 추가됨)

```swift
struct ViewModelBootcamp: View {

	@StateObject var fruitViewModel: FruitViewModel = FruitViewModel()
	
	var body: some View { // UI 관련된 사항들만 View 안에 작성됨
		NavigationView {
		    List {
	                
		        if fruitViewModel.isLoading { // 리스트 로딩 중일 때 3초간 로딩 아이콘 나오게 하기
		            ProgressView()
	            } else { // 로딩 중이지 않을 때 action
		            ForEach(fruitViewModel.fruitArray) { fruit in
		                HStack {
		                    Text("\(fruit.count)")
		                        .foregroundColor(.red)
	                        Text(fruit.name)
		                        .font(.headline)
	                            .bold()
	                    }
	                }
	                .onDelete (perform: fruitViewModel.deleteFruit)
	            }
	        }
	        .listStyle(GroupedListStyle())
	        .navigationTitle("Fruit List")
	        .toolbar {  // NavigationBarItems 대신 바뀐 기능 (상단 화살표 버튼)
	            ToolbarItem(placement: .navigationBarTrailing) {
		            NavigationLink(
	                    destination: RandomScreen(fruitViewModel: fruitViewModel),
                        label: {
	                        Image(systemName: "arrow.right")
	                            .font(.title)
                        })
                }
            }
	    } 
	}
}
```

<br>
<br>

## **@ObservedObject / @StateObject**

- 둘 다 ObservableObject의 데이터를 불러와 사용하는 기능이다. 겉으로 보기에는 큰 차이점이 없다.
- `@ObservedObject`는 어떤 이유에서든 뷰에 변화가 생겨서 새로고침하게 될 때마다, ObservedObject의 데이터 값까지 함께 새로고침이 된다. **→ 늘 다루는 데이터가 달라지는 sub view에 사용**
- `@StateObject`는 뷰가 새로고침 되어도 ObservedObject의 데이터 값은 그대로 유지된다. **→ 데이터를 관리하고 유지해야 하는 경우 / 무언가를 생성, 초기화, 처음 언급하는 경우에 사용**

![image.jpg1](https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/40e36aed-04f4-4c61-b3ba-53b444498484) |![image.jpg2](https://github.com/yongbeomkwak/SwiftUI-Study/assets/126866283/7b5fdd17-f76b-433c-91b2-56a357c49281)
--- | --- |

```swift
struct RandomScreen: View { // 두번째 화면
    
	@Environment(\.dismiss) var dismiss // 현재 띄워져 있는 화면에서 나가게끔 하는 기능
    @ObservedObject var fruitViewModel: FruitViewModel
    
    var body: some View {
	    ZStack {
	        Color.green.ignoresSafeArea()
            
            VStack {
	            ForEach(fruitViewModel.fruitArray){ fruit in
	                Text(fruit.name)
	                    .foregroundColor(.white)
                        .font(.headline)
                }
            }
		}
	}
}
```
