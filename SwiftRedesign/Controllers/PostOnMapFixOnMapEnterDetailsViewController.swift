//
//  PostOnMapFixOnMapEnterDetailsViewController.swift
//  SwiftRedesign
//
//  Created by rento on 13/11/24.
//

import UIKit

class PostOnMapFixOnMapEnterDetailsViewController: UIViewController {
    
    var isForPostOnMap: Bool
    var topView: UIView!
    var postOnMapCategory: PostOnMapCategoryHashable?
    var subCategory: PostOnMapSubCategoryHashable?
    var fixOnMapCategory: FixOnMapCategoryHashable?
    var backView: UIView!
    
    init(postOnMapCategory: PostOnMapCategoryHashable, subCategoryIndex: Int) {
        self.postOnMapCategory = postOnMapCategory
        self.subCategory = postOnMapCategory.subCategories[subCategoryIndex]
        self.isForPostOnMap = true
        super.init(nibName: nil, bundle: nil)
    }
    
    init(fixOnMapCategory: FixOnMapCategoryHashable) {
        self.fixOnMapCategory = fixOnMapCategory
        self.isForPostOnMap = false
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
        topView = UIView()
        topView.backgroundColor = .init(hex: "#FAFAFA")
        topView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topView)
     
        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.heightAnchor.constraint(equalToConstant: 65)
        ])
        
        let pullBar = UIView()
        pullBar.layer.cornerRadius = 3
        pullBar.backgroundColor = .init(hex: "#DDDDDD")
        pullBar.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(pullBar)
        
        NSLayoutConstraint.activate([
            pullBar.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            pullBar.widthAnchor.constraint(equalToConstant: 50),
            pullBar.heightAnchor.constraint(equalToConstant: 5),
            pullBar.topAnchor.constraint(equalTo: topView.topAnchor, constant: 12)
        ])
        
        let titleLbl = UILabel()
        titleLbl.text = isForPostOnMap ? "Post on Map" : "Fix Map"
        titleLbl.font = .systemFont(ofSize: 19, weight: .semibold)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(titleLbl)
        
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            titleLbl.topAnchor.constraint(equalTo: pullBar.bottomAnchor, constant: 10)
        ])
        
        let backBtn = UIButton()
        backBtn.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        backBtn.addTarget(self, action: #selector(self.backBtnClicked), for: .touchUpInside)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(backBtn)
        
        NSLayoutConstraint.activate([
            backBtn.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor),
            backBtn.trailingAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            backBtn.heightAnchor.constraint(equalToConstant: 22),
            backBtn.widthAnchor.constraint(equalToConstant: 22)
        ])
        
        setBackView()
        setEnterDetailsView()
    }
    
    func setBackView() {
        backView = UIView()
        backView.backgroundColor = .white
        backView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backView)
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10),
            backView.heightAnchor.constraint(equalToConstant: 37),
            backView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        let previousPageBtn = UIButton()
        previousPageBtn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        previousPageBtn.contentMode = .scaleAspectFit
        previousPageBtn.addTarget(self, action: #selector(self.previousPageBtnClicked), for: .touchUpInside)
        previousPageBtn.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(previousPageBtn)
        
        NSLayoutConstraint.activate([
            previousPageBtn.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            previousPageBtn.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15),
            previousPageBtn.heightAnchor.constraint(equalToConstant: 22),
            previousPageBtn.widthAnchor.constraint(equalToConstant: 22)
        ])
        
        let parntCatImgV = UIImageView(image: isForPostOnMap ? postOnMapCategory?.image : UIImage(systemName: "photo")!)
        parntCatImgV.contentMode = .scaleAspectFit
        parntCatImgV.backgroundColor = .white
        parntCatImgV.layer.shadowColor = UIColor.lightGray.cgColor
        parntCatImgV.layer.shadowOffset = .zero
        parntCatImgV.layer.shadowRadius = 1
        parntCatImgV.layer.shadowOpacity = 0.8
        parntCatImgV.layer.cornerRadius = 11
        parntCatImgV.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(parntCatImgV)
        
        NSLayoutConstraint.activate([
            parntCatImgV.leadingAnchor.constraint(equalTo: previousPageBtn.trailingAnchor, constant: 10),
            parntCatImgV.centerYAnchor.constraint(equalTo: previousPageBtn.centerYAnchor),
            parntCatImgV.heightAnchor.constraint(equalToConstant: 22),
            parntCatImgV.widthAnchor.constraint(equalToConstant: 22)
        ])
        
        let parentCategoryLbl = UILabel()
        parentCategoryLbl.numberOfLines = 0
        parentCategoryLbl.text = isForPostOnMap ? postOnMapCategory?.title : "Map"
        parentCategoryLbl.font = .systemFont(ofSize: 15, weight: .medium)
        parentCategoryLbl.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(parentCategoryLbl)
        
        NSLayoutConstraint.activate([
            parentCategoryLbl.leadingAnchor.constraint(equalTo: parntCatImgV.trailingAnchor, constant: 5),
            parentCategoryLbl.centerYAnchor.constraint(equalTo: parntCatImgV.centerYAnchor)
        ])
        
        let slashView = UIView()
        let radians = 15 / 180.0 * CGFloat.pi
        let rotation = CGAffineTransformRotate(slashView.transform, radians);
        slashView.transform = rotation
        slashView.backgroundColor = .black
        slashView.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(slashView)
        
        NSLayoutConstraint.activate([
            slashView.leadingAnchor.constraint(equalTo: parentCategoryLbl.trailingAnchor, constant: 10),
            slashView.heightAnchor.constraint(equalToConstant: 27),
            slashView.widthAnchor.constraint(equalToConstant: 3),
            slashView.centerYAnchor.constraint(equalTo: parentCategoryLbl.centerYAnchor)
        ])
        
        let subCatImgV = UIImageView(image: isForPostOnMap ? postOnMapCategory?.image : fixOnMapCategory?.image)
        subCatImgV.backgroundColor = .white
        subCatImgV.contentMode = .scaleAspectFit
        subCatImgV.layer.shadowColor = UIColor.lightGray.cgColor
        subCatImgV.layer.shadowOffset = .zero
        subCatImgV.layer.shadowRadius = 1
        subCatImgV.layer.shadowOpacity = 0.8
        subCatImgV.layer.cornerRadius = 11
        subCatImgV.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(subCatImgV)
        
        NSLayoutConstraint.activate([
            subCatImgV.centerYAnchor.constraint(equalTo: parntCatImgV.centerYAnchor),
            subCatImgV.heightAnchor.constraint(equalToConstant: 22),
            subCatImgV.widthAnchor.constraint(equalToConstant: 22),
            subCatImgV.leadingAnchor.constraint(equalTo: slashView.trailingAnchor, constant: 11)
        ])
        
        let subCatLbl = UILabel()
        subCatLbl.numberOfLines = 0
        subCatLbl.text = isForPostOnMap ? subCategory?.title : fixOnMapCategory?.title
        subCatLbl.font = .systemFont(ofSize: 15, weight: .medium)
        subCatLbl.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(subCatLbl)
        
        NSLayoutConstraint.activate([
            subCatLbl.leadingAnchor.constraint(equalTo: subCatImgV.trailingAnchor, constant: 5),
            subCatLbl.centerYAnchor.constraint(equalTo: subCatImgV.centerYAnchor),
            subCatLbl.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -15)
        ])
    }
    
    func setEnterDetailsView() {
        let chooseOnMapBtn = UIButton()
        chooseOnMapBtn.setImage(UIImage(systemName: "mappin.circle.fill"), for: .normal)
        chooseOnMapBtn.addTarget(self, action: #selector(self.chooseOnMapBtnClicked), for: .touchUpInside)
        chooseOnMapBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chooseOnMapBtn)
        
        NSLayoutConstraint.activate([
            chooseOnMapBtn.heightAnchor.constraint(equalToConstant: 22),
            chooseOnMapBtn.widthAnchor.constraint(equalToConstant: 22),
            chooseOnMapBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            chooseOnMapBtn.topAnchor.constraint(equalTo: backView.bottomAnchor, constant: 30)
        ])
        
        let searchLocationTF = UITextField()
        searchLocationTF.placeholder = "Search or choose location from map"
        searchLocationTF.font = .systemFont(ofSize: 17, weight: .regular)
        searchLocationTF.textColor = .init(hex: "#707070")
        searchLocationTF.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchLocationTF)
        
        NSLayoutConstraint.activate([
            searchLocationTF.centerYAnchor.constraint(equalTo: chooseOnMapBtn.centerYAnchor),
            searchLocationTF.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            searchLocationTF.trailingAnchor.constraint(equalTo: chooseOnMapBtn.leadingAnchor, constant: -10),
            searchLocationTF.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        let lineView = UIView()
        lineView.backgroundColor = .init(hex: "#DDDDDD")
        lineView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineView)
        
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: searchLocationTF.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: chooseOnMapBtn.trailingAnchor),
            lineView.topAnchor.constraint(equalTo: searchLocationTF.bottomAnchor, constant: 10),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        let addImgBtn = UIButton()
        addImgBtn.setImage(UIImage(systemName: "photo"), for: .normal)
        addImgBtn.setTitle("Add image", for: .normal)
        addImgBtn.setTitleColor(.black, for: .normal)
        addImgBtn.layer.borderColor = UIColor(hex: "#DDDDDD").cgColor
        addImgBtn.addTarget(self, action: #selector(self.addImgBtnClicked), for: .touchUpInside)
        addImgBtn.layer.borderWidth = 1
        addImgBtn.layer.cornerRadius = 10
        addImgBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addImgBtn)
        
        NSLayoutConstraint.activate([
            addImgBtn.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 15),
            addImgBtn.leadingAnchor.constraint(equalTo: lineView.leadingAnchor),
            addImgBtn.heightAnchor.constraint(equalToConstant: 120),
            addImgBtn.widthAnchor.constraint(equalToConstant: 118)
        ])
        
        addImgBtn.alignVerticalCenter(padding: 10)
        
        let addCommentBtn = UIButton()
        addCommentBtn.setImage(UIImage(systemName: "text.bubble.fill"), for: .normal)
        addCommentBtn.setTitle("Add a comment", for: .normal)
        addCommentBtn.setTitleColor(.black, for: .normal)
        addCommentBtn.layer.cornerRadius = 10
        addCommentBtn.layer.borderWidth = 1
        addCommentBtn.layer.borderColor = UIColor(hex: "#DDDDDD").cgColor
        addCommentBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10);
        addCommentBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0);
        addCommentBtn.addTarget(self, action: #selector(self.addCommentBtnClicked), for: .touchUpInside)
        addCommentBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addCommentBtn)
        
        NSLayoutConstraint.activate([
            addCommentBtn.leadingAnchor.constraint(equalTo: addImgBtn.trailingAnchor, constant: 15),
            addCommentBtn.topAnchor.constraint(equalTo: addImgBtn.topAnchor),
            addCommentBtn.bottomAnchor.constraint(equalTo: addImgBtn.bottomAnchor),
            addCommentBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
        
        let hideMyNameCheckBox = UIButton()
        hideMyNameCheckBox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        hideMyNameCheckBox.setImage(UIImage(systemName: "square"), for: .normal)
        hideMyNameCheckBox.addTarget(self, action: #selector(self.hideMyNameCheckBoxClicked(_:)), for: .touchUpInside)
        hideMyNameCheckBox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hideMyNameCheckBox)
        
        NSLayoutConstraint.activate([
            hideMyNameCheckBox.heightAnchor.constraint(equalToConstant: 22),
            hideMyNameCheckBox.widthAnchor.constraint(equalToConstant: 22),
            hideMyNameCheckBox.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            hideMyNameCheckBox.topAnchor.constraint(equalTo: addCommentBtn.bottomAnchor, constant: 28)
        ])
        
        let hideMyNameLbl = UILabel()
        hideMyNameLbl.text = "Hide My Name"
        hideMyNameLbl.font = .systemFont(ofSize: 17, weight: .regular)
        hideMyNameLbl.textColor = .init(hex: "#707070")
        hideMyNameLbl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hideMyNameLbl)
        
        NSLayoutConstraint.activate([
            hideMyNameLbl.leadingAnchor.constraint(equalTo: hideMyNameCheckBox.trailingAnchor, constant: 15),
            hideMyNameLbl.centerYAnchor.constraint(equalTo: hideMyNameCheckBox.centerYAnchor)
        ])
        
        let doneBtn = UIButton(type: .system)
        doneBtn.setTitle("Done", for: .normal)
        doneBtn.setTitleColor(.white, for: .normal)
        doneBtn.titleLabel?.textAlignment = .center
        doneBtn.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        doneBtn.backgroundColor = .init(hex: "#339E82")
        doneBtn.layer.cornerRadius = 12
        doneBtn.addTarget(self, action: #selector(self.doneBtnClicked), for: .touchUpInside)
        doneBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(doneBtn)
        
        NSLayoutConstraint.activate([
            doneBtn.topAnchor.constraint(equalTo: hideMyNameCheckBox.bottomAnchor, constant: 41),
            doneBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            doneBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            doneBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func doneBtnClicked() {
        isForPostOnMap ?
        NotificationCenter.default.post(name: NotificationCenterConstants.postSuccessfull, object: nil, userInfo: [:]) : NotificationCenter.default.post(name: NotificationCenterConstants.reportSuccessful, object: nil, userInfo: [:])
    }
    
    @objc func addImgBtnClicked() {
        
    }
    
    @objc func addCommentBtnClicked() {
        
    }
    
    @objc func chooseOnMapBtnClicked() {
        
    }
    
    @objc func hideMyNameCheckBoxClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @objc func previousPageBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func backBtnClicked() {
        if let sheetViewController = sheetViewController {
            sheetViewController.attemptDismiss(animated: true)
        }else if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }else {
            dismiss(animated: true)
        }
    }
}

