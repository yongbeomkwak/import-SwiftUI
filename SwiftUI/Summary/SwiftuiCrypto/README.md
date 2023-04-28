# TODO List

## 목차
1. [UI](#uiview)
2. [Service](#service)
3. [Manager](#manager)
4. [Extra](#extra)


---

<br>

## UI(View)
### 1. List

```swift

List{
    ForEach(vm.allCoins){ coin in
        CoinRowView(coin: coin, showHoldingsColumn: false)
            .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10)) // 리스트 행에 대한 패딩
    }
}

```

### 2.Image , ProgressView
```swift
ZStack{
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(.theme.secondaryText)
            }
}
```



## Service
```swift
import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins: [CoinModel] = []
    var coinSubscription: AnyCancellable?
    
    
    init(){
        getCoins()
    }
    
    
    private func getCoins(){
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {return}
        
    
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] coins in
                guard let self else  {return}
                self.allCoins  = coins
                self.coinSubscription?.cancel()
                
            })
           
        
        
    }
    
    
    
}
```

```swift
import Foundation
import UIKit
import Combine

class CoinImageService {
    
    @Published var image:UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private var coin:CoinModel
    
    init(coin:CoinModel){
        self.coin = coin
        getImage()
    }
    
    private func getImage(){
        
        guard let url = URL(string:coin.image) else {return}
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] image in
                
                guard let self else {return}
                self.image = image
                self.imageSubscription?.cancel()
                
            })
        
        
    }
}
```


## Manager

```swift
import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url:URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
                
            case .badURLResponse(url: let url):
                return "❌ Bad Response from URL: \(url)"
            case .unknown:
                return "[⚠️] Unknown error occured"
            }
        }
        
    }
    
    
    static func download(url:URL) -> AnyPublisher<Data,Error>  {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0,url: url) })
            .receive(on:DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
    
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output,url:URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 &&
                response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        
        return output.data
        
    }
    
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    
}
```


## Extra

### 1. StateViewModel initialize

```swift
struct CoinImageView: View {
    
    @StateObject var vm:CoinImageViewModel
    
    init(coin:CoinModel){
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
}
```