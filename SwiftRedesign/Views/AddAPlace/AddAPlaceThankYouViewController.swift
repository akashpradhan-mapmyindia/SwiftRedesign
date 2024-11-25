//
//  AddAPlaceThankYouViewController.swift
//  SwiftRedesign
//
//  Created by rento on 07/11/24.
//

import UIKit

class AddAPlaceThankYouViewController: UIViewController {
    
    var mapplsPin: String = "MMI000"
    var containerScrollView: UIScrollView!
    
    convenience init(mapplsPin: String) {
        self.init()
        self.mapplsPin = mapplsPin
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
    
    func setUpUI() {
        view.backgroundColor = .white
        
        let containerScrollView = UIScrollView()
        containerScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerScrollView)
        
        self.containerScrollView = containerScrollView
        
        NSLayoutConstraint.activate([
            containerScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            containerScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        containerScrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerScrollView.topAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerScrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor)
        ])
        
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineSpacing = 10
        paraStyle.alignment = .center
        
        let thankYouLbl = UILabel()
        let thankYouAttrTxt = NSMutableAttributedString(string: "Thank You", attributes: [NSAttributedString.Key.font : UIFont.sfProText.bold.ofSize(size: 34), NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.paragraphStyle : paraStyle])
        thankYouAttrTxt.append(NSAttributedString(string: "\nfor your contribution to Mappls", attributes: [NSAttributedString.Key.font : UIFont.sfProText.medium.ofSize(size: .small), NSAttributedString.Key.foregroundColor : UIColor(hex: "#707070")]))
        thankYouLbl.textAlignment = .center
        thankYouLbl.numberOfLines = 0
        thankYouLbl.attributedText = thankYouAttrTxt
        thankYouLbl.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(thankYouLbl)
        
        stackView.setCustomSpacing(35, after: thankYouLbl)
        
        let closeBtn = UIButton()
        closeBtn.setImage(UIImage(named: "clear"), for: .normal)
        closeBtn.contentVerticalAlignment = .fill
        closeBtn.contentHorizontalAlignment = .fill
        closeBtn.addTarget(self, action: #selector(self.closeBtnClicked), for: .touchUpInside)
        closeBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeBtn)
        
        NSLayoutConstraint.activate([
            closeBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            closeBtn.heightAnchor.constraint(equalToConstant: 33),
            closeBtn.widthAnchor.constraint(equalToConstant: 33)
        ])
        
