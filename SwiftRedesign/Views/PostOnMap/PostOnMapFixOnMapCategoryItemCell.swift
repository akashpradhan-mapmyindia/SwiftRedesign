//
//  PostOnMapCategoryItemCell.swift
//  SwiftRedesign
//
//  Created by rento on 11/11/24.
//

import UIKit

class PostOnMapFixOnMapCategoryItemCell: UICollectionViewCell {
    
    static let identifier: String = "PostOnMapFixOnMapCategoryItemCell"
    
    var imgBtn: UIImageView!
    var titleLbl: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imgBtn = UIImageView()
        imgBtn.backgroundColor = .white
        imgBtn.layer.cornerRadius = 50
        imgBtn.layer.shadowColor = UIColor.lightGray.cgColor
        imgBtn.layer.shadowOffset = .init(width: 0, height: 0.5)
        imgBtn.layer.shadowRadius = 1
        imgBtn.layer.shadowOpacity = 0.7
        imgBtn.contentMode = .scaleAspectFit
        imgBtn.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imgBtn)
        
        NSLayoutConstraint.activate([
            imgBtn.topAnchor.constraint(equalTo: contentView.topAnchor),
            imgBtn.heightAnchor.constraint(equalToConstant: 100),
            imgBtn.widthAnchor.constraint(equalToConstant: 100),
            imgBtn.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        titleLbl = UILabel()
        titleLbl.font = .sfProText.medium.ofSize(size: .small)
        titleLbl.numberOfLines = 0
        titleLbl.textAlignment = .center
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLbl)
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: imgBtn.bottomAnchor, constant: 5),
            titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(for item: PostOnMapCategoryHashable) {
        imgBtn.image = item.image
        titleLbl.text = item.title
    }
    
    func setUpUI(for item: FixOnMapCategoryHashable) {
        imgBtn.image = item.image
        titleLbl.text = item.title
    }
}
