//
//  CollectionViewSupplementaryItemTextView.swift
//  SwiftRedesign
//
//  Created by rento on 06/11/24.
//

import UIKit

class CollectionViewSupplementaryItemTextView: UICollectionReusableView {
    
    static let identifier: String = "CollectionViewSupplementaryItemTextView"
    
    var titleLbl: UILabel!
    
    func setUpUI(for title: String, font: UIFont = .systemFont(ofSize: 17, weight: .medium), textAlignment: NSTextAlignment = .left, titleTextColor: UIColor = .black) {
        titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.font = font
        titleLbl.textAlignment = textAlignment
        titleLbl.textColor = titleTextColor
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLbl)
        
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLbl.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
