//
//  Extension+UIFont.swift
//  Alram
//
//  Created by yongbeomkwak on 2023/03/26.
//

import Foundation
import SwiftUI


//AppleSDGothicNeoEB00
//AppleSDGothicNeoH00
//AppleSDGothicNeoL00
//AppleSDGothicNeoM00
//AppleSDGothicNeoR00
//AppleSDGothicNeoSB00
//AppleSDGothicNeoT00
//AppleSDGothicNeoUL00
//SFRounded-Ultralight

extension Font {
    
    static func neoB(_ size:CGFloat = 10) -> Font {
        return Font.custom("AppleSDGothicNeoB00", size: size)
    }
    
    static func neoH(_ size:CGFloat = 10) -> Font {
        return Font.custom("AppleSDGothicNeoH00", size: size)
    }
    
    static func neoL(_ size:CGFloat = 10) -> Font {
        return Font.custom("AppleSDGothicNeoL00", size: size)
    }
    
    static func neoR(_ size:CGFloat = 10) -> Font {
        return Font.custom("AppleSDGothicNeoR00", size: size)
    }
    
    static func neoSB(_ size:CGFloat = 10) -> Font {
        return Font.custom("AppleSDGothicNeoSB00", size: size)
    }
    
    static func neoT(_ size:CGFloat = 10) -> Font {
        return Font.custom("AppleSDGothicNeoT00", size: size)
    }
    
    static func neoUL(_ size:CGFloat = 10) -> Font {
        return Font.custom("AppleSDGothicNeoUL00", size: size)
    }
    
    static func sfRounded(_ size:CGFloat = 10) -> Font {
        return Font.custom("SFRounded-Ultralight", size: size)
    }
    
    
    
   
}
