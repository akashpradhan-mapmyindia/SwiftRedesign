//
//  AddAPlaceHeaderSupplementaryView.swift
//  SwiftRedesign
//
//  Created by rento on 28/10/24.
//

import UIKit

class AddAPlaceHeaderSupplementaryView: UICollectionReusableView {
    
    static let identifier: String = "AddAPlaceHeaderSupplementaryView"
    
    var titleLbl: UILabel!
    
    func setUpUI(with title: String) {
        let titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.textAlignment = .left
        titleLbl.font = .systemFont(ofSize: 19, weight: .semibold)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLbl)
        
        NSLayoutConstraint.activate([
            titleLbl.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLbl.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        self.titleLbl = titleLbl
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLbl.removeFromSuperview()
    }
}
