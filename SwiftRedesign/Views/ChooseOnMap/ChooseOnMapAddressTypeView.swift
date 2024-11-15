//
//  ChooseOnMapAddressTypeView.swift
//  SwiftRedesign
//
//  Created by rento on 29/10/24.
//

import UIKit

class ChooseOnMapAddressTypeView: UIView {
    
    var addAPlaceLocTypeSegCtrl: UISegmentedControl!
    var addressLbl: UILabel!
    var nextBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    convenience init() {
        self.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        let segmentCtrl = UISegmentedControl()
        segmentCtrl.insertSegment(withTitle: "Residential", at: 0, animated: false)
        segmentCtrl.insertSegment(withTitle: "Business", at: 1, animated: false)
        segmentCtrl.selectedSegmentTintColor = .init(hex: "#339E82")
        segmentCtrl.backgroundColor = .white
        segmentCtrl.selectedSegmentIndex = 0
        segmentCtrl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.sfProText.medium.ofSize(size: .small)], for: .normal)
        segmentCtrl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.sfProText.medium.ofSize(size: .small)], for: .selected)
        segmentCtrl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(segmentCtrl)
        self.addAPlaceLocTypeSegCtrl = segmentCtrl
        
        NSLayoutConstraint.activate([
            segmentCtrl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentCtrl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            segmentCtrl.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            segmentCtrl.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        let addressLbl = UILabel()
        addressLbl.font = .sfProText.medium.ofSize(size: .small)
        addressLbl.textColor = .init(hex: "#707070")
        addressLbl.numberOfLines = 0
        addressLbl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addressLbl)
        
        self.addressLbl = addressLbl
        
        NSLayoutConstraint.activate([
            addressLbl.topAnchor.constraint(equalTo: segmentCtrl.bottomAnchor, constant: 20),
            addressLbl.leadingAnchor.constraint(equalTo: segmentCtrl.leadingAnchor),
            addressLbl.trailingAnchor.constraint(equalTo: segmentCtrl.trailingAnchor),
            addressLbl.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
        
        let nextBtn = UIButton(type: .system)
        nextBtn.setTitle("Next", for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.titleLabel?.font = .sfProText.semiBold.ofSize(size: .regular)
        nextBtn.backgroundColor = .init(hex: "#339E82")
        nextBtn.layer.cornerRadius = 10
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nextBtn)
        
        self.nextBtn = nextBtn
        
        NSLayoutConstraint.activate([
            nextBtn.topAnchor.constraint(equalTo: addressLbl.bottomAnchor, constant: 20),
            nextBtn.leadingAnchor.constraint(equalTo: addressLbl.leadingAnchor),
            nextBtn.trailingAnchor.constraint(equalTo: addressLbl.trailingAnchor),
            nextBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
