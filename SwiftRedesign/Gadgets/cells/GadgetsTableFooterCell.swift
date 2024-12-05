//
//  GadgetsTableFooterCell.swift
//  SwiftRedesign
//
//  Created by rento on 21/10/24.
//

import UIKit

protocol GadgetsTableFooterCellDelegate: Sendable {
    func addNewGadgetBtnClicked() async
}

class GadgetsTableFooterCell: UITableViewCell {
    
    static let identifier: String = "GadgetsTableFooterCell"
    
    var delegate: GadgetsTableFooterCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        backgroundColor = .clear
        
        let gadgetsImgV = UIImageView(image: UIImage(systemName: "photo.circle"))
        gadgetsImgV.contentMode = .scaleAspectFit
        gadgetsImgV.backgroundColor = .clear
        contentView.addSubview(gadgetsImgV)
        gadgetsImgV.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gadgetsImgV.topAnchor.constraint(equalTo: contentView.topAnchor),
            gadgetsImgV.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            gadgetsImgV.heightAnchor.constraint(equalToConstant: 300),
            gadgetsImgV.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        let attributedText = NSAttributedString(string: "Discover the world of\n", attributes: [NSAttributedString.Key.font : UIFont.sfProDisplay.regular.ofSize(size: 23), NSAttributedString.Key.foregroundColor : UIColor.black])
        let attributedText2 = NSAttributedString(string: "Mappls IoT Devices", attributes: [NSAttributedString.Key.font : UIFont.sfProText.regular.ofSize(size: 25), NSAttributedString.Key.foregroundColor : UIColor.black])
        let mutableString = NSMutableAttributedString(attributedString: attributedText)
        mutableString.append(attributedText2)
        
        let discoverLbl = UILabel()
        discoverLbl.attributedText = mutableString
        discoverLbl.backgroundColor = .clear
        discoverLbl.numberOfLines = 0
        discoverLbl.textAlignment = .center
        contentView.addSubview(discoverLbl)
        discoverLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            discoverLbl.topAnchor.constraint(equalTo: gadgetsImgV.bottomAnchor, constant: 30),
            discoverLbl.centerXAnchor.constraint(equalTo: gadgetsImgV.centerXAnchor)
        ])
        
        let chkOutWideRngeLbl = UILabel()
        chkOutWideRngeLbl.text = "Check out wide range of our IoT offerings"
        chkOutWideRngeLbl.font = .sfProText.medium.ofSize(size: .regular)
        chkOutWideRngeLbl.textAlignment = .center
        chkOutWideRngeLbl.backgroundColor = .clear
        contentView.addSubview(chkOutWideRngeLbl)
        chkOutWideRngeLbl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chkOutWideRngeLbl.topAnchor.constraint(equalTo: discoverLbl.bottomAnchor, constant: 10),
            chkOutWideRngeLbl.centerXAnchor.constraint(equalTo: discoverLbl.centerXAnchor)
        ])
        
        let addNewGadgetBtn = UIButton(type: .system)
        addNewGadgetBtn.setTitle("Add New Gadget", for: .normal)
        addNewGadgetBtn.backgroundColor = .clear
        addNewGadgetBtn.setTitleColor(.black, for: .normal)
        addNewGadgetBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        addNewGadgetBtn.layer.borderWidth = 1
        addNewGadgetBtn.layer.borderColor = UIColor.black.cgColor
        addNewGadgetBtn.layer.cornerRadius = 5
        addNewGadgetBtn.addTarget(self, action: #selector(self.addNewGadgetBtnClicked), for: .touchUpInside)
        contentView.addSubview(addNewGadgetBtn)
        addNewGadgetBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addNewGadgetBtn.topAnchor.constraint(equalTo: chkOutWideRngeLbl.bottomAnchor, constant: 10),
            addNewGadgetBtn.leadingAnchor.constraint(equalTo: chkOutWideRngeLbl.leadingAnchor, constant: -10),
            addNewGadgetBtn.trailingAnchor.constraint(equalTo: chkOutWideRngeLbl.trailingAnchor, constant: 10),
            addNewGadgetBtn.heightAnchor.constraint(equalToConstant: 40),
            addNewGadgetBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func addNewGadgetBtnClicked() {
        Task {
            await self.delegate?.addNewGadgetBtnClicked()
        }
    }
}

