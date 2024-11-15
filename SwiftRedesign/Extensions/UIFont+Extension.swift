//
//  UIFont+Extension.swift
//  SwiftRedesign
//
//  Created by rento on 14/11/24.
//

import UIKit

extension UIFont {
    
    enum fontSize: CGFloat {
        case extra_small = 12
        case small = 14
        case regular = 16
        case medium = 18
        case extra_large = 36
    }
    
    enum sfProDisplay: String {
        case semiBold = "SFProDisplay-Semibold" // Info.plist
        case bold = "SFProDisplay-Bold"
        //case mediumItalic = "SFProDisplay-MediumItalic"
        case regular = "SFProDisplay-Regular" // Info.plist
        case medium = "SFProDisplay-Medium" // Info.plist
        
        func ofSize(size: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: size)!
        }
    }
    
    enum sfProText: String {
        case bold = "SFProText-Bold" // Info.plist
        case medium = "SFProText-Medium"
        case regular = "SFProText-Regular"
        case semiBold = "SFProText-Semibold"
        case mediumItalic = "SFProText-MediumItalic" // Info.plist
        
        func ofSize(size: fontSize) -> UIFont {
            return UIFont(name: self.rawValue, size: size.rawValue)!
        }
        
        func ofSize(size: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: size)!
        }
    }
}
