//
//  OpenHoursCustomTimeCell.swift
//  SwiftRedesign
//
//  Created by rento on 07/11/24.
//

import UIKit

class OpenHoursCustomTimeCell: UICollectionViewCell {
    
    static let identifier: String = "OpenHoursCustomTimeCell"
    
    func setUpUI(with item: CustomTime) {
        let fromLbl = UILabel()
        fromLbl.attributedText = item.fromTime.attributedTime(hourMinuteAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 26, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor(hex: "#212121")], meridiemAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 26, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor(hex: "#707070")])
        fromLbl.textAlignment = .left
        fromLbl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(fromLbl)
        
        NSLayoutConstraint.activate([
            fromLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            fromLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        let arrowIcon = UIImageView(image: UIImage(systemName: "arrow.right"))
        arrowIcon.contentMode = .scaleAspectFit
        arrowIcon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(arrowIcon)
        
        NSLayoutConstraint.activate([
            arrowIcon.heightAnchor.constraint(equalToConstant: 20),
            arrowIcon.widthAnchor.constraint(equalToConstant: 20),
            arrowIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        let toTimeLbl = UILabel()
        toTimeLbl.attributedText = item.toTime.attributedTime(hourMinuteAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 26, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor(hex: "#212121")], meridiemAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 26, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor(hex: "#707070")])
        toTimeLbl.textAlignment = .right
        toTimeLbl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(toTimeLbl)
        
        NSLayoutConstraint.activate([
            toTimeLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            toTimeLbl.centerYAnchor.constraint(equalTo: fromLbl.centerYAnchor)
        ])
    }
}
