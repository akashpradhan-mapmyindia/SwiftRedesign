//
//  OpenHoursSelectTimeCell.swift
//  SwiftRedesign
//
//  Created by rento on 06/11/24.
//

import UIKit

class OpenHoursSelectTimeCell: UICollectionViewCell {
    
    static let identifier: String = "OpenHoursSelectTimeCell"
    
    var titleLbl: UILabel!
    
    func setUpUI(for item: SelectTime) {
        contentView.layer.cornerRadius = 18
        
        if titleLbl == nil {
            titleLbl = UILabel()
            titleLbl.text = item.timeType.rawValue
            titleLbl.font = .systemFont(ofSize: 15, weight: .medium)
            titleLbl.textAlignment = .center
            titleLbl.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(titleLbl)
            
            NSLayoutConstraint.activate([
                titleLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                titleLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
            ])
        }else {
            titleLbl.text = item.timeType.rawValue
        }
        
        if item.isSelected {
            contentView.layer.borderColor = UIColor(hex: "#14724C33").cgColor
            contentView.layer.borderWidth = 1
            contentView.backgroundColor = .init(hex: "#339E821A")
            titleLbl.textColor = .init(hex: "#339E82")
        }else{
            contentView.layer.borderColor = UIColor(hex: "#DDDDDD").cgColor
            contentView.layer.borderWidth = 1
            contentView.backgroundColor = .init(hex: "#F3F3F3")
            titleLbl.textColor = .init(hex: "#707070")
        }
    }
}
