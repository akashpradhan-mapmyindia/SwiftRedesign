//
//  BaseViewController.swift
//  SwiftRedesign
//
//  Created by rento on 14/10/24.
//

import UIKit
import FittedSheets
import SwiftUI

class BaseViewController: UIViewController {
    var sheet: SheetViewController?
    var myLayersButton: UIButton!
    var gadgetsViewBtn: UIButton!
    var evFilterBtn: UIButton!
    var gadgetsHeaderV: UIView?
    var gadgetsViewSegmentControl: UISegmentedControl?
    var gadgetsHeaderVPortraitCons: [NSLayoutConstraint] = []
    var gadgetsHeaderVLandscapeCons: [NSLayoutConstraint] = []
    var gadgetsStatusCollectionView: UICollectionView?
    var gadgetsSearchBtn: UIButton?
    var gadgetsFilterBtn: UIButton?
    var newGadgetView: NewGadgetView?
    var gadgetsStatusNextBtn: UIButton?
    var addPlaceBtn: UIButton?
    var addAPlaceTopView: UIView?
    var addAPlacePortraitCons: [NSLayoutConstraint] = []
    var addAPlaceLandspaceCons: [NSLayoutConstraint] = []
    var viewInsetTop: CGFloat!
    var addAPlaceLocTypeSegCtrl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
    
