//
//  OpenHoursWeekDayCell.swift
//  SwiftRedesign
//
//  Created by rento on 06/11/24.
//

import UIKit

class OpenHoursWeekDayCell: UICollectionViewCell {
    
    static let identifer: String = "OpenHoursWeekDayCell"
    
    var titleLbl: UILabel!
    
    func setUpUI(for item: WeekDays) {
        contentView.layer.cornerRadius = 25
        
        if titleLbl == nil {
            titleLbl = UILabel()
            titleLbl.text = item.day.abbreviation
            titleLbl.font = .sfProText.semiBold.ofSize(size: 21)
            titleLbl.textAlignment = .center
            titleLbl.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(titleLbl)
            
            NSLayoutConstraint.activate([
                titleLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                titleLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])
        }else {
            titleLbl.text = item.day.abbreviation
        }
        
        if item.isSelected {
            contentView.backgroundColor = .init(hex: "#339E82")
            titleLbl.textColor = .white
        }else {
            contentView.backgroundColor = .init(hex: "#F3F3F3")
            titleLbl.textColor = .init(hex: "#707070")
        }
    }
}
