//
//  ChooseOnMapViewController.swift
//  SwiftRedesign
//
//  Created by rento on 24/10/24.
//

import UIKit

enum ChooseOnMapScreenType {
    case selectAddressType
    case selectAddressOnMap
}

class ChooseOnMapViewController: UIViewController {
    
    var addresTypeView: ChooseOnMapAddressTypeView?
    var screenType: ChooseOnMapScreenType?
    var addressOnMapView: ChooseOnMapSelectAddressView?
    
    convenience init(screenType: ChooseOnMapScreenType) {
        self.init()
        self.screenType = screenType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        setUpUI(for: screenType ?? .selectAddressType)
    }
    
    func setUpUI(for screenType: ChooseOnMapScreenType) {
        if screenType == .selectAddressType {
            let addresTypeView = ChooseOnMapAddressTypeView()
            addresTypeView.addressLbl.text = "Number 3, G-1, Swayamprabha Complex, opp. Ashok Nagar Road, Ashok Kunj, Ashok Nagar, Ranchi, Jharkhand 834002, India"
            addresTypeView.nextBtn.addTarget(self, action: #selector(self.nextBtnClicked), for: .touchUpInside)
            addresTypeView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(addresTypeView)
            
            self.addresTypeView = addresTypeView
            
            NSLayoutConstraint.activate([
                addresTypeView.topAnchor.constraint(equalTo: view.topAnchor),
                addresTypeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                addresTypeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                addresTypeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }else{
            let selectAddressView = ChooseOnMapSelectAddressView()
            selectAddressView.addressLbl.text = "GF-13th Floor, American Plaza, Near Eros Corporate Tower, Nehru Place, New Delhi, Delhi, 110019"
            selectAddressView.isHidden = false
            selectAddressView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(selectAddressView)
            
            self.addressOnMapView = selectAddressView
            
            NSLayoutConstraint.activate([
                selectAddressView.topAnchor.constraint(equalTo: view.topAnchor),
                selectAddressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                selectAddressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                selectAddressView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
    
    @objc func nextBtnClicked() {
        let vc = AddAPlaceViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
