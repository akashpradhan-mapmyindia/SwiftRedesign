//
//  PostOnMapCategoryViewController.swift
//  SwiftRedesign
//
//  Created by rento on 13/11/24.
//

import UIKit

class PostOnMapCategoryHashable: Hashable {
    
    var image: UIImage
    var title: String
    var subCategories: [PostOnMapSubCategoryHashable]
    
    init(image: UIImage, title: String, subCategories: [PostOnMapSubCategoryHashable]) {
        self.image = image
        self.title = title
        self.subCategories = subCategories
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(title)
    }
    
    static func == (lhs: PostOnMapCategoryHashable, rhs: PostOnMapCategoryHashable) -> Bool {
        return lhs.title == rhs.title
    }
}

class PostOnMapSubCategoryHashable: Hashable {
    
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(title)
    }
    
    static func == (lhs: PostOnMapSubCategoryHashable, rhs: PostOnMapSubCategoryHashable) -> Bool {
        return lhs.title == rhs.title
    }
}

class PostOnMapCategoryViewController: UIViewController {
    
    enum SupplementaryViewKind: String {
        case header = "headerKind"
    }
    
    var categoryCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Int, PostOnMapCategoryHashable>!
    var sections: [[PostOnMapCategoryHashable]] = []
    var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
    
    func setUpUI() {
        navigationController?.isNavigationBarHidden = true
        
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
        titleLbl.text = "Post on Map"
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
        
        setCategorySectionsData()
        setCategoryCollectionView()
        dataSource = makeDataSource()
        applyInitialSnapshot()
    }
    
    func setCategorySectionsData() {
        var section: [PostOnMapCategoryHashable] = []
        section.append(.init(image: UIImage(named: "fab-tringa")!, title: "Har Ghar Triranga", subCategories: [.init(title: "I hosted a flag"), .init(title: "This place hosted a flag")]))
        section.append(.init(image: UIImage(named: "Swachh-Bharat")!, title: "Swachh Bharat", subCategories: [.init(title: "I hosted a flag"), .init(title: "This place hosted a flag")]))
        section.append(.init(image: UIImage(named: "Aham-Brahmasmi")!, title: "Aham Brahmasmi", subCategories: [.init(title: "I hosted a flag"), .init(title: "This place hosted a flag")]))
        section.append(.init(image: UIImage(named: "UNICEF School")!, title: "UNICEF School", subCategories: [.init(title: "I hosted a flag"), .init(title: "This place hosted a flag")]))
        section.append(.init(image: UIImage(named: "safety")!, title: "Safety", subCategories: [.init(title: "I hosted a flag"), .init(title: "This place hosted a flag")]))
        section.append(.init(image: UIImage(named: "traffic")!, title: "Traffic", subCategories: [.init(title: "I hosted a flag"), .init(title: "This place hosted a flag")]))
        
        sections.append(section)
    }
    
    func setCategoryCollectionView() {
        let layout = UICollectionViewCompositionalLayout { section, layoutEnvironment in
            var group: NSCollectionLayoutGroup!
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(150))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
            if layoutEnvironment.traitCollection.verticalSizeClass == .regular {
                group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
            }else {
                group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 6)
            }
            group.interItemSpacing = .fixed(30)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 18
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: SupplementaryViewKind.header.rawValue, alignment: .top)
            section.boundarySupplementaryItems = [header]
            
            return section
        }
        
        categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        categoryCollectionView.register(PostOnMapFixOnMapCategoryItemCell.self, forCellWithReuseIdentifier: PostOnMapFixOnMapCategoryItemCell.identifier)
        categoryCollectionView.register(CollectionViewSupplementaryItemTextView.self, forSupplementaryViewOfKind: SupplementaryViewKind.header.rawValue, withReuseIdentifier: CollectionViewSupplementaryItemTextView.identifier)
        categoryCollectionView.delegate = self
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryCollectionView)
        
        NSLayoutConstraint.activate([
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            categoryCollectionView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            categoryCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, PostOnMapCategoryHashable>()
        for (index, section) in sections.enumerated() {
            snapshot.appendSections([index])
            snapshot.appendItems(section, toSection: index)
        }
        dataSource.apply(snapshot)
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, index) in
            if index.section == 0 {
                let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewSupplementaryItemTextView.identifier, for: index) as! CollectionViewSupplementaryItemTextView
                cell.setUpUI(for: "Select Category", font: .sfProText.medium.ofSize(size: .regular))
                return cell
            }
            return nil
        }
    }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<Int, PostOnMapCategoryHashable> {
        let dataSource = UICollectionViewDiffableDataSource<Int, PostOnMapCategoryHashable>(collectionView: categoryCollectionView) { collectionView, indexPath, itemIdentifier in
            let cellData = self.sections[indexPath.section][indexPath.row]
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostOnMapFixOnMapCategoryItemCell.identifier, for: indexPath) as? PostOnMapFixOnMapCategoryItemCell else {return UICollectionViewCell()}
            cell.setUpUI(for: cellData)
            return cell
        }
        return dataSource
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

extension PostOnMapCategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellData = sections[0][indexPath.row]
        let vc = PostOnMapSubCategoryViewController(category: cellData)
        navigationController?.pushViewController(vc, animated: true)
    }
}

