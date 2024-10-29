//
//  ChooseOnMapViewController.swift
//  SwiftRedesign
//
//  Created by rento on 24/10/24.
//

import UIKit

class ChooseOnMapViewController: UIViewController {
    
    var addAPlaceLocTypeSegCtrl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
    
    func setUpUI() {
        let segmentCtrl = UISegmentedControl()
        segmentCtrl.insertSegment(withTitle: "Residential", at: 0, animated: false)
        segmentCtrl.insertSegment(withTitle: "Business", at: 1, animated: false)
        segmentCtrl.selectedSegmentTintColor = .init(hex: "#339E82")
        segmentCtrl.backgroundColor = .white
        segmentCtrl.selectedSegmentIndex = 0
        segmentCtrl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        segmentCtrl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        segmentCtrl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentCtrl)
        self.addAPlaceLocTypeSegCtrl = segmentCtrl
        
        NSLayoutConstraint.activate([
            segmentCtrl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentCtrl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            segmentCtrl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            segmentCtrl.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        let addressLbl = UILabel()
        addressLbl.text = "Number 3, G-1, Swayamprabha Complex, opp. Ashok Nagar Road, Ashok Kunj, Ashok Nagar, Ranchi, Jharkhand 834002, India"
        addressLbl.font = .systemFont(ofSize: 16, weight: .regular)
        addressLbl.numberOfLines = 0
        addressLbl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addressLbl)
        
        NSLayoutConstraint.activate([
            addressLbl.topAnchor.constraint(equalTo: segmentCtrl.bottomAnchor, constant: 20),
            addressLbl.leadingAnchor.constraint(equalTo: segmentCtrl.leadingAnchor),
            addressLbl.trailingAnchor.constraint(equalTo: segmentCtrl.trailingAnchor),
            addressLbl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
        
        let nextBtn = UIButton(type: .system)
        nextBtn.setTitle("Next", for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        nextBtn.addTarget(self, action: #selector(self.nextBtnClicked), for: .touchUpInside)
        nextBtn.backgroundColor = .init(hex: "#339E82")
        nextBtn.layer.cornerRadius = 10
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextBtn)
        
        NSLayoutConstraint.activate([
            nextBtn.topAnchor.constraint(equalTo: addressLbl.bottomAnchor, constant: 20),
            nextBtn.leadingAnchor.constraint(equalTo: addressLbl.leadingAnchor),
            nextBtn.trailingAnchor.constraint(equalTo: addressLbl.trailingAnchor),
            nextBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func nextBtnClicked() {
        let vc = AddAPlaceViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
