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
    
    var imageView: UIImageView?
    var button: UIButton?
    
    func setUpUI(for item: AddAPlaceDetailsCollectionViewHashable, isAddImageCell: Bool = false) {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = UIColor(hex: "#DDDDDD").cgColor
        contentView.layer.borderWidth = 1
        
        if isAddImageCell {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: "photo")!, for: .normal)
            button.setTitle("Add image", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
            button.addTarget(self, action: #selector(self.addImageClicked), for: .touchUpInside)
            button.contentMode = .scaleAspectFit
            button.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(button)
            self.button = button
            
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                button.topAnchor.constraint(equalTo: contentView.topAnchor)
            ])
            
            button.alignVerticalCenter(padding: 10)
        }else {
            let imageView = UIImageView(image: item.icon!)
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(imageView)
            self.imageView = imageView
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
            
            let button = UIButton()
            button.setImage(UIImage(systemName: "x.circle.fill")!, for: .normal)
            button.addTarget(self, action: #selector(self.deleteImageClicked), for: .touchUpInside)
            button.contentMode = .scaleAspectFit
            button.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(button)
            self.button = button
            
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
                button.widthAnchor.constraint(equalToConstant: 30),
                button.heightAnchor.constraint(equalToConstant: 30)
            ])
        }
    }
    
    @objc func deleteImageClicked() {
        delegate?.deleteImageClicked()
    }
    
    @objc func addImageClicked() {
        delegate?.addImageClicked()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.removeFromSuperview()
        button?.removeFromSuperview()
    }
}
