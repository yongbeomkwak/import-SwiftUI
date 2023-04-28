# TODO List

## 목차
1. [UI](#uiview)
2. [Service](#service)
3. [NetworkingManager](#networkingmanager)

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

## 2. Service
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
            .sink(receiveCompletion: { (completion) in
                
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                
            }, receiveValue: { [weak self] coins in
                guard let self else  {return}
                self.allCoins  = coins
                self.coinSubscription?.cancel()
                
            })
           
        
        
    }
    
    
    
}
```


## NetworkingManager
```swift
class NetworkingManager {
    
    static func download(url:URL) -> AnyPublisher<Data,Error>  {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ output -> Data in
                guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 &&
                        response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                
                return output.data
            })
            .receive(on:DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
    
    
}
```