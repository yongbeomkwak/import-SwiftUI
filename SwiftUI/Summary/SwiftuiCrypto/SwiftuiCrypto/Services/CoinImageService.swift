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
           // print("Retrieved image from File Manager")
        } else { //아니면 다운
            downloadCoinImage()
          //  print("Downloading image now")
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