    func setUpUI() {
        view.backgroundColor = .blue
        navigationController?.isNavigationBarHidden = true

        let myLayersButton = UIButton(type: .system)
        myLayersButton.setTitle("Layer", for: .normal)
        myLayersButton.backgroundColor = .green
        myLayersButton.addTarget(self, action: #selector(self.setUpMyLayersUI), for: .touchUpInside)
        view.addSubview(myLayersButton)
        myLayersButton.translatesAutoresizingMaskIntoConstraints = false
        self.myLayersButton = myLayersButton
        
        NSLayoutConstraint.activate([
            myLayersButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            myLayersButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            myLayersButton.heightAnchor.constraint(equalToConstant: 40),
            myLayersButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        let gadgetsViewBtn = UIButton(type: .system)
        gadgetsViewBtn.setTitle("Gadgets", for: .normal)
        gadgetsViewBtn.backgroundColor = .green
        gadgetsViewBtn.addTarget(self, action: #selector(self.setUpGadgetsUI), for: .touchUpInside)
        view.addSubview(gadgetsViewBtn)
        gadgetsViewBtn.translatesAutoresizingMaskIntoConstraints = false
        self.gadgetsViewBtn = gadgetsViewBtn
        
        NSLayoutConstraint.activate([
            gadgetsViewBtn.topAnchor.constraint(equalTo: myLayersButton.bottomAnchor, constant: 10),
            gadgetsViewBtn.trailingAnchor.constraint(equalTo: myLayersButton.trailingAnchor),
            gadgetsViewBtn.heightAnchor.constraint(equalToConstant: 40),
            gadgetsViewBtn.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        let evFilterBtn = UIButton(type: .system)
        evFilterBtn.addTarget(self, action: #selector(self.evFilterBtnClicked(_:)), for: .touchUpInside)
        evFilterBtn.setTitle("EV Filter", for: .normal)
        evFilterBtn.backgroundColor = .green
        evFilterBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(evFilterBtn)
        self.evFilterBtn = evFilterBtn
        
        NSLayoutConstraint.activate([
            evFilterBtn.topAnchor.constraint(equalTo: gadgetsViewBtn.bottomAnchor, constant: 10),
            evFilterBtn.trailingAnchor.constraint(equalTo: myLayersButton.trailingAnchor),
            evFilterBtn.widthAnchor.constraint(equalToConstant: 60),
            evFilterBtn.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        let addPlaceBtn = UIButton(type: .system)
        addPlaceBtn.setTitle("Add a Place", for: .normal)
        addPlaceBtn.backgroundColor = .green
        addPlaceBtn.addTarget(self, action: #selector(self.addPlaceBtnClicked), for: .touchUpInside)
        view.addSubview(addPlaceBtn)
        addPlaceBtn.translatesAutoresizingMaskIntoConstraints = false
        self.addPlaceBtn = addPlaceBtn
        
        NSLayoutConstraint.activate([
            addPlaceBtn.topAnchor.constraint(equalTo: evFilterBtn.bottomAnchor, constant: 10),
            addPlaceBtn.trailingAnchor.constraint(equalTo: myLayersButton.trailingAnchor),
            addPlaceBtn.widthAnchor.constraint(equalToConstant: 100),
            addPlaceBtn.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        let quickAccessSheetBtn = UIButton(type: .system)
        quickAccessSheetBtn.setTitle("Open Quick Access Sheet", for: .normal)
        quickAccessSheetBtn.backgroundColor = .green
        quickAccessSheetBtn.addTarget(self, action: #selector(self.showQuickAccessSheet), for: .touchUpInside)
        quickAccessSheetBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quickAccessSheetBtn)
        
        NSLayoutConstraint.activate([
            quickAccessSheetBtn.topAnchor.constraint(equalTo: addPlaceBtn.bottomAnchor, constant: 10),
            quickAccessSheetBtn.trailingAnchor.constraint(equalTo: evFilterBtn.trailingAnchor),
            quickAccessSheetBtn.heightAnchor.constraint(equalToConstant: 40),
            quickAccessSheetBtn.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func showQuickAccessSheet() {
        var sheetOptions = SheetOptions()
        sheetOptions.transitionAnimationOptions = .curveLinear
        sheetOptions.useInlineMode = true
        
        let view = QuickAccessView(postOnMapBtnAction: quickAccessPostOnMapBtnClicked, fixOnMapBtnAction: quickAccessFixMapBtnClicked)
        
        let hostingView = UIHostingController(rootView: view)
        if #available(iOS 16.0, *) {
            hostingView.sizingOptions = .preferredContentSize
        }
        sheet = showSheetController(options: sheetOptions, controller: hostingView, sheetSizes: [], from: self, in: self.view)
        sheet?.navigationController?.isNavigationBarHidden = true
        setDefaultSheetSize()
    }
    
    func setDefaultSheetSize() {
        if self.traitCollection.verticalSizeClass == .regular {
            sheet?.sizes = [.percent(0.25), .percent(0.9)]
            DispatchQueue.main.async {
                if self.sheet?.currentSize == .percent(1.0) {
                    self.sheet?.resize(to: .percent(0.9))
                } else if self.sheet?.currentSize == .percent(0.16){
                    self.sheet?.resize(to: .percent(0.25))
                } else {
                    self.sheet?.resize(to: .percent(0.25))
                }
            }
        }else{
            sheet?.sizes = [.percent(0.16), .percent(1.0)]
            DispatchQueue.main.async {
                if self.sheet?.currentSize == .percent(0.9) {
                    self.sheet?.resize(to: .percent(1.0))
                } else if self.sheet?.currentSize == .percent(0.25) {
                    self.sheet?.resize(to: .percent(0.16))
                } else {
                    self.sheet?.resize(to: .percent(0.16))
                }
            }
        }
    }
    
    @objc func evFilterBtnClicked(_ sender: UIButton) {
        self.navigationController?.pushViewController(EVFilterViewController(), animated: true)
    }
    
    @objc func setUpMyLayersUI() {
        let layersVC = MyLayersVC()
        self.navigationController?.pushViewController(layersVC, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewInsetTop = traitCollection.verticalSizeClass == .regular ? view.safeAreaInsets.top : max(max(view.safeAreaInsets.left, view.safeAreaInsets.right), 20)
        setUpGadgetsTopUI()
        setAddAPlaceUI()
    }
    
    func showSheetController(options: SheetOptions, controller: UIViewController, sheetSizes: [SheetSize], from parent: UIViewController, in view: UIView?) -> SheetViewController {
        sheet?.attemptDismiss(animated: true)
        let sheet = SheetViewController(controller: controller, sizes: sheetSizes, options: options)
        sheet.cornerRadius = 15.0
        sheet.gripColor = .init(hex: "#DDDDDD")
        sheet.allowPullingPastMaxHeight = false
        sheet.allowPullingPastMinHeight = false
        sheet.dismissOnPull = false
        sheet.dismissOnOverlayTap = false
        sheet.overlayColor = UIColor.clear
        sheet.pullBarBackgroundColor = .clear
        sheet.allowGestureThroughOverlay = true
        if let view = view {
            sheet.animateIn(to: view, in: parent)
        } else {
            parent.present(sheet, animated: true, completion: nil)
        }
        return sheet
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if let sheet = sheet {
            if let _ = sheet.childViewController as? MyGadgetsVC {
                gadgetsSetSheetSize()
            }else if let _ = sheet.childViewController as? ChooseOnMapViewController {
                chooseOnMapSetSheetSize()
            }else {
                setDefaultSheetSize()
            }
        }
        if self.traitCollection.verticalSizeClass == .regular {
            NSLayoutConstraint.deactivate(gadgetsHeaderVLandscapeCons + addAPlaceLandspaceCons)
            NSLayoutConstraint.activate(gadgetsHeaderVPortraitCons + addAPlacePortraitCons)
        }else {
            NSLayoutConstraint.deactivate(gadgetsHeaderVPortraitCons + addAPlacePortraitCons)
            NSLayoutConstraint.activate(gadgetsHeaderVLandscapeCons + addAPlaceLandspaceCons)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

