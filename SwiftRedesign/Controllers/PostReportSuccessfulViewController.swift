//
//  PostReportSuccessfulViewController.swift
//  SwiftRedesign
//
//  Created by rento on 12/11/24.
//

import UIKit

class PostReportSuccessfulViewController: UIViewController {
    
    var containerView: UIView!
    var containerVPortCons: [NSLayoutConstraint] = []
    var containerVLandsCons: [NSLayoutConstraint] = []
    var isForPost: Bool
    
    init(isForPost: Bool) {
        self.isForPost = isForPost
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
    
    func setUpUI() {
        view.backgroundColor = .init(hex: "#00000066")
        
        containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        containerVPortCons.append(contentsOf: [            containerView.heightAnchor.constraint(equalToConstant: 500), containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15), containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15)])
        
        containerVLandsCons.append(contentsOf: [            containerView.heightAnchor.constraint(equalToConstant: 300), containerView.widthAnchor.constraint(equalToConstant: 400)])
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        let cancelBtn = UIButton()
        cancelBtn.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(self.cancelBtnClicked), for: .touchUpInside)
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(cancelBtn)
        
        NSLayoutConstraint.activate([
            cancelBtn.heightAnchor.constraint(equalToConstant: 22),
            cancelBtn.widthAnchor.constraint(equalToConstant: 22),
            cancelBtn.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            cancelBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15)
        ])
        
        let checkMarkImgV = UIImageView(image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate))
        checkMarkImgV.tintColor = .white
        checkMarkImgV.layer.cornerRadius = 45
        checkMarkImgV.contentMode = .scaleAspectFit
        checkMarkImgV.backgroundColor = .green
        checkMarkImgV.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(checkMarkImgV)
        
        containerVPortCons.append(            checkMarkImgV.topAnchor.constraint(lessThanOrEqualTo: containerView.topAnchor, constant: 60))
        
        containerVLandsCons.append(            checkMarkImgV.topAnchor.constraint(lessThanOrEqualTo: containerView.topAnchor, constant: 20))
        
        NSLayoutConstraint.activate([
            checkMarkImgV.heightAnchor.constraint(equalToConstant: 90),
            checkMarkImgV.widthAnchor.constraint(equalToConstant: 90),
            checkMarkImgV.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        let successfulLbl = UILabel()
        successfulLbl.text = isForPost ? "Post Successfully" : "Reported Successfully"
        successfulLbl.textAlignment = .center
        successfulLbl.font = .systemFont(ofSize: 19, weight: .semibold)
        successfulLbl.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(successfulLbl)
        
        containerVPortCons.append(successfulLbl.topAnchor.constraint(equalTo: checkMarkImgV.bottomAnchor, constant: 25))
        
        containerVLandsCons.append(successfulLbl.topAnchor.constraint(equalTo: checkMarkImgV.bottomAnchor, constant: 8))
        
        NSLayoutConstraint.activate([
            successfulLbl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            successfulLbl.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        let submittedLbl = UILabel()
        submittedLbl.numberOfLines = 0
        submittedLbl.text = isForPost ? "Your post has been submitted successfully." : "Your report has been submitted successfully."
        submittedLbl.textAlignment = .center
        submittedLbl.textColor = .init(hex: "#707070")
        submittedLbl.font = .systemFont(ofSize: 15, weight: .medium)
        submittedLbl.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(submittedLbl)
        
        containerVPortCons.append(submittedLbl.topAnchor.constraint(equalTo: successfulLbl.bottomAnchor, constant: 15))
        
        containerVLandsCons.append(submittedLbl.topAnchor.constraint(equalTo: successfulLbl.bottomAnchor, constant: 5))
        
        NSLayoutConstraint.activate([
            submittedLbl.widthAnchor.constraint(equalToConstant: 188),
            submittedLbl.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        let viewBtn = UIButton(type: .system)
        viewBtn.setTitle(isForPost ? "View your Post" : "View Report Issue", for: .normal)
        viewBtn.addTarget(self, action: #selector(self.viewBtnClicked), for: .touchUpInside)
        viewBtn.backgroundColor = .white
        viewBtn.setTitleColor(.init(hex: "#007BBE"), for: .normal)
        viewBtn.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        viewBtn.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(viewBtn)
        
        containerVPortCons.append(viewBtn.topAnchor.constraint(equalTo: submittedLbl.bottomAnchor, constant: 30))
        
        containerVLandsCons.append(viewBtn.topAnchor.constraint(equalTo: submittedLbl.bottomAnchor, constant: 10))
        
        NSLayoutConstraint.activate([
            viewBtn.centerXAnchor.constraint(equalTo: submittedLbl.centerXAnchor),
            viewBtn.heightAnchor.constraint(equalToConstant: 18),
            viewBtn.widthAnchor.constraint(equalToConstant: isForPost ? 120 : 130)
        ])
        
        let shareBtn = UIButton(type: .system)
        shareBtn.setTitle("Share", for: .normal)
        shareBtn.layer.borderWidth = 1
        shareBtn.layer.borderColor = UIColor(hex: "#339E82").cgColor
        shareBtn.backgroundColor = .white
        shareBtn.setTitleColor(.black, for: .normal)
        shareBtn.layer.cornerRadius = 10
        shareBtn.addTarget(self, action: #selector(self.shareBtnClicked), for: .touchUpInside)
        shareBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let continueBtn = UIButton(type: .system)
        continueBtn.setTitle("Continue", for: .normal)
        continueBtn.setTitleColor(.white, for: .normal)
        continueBtn.backgroundColor = .init(hex: "#339E82")
        continueBtn.layer.cornerRadius = 10
        continueBtn.addTarget(self, action: #selector(self.continueBtnClicked), for: .touchUpInside)
        continueBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [shareBtn, continueBtn])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(stackView)
        
        containerVPortCons.append(stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -35))
        
        containerVLandsCons.append(stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12))
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        if traitCollection.verticalSizeClass == .regular {
            NSLayoutConstraint.activate(containerVPortCons)
        }else {
            NSLayoutConstraint.activate(containerVLandsCons)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.verticalSizeClass == .regular {
            NSLayoutConstraint.deactivate(containerVLandsCons)
            NSLayoutConstraint.activate(containerVPortCons)
        }else {
            NSLayoutConstraint.deactivate(containerVPortCons)
            NSLayoutConstraint.activate(containerVLandsCons)
        }
    }
    
    @objc func viewBtnClicked() {
        
    }
    
    @objc func shareBtnClicked() {
        
    }
    
    @objc func continueBtnClicked() {
        
    }
    
    @objc func cancelBtnClicked() {
        if let sheetViewController = sheetViewController {
            sheetViewController.attemptDismiss(animated: true)
        }
    }
}
