# Weak Self

## Weak Self란?
weak self는 스위프트에서 주로 사용되는 메모리 관리 패턴 중 하나입니다.
주로 클로저나 비동기 작업에서 발생할 수 있는 강한 순환 참조(circular reference) 문제를 해결하기 위해 사용됩니다.

<br>

### Async 란 무엇인가?

<br>

스위프트의 **`async`** 키워드는 비동기적인 작업을 수행하기 위해 도입된 기능입니다.

**`async`** 키워드는 비동기 작업을 정의하는 함수나 메서드에 붙여 사용합니다. 이 함수나 메서드는 비동기적으로 실행되며, 작업이 완료될 때까지 다른 코드로의 실행 흐름을 블록하지 않고 동시에 다른 작업을 수행할 수 있습니다.
<br>
<br>

<br>

### 레퍼런스 카운트란 무엇인가?

<br>

레퍼런스 카운트는 스위프트의 메모리 관리 기법 중 하나입니다.

스위프트는 Automatic Reference Counting(ARC)라고 하는 메모리 관리 시스템을 사용하여 메모리를 자동으로 관리합니다.

레퍼런스 카운트는 객체가 참조하는 다른 객체의 수를 추적하는 값입니다. 객체가 참조되는 개수를 카운트하면, 메모리에서 객체를 안전하게 해제할 수 있습니다.

객체가 생성될 때 레퍼런스 카운트는 1로 시작하며, 다른 객체가 참조하면 카운트가 증가하고, 참조를 해제하면 카운트가 감소합니다. 레퍼런스 카운트가 0이 되면 객체는 자동으로 메모리에서 해제됩니다.

<br>

<br>

### 이제부터 코드를 하나하나 확인할게요 :)
<br>

`@AppStorage`는 SwiftUI에서 `UserDefaults`를 통해 데이터를 간편하게 저장하고 검색하는 데 사용되는 프로퍼티 래퍼입니다.

`@AppStorage` 프로퍼티 래퍼는 일반적으로 `@State` 또는 `@StateObject`와 함께 사용되며, `UserDefaults`에서 값을 가져와서 해당 프로퍼티에 할당하거나, 프로퍼티의 값을 `UserDefaults`에 저장합니다.

아래의 코드 `@AppStorage("count") var count: Int?`은 `"count"`라는 키를 사용하여` UserDefaults`에 정수형 데이터를 저장하거나 검색합니다.

<br>

```swift
struct WeakSelfTwoBootcamp: View {
    
    @AppStorage("count") var count: Int? // count라는 키를 사용하여 변수 count를 저장
    
    init() {
        count = 0 // 뷰 생성시, count = 0
    }
    
    var body: some View {
        NavigationView {
            NavigationLink("Navigate", destination: WeakSelfSecondScreen())
                .navigationTitle("Screen 1")
        }
        .overlay (
            Text("\(count ?? 0)") // 오른쪽 상단에 count / nil 값일 시에 0
                .font(.largeTitle)
                .padding()
                .background(Color.green.cornerRadius(10))
            , alignment: .topTrailing
        )
    }
}
```
<br>
<br>



@StateObject는 SwiftUI에서 상태를 관찰 가능하게 만들어주는 속성 중 하나입니다.
아래의 코드는 vm 객체의 상태가 변경될 때마다 SwiftUI가 자동으로 해당 뷰를 업데이트합니다.


<br>

```swift
struct WeekSelfSecondScreen: View {
    
    @StateObject var vm = weakSelfSecondScreenViewModel()
    
    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
            .foregroundColor(.red)
            
            if let data = vm.data {
                Text(data)
            }
            // if let data = vm.data: vm의 data 속성을 사용하여 옵셔널 바인딩을 수행합니다.
        }
    }
}
```
<br>
<br>


<br>

```swift
class weakSelfSecondScreenViewModel: ObservableObject {
// 이 프로토콜을 채택한 객체는 (**관찰 가능한 속성**)을 가질 수 있으며,
// 이러한 속성이 변경되면 자동으로 뷰에 알림을 보내어 UI를 업데이트할 수 있습니다.
    
    @Published var data: String? = nil
		//@Published는 프로퍼티 앞에 붙여서 해당 프로퍼티를 (**관찰 가능한 속성**)으로 만들어줍니다.
    // 이 속성은 값이 변경될 때마다 자동으로 변경 이벤트를 발생시키고, 해당 변경사항을 관찰하고 있는 뷰에 알리게 됩니다.    
    
init() { // Second View로 화면을 이동할 때 초기화
        print("INITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count") // 유저 디포트의 (count 키) 값에 있는 (변수 count)의 값을 가져와서 currentCount 에 할당합니다.
        UserDefaults.standard.set(currentCount + 1, forKey: "count") // currentCount + 1 값을 (변수 count)에 할당합니다. 쉽게 말해서, count 값이 + 1 된다는 의미.

        getData()
    }
    
    deinit { // 원래는 사라져야 하지만 500초 동안 동작이 걸려있어서 클릭 후 500초동안 사라지지 못함.
        // 숫자 개수만큼 뷰가 백그라운드에 살아 있게 된다.
        print("DEINTIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count") // 값을 가져오고
        UserDefaults.standard.set(currentCount - 1, forKey: "count") // 1을 추가
    }
    
    func getData() {

//        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { // 500초 걸림
//            self.data = "New Data!!!!" // self.data 에 대한 강력한 참조
//        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
            self?.data = "New Data!!!!" // self에 대해서 약한 참조 방법입니다.
        }
    }
}
```
<br>


강한 참조:
<br>
<img width="80%" src="https://github.com/HunyongSeong/SwiftUIStudy/assets/108869319/8be2374b-437c-43c1-ab85-1708bdbabb1a"/>
<br>

```swift
func getData() {

		// (1) 강력한 참조
		DispatchQueue.main.asyncAfter(deadline: .now() + 500) { // 500초 걸림
			 self.data = "New Data!!!!" // self.data 에 대한 강력한 참조
		}
		// 위의 코드는 Second View로 이동할 때, data의 값을 500초 후에 전달해주는 코드 입니다.
		// 500초 후에는 뷰에 New Data!!!! 가 보여지게 됩니다.
		// 기존에 화면을 나가게 되면 사려져야 하지만 500초 후에 데이터를 전달하기 때문에 해당 시간동안
		// 사라지지 못하고 숫자 개수만큼 뷰가 백그라운드에 살아있게 됩니다.
		
}
```
<br>

약한 참조:
<br>
<img width="80%" src="https://github.com/HunyongSeong/SwiftUIStudy/assets/108869319/acd45295-6f26-4729-a554-0d3bef02b070"/>
<br>

```swift
func getData() {
		
		// (2) 약한 참조
		DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
		    self?.data = "New Data!!!!" // self에 대해서 약한 참조 방법입니다.
		}
	  // self는 이제 선택 사항이므로 업데이트 되는 이 데이터에 대한 참조는 있지만, 
		// 이 클래스가 활성 상태를 유지할 필요는 없다고 선언 -> 클래스 초기화 해제 가능

    // 실제 데이터를 화면(2)에서 다운받는 경우에 우리가 다른 화면(1)으로 이동하게 되면,
		// 이전에 화면(2)은 필요가 없습니다. 하지만 데이터를 다운받고 있는 중이기 때문에 
		// 이전의 화면(2)은 활성화 상태입니다. 그리고 우리는 약한 참조를 통해서 활성화 상태를 
		// 유지할 필요가 없다고 알려줄 수 있습니다.
}
```
<br>





