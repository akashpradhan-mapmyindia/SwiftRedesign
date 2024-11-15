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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLbl = UILabel()
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLbl)
        
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLbl.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(for title: String, font: UIFont = .sfProText.medium.ofSize(size: .small), textAlignment: NSTextAlignment = .left, titleTextColor: UIColor = .black) {
        titleLbl.text = title
        titleLbl.font = font
        titleLbl.textAlignment = textAlignment
        titleLbl.textColor = titleTextColor
    }
}
