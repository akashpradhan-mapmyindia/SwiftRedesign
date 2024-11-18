//
//  AddAPlaceImageCell.swift
//  SwiftRedesign
//
//  Created by rento on 28/10/24.
//

import UIKit

protocol AddAPlaceImageCellDelegte: AnyObject {
    func addImageClicked()
    func deleteImageClicked()
}

class AddAPlaceImageCell: UICollectionViewCell {
    
    static let identifier: String = "AddAPlaceImageCell"
    
    weak var delegate: AddAPlaceImageCellDelegte?
    
    var imageView: UIImageView!
    var eraseBtn: UIButton!
    var addImgBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = UIColor(hex: "#DDDDDD").cgColor
        contentView.layer.borderWidth = 1
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "add image")!, for: .normal)
        button.setTitle("Add image", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .sfProText.medium.ofSize(size: .small)
        button.addTarget(self, action: #selector(self.addImageClicked), for: .touchUpInside)
        button.contentMode = .scaleAspectFit
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(button)
        self.addImgBtn = button
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            button.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        button.alignVerticalCenter(padding: 10)
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        self.imageView = imageView
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        let eraseBtn = UIButton()
        eraseBtn.setImage(UIImage(named: "clear")!, for: .normal)
        eraseBtn.addTarget(self, action: #selector(self.deleteImageClicked), for: .touchUpInside)
        eraseBtn.contentMode = .scaleAspectFit
        eraseBtn.isHidden = true
        eraseBtn.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(eraseBtn)
        self.eraseBtn = eraseBtn
        
        NSLayoutConstraint.activate([
            eraseBtn.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            eraseBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            eraseBtn.widthAnchor.constraint(equalToConstant: 30),
            eraseBtn.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setUpUI(for item: AddAPlaceDetailsCollectionViewHashable, isAddImageCell: Bool = false) {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = UIColor(hex: "#DDDDDD").cgColor
        contentView.layer.borderWidth = 1
        
        if isAddImageCell {
            addImgBtn.isHidden = false
            
            imageView.isHidden = true
            eraseBtn.isHidden = true
        }else {
            imageView.isHidden = false
            imageView.image = item.icon!
            
            eraseBtn.isHidden = false
            
            addImgBtn.isHidden = true
        }
    }
    
    @objc func deleteImageClicked() {
        delegate?.deleteImageClicked()
    }
    
    @objc func addImageClicked() {
        delegate?.addImageClicked()
    }
}
