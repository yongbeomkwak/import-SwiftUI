//
//  Extension+String.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/05/01.
//

import Foundation


extension String {
    
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
