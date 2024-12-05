//
//  AddAPlaceAdditionalInfoCell.swift
//  SwiftRedesign
//
//  Created by rento on 28/10/24.
//

import UIKit

class AddAPlaceAdditionalInfoCell: UICollectionViewCell {
    
    static let identifer: String = "AddAPlaceAdditionalInfoCell"
    
    var delegate: AddAPlaceCollectionViewInfoCellDelegate?
    var titleLbl: UILabel!
    var txtView: UITextView!
    var nextBtn: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        let titleLbl = UILabel()
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
        
        let nextBtn = CustomButton()
        nextBtn.setImage(UIImage(named: "forward")!, for: .normal)
        nextBtn.contentMode = .scaleAspectFit
        nextBtn.addTarget(self, action: #selector(self.nextBtnClicked), for: .touchUpInside)
        nextBtn.isHidden = true
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

    func setUpUI(for item: AddAPlaceDetailsCollectionViewHashable, addNextBtn: Bool = false) {
        titleLbl.attributedText = item.title

        if addNextBtn {
            nextBtn?.isHidden = false
        }else {
            nextBtn?.isHidden = true
        }
    }
    
    @objc func nextBtnClicked() {
        Task {
            await delegate?.nextBtnClicked(forTitle: titleLbl.text ?? "")
        }
    }
}

extension AddAPlaceAdditionalInfoCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        Task {
            await delegate?.textFieldDidChange(textView.text, forTitle: titleLbl.text ?? "")
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
}
