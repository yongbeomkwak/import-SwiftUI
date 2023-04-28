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
