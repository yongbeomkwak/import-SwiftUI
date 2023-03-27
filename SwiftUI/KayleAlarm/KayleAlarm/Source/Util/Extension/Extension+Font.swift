//
//  Extension+Font.swift
//  KayleAlarm
//
//  Created by yongbeomkwak on 2023/03/27.
//

import Foundation
import SwiftUI

extension Font {
    
    
    

    static func sdNeoB(_ size:CGFloat = 10 ) -> Font {
        
        return Font.custom("AppleSDGothicNeoB00", size: size)
        
    }
    
    static func sdNeoEB(_ size:CGFloat = 10) -> Font {
        
        return Font.custom("AppleSDGothicNeoEB00", size: size)
        
    }
    
    static func sdNeoH(_ size:CGFloat = 10) -> Font {
        
        return Font.custom("AppleSDGothicNeoH00", size: size)
        
    }
    
    static func sfPro(_ size:CGFloat = 10) -> Font {
        
        return Font.custom("SFRounded-Ultralight", size: size)
        
    }
    
    
    
}
