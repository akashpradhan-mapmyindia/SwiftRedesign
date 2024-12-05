//
//  PostOnMapFixOnMapEnterDetailsViewController.swift
//  SwiftRedesign
//
//  Created by rento on 13/11/24.
//

import UIKit
import FittedSheets
import Photos

class PostOnMapFixOnMapEnterDetailsViewController: UIViewController {
    
    var isForPostOnMap: Bool
    var topView: UIView!
    var postOnMapCategory: PostOnMapCategoryHashable?
    var subCategory: PostOnMapSubCategoryHashable?
    var fixOnMapCategory: FixOnMapCategoryHashable?
    var scrollView: UIScrollView!
    var imgAddedStackView: UIStackView!
    var addImgBtn: UIButton!
    var searchLocBtn: UIButton!
    var imagePickerController: UIImagePickerController!
    var commentLbl: UITextView!
    var addCommentBtn: UIButton!
    var imageCommentInitialConstraints: [NSLayoutConstraint] = []
    var imageCommentAddedConstraints: [NSLayoutConstraint] = []
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let sheetViewController = sheetViewController {
            sheetViewController.handleScrollView(scrollView)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setSearchLocBtnSpacing()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            self.setSearchLocBtnSpacing()
        }
    }
    
    func setSearchLocBtnSpacing() {
        let buttonWidth = searchLocBtn.frame.width
        let titleWidth = searchLocBtn.titleLabel?.intrinsicContentSize.width ?? 0
        let imageWidth = searchLocBtn.imageView?.intrinsicContentSize.width ?? 0
        
        let spacing = max(0, buttonWidth - titleWidth - imageWidth)
        searchLocBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -spacing / 2, bottom: 0, right: spacing / 2)
        searchLocBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: spacing / 2, bottom: 0, right: -spacing / 2)
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
    
    func setUpUI() {
        view.backgroundColor = .white
        
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
        titleLbl.font = .sfProText.semiBold.ofSize(size: .medium)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(titleLbl)
        
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            titleLbl.topAnchor.constraint(equalTo: pullBar.bottomAnchor, constant: 10)
        ])
        
        let backBtn = UIButton()
        backBtn.setImage(UIImage(named: "clear"), for: .normal)
        backBtn.addTarget(self, action: #selector(self.backBtnClicked), for: .touchUpInside)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(backBtn)
        
        NSLayoutConstraint.activate([
            backBtn.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor),
            backBtn.trailingAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            backBtn.heightAnchor.constraint(equalToConstant: 22),
            backBtn.widthAnchor.constraint(equalToConstant: 22)
        ])
        
        setEnterDetailsView()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        self.imagePickerController = imagePickerController
    }
    
    func setEnterDetailsView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15 + 65),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        let backStackView = UIStackView()
        backStackView.axis = .horizontal
        backStackView.alignment = .center
        backStackView.backgroundColor = .white
        backStackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(backStackView)
        
        let previousPageBtn = UIButton()
        previousPageBtn.setImage(UIImage(named: "back"), for: .normal)
        previousPageBtn.contentMode = .scaleAspectFit
        previousPageBtn.addTarget(self, action: #selector(self.previousPageBtnClicked), for: .touchUpInside)
        previousPageBtn.translatesAutoresizingMaskIntoConstraints = false
        backStackView.addArrangedSubview(previousPageBtn)
        
        backStackView.setCustomSpacing(10, after: previousPageBtn)
        
        NSLayoutConstraint.activate([
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
        backStackView.addArrangedSubview(parntCatImgV)
        
        backStackView.setCustomSpacing(8, after: parntCatImgV)
        
        NSLayoutConstraint.activate([
            parntCatImgV.heightAnchor.constraint(equalToConstant: 22),
            parntCatImgV.widthAnchor.constraint(equalToConstant: 22)
        ])
        
        let parentCategoryLbl = UILabel()
        parentCategoryLbl.numberOfLines = 0
        parentCategoryLbl.text = isForPostOnMap ? postOnMapCategory?.title : "Map"
        parentCategoryLbl.font = .sfProText.medium.ofSize(size: .small)
        parentCategoryLbl.translatesAutoresizingMaskIntoConstraints = false
        backStackView.addArrangedSubview(parentCategoryLbl)
        
        backStackView.setCustomSpacing(10, after: parentCategoryLbl)
        
        let slashView = UIView()
        let radians = 15 / 180.0 * CGFloat.pi
        let rotation = CGAffineTransformRotate(slashView.transform, radians)
        slashView.transform = rotation
        slashView.backgroundColor = .black
        slashView.translatesAutoresizingMaskIntoConstraints = false
        backStackView.addArrangedSubview(slashView)
        
        backStackView.setCustomSpacing(11, after: slashView)
        
        NSLayoutConstraint.activate([
            slashView.heightAnchor.constraint(equalToConstant: 27),
            slashView.widthAnchor.constraint(equalToConstant: 3)
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
        backStackView.addArrangedSubview(subCatImgV)
        
        backStackView.setCustomSpacing(8, after: subCatImgV)
        
        NSLayoutConstraint.activate([
            subCatImgV.heightAnchor.constraint(equalToConstant: 22),
            subCatImgV.widthAnchor.constraint(equalToConstant: 22)
        ])
        
        let subCatLbl = UILabel()
        subCatLbl.numberOfLines = 0
        subCatLbl.text = isForPostOnMap ? subCategory?.title : fixOnMapCategory?.title
        subCatLbl.font = .sfProText.medium.ofSize(size: .small)
        subCatLbl.translatesAutoresizingMaskIntoConstraints = false
        backStackView.addArrangedSubview(subCatLbl)
        
        stackView.setCustomSpacing(15, after: backStackView)
        
        if !isForPostOnMap {
            let selectCategoryView = UIView()
            selectCategoryView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(selectCategoryView)
            
            let selectCategoryLbl = UILabel()
            selectCategoryLbl.text = "Select Category"
            selectCategoryLbl.font = .sfProText.medium.ofSize(size: .small)
            selectCategoryLbl.translatesAutoresizingMaskIntoConstraints = false
            selectCategoryView.addSubview(selectCategoryLbl)
            
            NSLayoutConstraint.activate([
                selectCategoryLbl.topAnchor.constraint(equalTo: selectCategoryView.topAnchor),
                selectCategoryLbl.leadingAnchor.constraint(equalTo: selectCategoryView.leadingAnchor)
            ])
            
            let categoryIconImgV = UIImageView(image: self.fixOnMapCategory?.image)
            categoryIconImgV.contentMode = .scaleAspectFit
            categoryIconImgV.translatesAutoresizingMaskIntoConstraints = false
            selectCategoryView.addSubview(categoryIconImgV)
            
            NSLayoutConstraint.activate([
                categoryIconImgV.leadingAnchor.constraint(equalTo: selectCategoryLbl.leadingAnchor),
                categoryIconImgV.topAnchor.constraint(equalTo: selectCategoryLbl.bottomAnchor, constant: 10),
                categoryIconImgV.heightAnchor.constraint(equalToConstant: 44),
                categoryIconImgV.widthAnchor.constraint(equalToConstant: 44),
                categoryIconImgV.bottomAnchor.constraint(equalTo: selectCategoryView.bottomAnchor)
            ])
            
            let categoryLbl = UILabel()
            categoryLbl.text = fixOnMapCategory?.title
            categoryLbl.font = .sfProText.medium.ofSize(size: .regular)
            categoryLbl.translatesAutoresizingMaskIntoConstraints = false
            selectCategoryView.addSubview(categoryLbl)
            
            NSLayoutConstraint.activate([
                categoryLbl.leadingAnchor.constraint(equalTo: categoryIconImgV.trailingAnchor, constant: 7),
                categoryLbl.centerYAnchor.constraint(equalTo: categoryIconImgV.centerYAnchor)
            ])
            
            stackView.setCustomSpacing(30, after: selectCategoryView)
        }
        
        let searchLocBtn = UIButton(type: .system)
        searchLocBtn.contentHorizontalAlignment = .center
        searchLocBtn.semanticContentAttribute = .forceRightToLeft
        
        let spacing: CGFloat = 20
        searchLocBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -spacing, bottom: 0, right: spacing)
        searchLocBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: -spacing)
        searchLocBtn.setTitle("Search or choose location from map", for: .normal)
        searchLocBtn.titleLabel!.font = .sfProText.regular.ofSize(size: .regular)
        searchLocBtn.setTitleColor(.init(hex: "#707070"), for: .normal)
        searchLocBtn.setImage(UIImage(named: "location 1")?.withRenderingMode(.alwaysOriginal), for: .normal)
        searchLocBtn.addTarget(self, action: #selector(self.chooseOnMapBtnClicked), for: .touchUpInside)
        searchLocBtn.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(searchLocBtn)
        
        self.searchLocBtn = searchLocBtn
        
        NSLayoutConstraint.activate([
            searchLocBtn.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
        
        stackView.setCustomSpacing(5, after: searchLocBtn)
        
        let lineView = UIView()
        lineView.backgroundColor = .init(hex: "#DDDDDD")
        lineView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(lineView)
        
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        
        stackView.setCustomSpacing(15, after: lineView)
        
        let imageCommentStackView = UIStackView()
        imageCommentStackView.distribution = .equalSpacing
        imageCommentStackView.axis = .horizontal
        imageCommentStackView.alignment = .fill
        imageCommentStackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(imageCommentStackView)
        
        NSLayoutConstraint.activate([
            imageCommentStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            imageCommentStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        
        let addImgBtn = UIButton()
        addImgBtn.setImage(UIImage(named: "add image"), for: .normal)
        addImgBtn.setTitle("Add image", for: .normal)
        addImgBtn.titleLabel?.font = .sfProText.medium.ofSize(size: .small)
        addImgBtn.setTitleColor(.black, for: .normal)
        addImgBtn.layer.borderColor = UIColor(hex: "#DDDDDD").cgColor
        addImgBtn.addTarget(self, action: #selector(self.addImgBtnClicked), for: .touchUpInside)
        addImgBtn.layer.borderWidth = 1
        addImgBtn.layer.cornerRadius = 10
        addImgBtn.clipsToBounds = true
        addImgBtn.translatesAutoresizingMaskIntoConstraints = false
        imageCommentStackView.addArrangedSubview(addImgBtn)
        
        self.addImgBtn = addImgBtn
        
        NSLayoutConstraint.activate([
            addImgBtn.heightAnchor.constraint(equalToConstant: 120),
            addImgBtn.widthAnchor.constraint(equalToConstant: 118)
        ])
        
        addImgBtn.alignVerticalCenter(padding: 10)
        
        let imgAddedView = UIStackView()
        imgAddedView.axis = .horizontal
        imgAddedView.distribution = .fillProportionally
        imgAddedView.alignment = .center
        imgAddedView.spacing = 0
        imgAddedView.isHidden = true
        imgAddedView.backgroundColor = .white.withAlphaComponent(0.84)
        imgAddedView.clipsToBounds = true
        imgAddedView.layer.cornerRadius = 24
        imgAddedView.translatesAutoresizingMaskIntoConstraints = false
        addImgBtn.addSubview(imgAddedView)
        
        self.imgAddedStackView = imgAddedView
        
        NSLayoutConstraint.activate([
            imgAddedView.centerXAnchor.constraint(equalTo: addImgBtn.centerXAnchor),
            imgAddedView.centerYAnchor.constraint(equalTo: addImgBtn.centerYAnchor),
            imgAddedView.widthAnchor.constraint(equalToConstant: 84),
            imgAddedView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        let addMoreBtn = CustomButton()
        addMoreBtn.setImage(UIImage(named: "Add"), for: .normal)
        addMoreBtn.addTarget(self, action: #selector(self.addMoreImgBtnClicked), for: .touchUpInside)
        addMoreBtn.backgroundColor = .clear
        addMoreBtn.translatesAutoresizingMaskIntoConstraints = false
        imgAddedView.addArrangedSubview(addMoreBtn)
        
        let separatorLineV = UIView()
        separatorLineV.backgroundColor = .white
        separatorLineV.translatesAutoresizingMaskIntoConstraints = false
        imgAddedView.addArrangedSubview(separatorLineV)
        
        NSLayoutConstraint.activate([
            separatorLineV.widthAnchor.constraint(equalToConstant: 2),
            separatorLineV.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        let editImgBtn = CustomButton()
        editImgBtn.setImage(UIImage(named: "Edit"), for: .normal)
        editImgBtn.addTarget(self, action: #selector(self.editImgBtnClicked), for: .touchUpInside)
        editImgBtn.backgroundColor = .clear
        editImgBtn.translatesAutoresizingMaskIntoConstraints = false
        imgAddedView.addArrangedSubview(editImgBtn)
        
        let addCommentBtn = UIButton()
        addCommentBtn.setImage(UIImage(named: "chat_black_24dp"), for: .normal)
        addCommentBtn.setTitle("Add a comment", for: .normal)
        addCommentBtn.titleLabel?.font = .sfProText.medium.ofSize(size: .small)
        addCommentBtn.setTitleColor(.black, for: .normal)
        addCommentBtn.layer.cornerRadius = 10
        addCommentBtn.layer.borderWidth = 1
        addCommentBtn.layer.borderColor = UIColor(hex: "#DDDDDD").cgColor
        addCommentBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        addCommentBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        addCommentBtn.addTarget(self, action: #selector(self.addCommentBtnClicked), for: .touchUpInside)
        addCommentBtn.translatesAutoresizingMaskIntoConstraints = false
        imageCommentStackView.addArrangedSubview(addCommentBtn)
        
        self.addCommentBtn = addCommentBtn
        
        imageCommentInitialConstraints = [addCommentBtn.trailingAnchor.constraint(equalTo: imageCommentStackView.trailingAnchor), addCommentBtn.leadingAnchor.constraint(equalTo: addImgBtn.trailingAnchor, constant: 20)]
        
        NSLayoutConstraint.activate(imageCommentInitialConstraints)
        
        let commentLbl = UITextView()
        commentLbl.textAlignment = .left
        commentLbl.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        commentLbl.layer.cornerRadius = 10
        commentLbl.layer.borderWidth = 1
        commentLbl.isUserInteractionEnabled = true
        commentLbl.text = ""
        commentLbl.layer.borderColor = UIColor(hex: "#DDDDDD").cgColor
        commentLbl.font = .sfProText.medium.ofSize(size: .small)
        commentLbl.isHidden = true
        commentLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.addCommentBtnClicked)))
        commentLbl.translatesAutoresizingMaskIntoConstraints = false
        imageCommentStackView.addArrangedSubview(commentLbl)
        
        self.commentLbl = commentLbl
        
        imageCommentAddedConstraints = [
            commentLbl.trailingAnchor.constraint(equalTo: imageCommentStackView.trailingAnchor),
            commentLbl.leadingAnchor.constraint(equalTo: addImgBtn.trailingAnchor, constant: 20)
        ]
        
        stackView.setCustomSpacing(26, after: imageCommentStackView)
        
        let hideNameCheckBoxStackView = UIStackView()
        hideNameCheckBoxStackView.axis = .horizontal
        hideNameCheckBoxStackView.alignment = .leading
        hideNameCheckBoxStackView.distribution = .fill
        hideNameCheckBoxStackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(hideNameCheckBoxStackView)
        
        let hideMyNameCheckBox = UIButton()
        hideMyNameCheckBox.setImage(UIImage(named: "check_box_black_24dp (1)"), for: .selected)
        hideMyNameCheckBox.setImage(UIImage(named: "check_box_outline_blank_black_24dp (1)"), for: .normal)
        hideMyNameCheckBox.addTarget(self, action: #selector(self.hideMyNameCheckBoxClicked(_:)), for: .touchUpInside)
        hideMyNameCheckBox.translatesAutoresizingMaskIntoConstraints = false
        hideNameCheckBoxStackView.addArrangedSubview(hideMyNameCheckBox)
        
        NSLayoutConstraint.activate([
            hideMyNameCheckBox.heightAnchor.constraint(equalToConstant: 22),
            hideMyNameCheckBox.widthAnchor.constraint(equalToConstant: 22)
        ])
        
        hideNameCheckBoxStackView.setCustomSpacing(10, after: hideMyNameCheckBox)
        
        let hideMyNameLbl = UILabel()
        hideMyNameLbl.text = "Hide My Name"
        hideMyNameLbl.font = .sfProText.regular.ofSize(size: .regular)
        hideMyNameLbl.textColor = .init(hex: "#707070")
        hideMyNameLbl.translatesAutoresizingMaskIntoConstraints = false
        hideNameCheckBoxStackView.addArrangedSubview(hideMyNameLbl)
        
        NSLayoutConstraint.activate([
            hideMyNameLbl.leadingAnchor.constraint(equalTo: hideMyNameCheckBox.trailingAnchor, constant: 15),
            hideMyNameLbl.centerYAnchor.constraint(equalTo: hideMyNameCheckBox.centerYAnchor)
        ])
        
        stackView.setCustomSpacing(43, after: hideNameCheckBoxStackView)
        
        let doneBtn = UIButton(type: .system)
        doneBtn.setTitle("Done", for: .normal)
        doneBtn.setTitleColor(.white, for: .normal)
        doneBtn.titleLabel?.textAlignment = .center
        doneBtn.titleLabel?.font = .sfProText.semiBold.ofSize(size: .regular)
        doneBtn.backgroundColor = .init(hex: "#339E82")
        doneBtn.layer.cornerRadius = 12
        doneBtn.addTarget(self, action: #selector(self.doneBtnClicked), for: .touchUpInside)
        doneBtn.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(doneBtn)
        
        NSLayoutConstraint.activate([
            doneBtn.heightAnchor.constraint(equalToConstant: 50),
            doneBtn.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            doneBtn.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
    }
    
    @objc func doneBtnClicked() {
        isForPostOnMap ?
        NotificationCenter.default.post(name: NotificationCenterConstants.postSuccessfull, object: nil, userInfo: [:]) : NotificationCenter.default.post(name: NotificationCenterConstants.reportSuccessful, object: nil, userInfo: [:])
    }
    
    @objc func addImgBtnClicked() {
        if #available(iOS 14, *) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite, handler: { authorization in
                switch authorization {
                case .authorized:
                    DispatchQueue.main.async {
                        self.present(self.imagePickerController, animated: true)
                    }
                default:
                    print("Photo Library access denied.")
                }
            })
        } else {
            PHPhotoLibrary.requestAuthorization { authorization in
                switch authorization {
                case .authorized:
                    DispatchQueue.main.async {
                        self.present(self.imagePickerController, animated: true)
                    }
                default:
                    print("Photo Library access denied.")
                }
            }
        }
    }
    
    @objc func addMoreImgBtnClicked() {
        
    }
    
    @objc func editImgBtnClicked() {
        
    }
    
    @objc func addCommentBtnClicked() {
        let vc = AddCommentViewController.init(comment: commentLbl.text ?? "")
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
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
        customDismiss(animated: true)
    }
}

extension PostOnMapFixOnMapEnterDetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagePicked = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        if let image = imagePicked {
            addImgBtn.setBackgroundImage(image, for: .normal)
            imgAddedStackView.isHidden = false
            addImgBtn.setImage(nil, for: .normal)
            addImgBtn.setTitle("", for: .normal)
            addImgBtn.removeTarget(self, action: #selector(self.addImgBtnClicked), for: .touchUpInside)
            imagePickerController.dismiss(animated: true)
        }
    }
}

extension PostOnMapFixOnMapEnterDetailsViewController: AddCommentViewControllerDelegate {
    func commentDoneBtnClicked(comment: String) {
        if comment.isEmpty {
            commentLbl.text = ""
            
            addCommentBtn.isHidden = false
            commentLbl.isHidden = true
            NSLayoutConstraint.deactivate(imageCommentAddedConstraints)
            NSLayoutConstraint.activate(imageCommentInitialConstraints)
        }else {
            commentLbl.text = comment
            
            addCommentBtn.isHidden = true
            commentLbl.isHidden = false
            NSLayoutConstraint.deactivate(imageCommentInitialConstraints)
            NSLayoutConstraint.activate(imageCommentAddedConstraints)
        }
    }
}
