# Crpyto App

## 목차
1. [UI](#uiview)
2. [Service](#service)
3. [Manager](#manager)
4. [CoreData](#coredata)
5. [Extra](#extra)


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

### 1.데이터 서비스

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

### 2.이미지 서비스

```swift
//
//  CoinImageService.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/04/28.
//

import Foundation
import UIKit
import Combine

class CoinImageService {
    
    @Published var image:UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private var coin:CoinModel
    private let fileManager = LocalFileManager.shared
    private let folderName = "coin_image"
    private let imageName:String
    
    
    init(coin:CoinModel){
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName){ //캐싱 되어 있으면 바로 꺼내고
            image = savedImage
            print("Retrieved image from File Manager")
        } else { //아니면 다운
            downloadCoinImage()
            print("Downloading image now")
        }
    }
    
    private func downloadCoinImage(){
        guard let url = URL(string:coin.image) else {return}
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] image in
                
                guard let self, let downloadedImage = image else {return}
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
                
            })
        
    }

}

```


## Manager

### 1. 네트워크 매니저

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

### 2.로컬 파일 매니저
```swift
//
//  LocalFileManager.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/04/28.
//

import Foundation
import UIKit

class LocalFileManager {
    
    static let shared = LocalFileManager()
    
    private init() {}
    
    
    func saveImage(image:UIImage,imageName:String,folderName:String) {
        
        //create folder
        createFolderIfNeeded(folderName: folderName)
        
        
        //get path for image
        guard let data = image.pngData(),let url = getURLForImage(imageName: imageName, folderName: folderName)  // PNG Data 포맷
        else {return}
        
        // save image to path
        do{
            try data.write(to: url)
        } catch let error {
            print("Error saving image. \(error)")
        }
        
    
    }
    
    func getImage(imageName: String, folderName:String) -> UIImage? {
        
        guard let url = getURLForImage(imageName: imageName, folderName: folderName), FileManager.default.fileExists(atPath: url.path()) else {
            return nil
        }
        
        return UIImage(contentsOfFile: url.path())
        
    }
    
    private func createFolderIfNeeded(folderName:String){
        
        guard let url = getURLForFolder(folderName: folderName) else {return}
        
        if !FileManager.default.fileExists(atPath: url.path()) { //폴더 경로 없으면
            do{
                /*
                 at : 경로 및 폴더명, 위에서 만든 URL 사용
                 withIntermediateDirectories : “중간 디렉토리들도 만들꺼야?” 이런 의미.
                 attributes : 파일 접근 권한, 그룹 등등 폴더 속성 정의
                 
                 */
                //폴더 생성
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true,attributes: nil)
                
            } catch let error {
                print("Error creating directory. FolderName: \(folderName). \(error)")
            }
            
        }
        
    }
    
    private func getURLForFolder(folderName:String) -> URL? {
        //먼저 FileManager인스턴스를 생성해야겠죠?  default는 FileManager의 싱글톤 인스턴스를 만들어준답니다.
        /*
         저 urls라는 메소드는 요청된 도메인에서 지정된 공통 디렉토리에 대한 URL배열을 리턴해주는 메소드에요.

         첫번째 파라미터는 검색 경로 디렉토리에요.  들어간 값을 보니, enum인 것 같죠?

         무슨 값들이 있는지는 여기에 나와있어요.  그리고 두번째는 Domain을 나타내는 파라미터로, 다른 값들은 여기에 나와있어요. 
         
         */
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return url.appendingPathComponent(folderName) // return  cacheDirectory경로/folderName
    }
    
    private func getURLForImage(imageName:String, folderName:String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }
        
        return folderURL.appendingPathComponent(imageName + ".png") // cacheDirectory경로/folderName/imageName
    }
    
    
}

```

## CoreData

### 1. DataModel 
<img width="118" alt="스크린샷 2023-04-29 오후 6 54 32" src="https://user-images.githubusercontent.com/48616183/235296657-fb31cc0f-f942-4cc7-97ac-40f00ed75da9.png">

### 2. Service

```swift

import Foundation
import CoreData

class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName : String = "PortfolioContainer" // DataModel 파일명과 같게 설정
    private let entityName:String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init(){
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores(completionHandler: { (_,error) in
            
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
        })
        
        self.getPortfolio()
    }
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Entities. \(error)")
        }
        
        
    }
    
    // MARK: PUBLIC
    
    
    func updatePortfolio(coin:CoinModel, amount:Double){
        
        if let entity = savedEntities.first(where: {$0.coinID == coin.id}) {
            
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    
    
    // MARK: PRIVATE
    
    private func add(coin:CoinModel,amount: Double){
        let entity =  PortfolioEntity(context: container.viewContext)
        
        entity.coinID = coin.id
        entity.amount = amount
        
        applyChange()
    }
    
    private func update(entity: PortfolioEntity, amount:Double) {
        entity.amount = amount
        applyChange()
    }
    
    private func delete(entity: PortfolioEntity){
        container.viewContext.delete(entity)
        applyChange()
    }
    
    private func save(){
        
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data \(error)")
        }
        
    }
    
    private func applyChange(){
        save()
        getPortfolio()
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