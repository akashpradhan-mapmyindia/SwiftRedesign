//
//  UIButton+Extension.swift
//  SwiftRedesign
//
//  Created by rento on 28/10/24.
//

import UIKit

extension UIButton {
 
    func alignVerticalCenter(padding: CGFloat = 0.0) {
        guard let imageSize = imageView?.frame.size, let titleText = titleLabel?.text, let titleFont = titleLabel?.font else {
            return
        }
        
        let titleSize = (titleText as NSString).size(withAttributes: [.font: titleFont])
        let total = imageSize.height + titleSize.height + padding
        imageEdgeInsets = UIEdgeInsets(top: -(total - imageSize.height), left: 0, bottom: 0, right: -titleSize.width)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(total - titleSize.height), right: 0)
    }
}

