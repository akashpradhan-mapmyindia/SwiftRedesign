//
//  UIViewController+Extension.swift
//  SwiftRedesign
//
//  Created by rento on 03/12/24.
//

import UIKit

extension UIViewController {
    func customDismiss(animated: Bool) {
        if let sheetViewController = sheetViewController {
            sheetViewController.attemptDismiss(animated: animated)
        }else if let navigationController = navigationController {
            navigationController.popViewController(animated: animated)
        }else {
            dismiss(animated: animated)
        }
    }
}
