//
//  ChooseOnMapSelectAddressView.swift
//  SwiftRedesign
//
//  Created by rento on 29/10/24.
//

import UIKit

class ChooseOnMapSelectAddressView: UIView {
    
    var addressLbl: UILabel!
    var moreMarkerDescLbl: UILabel!
    var doneBtn: UIButton!
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        let addressLbl = UILabel()
        addressLbl.font = .systemFont(ofSize: 19, weight: .semibold)
        addressLbl.numberOfLines = 0
        addressLbl.textAlignment = .left
        addressLbl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addressLbl)
        
        self.addressLbl = addressLbl
        
        NSLayoutConstraint.activate([
            addressLbl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            addressLbl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            addressLbl.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
        
        let moveMarkerDescLbl = UILabel()
        moveMarkerDescLbl.text = "Move the map/marker to point the exact location of the place on map"
        moveMarkerDescLbl.numberOfLines = 0
        moveMarkerDescLbl.font = .systemFont(ofSize: 15, weight: .regular)
        moveMarkerDescLbl.textAlignment = .left
        moveMarkerDescLbl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(moveMarkerDescLbl)
        
        self.moreMarkerDescLbl = moveMarkerDescLbl
        
        NSLayoutConstraint.activate([
            moveMarkerDescLbl.topAnchor.constraint(equalTo: addressLbl.bottomAnchor, constant: 10),
            moveMarkerDescLbl.leadingAnchor.constraint(equalTo: addressLbl.leadingAnchor),
            moveMarkerDescLbl.trailingAnchor.constraint(equalTo: addressLbl.trailingAnchor)
        ])
        
        let doneBtn = UIButton(type: .system)
        doneBtn.setTitle("Done", for: .normal)
        doneBtn.layer.cornerRadius = 10
        doneBtn.backgroundColor = .init(hex: "#339E82")
        doneBtn.setTitleColor(.white, for: .normal)
        doneBtn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(doneBtn)
        
        self.doneBtn = doneBtn
        
        NSLayoutConstraint.activate([
            doneBtn.topAnchor.constraint(equalTo: moveMarkerDescLbl.bottomAnchor, constant: 20),
            doneBtn.leadingAnchor.constraint(equalTo: addressLbl.leadingAnchor),
            doneBtn.trailingAnchor.constraint(equalTo: addressLbl.trailingAnchor),
            doneBtn.heightAnchor.constraint(equalToConstant: 50),
            doneBtn.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }
}
