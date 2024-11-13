//
//  BaseViewController+PostOnMap+FixOnMap.swift
//  SwiftRedesign
//
//  Created by rento on 12/11/24.
//

import UIKit
import SwiftUI
import FittedSheets

extension BaseViewController {
    
    struct QuickAccessView: View {
        
        let postOnMapBtnAction: () -> Void?
        let fixOnMapBtnAction: () -> Void?
        
        var body: some View {
            HStack {
                Button("Post on Map") {
                    postOnMapBtnAction()
                }
                .padding(.all)
                
                Button("Fix map") {
                    fixOnMapBtnAction()
                }
            }
        }
    }
    
    func quickAccessFixMapBtnClicked() {
        var sheetOptions = SheetOptions()
        sheetOptions.useInlineMode = true
        sheetOptions.pullBarHeight = 0
        sheetOptions.transitionAnimationOptions = .curveLinear
        
        let vc = FixOnMapCategoryViewController()
        let navVC = UINavigationController(rootViewController: vc)
        sheet = showSheetController(options: sheetOptions, controller: navVC, sheetSizes: [], from: self, in: view)
        sheet?.handleScrollView(vc.categoryCollectionView)
        setDefaultSheetSize()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reportSuccessfullClicked), name: NotificationCenterConstants.reportSuccessful, object: nil)
    }
    
    @objc func reportSuccessfullClicked() {
        NotificationCenter.default.removeObserver(self, name: NotificationCenterConstants.reportSuccessful, object: nil)
        
        let vc = PostReportSuccessfulViewController(isForPost: false)
        var sheetOptions = SheetOptions()
        sheetOptions.useInlineMode = true
        sheetOptions.pullBarHeight = 0
        sheetOptions.transitionAnimationOptions = .curveLinear
        sheetOptions.useFullScreenMode = true
        
        let sheet = showSheetController(options: sheetOptions, controller: vc, sheetSizes: [.fullscreen], from: self, in: view)
        sheet.contentBackgroundColor = .clear
    }
    
    func quickAccessPostOnMapBtnClicked() {
        var sheetOptions = SheetOptions()
        sheetOptions.useInlineMode = true
        sheetOptions.pullBarHeight = 0
        sheetOptions.transitionAnimationOptions = .curveLinear
        
        let vc = PostOnMapCategoryViewController()
        let navVC = UINavigationController(rootViewController: vc)
        sheet = showSheetController(options: sheetOptions, controller: navVC, sheetSizes: [], from: self, in: view)
        sheet?.handleScrollView(vc.categoryCollectionView)
        setDefaultSheetSize()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.postSuccessfullClicked(_:)), name: NotificationCenterConstants.postSuccessfull, object: nil)
    }
    
    @objc func postSuccessfullClicked(_ notification: NSNotification) {
        NotificationCenter.default.removeObserver(self, name: NotificationCenterConstants.postSuccessfull, object: nil)
        
        let vc = PostReportSuccessfulViewController(isForPost: true)
        var sheetOptions = SheetOptions()
        sheetOptions.useInlineMode = true
        sheetOptions.pullBarHeight = 0
        sheetOptions.transitionAnimationOptions = .curveLinear
        sheetOptions.useFullScreenMode = true
        
        let sheet = showSheetController(options: sheetOptions, controller: vc, sheetSizes: [.fullscreen], from: self, in: view)
        sheet.contentBackgroundColor = .clear
    }
}
