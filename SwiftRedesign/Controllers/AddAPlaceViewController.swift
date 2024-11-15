//
//  AddAPlaceViewController.swift
//  SwiftRedesign
//
//  Created by rento on 23/10/24.
//

import UIKit

class AddAPlaceDetailsCollectionViewHashable: Hashable {
    
    var cellIdentifier: String
    var title: NSMutableAttributedString
    var icon: UIImage?
    
    init(cellIdentifier: String, title: NSMutableAttributedString = .init(string: ""), icon: UIImage? = nil) {
        self.title = title
        self.icon = icon
        self.cellIdentifier = cellIdentifier
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(title)
    }
    
    static func == (lhs: AddAPlaceDetailsCollectionViewHashable, rhs: AddAPlaceDetailsCollectionViewHashable) -> Bool {
        return lhs.title == rhs.title
    }
}

class AddAPlaceViewController: UIViewController {
    
    struct SupplementaryViewKind {
        static let header = "header-kind"
    }
    
    enum CellTitle: String {
        case placeName = "Place Name"
        case address = "Address"
        case category = "Category"
        case description = "Description"
        case popularlyKnownAs = "Popularly Known as"
        case mobileNumber = "Mobile Number"
        case phoneNumber = "Phone No."
        case email = "Email"
        case openHours = "Open hours"
    }
    
