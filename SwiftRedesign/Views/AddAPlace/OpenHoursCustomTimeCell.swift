//
//  OpenHoursCustomTimeCell.swift
//  SwiftRedesign
//
//  Created by rento on 07/11/24.
//

import UIKit

class OpenHoursCustomTimeCell: UICollectionViewCell {
    
    static let identifier: String = "OpenHoursCustomTimeCell"
    
    var fromLbl: UILabel!
    var toTimeLbl: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        let fromLbl = UILabel()
        fromLbl.textAlignment = .left
        fromLbl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(fromLbl)
        
        self.fromLbl = fromLbl
        
        NSLayoutConstraint.activate([
            fromLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            fromLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        let arrowIcon = UIImageView(image: UIImage(systemName: "arrow.right")?.withRenderingMode(.alwaysTemplate))
        arrowIcon.tintColor = .init(hex: "#707070")
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
        toTimeLbl.textAlignment = .right
        toTimeLbl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(toTimeLbl)
        
        self.toTimeLbl = toTimeLbl
        
        NSLayoutConstraint.activate([
            toTimeLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            toTimeLbl.centerYAnchor.constraint(equalTo: fromLbl.centerYAnchor)
        ])
    }
    
    func setUpUI(with item: CustomTime) {
        fromLbl.attributedText = item.fromTime.attributedTime(hourMinuteAttributes: [NSAttributedString.Key.font : UIFont.sfProText.bold.ofSize(size: 25), NSAttributedString.Key.foregroundColor : UIColor(hex: "#212121")], meridiemAttributes: [NSAttributedString.Key.font : UIFont.sfProText.medium.ofSize(size: 25), NSAttributedString.Key.foregroundColor : UIColor(hex: "#707070")])
        toTimeLbl.attributedText = item.toTime.attributedTime(hourMinuteAttributes: [NSAttributedString.Key.font : UIFont.sfProText.bold.ofSize(size: 25), NSAttributedString.Key.foregroundColor : UIColor(hex: "#212121")], meridiemAttributes: [NSAttributedString.Key.font : UIFont.sfProText.medium.ofSize(size: 25), NSAttributedString.Key.foregroundColor : UIColor(hex: "#707070")])
    }
}
