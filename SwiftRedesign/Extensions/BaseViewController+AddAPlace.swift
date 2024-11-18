//
//  BaseViewController+AddAPlace.swift
//  SwiftRedesign
//
//  Created by rento on 24/10/24.
//

import UIKit
import FittedSheets

extension BaseViewController {
    @objc func addPlaceBtnClicked() {
       showAddAPlaceView()
    }
    
    func showAddAPlaceView() {
        addAPlaceTopView?.isHidden = false
        
        var sheetOptions = SheetOptions()
        sheetOptions.transitionAnimationOptions = .curveLinear
        sheetOptions.pullBarHeight = 30
        sheetOptions.useInlineMode = true
        
        let vc = ChooseOnMapViewController()
        sheet = showSheetController(options: sheetOptions, controller: vc, sheetSizes: [], from: self, in: view)
        chooseOnMapSetSheetSize()
    }
    
    func hideAddAPlaceView() {
        addAPlaceTopView?.isHidden = true
        sheet?.attemptDismiss(animated: true)
    }
    
    func setAddAPlaceTopView() {
        if addAPlaceTopView != nil {
            return
        }
        let topView = UIView()
        topView.backgroundColor = .white
        topView.isHidden = true
        view.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        self.addAPlaceTopView = topView
        
        addAPlacePortraitCons.append( topView.heightAnchor.constraint(equalToConstant: 55 + viewInsetTop))
        addAPlaceLandspaceCons.append(topView.heightAnchor.constraint(equalToConstant: 50))
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        let titleLbl = UILabel()
        titleLbl.text = "Choose on map"
        titleLbl.font = .sfProText.semiBold.ofSize(size: .medium)
        topView.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLbl.centerYAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.centerYAnchor),
            titleLbl.centerXAnchor.constraint(equalTo: topView.centerXAnchor)
        ])
        
        let backBtn = CustomButton()
        backBtn.setImage(UIImage(named: "back")!, for: .normal)
        backBtn.addTarget(self, action: #selector(self.addAPlaceBackBtnClicked), for: .touchUpInside)
        topView.addSubview(backBtn)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backBtn.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor),
            backBtn.leadingAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            backBtn.heightAnchor.constraint(equalToConstant: 40),
            backBtn.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        let searchBtn = CustomButton()
        searchBtn.setImage(UIImage(named: "search"), for: .normal)
        searchBtn.addTarget(self, action: #selector(self.addAPlaceSearchBtnClicked), for: .touchUpInside)
        topView.addSubview(searchBtn)
        searchBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBtn.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor),
            searchBtn.trailingAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            searchBtn.heightAnchor.constraint(equalToConstant: 40),
            searchBtn.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        if traitCollection.verticalSizeClass == .regular {
            NSLayoutConstraint.activate(addAPlacePortraitCons)
        }else{
            NSLayoutConstraint.activate(addAPlaceLandspaceCons)
        }
    }
    
    @objc func nextBtnOpenAddaPlaceVC() {
        let vc = AddAPlaceViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func addAPlaceSearchBtnClicked() {
        
    }
    
    @objc func addAPlaceBackBtnClicked() {
        hideAddAPlaceView()
    }
    
    func setAddAPlaceUI() {
        setAddAPlaceTopView()
    }
    
    func chooseOnMapSetSheetSize() {
        sheet?.sizes = [.intrinsic]
        DispatchQueue.main.async {
            self.sheet?.resize(to: .intrinsic)
        }
    }
}
