//
//  Extension+View.swift
//  SnackAlarm
//
//  Created by 관식 on 2023/03/29.
//

import SwiftUI
import Foundation

extension View {
    
    var safeArea: UIEdgeInsets {
        
        if let safeArea = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets {
            return safeArea
        }
        
        return .zero
        
    }
}
