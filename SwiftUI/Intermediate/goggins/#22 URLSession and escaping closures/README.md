# 22 URLSession and escaping closures

## 제이슨 데이터를 가지고 있는 사이트의 URL
https://jsonplaceholder.typicode.com/posts

<img width="80%" alt="Screenshot 2023-06-25 at 5 36 23 PM" src="https://github.com/HunyongSeong/MovieDiary/assets/108869319/8f6af46e-cdc1-4fd3-875b-a118199a0782">


<br>

### 제이슨 데이터를 디코딩해서 앱에서 보여주기 위해서는 어떻게 해야할까요?

<br>


<img width="390" alt="Untitled (1)" src="https://github.com/HunyongSeong/MovieDiary/assets/108869319/ab28b2b2-faf1-47cb-8e8e-2885d4eee322">

<br>

```swift
import SwiftUI

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
```
<br>
<br>

<aside>
💡 Codable 프로토콜은 Swift의 인코딩 및 디코딩을 지원하는 프로토콜입니다.
PostModel 구조체의 인스턴스를 → JSON 데이터로 (인코딩)하거나,
JSON 데이터를 → PostModel 구조체의 인스턴스로 (디코딩)할 수 있습니다.

디코딩(Decoding)은 데이터를 읽어와서 해당 데이터를 구조화된 형태로 변환하는 과정

</aside>

<br>

 Identifiable 프로토콜은 SwiftUI에서 사용되며,
 각 데이터 모델이 고유한 식별자(ID)를 가지고 있음을 나타냅니다.
 이 구조체는 id라는 속성을 가지고 있으며, 이를 통해 데이터를 식별할 수 있습니다.

 Codable 프로토콜은 Swift의 인코딩 및 디코딩을 지원하는 프로토콜입니다.
 이를 통해 PostModel 구조체의 인스턴스를 JSON 데이터로 인코딩하거나,
 JSON 데이터를 PostModel 구조체의 인스턴스로 디코딩할 수 있습니다.

<br>

<br>

```swift
istruct DownloadWithEscapingBootcamp: View {

    @StateObject var vm = DownloadWithEscapingViewModel()

    var body: some View {
        List {
            ForEach(vm.posts) { post in 
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct DownloadWithEscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscapingBootcamp()
    }
}
```
<br>
<br>


DownloadWithEscapingViewModel() 인스턴스의 posts를 바인딩
<br>
 ** posts(JSON 데이터의 배열)

<br>
<br>

아래의 JSON 데이터의 배열이 posts에 들어가게 됨

<br>

<img width="80%" alt="Screenshot 2023-06-25 at 5 36 23 PM" src="https://github.com/HunyongSeong/MovieDiary/assets/108869319/8f6af46e-cdc1-4fd3-875b-a118199a0782">

<br>

```swift
class DownloadWithEscapingViewModel: ObservableObject { 
// ObservableObject 프로토콜 채택한 객체는 관찰 가능한 속성 가질 수 있음

    @Published var posts: [PostModel] = [] 
// @Published 관찰 가능한 속성 / 변경 -> 뷰에 알림

    init() {
        getPost()
    }

    func getPost() {

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        // url 객채를 생성하고 확인
        
		// returnData는 data <- (잘 구워진 스테이크)
        downloadData(fromURL: url) { returnData in // returnData는 다운로드된 데이터
            if let data = returnData { 
			// 만약 데이터가 담긴다면 -> 아래 data를 [PostModel] 형식으로 디코딩 -> newPost에 담기

                guard let newPost = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
                DispatchQueue.main.async { [weak self] in // 비동기를 의미하는 디스패치 대기열, 뷰 작업은 메인에서 이루어짐
                    self?.posts = newPost 
					// 위에서 선언한 객체인 posts에 newPost를 넣기 // 약한 참조(메모리누수) // posts는 메인뷰에서 리스트 뷰에 사용
                }
                
                /*
                [weak self]를 사용하여 약한 참조로 현재 객체를 캡처하고,
				DispatchQueue.main.async를 사용하여 메인 큐에서 비동기적으로
                실행하는 것은 메모리 관리와 UI 업데이트의 안정성을 보장하기 위한 중요한 패턴
				(UI 업데이트는 메인 스레드에서 실행되어야함)
				클로저 안에서는 항상 [weak self]를 해주어야 메모리 누수가 생기지 않는다.
                 */
                
            } else {
                print("No data return")
            }
        }
    }

    // URL에서 데이터를 가져오고, 디코딩해서 검증이 완료된 data(잘 구워진 스테이크)를 내보내는 함수
    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) { 
		// completionHandler는 이것이 끝나고 나서 다루겠다는 의미.
		// 여기서 @escaping은 클로저가 함수나 메서드의 범위를 벗어나서 
		// 저장되거나 사용될 수 있음을 나타내는 속성입니다.

        URLSession.shared.dataTask(with: url) { (data, response, error) in // 데이터, 응답, 오류
            guard
            let data = data, // 데이터 확인
            error == nil, // 에러확인
            let response = response as? HTTPURLResponse, // 응답 확인
            response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error downloading data.")
                completionHandler(nil) // 오류가 없으면 nil이 반환된다.
                return
            }
    
            completionHandler(data) // <- 위 작업을 통하여 검증이 완료된 data
			// ex) 처음 데이터가 날것의 고기라면 현제 데이터는 잘 구워진 스테이크

            //데이터 다운로드가 완료되고 유효한 데이터가 있는 경우에 해당 데이터를 
		    //completionHandler 클로저의 매개변수로 전달하는 역할.
          
        }.resume() // <- 시작기능
        
    }
}
/* (1)다운캐스팅을 통해 ( :URLResponse?) -> ( :HTTPURLResponse) 타입으로 변환하면,
HTTP 응답에 관련된 세부 정보에 접근할 수 있습니다. 예를 들어, 상태 코드(status code), 
헤더 정보(headers), 응답 URL 등을 확인하고 필요에 따라 이러한 정보를 처리할 수 있습니다.

🌟 따라서, (response)를 HTTPURLResponse 타입으로 다운캐스팅하여 
HTTP 응답과 관련된 정보에 접근하고 처리할 수 있습니다. */
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

비동기적으로 지정된 URL에서 데이터를 다운로드하는 작업을 수행하는 함수
비동기적인 방식에서는 데이터 요청을 보낸 후에도 다음 동작을 계속해서 수행할 수 있습니다. 

응답을 기다리지 않고, 백그라운드에서 데이터를 받아오는 동작을 수행할 수 있습니다. 
이는 네트워크 요청이나 파일 다운로드 등 시간이 오래 걸릴 수 있는 작업을 수행할 때 유용합니다

<br>

