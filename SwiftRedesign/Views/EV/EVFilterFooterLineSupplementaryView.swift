//
//  EVFilterFooterLineSupplementaryView.swift
//  SwiftRedesign
//
//  Created by rento on 23/10/24.
//

import UIKit

class EVFilterFooterLineSupplementaryView: UICollectionReusableView {
    
    var lineView: UIView!
    
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
        backgroundColor = .clear
        
        let lineView = UIView()
        lineView.backgroundColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lineView.centerYAnchor.constraint(equalTo: centerYAnchor),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        self.lineView = lineView
    }
}
