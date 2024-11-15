//
//  PostOnMapSubCategoryCell.swift
//  SwiftRedesign
//
//  Created by rento on 11/11/24.
//

import UIKit

class PostOnMapSubCategoryCell: UITableViewCell {
    
    static let identifier: String = "PostOnMapSubCategoryCell"
    
    var imgView: UIImageView!
    var titleLbl: UILabel!
    var nextImg: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imgView = UIImageView()
        imgView.backgroundColor = .white
        imgView.layer.cornerRadius = 22.5
        imgView.layer.shadowColor = UIColor.lightGray.cgColor
        imgView.layer.shadowOffset = .zero
        imgView.layer.shadowRadius = 1
        imgView.layer.shadowOpacity = 0.8
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imgView)
        
        NSLayoutConstraint.activate([
            imgView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imgView.heightAnchor.constraint(equalToConstant: 45),
            imgView.widthAnchor.constraint(equalToConstant: 45)
        ])
        
        titleLbl = UILabel()
        titleLbl.font = .sfProText.medium.ofSize(size: .regular)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLbl)
        
        NSLayoutConstraint.activate([
            titleLbl.centerYAnchor.constraint(equalTo: imgView.centerYAnchor),
            titleLbl.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 10)
        ])
        
        nextImg = UIImageView(image: UIImage(systemName: "chevron.right"))
        nextImg.contentMode = .scaleAspectFit
        nextImg.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nextImg)
        
        NSLayoutConstraint.activate([
            nextImg.centerYAnchor.constraint(equalTo: imgView.centerYAnchor),
            nextImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nextImg.heightAnchor.constraint(equalToConstant: 22),
            nextImg.widthAnchor.constraint(equalToConstant: 22)
        ])
        
        let lineView = UIView()
        lineView.backgroundColor = .init(hex: "#DDDDDD")
        lineView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lineView)
        
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: imgView.trailingAnchor),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(for item: PostOnMapSubCategoryHashable, with image: UIImage) {
        imgView.image = image
        titleLbl.text = item.title
    }
}
