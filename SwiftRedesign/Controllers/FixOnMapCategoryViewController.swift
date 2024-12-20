//
//  FixOnMapCategoryViewController.swift
//  SwiftRedesign
//
//  Created by rento on 12/11/24.
//

import UIKit

class FixOnMapCategoryHashable: Hashable {
    
    var title: String
    var image: UIImage
    
    init(title: String, image: UIImage) {
        self.title = title
        self.image = image
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(title)
    }
    
    static func == (lhs: FixOnMapCategoryHashable, rhs: FixOnMapCategoryHashable) -> Bool {
        return lhs.title == rhs.title
    }
}

class FixOnMapCategoryViewController: UIViewController {
    
    enum SupplementaryViewKind: String {
        case header = "headerKind"
    }
    
    var categoryCollectionView: UICollectionView!
    var topView: UIView!
    var section: [FixOnMapCategoryHashable] = []
    var dataSource: UICollectionViewDiffableDataSource<Int, FixOnMapCategoryHashable>!
    
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
        titleLbl.text = "Fix Map"
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
        var snapshot = NSDiffableDataSourceSnapshot<Int, FixOnMapCategoryHashable>()
        snapshot.appendSections([0])
        snapshot.appendItems(section, toSection: 0)
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
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<Int, FixOnMapCategoryHashable> {
        let dataSource = UICollectionViewDiffableDataSource<Int, FixOnMapCategoryHashable>(collectionView: categoryCollectionView) { collectionView, indexPath, itemIdentifier in
            let cellData = self.section[indexPath.row]
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostOnMapFixOnMapCategoryItemCell.identifier, for: indexPath) as? PostOnMapFixOnMapCategoryItemCell else {return UICollectionViewCell()}
            cell.setUpUI(for: cellData)
            return cell
        }
        return dataSource
    }
    
    func setCategorySectionsData() {
        section.append(.init(title: "New Road", image: UIImage(named: "new-road")!))
        section.append(.init(title: "Incorrect Name", image: UIImage(named: "incorrect-name")!))
        section.append(.init(title: "Place Missing", image: UIImage(named: "place-missing")!))
        section.append(.init(title: "Road Missing", image: UIImage(named: "road-missing")!))
        section.append(.init(title: "Invalid Turn", image: UIImage(named: "invalid-turn")!))
    }
    
    @objc func backBtnClicked() {
        customDismiss(animated: true)
    }
}

extension FixOnMapCategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PostOnMapFixOnMapEnterDetailsViewController(fixOnMapCategory: section[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