        let mapplsPinBtn = UIButton(type: .system)
        mapplsPinBtn.setTitle("mappls.com/\(mapplsPin.lowercased())", for: .normal)
        mapplsPinBtn.titleLabel?.font = .sfProText.medium.ofSize(size: .small)
        mapplsPinBtn.setImage(UIImage(named: "icon-mappls-pin")?.withRenderingMode(.alwaysOriginal), for: .normal)
        mapplsPinBtn.addTarget(self, action: #selector(self.mapplsPinBtnClicked), for: .touchUpInside)
        mapplsPinBtn.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(mapplsPinBtn)
        
        stackView.setCustomSpacing(18, after: mapplsPinBtn)
        
        let qrCodeImgView = UIImageView(image: UIImage(systemName: "qrcode"))
        qrCodeImgView.contentMode = .scaleAspectFit
        qrCodeImgView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(qrCodeImgView)
        
        stackView.setCustomSpacing(18, after: qrCodeImgView)
        
        NSLayoutConstraint.activate([
            qrCodeImgView.heightAnchor.constraint(equalToConstant: 80),
            qrCodeImgView.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        let mapplsPinAddHeadingLbl = UILabel()
        mapplsPinAddHeadingLbl.text = "Mappls pin for your added place is"
        mapplsPinAddHeadingLbl.font = .sfProText.medium.ofSize(size: .regular)
        mapplsPinAddHeadingLbl.textAlignment = .center
        mapplsPinAddHeadingLbl.textColor = .init(hex: "#707070")
        mapplsPinAddHeadingLbl.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(mapplsPinAddHeadingLbl)

        stackView.setCustomSpacing(35, after: mapplsPinAddHeadingLbl)
        
        let mapplsPinLbl = UILabel()
        mapplsPinLbl.text = mapplsPin.uppercased()
        mapplsPinLbl.textAlignment = .center
        mapplsPinLbl.textColor = .init(hex: "#339E82")
        mapplsPinLbl.font = .sfProDisplay.medium.ofSize(size: 26)
        mapplsPinLbl.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(mapplsPinLbl)
        
        stackView.setCustomSpacing(20, after: mapplsPinLbl)
        
        let shareBtn = CustomButton()
        shareBtn.setImage(UIImage(named: "share"), for: .normal)
        shareBtn.addTarget(self, action: #selector(self.shareBtnClicked), for: .touchUpInside)
        shareBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let lineSeparator = UIView()
        lineSeparator.backgroundColor = .init(hex: "#DDDDDD")
        lineSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lineSeparator.heightAnchor.constraint(equalToConstant: 40),
            lineSeparator.widthAnchor.constraint(equalToConstant: 1)
        ])
        
        let downloadBtn = CustomButton()
        downloadBtn.setImage(UIImage(named: "download"), for: .normal)
        downloadBtn.addTarget(self, action: #selector(self.downloadBtnClicked), for: .touchUpInside)
        downloadBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let downloadShareStackView = UIStackView(arrangedSubviews: [shareBtn, lineSeparator, downloadBtn])
        downloadShareStackView.alignment = .center
        downloadShareStackView.axis = .horizontal
        downloadShareStackView.distribution = .fillProportionally
        downloadShareStackView.layer.borderColor = UIColor(hex: "#DDDDDD").cgColor
        downloadShareStackView.layer.borderWidth = 1
        downloadShareStackView.backgroundColor = .init(hex: "#F3F3F3")
        downloadShareStackView.layer.cornerRadius = 13
        downloadShareStackView.layer.cornerCurve = .circular
        downloadShareStackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(downloadShareStackView)
        
        stackView.setCustomSpacing(20, after: downloadShareStackView)
        
        NSLayoutConstraint.activate([
            downloadShareStackView.leadingAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            downloadShareStackView.trailingAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            downloadShareStackView.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        let spreadAccomplishmentBtn = UIButton(type: .system)
        spreadAccomplishmentBtn.setTitle("Spread The Accomplishment", for: .normal)
        spreadAccomplishmentBtn.titleLabel?.font = .sfProText.semiBold.ofSize(size: .regular)
        spreadAccomplishmentBtn.setTitleColor(.init(hex: "#339E82"), for: .normal)
        spreadAccomplishmentBtn.layer.borderWidth = 1
        spreadAccomplishmentBtn.layer.borderColor = UIColor(hex: "#339E82").cgColor
        spreadAccomplishmentBtn.layer.cornerRadius = 13
        spreadAccomplishmentBtn.layer.cornerCurve = .circular
        spreadAccomplishmentBtn.addTarget(self, action: #selector(self.spreadAccomplishmentBtnClicked), for: .touchUpInside)
        spreadAccomplishmentBtn.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(spreadAccomplishmentBtn)
        
        stackView.setCustomSpacing(30, after: spreadAccomplishmentBtn)
        
        NSLayoutConstraint.activate([
            spreadAccomplishmentBtn.leadingAnchor.constraint(equalTo: downloadShareStackView.leadingAnchor),
            spreadAccomplishmentBtn.trailingAnchor.constraint(equalTo: downloadShareStackView.trailingAnchor),
            spreadAccomplishmentBtn.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        let shareDescriptionLbl = UILabel()
        shareDescriptionLbl.text = "Feel free to share this with your friends & co-workers. Please note this submission will be professionally validate by our map data team"
        shareDescriptionLbl.textColor = .init(hex: "#707070")
        shareDescriptionLbl.font = .sfProText.medium.ofSize(size: .small)
        shareDescriptionLbl.numberOfLines = 0
        shareDescriptionLbl.textAlignment = .center
        shareDescriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(shareDescriptionLbl)
        
        stackView.setCustomSpacing(15, after: shareDescriptionLbl)
        
        NSLayoutConstraint.activate([
            shareDescriptionLbl.leadingAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            shareDescriptionLbl.trailingAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
        
        let learnMoreStackView = UIStackView()
        learnMoreStackView.axis = .horizontal
        learnMoreStackView.distribution = .fillProportionally
        learnMoreStackView.spacing = 5
        learnMoreStackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(learnMoreStackView)
        
        let learnMoreLbl = UILabel()
        learnMoreLbl.text = "Learn more about"
        learnMoreLbl.font = .sfProText.medium.ofSize(size: .small)
        learnMoreLbl.textColor = .init(hex: "#707070")
        learnMoreLbl.translatesAutoresizingMaskIntoConstraints = false
        
        learnMoreStackView.addArrangedSubview(learnMoreLbl)
        
        let learnMoreMapplsPinBtn = UIButton(type: .system)
        learnMoreMapplsPinBtn.setTitle("Mappls Pin", for: .normal)
        learnMoreMapplsPinBtn.titleLabel?.font = .sfProText.medium.ofSize(size: .small)
        learnMoreMapplsPinBtn.setTitleColor(.init(hex: "#007BBE"), for: .normal)
        learnMoreMapplsPinBtn.addTarget(self, action: #selector(self.learnMoreMapplsPinBtnClicked), for: .touchUpInside)
        learnMoreMapplsPinBtn.translatesAutoresizingMaskIntoConstraints = false
        
        learnMoreStackView.addArrangedSubview(learnMoreMapplsPinBtn)
        
        let addAnotherPlaceBtn = UIButton(type: .system)
        addAnotherPlaceBtn.setTitle("Add Another Place", for: .normal)
        addAnotherPlaceBtn.titleLabel?.font = .sfProText.semiBold.ofSize(size: .regular)
        addAnotherPlaceBtn.setTitleColor(.white, for: .normal)
        addAnotherPlaceBtn.backgroundColor = .init(hex: "#339E82")
        addAnotherPlaceBtn.layer.cornerRadius = 13
        addAnotherPlaceBtn.layer.cornerCurve = .circular
        addAnotherPlaceBtn.addTarget(self, action: #selector(self.addAnotherPlaceBtnClicked), for: .touchUpInside)
        addAnotherPlaceBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addAnotherPlaceBtn)
        
        NSLayoutConstraint.activate([
            addAnotherPlaceBtn.topAnchor.constraint(equalTo: containerScrollView.bottomAnchor, constant: 10),
            addAnotherPlaceBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            addAnotherPlaceBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            addAnotherPlaceBtn.heightAnchor.constraint(equalToConstant: 52),
            addAnotherPlaceBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func learnMoreMapplsPinBtnClicked() {
        
    }
    
    @objc func addAnotherPlaceBtnClicked() {
        
    }
    
    @objc func spreadAccomplishmentBtnClicked() {
        
    }
    
    @objc func downloadBtnClicked() {
        
    }
    
    @objc func shareBtnClicked() {
        
    }
    
    @objc func mapplsPinBtnClicked() {
        
    }
    
    @objc func closeBtnClicked() {
        if let sheetViewController = sheetViewController {
            sheetViewController.attemptDismiss(animated: true)
        }else {
            navigationController?.popViewController(animated: true)
        }
    }
}
