//
//  EVFilterCollectionViewCell.swift
//  SwiftRedesign
//
//  Created by rento on 22/10/24.
//

import UIKit

class EVFilterCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "EVFilterCollectionViewCell"
    
    weak var valueLbl: UILabel?
    var value: EVFilterValueHashable?
    
    func setUpUI(for value: EVFilterValueHashable) {
        self.value = value
        
        contentView.layer.cornerRadius = 4
        contentView.layer.borderWidth = 1
        
        let valueLbl = UILabel()
        valueLbl.text = value.name
        valueLbl.font = .systemFont(ofSize: 13, weight: .regular)
        contentView.addSubview(valueLbl)
        valueLbl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            valueLbl.topAnchor.constraint(equalTo: contentView.topAnchor),
            valueLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            valueLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            valueLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        self.valueLbl = valueLbl
        
        if value.isSelected {
            setSelected()
        }else {
            setUnselected()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        valueLbl?.removeFromSuperview()
    }
    
    func setSelected(){
        contentView.backgroundColor = #colorLiteral(red: 0.2, green: 0.6196078431, blue: 0.5098039216, alpha: 0.2)
        contentView.layer.borderColor = #colorLiteral(red: 0.2, green: 0.6196078431, blue: 0.5098039216, alpha: 0.5).cgColor
        valueLbl?.textColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
    }
       
    func setUnselected() {
        contentView.layer.borderColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1).cgColor
        contentView.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
        valueLbl?.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
    }
}
