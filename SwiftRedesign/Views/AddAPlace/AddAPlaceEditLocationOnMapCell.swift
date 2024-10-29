//
//  AddAPlaceEditLocationOnMapCell.swift
//  SwiftRedesign
//
//  Created by rento on 25/10/24.
//

import UIKit

protocol AddAPlaceEditLocationOnMapCellDelegate: AnyObject {
    func editOnMapBtnClicked()
}

class AddAPlaceEditLocationOnMapCell: UICollectionViewCell {

    static let identifier: String = "AddAPlaceEditLocationOnMapCell"
    
    weak var delegate: AddAPlaceEditLocationOnMapCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        let mapBgView = UIView()
        mapBgView.layer.cornerRadius = 12
        mapBgView.backgroundColor = .blue
        mapBgView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mapBgView)
        
        NSLayoutConstraint.activate([
            mapBgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mapBgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            mapBgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            mapBgView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        let editOnMapBtn = UIButton(type: .system)
        editOnMapBtn.setTitle("Edit location on map", for: .normal)
        editOnMapBtn.titleLabel?.font = .systemFont(ofSize: 16)
        editOnMapBtn.setTitleColor(.white, for: .normal)
        editOnMapBtn.layer.borderColor = UIColor.white.cgColor
        editOnMapBtn.layer.borderWidth = 1
        editOnMapBtn.layer.cornerRadius = 5
        editOnMapBtn.translatesAutoresizingMaskIntoConstraints = false
        mapBgView.addSubview(editOnMapBtn)
        
        NSLayoutConstraint.activate([
            editOnMapBtn.centerYAnchor.constraint(equalTo: mapBgView.centerYAnchor),
            editOnMapBtn.centerXAnchor.constraint(equalTo: mapBgView.centerXAnchor),
            editOnMapBtn.heightAnchor.constraint(equalToConstant: 25),
            editOnMapBtn.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        let editPublishNote = UILabel()
        editPublishNote.text = "Note: Your edits will be published on Mappls shortly. Mappls will email you about the status of your edits and may contact you for furthers details."
        editPublishNote.textAlignment = .left
        editPublishNote.numberOfLines = 0
        editPublishNote.font = .systemFont(ofSize: 15)
        editPublishNote.textColor = .init(hex: "#707070")
        editPublishNote.backgroundColor = .clear
        editPublishNote.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(editPublishNote)
        
        NSLayoutConstraint.activate([
            editPublishNote.topAnchor.constraint(equalTo: mapBgView.bottomAnchor, constant: 10),
            editPublishNote.leadingAnchor.constraint(equalTo: mapBgView.leadingAnchor),
            editPublishNote.trailingAnchor.constraint(equalTo: mapBgView.trailingAnchor),
            editPublishNote.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
