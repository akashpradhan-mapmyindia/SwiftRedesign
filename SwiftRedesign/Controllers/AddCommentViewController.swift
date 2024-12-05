//
//  AddCommentViewController.swift
//  SwiftRedesign
//
//  Created by rento on 25/11/24.
//

import UIKit

protocol AddCommentViewControllerDelegate: Sendable {
    func commentDoneBtnClicked(comment: String) async
}

class AddCommentViewController: UIViewController {
    
    var delegate: AddCommentViewControllerDelegate?
    
    var comment: String
    
    var topBar: UIView!
    var commentTxtView: UITextView!
    
    init(comment: String) {
        self.comment = comment
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topBar.layer.shadowRadius = 1
        topBar.layer.shadowOpacity = 0.7
        topBar.layer.shadowColor = UIColor.init(hex: "#0000004D").cgColor
        topBar.layer.shadowOffset = .zero
        let shadowSize: CGFloat = 20
        let contactRect = CGRect(x: -shadowSize, y: topBar.frame.height - (shadowSize * 0.4), width: topBar.frame.width + shadowSize * 2, height: 1)
        topBar.layer.shadowPath = UIBezierPath(rect: contactRect).cgPath
        topBar.layer.zPosition = 3
    }
    
    func setUpUI() {
        view.backgroundColor = .white
        
        let topBar = UIView()
        topBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBar)
        
        self.topBar = topBar
        
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let backBtn = UIButton()
        backBtn.setImage(UIImage(named: "back"), for: .normal)
        backBtn.addTarget(self, action: #selector(self.backBtnClicked), for: .touchUpInside)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        topBar.addSubview(backBtn)
        
        NSLayoutConstraint.activate([
            backBtn.leadingAnchor.constraint(equalTo: topBar.leadingAnchor, constant: 15),
            backBtn.heightAnchor.constraint(equalToConstant: 22),
            backBtn.widthAnchor.constraint(equalToConstant: 22),
            backBtn.centerYAnchor.constraint(equalTo: topBar.centerYAnchor)
        ])
        
        let titleLbl = UILabel()
        titleLbl.text = "Comment"
        titleLbl.textAlignment = .center
        titleLbl.font = .sfProText.semiBold.ofSize(size: .medium)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        topBar.addSubview(titleLbl)
        
        NSLayoutConstraint.activate([
            titleLbl.centerXAnchor.constraint(equalTo: topBar.centerXAnchor),
            titleLbl.centerYAnchor.constraint(equalTo: topBar.centerYAnchor)
        ])
        
        let doneBtn = UIButton(type: .system)
        doneBtn.setTitle("Done", for: .normal)
        doneBtn.titleLabel?.font = .sfProText.regular.ofSize(size: .medium)
        doneBtn.addTarget(self, action: #selector(self.doneBtnClicked), for: .touchUpInside)
        doneBtn.translatesAutoresizingMaskIntoConstraints = false
        topBar.addSubview(doneBtn)
        
        NSLayoutConstraint.activate([
            doneBtn.trailingAnchor.constraint(equalTo: topBar.trailingAnchor, constant: -15),
            doneBtn.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            doneBtn.heightAnchor.constraint(equalToConstant: 20),
            doneBtn.widthAnchor.constraint(equalToConstant: 45)
        ])
        
        let commentTxtView = UITextView()
        if comment == "" {
            commentTxtView.text = "Share details here..."
            commentTxtView.textColor = .init(hex: "#707070")
        }else {
            commentTxtView.text = comment
        }
        commentTxtView.delegate = self
        commentTxtView.layer.borderColor = UIColor(hex: "#DDDDDD").cgColor
        commentTxtView.layer.borderWidth = 1
        commentTxtView.layer.cornerRadius = 10
        commentTxtView.font = .sfProText.medium.ofSize(size: .small)
        commentTxtView.textContainer.heightTracksTextView = true
        commentTxtView.isScrollEnabled = false
        commentTxtView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(commentTxtView)
        
        self.commentTxtView = commentTxtView
        
        NSLayoutConstraint.activate([
            commentTxtView.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 15),
            commentTxtView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            commentTxtView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            commentTxtView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func doneBtnClicked() {
        backBtnClicked()
        Task {
            await delegate?.commentDoneBtnClicked(comment: comment)
        }
    }
    
    @objc func backBtnClicked() {
        customDismiss(animated: true)
    }
}

extension AddCommentViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.textColor != .init(hex: "#707070") {
            comment = textView.text ?? ""
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .init(hex: "#707070") {
            textView.text = nil
            textView.textColor = .init(hex: "#212121")
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Share details here..."
            textView.textColor = .init(hex: "#707070")
        }else {
            comment = textView.text!
        }
    }
}
