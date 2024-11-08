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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(forSubcategory item: AddAPlaceCategoryTableViewHashable.SubCategoryHashable) {
        if titleLbl == nil {
            titleLbl = UILabel()
            titleLbl.text = item.title
            titleLbl.textColor = .init(hex: "#212121")
            titleLbl.font = .systemFont(ofSize: 17, weight: .medium)
            titleLbl.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(titleLbl)
            
            NSLayoutConstraint.activate([
                titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                titleLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
            ])
        }else {
            titleLbl.text = item.title
        }
    }
    
    func setUpUI(with item: AddAPlaceCategoryTableViewHashable) {
        if titleLbl == nil {
            titleLbl = UILabel()
            titleLbl.text = item.title
            titleLbl.textColor = .init(hex: "#212121")
            titleLbl.font = .systemFont(ofSize: 17, weight: .medium)
            titleLbl.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(titleLbl)
            
            NSLayoutConstraint.activate([
                titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                titleLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
            ])
        }else{
            titleLbl.text = item.title
        }
        
        if openSubCatBtn == nil {
            openSubCatBtn = UIImageView()
            openSubCatBtn.image = UIImage(systemName: "chevron.right")!.withRenderingMode(.alwaysTemplate)
            openSubCatBtn.contentMode = .scaleAspectFit
            openSubCatBtn.tintColor = .black
            openSubCatBtn.backgroundColor = .clear
            openSubCatBtn.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(openSubCatBtn)
            
            NSLayoutConstraint.activate([
                openSubCatBtn.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor),
                openSubCatBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                openSubCatBtn.heightAnchor.constraint(equalToConstant: 22),
                openSubCatBtn.widthAnchor.constraint(equalToConstant: 22)
            ])
        }
    }
}
