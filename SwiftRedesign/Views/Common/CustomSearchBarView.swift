//
//  CustomSearchBarView.swift
//  SwiftRedesign
//
//  Created by rento on 04/11/24.
//

import UIKit

class CustomSearchBarView: UIView {
    
    var cancelBtn: UIButton!
    var searchLeadingIcon: UIImageView!
    var searchTextField: UITextField!
    var commonHeightCons: [NSLayoutConstraint] = []
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.deactivate(commonHeightCons)
        commonHeightCons = [
            cancelBtn.heightAnchor.constraint(equalToConstant: min(25, frame.size.height-10)),
            cancelBtn.widthAnchor.constraint(equalToConstant: min(25, frame.size.height-10)),
            searchLeadingIcon.widthAnchor.constraint(equalToConstant: min(22, frame.size.height-10)),
            searchLeadingIcon.heightAnchor.constraint(equalToConstant: min(22, frame.size.height-10))
        ]
        NSLayoutConstraint.activate(commonHeightCons)
    }
    
    func commonInit() {
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.borderColor = UIColor(hex: "#DDDDDD").cgColor
        layer.borderWidth = 1
        
        cancelBtn = UIButton()
        cancelBtn.setImage(UIImage(systemName: "xmark"), for: .normal)
        cancelBtn.backgroundColor = .clear
        cancelBtn.addTarget(self, action: #selector(self.clearBtnClicked), for: .touchUpInside)
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cancelBtn)
        
        commonHeightCons.append(contentsOf: [            cancelBtn.heightAnchor.constraint(equalToConstant: min(25, frame.size.height-10)), cancelBtn.widthAnchor.constraint(equalToConstant: min(25, frame.size.height-10))])
        
        NSLayoutConstraint.activate([
            cancelBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            cancelBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
        searchLeadingIcon = UIImageView(image: UIImage(systemName: "magnifyingglass")!.withRenderingMode(.alwaysTemplate))
        searchLeadingIcon.backgroundColor = .clear
        searchLeadingIcon.contentMode = .scaleAspectFit
        searchLeadingIcon.tintColor = .black
        searchLeadingIcon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchLeadingIcon)
        
        commonHeightCons.append(contentsOf: [            searchLeadingIcon.widthAnchor.constraint(equalToConstant: min(22, frame.size.height-10)), searchLeadingIcon.heightAnchor.constraint(equalToConstant: min(22, frame.size.height-10))])
        
        NSLayoutConstraint.activate([
            searchLeadingIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            searchLeadingIcon.centerYAnchor.constraint(equalTo: cancelBtn.centerYAnchor)
        ])
        
        searchTextField = UITextField()
        searchTextField.placeholder = "Search..."
        searchTextField.backgroundColor = .clear
        searchTextField.textColor = .black
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: searchLeadingIcon.trailingAnchor, constant: 5),
            searchTextField.topAnchor.constraint(equalTo: searchLeadingIcon.topAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: searchLeadingIcon.bottomAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: cancelBtn.leadingAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate(commonHeightCons)
    }
    
    @objc func clearBtnClicked() {
        searchTextField.text = ""
    }
}
