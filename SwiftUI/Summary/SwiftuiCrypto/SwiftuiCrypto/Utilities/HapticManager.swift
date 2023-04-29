//
//  HapticManager.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/04/29.
//

import Foundation
import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type:UINotificationFeedbackGenerator.FeedbackType){
        generator.notificationOccurred(type)
    }
}