    var topBar: UIView!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Int, AddAPlaceDetailsCollectionViewHashable>?
    var sections: [[AddAPlaceDetailsCollectionViewHashable]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
    
    func setUpUI() {
        view.backgroundColor = .white
        
        setUpSectionsData()
        setTopBar()
        setCollectionView()
        dataSource = makeDataSource()
        applyInitialSnapshot()
    }
    
    func setTopBar() {
        let topBar = UIView()
        topBar.backgroundColor = .white
        view.addSubview(topBar)
        topBar.translatesAutoresizingMaskIntoConstraints = false
        self.topBar = topBar
        
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let titleLbl = UILabel()
        titleLbl.text = "Add a Place"
        titleLbl.font = .sfProText.semiBold.ofSize(size: .medium)
        titleLbl.textAlignment = .center
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        topBar.addSubview(titleLbl)
        
        NSLayoutConstraint.activate([
            titleLbl.centerYAnchor.constraint(equalTo: topBar.safeAreaLayoutGuide.centerYAnchor),
            titleLbl.centerXAnchor.constraint(equalTo: topBar.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        let backBtn = UIButton()
        backBtn.setImage(UIImage(systemName: "chevron.left")!, for: .normal)
        backBtn.contentMode = .scaleAspectFit
        backBtn.addTarget(self, action: #selector(self.backBtnClicked), for: .touchUpInside)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        topBar.addSubview(backBtn)
        
        NSLayoutConstraint.activate([
            backBtn.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor),
            backBtn.leadingAnchor.constraint(equalTo: topBar.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            backBtn.heightAnchor.constraint(equalToConstant: 22),
            backBtn.widthAnchor.constraint(equalToConstant: 22)
        ])
        
        let submitBtn = UIButton(type: .system)
        submitBtn.setTitle("Submit", for: .normal)
        submitBtn.titleLabel?.font = .sfProText.regular.ofSize(size: .medium)
        submitBtn.addTarget(self, action: #selector(self.submitBtnClicked), for: .touchUpInside)
        submitBtn.translatesAutoresizingMaskIntoConstraints = false
        topBar.addSubview(submitBtn)
        
        NSLayoutConstraint.activate([
            submitBtn.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor),
            submitBtn.trailingAnchor.constraint(equalTo: topBar.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            submitBtn.heightAnchor.constraint(equalToConstant: 20),
            submitBtn.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topBar.layer.shadowRadius = 1
        topBar.layer.shadowOpacity = 0.7
        topBar.layer.shadowColor = UIColor.init(hex: "#0000004D").cgColor
        topBar.layer.shadowOffset = .zero
        let shadowSize: CGFloat = 20
        let contactRect = CGRect(x: -shadowSize, y: topBar.frame.height - (shadowSize * 0.4), width: topBar.frame.width + shadowSize * 2, height: 10)
        topBar.layer.shadowPath = UIBezierPath(rect: contactRect).cgPath
        topBar.layer.zPosition = 3
    }
    
    @objc func backBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func submitBtnClicked() {
        let vc = AddAPlaceThankYouViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUpSectionsData() {
        var section: [AddAPlaceDetailsCollectionViewHashable] = []
        section.append(.init(cellIdentifier: AddAPlaceCollectionViewInfoCell.identifier, title: addSuperscript(to: CellTitle.placeName.rawValue, with: "*"), icon: UIImage(systemName: "building.2")!))
        section.append(.init(cellIdentifier: AddAPlaceCollectionViewInfoCell.identifier, title: addSuperscript(to: CellTitle.category.rawValue, with: "*"), icon: UIImage(systemName: "tag.fill")!))
        section.append(.init(cellIdentifier: AddAPlaceCollectionViewInfoCell.identifier, title: addSuperscript(to: CellTitle.address.rawValue, with: "*"), icon: UIImage(systemName: "mappin.and.ellipse")!))
        section.append(.init(cellIdentifier: AddAPlaceEditLocationOnMapCell.identifier))
        section.append(.init(cellIdentifier: AddAPlaceCollectionViewInfoCell.identifier, title: addSuperscript(to: CellTitle.description.rawValue, with: "*"), icon: UIImage(systemName: "doc.text.fill")!))
        
        sections.append(section)
        
        section = []
        section.append(.init(cellIdentifier: AddAPlaceImageCell.identifier))
        section.append(.init(cellIdentifier: AddAPlaceImageCell.identifier, icon: UIImage(systemName: "photo.fill")!))
        section.append(.init(cellIdentifier: AddAPlaceImageCell.identifier, icon: UIImage(systemName: "photo.fill")!))
        section.append(.init(cellIdentifier: AddAPlaceImageCell.identifier, icon: UIImage(systemName: "photo.fill")!))
        section.append(.init(cellIdentifier: AddAPlaceImageCell.identifier, icon: UIImage(systemName: "photo.fill")!))
        section.append(.init(cellIdentifier: AddAPlaceImageCell.identifier, icon: UIImage(systemName: "photo.fill")!))
        section.append(.init(cellIdentifier: AddAPlaceImageCell.identifier, icon: UIImage(systemName: "photo.fill")!))

        sections.append(section)
        
        section = []
        section.append(.init(cellIdentifier: AddAPlaceAdditionalInfoCell.identifer, title: .init(string: CellTitle.popularlyKnownAs.rawValue, attributes: [NSAttributedString.Key.font : UIFont.sfProText.medium.ofSize(size: .small)])))
        sections.append(section)

        section = []
        section.append(.init(cellIdentifier: AddAPlaceAdditionalInfoCell.identifer, title: .init(string: CellTitle.mobileNumber.rawValue, attributes: [NSAttributedString.Key.font : UIFont.sfProText.medium.ofSize(size: .small)])))
        section.append(.init(cellIdentifier: AddAPlaceAdditionalInfoCell.identifer, title: .init(string: CellTitle.phoneNumber.rawValue, attributes: [NSAttributedString.Key.font : UIFont.sfProText.medium.ofSize(size: .small)])))
        section.append(.init(cellIdentifier: AddAPlaceAdditionalInfoCell.identifer, title: .init(string: CellTitle.email.rawValue, attributes: [NSAttributedString.Key.font : UIFont.sfProText.medium.ofSize(size: .small)])))
        section.append(.init(cellIdentifier: AddAPlaceAdditionalInfoCell.identifer, title: .init(string: CellTitle.openHours.rawValue, attributes: [NSAttributedString.Key.font : UIFont.sfProText.medium.ofSize(size: .small)])))
        
        sections.append(section)
    }
    
    func headerTitle(for section: Int) -> String {
        switch section {
        case 0:
            return ""
        case 1:
            return ""
        case 2:
            return "Additional Info"
        case 3:
            return "Contact Details"
        default:
            return ""
        }
    }
    
    func addSuperscript(to string: String, with superscript: String, font: UIFont = .sfProText.medium.ofSize(size: .regular)) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: string, attributes: [NSAttributedString.Key.font : font])
        
        let superscriptAttibutedString = NSAttributedString(string: superscript, attributes: [NSAttributedString.Key.font : font, NSAttributedString.Key.baselineOffset : 2, NSAttributedString.Key.foregroundColor : UIColor(hex: "#F81818")])
        
        attributedString.append(superscriptAttibutedString.attributedSubstring(from: .init(location: 0, length: superscript.count)))
        return attributedString
    }

    func setCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            if sectionIndex == 1 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(100))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = .init(top: 25, leading: 10, bottom: 20, trailing: 0)
                section.interGroupSpacing = 20
                return section
            }else{
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                if sectionIndex == 2 || sectionIndex == 3 {
                    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(25))
                    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: SupplementaryViewKind.header, alignment: .top)
                    header.zIndex = 2
                    header.pinToVisibleBounds = true
                    
                    section.boundarySupplementaryItems = [header]
                    section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
                }
                return section
            }
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AddAPlaceCollectionViewInfoCell.self, forCellWithReuseIdentifier: AddAPlaceCollectionViewInfoCell.identifier)
        collectionView.register(AddAPlaceEditLocationOnMapCell.self, forCellWithReuseIdentifier: AddAPlaceEditLocationOnMapCell.identifier)
        collectionView.register(AddAPlaceImageCell.self, forCellWithReuseIdentifier: AddAPlaceImageCell.identifier)
        collectionView.register(AddAPlaceAdditionalInfoCell.self, forCellWithReuseIdentifier: AddAPlaceAdditionalInfoCell.identifer)
        collectionView.register(AddAPlaceHeaderSupplementaryView.self, forSupplementaryViewOfKind: SupplementaryViewKind.header, withReuseIdentifier: AddAPlaceHeaderSupplementaryView.identifier)
        self.collectionView = collectionView
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<Int, AddAPlaceDetailsCollectionViewHashable> {
        return UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cellData = self.sections[indexPath.section][indexPath.row]
            
            switch cellData.cellIdentifier {
            case AddAPlaceCollectionViewInfoCell.identifier:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellData.cellIdentifier, for: indexPath) as? AddAPlaceCollectionViewInfoCell else {return UICollectionViewCell()}
                cell.delegate = self
                if cellData.title.string.split(separator: .init(unicodeScalarLiteral: "*")).first ?? "" == CellTitle.category.rawValue {
                    cell.setUpUI(for: cellData, addNextBtn: true)
                    cell.txtView.isEditable = false
                }else{
                    cell.setUpUI(for: cellData)
                }
                return cell
            case  AddAPlaceEditLocationOnMapCell.identifier:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellData.cellIdentifier, for: indexPath) as? AddAPlaceEditLocationOnMapCell else {return UICollectionViewCell()}
                cell.editOnMapBtn.addTarget(self, action: #selector(self.editOnMapBtnClicked), for: .touchUpInside)
                return cell
            case AddAPlaceImageCell.identifier:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddAPlaceImageCell.identifier, for: indexPath) as? AddAPlaceImageCell else {return UICollectionViewCell()}
                cell.setUpUI(for: cellData, isAddImageCell: indexPath.row == 0)
                cell.delegate = self
                return cell
            case AddAPlaceAdditionalInfoCell.identifer:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddAPlaceAdditionalInfoCell.identifer, for: indexPath) as? AddAPlaceAdditionalInfoCell else {return UICollectionViewCell()}
                if cellData.title.string == CellTitle.openHours.rawValue {
                    cell.setUpUI(for: cellData, addNextBtn: true)
                    cell.txtView.isEditable = false
                }else {
                    cell.setUpUI(for: cellData)
                }
                cell.delegate = self
                return cell
             default:
                 return UICollectionViewCell()
            }
        }
    }
    
    func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, AddAPlaceDetailsCollectionViewHashable>()
        for (index, section) in sections.enumerated() {
            snapshot.appendSections([index])
            snapshot.appendItems(section, toSection: index)
        }
        dataSource?.apply(snapshot, animatingDifferences: false)
        
        dataSource?.supplementaryViewProvider = { (view, kind, index) in
            if kind == SupplementaryViewKind.header {
                let header = view.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AddAPlaceHeaderSupplementaryView.identifier, for: index) as! AddAPlaceHeaderSupplementaryView
                header.setUpUI(with: self.headerTitle(for: index.section))
                return header
            }else{
                return nil
            }
        }
    }
    
    @objc func editOnMapBtnClicked() {
        let vc = ChooseOnMapParentVC()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AddAPlaceViewController: AddAPlaceCollectionViewInfoCellDelegate, AddAPlaceImageCellDelegte, ChooseOnMapParentViewControllerDelegate {
    
    func addressSelected(with location: String) {
        
    }
    
    func nextBtnClicked(forTitle: String) {
        switch forTitle.split(separator: .init(unicodeScalarLiteral: "*")).first ?? "" {
        case CellTitle.category.rawValue:
            let vc = AddAPlaceCategoryViewController()
            navigationController?.pushViewController(vc, animated: true)
        case CellTitle.openHours.rawValue:
            let vc = OpenHoursSelectionViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    func addImageClicked() {
        
    }
    
    func deleteImageClicked() {
        
    }
    
    func textFieldDidChange(_ text: String, forTitle: String) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
}
