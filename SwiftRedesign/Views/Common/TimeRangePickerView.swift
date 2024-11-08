//
//  TimeRangePickerView.swift
//  SwiftRedesign
//
//  Created by rento on 06/11/24.
//

import UIKit

class TimeRangePickerView: UIViewController {
    
    var fromPicker: UIPickerView!
    var toPicker: UIPickerView!
    var containerView: UIView!
    var finishedBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
    
    func setUpUI() {
        view.backgroundColor = .clear
        
        let containerView = UIView()
        containerView.layer.cornerRadius = 12
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        self.containerView = containerView
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        fromPicker = UIPickerView()
        fromPicker.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(fromPicker)
        
        NSLayoutConstraint.activate([
            fromPicker.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            fromPicker.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10)
        ])
        
        let toLbl = UILabel()
        toLbl.text = "to"
        toLbl.font = .systemFont(ofSize: 20, weight: .medium)
        toLbl.textColor = .init(hex: "#77767E")
        toLbl.textAlignment = .center
        toLbl.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(toLbl)
        
        NSLayoutConstraint.activate([
            toLbl.centerYAnchor.constraint(equalTo: fromPicker.safeAreaLayoutGuide.centerYAnchor),
            toLbl.centerXAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.centerXAnchor),
            toLbl.heightAnchor.constraint(equalToConstant: 20),
            toLbl.widthAnchor.constraint(equalToConstant: 20),
            toLbl.leadingAnchor.constraint(equalTo: fromPicker.trailingAnchor, constant: 20)
        ])
        
        toPicker = UIPickerView()
        toPicker.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(toPicker)
        
        NSLayoutConstraint.activate([
            toPicker.topAnchor.constraint(equalTo: fromPicker.topAnchor),
            toPicker.leadingAnchor.constraint(equalTo: toLbl.trailingAnchor, constant: 20),
            toPicker.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            toPicker.bottomAnchor.constraint(equalTo: fromPicker.bottomAnchor)
        ])
        
        let lineView = UIView()
        lineView.backgroundColor = .init(hex: "#E6E4EA")
        lineView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(lineView)
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: fromPicker.bottomAnchor, constant: 10),
            lineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        let finishedBtn = UIButton(type: .system)
        finishedBtn.setTitle("Finished", for: .normal)
        finishedBtn.setTitleColor(.init(hex: "#007BBE"), for: .normal)
        finishedBtn.titleLabel?.font = .systemFont(ofSize: 22, weight: .regular)
        finishedBtn.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(finishedBtn)
        
        self.finishedBtn = finishedBtn
        
        NSLayoutConstraint.activate([
            finishedBtn.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            finishedBtn.leadingAnchor.constraint(equalTo: lineView.leadingAnchor),
            finishedBtn.trailingAnchor.constraint(equalTo: lineView.trailingAnchor),
            finishedBtn.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            finishedBtn.heightAnchor.constraint(equalToConstant: 58)
        ])
        
        let cancelBtn = UIButton(type: .system)
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.backgroundColor = .white
        cancelBtn.setTitleColor(.init(hex: "#007BBE"), for: .normal)
        cancelBtn.titleLabel?.font = .systemFont(ofSize: 22, weight: .regular)
        cancelBtn.addTarget(self, action: #selector(self.cancelBtnClicked), for: .touchUpInside)
        cancelBtn.layer.cornerRadius = 13
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cancelBtn)
        
        NSLayoutConstraint.activate([
            cancelBtn.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 8),
            cancelBtn.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            cancelBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            cancelBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            cancelBtn.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
    
    @objc func cancelBtnClicked() {
        if let sheetViewController = sheetViewController {
            sheetViewController.attemptDismiss(animated: true)
            return
        }else if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }else {
            dismiss(animated: true)
        }
    }
}
