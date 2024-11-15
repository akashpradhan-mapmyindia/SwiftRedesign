//
//  AddAPlaceAdditionalInfoCell.swift
//  SwiftRedesign
//
//  Created by rento on 28/10/24.
//

import UIKit

class AddAPlaceAdditionalInfoCell: UICollectionViewCell {
    
    static let identifer: String = "AddAPlaceAdditionalInfoCell"
    
    weak var delegate: AddAPlaceCollectionViewInfoCellDelegate?
    var titleLbl: UILabel!
    var txtView: UITextView!
    var nextBtn: UIButton?

    func setUpUI(for item: AddAPlaceDetailsCollectionViewHashable, addNextBtn: Bool = false) {
        let titleLbl = UILabel()
        titleLbl.attributedText = item.title
        titleLbl.textAlignment = .left
        titleLbl.textColor = .init(hex: "#707070")
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLbl)
        
        self.titleLbl = titleLbl
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        let txtView = UITextView()
        txtView.font = .sfProText.regular.ofSize(size: .regular)
        txtView.isScrollEnabled = false
        txtView.textContainer.heightTracksTextView = true
        txtView.delegate = self
        contentView.addSubview(txtView)
        txtView.translatesAutoresizingMaskIntoConstraints = false
        
        self.txtView = txtView
    
        let heightCons = txtView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30)
        heightCons.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            txtView.topAnchor.constraint(equalTo: titleLbl.bottomAnchor),
            txtView.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor),
            txtView.trailingAnchor.constraint(equalTo: titleLbl.trailingAnchor),
            heightCons,
            txtView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])

        let border = UIView()
        border.backgroundColor = .init(hex: "#DDDDDD")
        border.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(border)
        
        NSLayoutConstraint.activate([
            border.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1),
            border.heightAnchor.constraint(equalToConstant: 1),
            border.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor),
            border.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        if addNextBtn {
            let nextBtn = UIButton()
            nextBtn.setImage(UIImage(systemName: "chevron.right")!, for: .normal)
            nextBtn.contentMode = .scaleAspectFit
            nextBtn.addTarget(self, action: #selector(self.nextBtnClicked), for: .touchUpInside)
            nextBtn.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(nextBtn)
            
            self.nextBtn = nextBtn
            
            NSLayoutConstraint.activate([
                nextBtn.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor),
                nextBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                nextBtn.heightAnchor.constraint(equalToConstant: 25),
                nextBtn.widthAnchor.constraint(equalToConstant: 25)
            ])
        }
    }
    
    @objc func nextBtnClicked() {
        delegate?.nextBtnClicked?(forTitle: titleLbl.text ?? "")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.txtView.removeFromSuperview()
        self.titleLbl.removeFromSuperview()
        self.nextBtn?.removeFromSuperview()
    }
}

extension AddAPlaceAdditionalInfoCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        delegate?.textFieldDidChange(textView.text, forTitle: titleLbl.text ?? "")
    }
}
