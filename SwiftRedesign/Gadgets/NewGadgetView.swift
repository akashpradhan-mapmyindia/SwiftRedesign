//
//  NewGadgetView.swift
//  SwiftRedesign
//
//  Created by rento on 21/10/24.
//

import UIKit

protocol NewGadgetViewDelegate: AnyObject {
    func addNewGadgetBtnClicked()
    func buyNowBtnClicked()
    func callSupportBtnClicked()
    func writeToUseBtnClicked()
}

class NewGadgetView: UIView {
    
    weak var delegate: NewGadgetViewDelegate?
    
    var scrollView: UIScrollView!
    
    init() {
        super.init(frame: .zero)
        backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1)
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        let newGadgetHeaderLbl = UILabel()
        newGadgetHeaderLbl.text = "Got a new Mappls IoT Gadget?\nAdd it here! or Buy one Today!!"
        newGadgetHeaderLbl.numberOfLines = 0
        newGadgetHeaderLbl.textAlignment = .center
        newGadgetHeaderLbl.font = .sfProText.regular.ofSize(size: 19)
        newGadgetHeaderLbl.backgroundColor = .clear
        newGadgetHeaderLbl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(newGadgetHeaderLbl)
        
        NSLayoutConstraint.activate([
            newGadgetHeaderLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            newGadgetHeaderLbl.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        let gadgetsImgV = UIImageView(image: UIImage(systemName: "photo.circle"))
        gadgetsImgV.contentMode = .scaleAspectFit
        gadgetsImgV.backgroundColor = .clear
        contentView.addSubview(gadgetsImgV)
        gadgetsImgV.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gadgetsImgV.topAnchor.constraint(equalTo: newGadgetHeaderLbl.bottomAnchor, constant: 20),
            gadgetsImgV.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            gadgetsImgV.heightAnchor.constraint(equalToConstant: 200),
            gadgetsImgV.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        let checkOutLbl = UILabel()
        checkOutLbl.text = "Check out wide range of\nour IoT offerings"
        checkOutLbl.numberOfLines = 0
        checkOutLbl.textAlignment = .center
        checkOutLbl.font = .sfProDisplay.regular.ofSize(size: 23)
        contentView.addSubview(checkOutLbl)
        checkOutLbl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkOutLbl.topAnchor.constraint(equalTo: gadgetsImgV.bottomAnchor, constant: 20),
            checkOutLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        let addNewGadgetBtn = UIButton(type: .system)
        addNewGadgetBtn.setTitle("Add New Gadget", for: .normal)
        addNewGadgetBtn.titleLabel?.font = .sfProText.semiBold.ofSize(size: 16)
        addNewGadgetBtn.addTarget(self, action: #selector(self.addNewBtnClicked), for: .touchUpInside)
        addNewGadgetBtn.layer.borderColor = UIColor.black.cgColor
        addNewGadgetBtn.layer.borderWidth = 1
        addNewGadgetBtn.layer.cornerRadius = 8
        addNewGadgetBtn.setTitleColor(.black, for: .normal)
        addNewGadgetBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let buyNowBtn = UIButton(type: .system)
        buyNowBtn.setTitle("Buy Now", for: .normal)
        buyNowBtn.addTarget(self, action: #selector(self.buyNowClicked), for: .touchUpInside)
        buyNowBtn.titleLabel?.font = .sfProText.semiBold.ofSize(size: 17)
        buyNowBtn.layer.borderColor = UIColor.black.cgColor
        buyNowBtn.layer.borderWidth = 1
        buyNowBtn.layer.cornerRadius = 8
        buyNowBtn.setTitleColor(.black, for: .normal)
        buyNowBtn.translatesAutoresizingMaskIntoConstraints = false

        let btnStkView = UIStackView(arrangedSubviews: [addNewGadgetBtn, buyNowBtn])
        btnStkView.axis = .horizontal
        btnStkView.distribution = .fillEqually
        btnStkView.spacing = 20
        contentView.addSubview(btnStkView)
        btnStkView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            btnStkView.topAnchor.constraint(equalTo: checkOutLbl.bottomAnchor, constant: 20),
            btnStkView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            btnStkView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            btnStkView.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        let callSupportBtn = UIButton(type: .system)
        callSupportBtn.setTitle("Call Support", for: .normal)
        callSupportBtn.backgroundColor = .clear
        callSupportBtn.addTarget(self, action: #selector(self.callSupportClicked), for: .touchUpInside)
        callSupportBtn.titleLabel?.font = .sfProText.medium.ofSize(size: .regular)
        callSupportBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let writeToUsBtn = UIButton(type: .system)
        writeToUsBtn.setTitle("Write To Us", for: .normal)
        writeToUsBtn.backgroundColor = .clear
        writeToUsBtn.addTarget(self, action: #selector(self.writeToUsClicked), for: .touchUpInside)
        writeToUsBtn.titleLabel?.font = .sfProText.medium.ofSize(size: .regular)
        writeToUsBtn.translatesAutoresizingMaskIntoConstraints = false

        let btnStkView2 = UIStackView(arrangedSubviews: [callSupportBtn, writeToUsBtn])
        btnStkView2.axis = .horizontal
        btnStkView2.distribution = .fillEqually
        btnStkView2.alignment = .center
        btnStkView2.spacing = 20
        btnStkView2.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(btnStkView2)
        
        NSLayoutConstraint.activate([
            btnStkView2.topAnchor.constraint(equalTo: btnStkView.bottomAnchor, constant: 10),
            btnStkView2.leadingAnchor.constraint(equalTo: btnStkView.leadingAnchor),
            btnStkView2.trailingAnchor.constraint(equalTo: btnStkView.trailingAnchor),
            btnStkView2.heightAnchor.constraint(equalToConstant: 45),
            btnStkView2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func addNewBtnClicked() {
        delegate?.addNewGadgetBtnClicked()
    }
    
    @objc func buyNowClicked() {
        delegate?.buyNowBtnClicked()
    }
    
    @objc func callSupportClicked() {
        delegate?.callSupportBtnClicked()
    }
    
    @objc func writeToUsClicked() {
        delegate?.writeToUseBtnClicked()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
