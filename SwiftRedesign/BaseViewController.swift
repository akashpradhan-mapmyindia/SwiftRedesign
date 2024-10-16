//
//  BaseViewController.swift
//  SwiftRedesign
//
//  Created by rento on 14/10/24.
//

import UIKit
import FittedSheets

class BaseViewController: UIViewController {
    var sheet: SheetViewController?
    var myLayersButton: UIButton!
    var gadgetsViewBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
    
    func setUpUI() {
        view.backgroundColor = .blue
        
        myLayersButton = UIButton(type: .system)
        myLayersButton.setTitle("Layer", for: .normal)
        myLayersButton.backgroundColor = .green
        myLayersButton.addTarget(self, action: #selector(self.setUpMyLayersUI), for: .touchUpInside)
        view.addSubview(myLayersButton)
        myLayersButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myLayersButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            myLayersButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            myLayersButton.heightAnchor.constraint(equalToConstant: 40),
            myLayersButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        gadgetsViewBtn = UIButton(type: .system)
        gadgetsViewBtn.setTitle("Gadgets", for: .normal)
        gadgetsViewBtn.backgroundColor = .green
        gadgetsViewBtn.addTarget(self, action: #selector(self.setUpGadgetsUI), for: .touchUpInside)
        view.addSubview(gadgetsViewBtn)
        gadgetsViewBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gadgetsViewBtn.topAnchor.constraint(equalTo: myLayersButton.bottomAnchor, constant: 10),
            gadgetsViewBtn.trailingAnchor.constraint(equalTo: myLayersButton.trailingAnchor),
            gadgetsViewBtn.heightAnchor.constraint(equalToConstant: 40),
            gadgetsViewBtn.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func setUpMyLayersUI() {
        var sheetOptions = SheetOptions()
        sheetOptions.pullBarHeight = 0
        sheetOptions.transitionAnimationOptions = .curveLinear
        sheetOptions.useInlineMode = true
        
        let layersVC = MyLayersVC()
        layersVC.delegate = self
        sheet = showSheetController(options: sheetOptions, controller: layersVC, sheetSizes: [.fullscreen], from: self, in: nil)
        sheet?.cornerRadius = 0
        sheet?.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func setUpGadgetsUI() {
        
        var sheetOptions = SheetOptions()
        sheetOptions.pullBarHeight = 10
        sheetOptions.useInlineMode = true
        sheetOptions.transitionAnimationOptions = .curveLinear
        
        sheet = showSheetController(options: sheetOptions, controller: MyGadgetsVC(), sheetSizes: [], from: self, in: view)

        if self.traitCollection.verticalSizeClass == .regular {
            sheet?.sizes = [.percent(0.05), .percent(0.25), .percent(0.9)]
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
                } else if self.sheet?.currentSize == .percent(0.05) || self.sheet?.currentSize == .percent(0.25) {
                    self.sheet?.resize(to: .percent(0.16))
                } else {
                    self.sheet?.resize(to: .percent(0.16))
                }
            }
        }
    }
    
    func showSheetController(options: SheetOptions, controller: UIViewController, sheetSizes: [SheetSize], from parent: UIViewController, in view: UIView?) -> SheetViewController {
        let sheet = SheetViewController(controller: controller, sizes: sheetSizes, options: options)
        sheet.cornerRadius = 15.0
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension BaseViewController: MyLayersVCDelegate {
    func dismissSheet() {
        sheet?.dismiss(animated: true)
    }
}
