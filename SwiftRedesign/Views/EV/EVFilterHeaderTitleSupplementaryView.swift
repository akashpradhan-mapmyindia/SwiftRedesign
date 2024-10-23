//
//  EVFilterHeaderTitleSupplementaryView.swift
//  SwiftRedesign
//
//  Created by rento on 23/10/24.
//

import UIKit

class EVFilterHeaderTitleSupplementaryView: UICollectionReusableView {
    
    static let identifier: String = "EVFilterHeaderTitleSupplementaryView"

    var titleLbl: UILabel!
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        backgroundColor = .white
        
        let titleLbl = UILabel()
        addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.font = .systemFont(ofSize: 18, weight: .medium)
        titleLbl.textAlignment = .left
        self.titleLbl = titleLbl
        
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor
                .constraint(equalTo: leadingAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLbl.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
