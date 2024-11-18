//
//  AddAPlaceCategoryCell.swift
//  SwiftRedesign
//
//  Created by rento on 04/11/24.
//

import UIKit

class AddAPlaceCategoryCell: UITableViewCell {
    
    static let identifier: String = "AddAPlaceCategoryCell"
    
    var titleLbl: UILabel!
    var openSubCatBtn: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        titleLbl = UILabel()
        titleLbl.textColor = .init(hex: "#212121")
        titleLbl.font = .sfProText.medium.ofSize(size: .regular)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLbl)
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        openSubCatBtn = UIImageView()
        openSubCatBtn.image = UIImage(named: "forward")
        openSubCatBtn.contentMode = .scaleAspectFit
        openSubCatBtn.tintColor = .black
        openSubCatBtn.backgroundColor = .clear
        openSubCatBtn.isHidden = true
        openSubCatBtn.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(openSubCatBtn)
        
        NSLayoutConstraint.activate([
            openSubCatBtn.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor),
            openSubCatBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            openSubCatBtn.heightAnchor.constraint(equalToConstant: 22),
            openSubCatBtn.widthAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func setUpUI(forSubcategory item: AddAPlaceCategoryTableViewHashable.SubCategoryHashable) {
        titleLbl.text = item.title
    }
    
    func setUpUI(with item: AddAPlaceCategoryTableViewHashable) {
        titleLbl.text = item.title
        openSubCatBtn.isHidden = false
    }
}
