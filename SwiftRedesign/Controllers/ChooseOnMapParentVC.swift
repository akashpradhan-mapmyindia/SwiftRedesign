//
//  ChooseOnMapParentVC.swift
//  SwiftRedesign
//
//  Created by rento on 29/10/24.
//

import UIKit
import FittedSheets

protocol ChooseOnMapParentViewControllerDelegate: AnyObject {
    func addressSelected(with location: String)
}

class ChooseOnMapParentVC: UIViewController {
    
    weak var delegate: ChooseOnMapParentViewControllerDelegate?
    
    var topBar: UIView!
    var chooseOnMapSheet: SheetViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
    
    func setUpUI() {
        view.backgroundColor = .white
        
        topBar = UIView()
        topBar.layer.shadowRadius = 1
        topBar.layer.shadowColor = UIColor(hex: "#0000004D").cgColor
        topBar.layer.shadowOpacity = 0.7
        topBar.layer.shadowOffset = .zero
        topBar.backgroundColor = .white
        topBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBar)
        
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let titleLbl = UILabel()
        titleLbl.text = "Choose On Map"
        titleLbl.font = .sfProText.semiBold.ofSize(size: .medium)
        titleLbl.textAlignment = .center
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        topBar.addSubview(titleLbl)
        
        NSLayoutConstraint.activate([
            titleLbl.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            titleLbl.centerXAnchor.constraint(equalTo: topBar.centerXAnchor)
        ])
        
        let backBtn = UIButton()
        backBtn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backBtn.addTarget(self, action: #selector(self.backBtnClicked), for: .touchUpInside)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        topBar.addSubview(backBtn)
        
        NSLayoutConstraint.activate([
            backBtn.leadingAnchor.constraint(equalTo: topBar.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            backBtn.heightAnchor.constraint(equalToConstant: 40),
            backBtn.widthAnchor.constraint(equalToConstant: 40),
            backBtn.centerYAnchor.constraint(equalTo: topBar.centerYAnchor)
        ])
        
        let searchBtn = UIButton()
        searchBtn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchBtn.addTarget(self, action: #selector(self.searchBtnClicked), for: .touchUpInside)
        searchBtn.translatesAutoresizingMaskIntoConstraints = false
        topBar.addSubview(searchBtn)
        
        NSLayoutConstraint.activate([
            searchBtn.trailingAnchor.constraint(equalTo: topBar.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            searchBtn.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            searchBtn.heightAnchor.constraint(equalToConstant: 40),
            searchBtn.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        openChooseOnMapSheet()
    }
    
    override func viewDidLayoutSubviews() {
        let shadowSize: CGFloat = 20
        let contactRect = CGRect(x: -shadowSize, y: topBar.frame.height - (shadowSize * 0.4), width: topBar.frame.width + shadowSize * 2, height: 10)
        topBar.layer.shadowPath = UIBezierPath(rect: contactRect).cgPath
    }
    
    func openChooseOnMapSheet() {
        var sheetOptions = SheetOptions()
        sheetOptions.useInlineMode = true
        sheetOptions.pullBarHeight = 30
        sheetOptions.transitionAnimationOptions = .curveLinear
        
        let vc = ChooseOnMapViewController(screenType: .selectAddressOnMap)
        
        let sheet = SheetViewController(controller: vc, options: sheetOptions)
        sheet.cornerRadius = 15.0
        sheet.gripColor = .init(hex: "#DDDDDD")
        sheet.allowPullingPastMaxHeight = false
        sheet.allowPullingPastMinHeight = false
        sheet.dismissOnPull = false
        sheet.dismissOnOverlayTap = false
        sheet.overlayColor = UIColor.clear
        sheet.pullBarBackgroundColor = .clear
        sheet.allowGestureThroughOverlay = true
        
        sheet.animateIn(to: view, in: self)
        
        vc.addressOnMapView?.doneBtn.addTarget(self, action: #selector(self.addressSelected), for: .touchUpInside)
        
        chooseOnMapSheet = sheet
        
        setSheetSize()
    }
    
    @objc func addressSelected() {
        navigationController?.popViewController(animated: true)
        delegate?.addressSelected(with: "")
    }
    
    func setSheetSize() {
        chooseOnMapSheet.sizes = [.intrinsic]
        DispatchQueue.main.async {
            self.chooseOnMapSheet.resize(to: .intrinsic)
        }
    }
    
    @objc func searchBtnClicked() {
        
    }
    
    @objc func backBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
}
