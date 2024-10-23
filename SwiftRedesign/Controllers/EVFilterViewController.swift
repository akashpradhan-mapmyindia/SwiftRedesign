//
//  EVFilterViewController.swift
//  SwiftRedesign
//
//  Created by rento on 22/10/24.
//

import UIKit

class EVFilter {
    
    var catcode, displayName, key, selectionType: String?
    var values: [EVFilterValueHashable]?
    
    init(catcode: String? = nil, displayName: String? = nil, key: String? = nil, selectionType: String? = nil, values: [EVFilterValueHashable]? = nil) {
        self.catcode = catcode
        self.displayName = displayName
        self.key = key
        self.selectionType = selectionType
        self.values = values
    }
}

class EVFilterValueHashable: Hashable {
    var isSelected: Bool
    var name: String
    var id: String
    
    init(name: String, id: String, isSelected: Bool = false) {
        self.name = name
        self.id = id
        self.isSelected = isSelected
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    static func == (lhs: EVFilterValueHashable, rhs: EVFilterValueHashable) -> Bool {
        return lhs.id == rhs.id
    }
}

class EVFilterViewController: UIViewController {
    
    struct ElementKind {
        static let badge = "badge-element-kind"
        static let background = "background-element-kind"
        static let sectionHeader = "section-header-element-kind"
        static let sectionFooter = "section-footer-element-kind"
        static let layoutHeader = "layout-header-element-kind"
        static let layoutFooter = "layout-footer-element-kind"
    }
    
    var topBar: UIView!
    var headerLbl: UILabel!
    var applyBtn: UIButton!
    
    var filtersCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Int, EVFilterValueHashable>!
    var sections: [EVFilter] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
    
    func setUpUI() {
        view.backgroundColor = .white
        
        setTopBar()
        setHeaderLbl()
        setApplyBtn()
        
        setUpFilterData()
        setFiltersCollectionView()
        dataSource = makeDataSource()
        applyInitialSnapshot()
    }
    
    func setHeaderLbl() {
        let headerLbl = UILabel()
        headerLbl.text = "Please select one or more options."
        headerLbl.font = .systemFont(ofSize: 13, weight: .medium)
        headerLbl.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        view.addSubview(headerLbl)
        headerLbl.translatesAutoresizingMaskIntoConstraints = false
        self.headerLbl = headerLbl
        
        NSLayoutConstraint.activate([
            headerLbl.topAnchor.constraint(equalTo: topBar.bottomAnchor),
            headerLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            headerLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            headerLbl.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setApplyBtn() {
        let btn = UIButton(type: .system)
        btn.setTitle("Apply", for: .normal)
        btn.addTarget(self, action: #selector(self.applyBtnClicked), for: .touchUpInside)
        btn.layer.cornerRadius = 8
        btn.titleLabel?.font = .systemFont(ofSize: 18)
        btn.layer.masksToBounds = true
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(red: 0.20, green: 0.62, blue: 0.51, alpha: 1.00)
        view.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        self.applyBtn = btn
        
        NSLayoutConstraint.activate([
            btn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            btn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            btn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            btn.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func applyBtnClicked() {
        
    }
    
    func setTopBar() {
        let topBar = UIView()
        view.addSubview(topBar)
        topBar.translatesAutoresizingMaskIntoConstraints = false
        self.topBar = topBar
        
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let titleLbl = UILabel()
        titleLbl.text = "Filters"
        titleLbl.font = .systemFont(ofSize: 18, weight: .medium)
        topBar.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLbl.centerXAnchor.constraint(equalTo: topBar.centerXAnchor),
            titleLbl.centerYAnchor.constraint(equalTo: topBar.centerYAnchor)
        ])
        
        let resetBtn = UIButton(type: .roundedRect)
        resetBtn.setTitle("Reset", for: .normal)
        resetBtn.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        resetBtn.addTarget(self, action: #selector(self.resetBtnClicked), for: .touchUpInside)
        topBar.addSubview(resetBtn)
        resetBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            resetBtn.trailingAnchor.constraint(equalTo: topBar.trailingAnchor, constant: -10),
            resetBtn.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            resetBtn.heightAnchor.constraint(equalToConstant: 40),
            resetBtn.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        let backBtn = UIButton()
        backBtn.setImage(UIImage(systemName: "xmark")!, for: .normal)
        backBtn.addTarget(self, action: #selector(self.backBtnPressed), for: .touchUpInside)
        backBtn.contentMode = .scaleAspectFit
        topBar.addSubview(backBtn)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backBtn.leadingAnchor.constraint(equalTo: topBar.leadingAnchor, constant: 10),
            backBtn.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            backBtn.heightAnchor.constraint(equalToConstant: 40),
            backBtn.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setUpFilterData() {
        let section1 = EVFilter(displayName: "Electric Charging Plug", values: [.init(name: "Type 2", id: "4"), .init(name: "Type 1", id: "5"), .init(name: "Ather", id: "6")])
        let section2 = EVFilter(displayName: "Electric Charging Network", values: [.init(name: "Revolt", id: "0"), .init(name: "Indian Oil", id: "1"), .init(name: "Tata Power", id: "2"), .init(name: "Powergrid", id: "3")])
        
        sections.append(section1)
        sections.append(section2)
    }
    
    func setFiltersCollectionView() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(30))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: ElementKind.sectionHeader, alignment: .top)
        sectionHeader.zIndex = 2
        sectionHeader.pinToVisibleBounds = true

        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(10))
        
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: ElementKind.sectionFooter, alignment: .bottom)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        filtersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        filtersCollectionView.register(EVFilterCollectionViewCell.self, forCellWithReuseIdentifier: EVFilterCollectionViewCell.identifier)
        filtersCollectionView.delegate = self
        view.addSubview(filtersCollectionView)
        filtersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            filtersCollectionView.topAnchor.constraint(equalTo: headerLbl.bottomAnchor),
            filtersCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            filtersCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            filtersCollectionView.bottomAnchor.constraint(equalTo: applyBtn.topAnchor, constant: -10)
        ])
    }
    
    func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, EVFilterValueHashable>()
        
        for (index, section) in sections.enumerated() {
            snapshot.appendSections([index])
            snapshot.appendItems(section.values ?? [], toSection: index)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
        
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <EVFilterHeaderTitleSupplementaryView>(elementKind: ElementKind.sectionHeader) {
            (supplementaryView, string, indexPath) in
            supplementaryView.titleLbl.text = self.sections[indexPath.section].displayName
        }
        
        let footerRegistration = UICollectionView.SupplementaryRegistration
        <EVFilterFooterLineSupplementaryView>(elementKind: ElementKind.sectionFooter) {
            (supplementaryView, string, indexPath) in
            if indexPath.section == self.sections.count-1 {
                supplementaryView.lineView.backgroundColor = .clear
            }
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            if kind == ElementKind.sectionFooter {
                return self.filtersCollectionView.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: index)
            }else {
                return self.filtersCollectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: index)
            }
        }
    }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<Int, EVFilterValueHashable> {
        let cellRegistration = UICollectionView.CellRegistration<EVFilterCollectionViewCell, EVFilterValueHashable> { cell, indexPath, filter in
            cell.setUpUI(for: filter)
        }
        
        return UICollectionViewDiffableDataSource<Int, EVFilterValueHashable>(
            collectionView: filtersCollectionView,
            cellProvider: { collectionView, indexPath, item in
                collectionView.dequeueConfiguredReusableCell(
                    using: cellRegistration,
                    for: indexPath,
                    item: item
                )
            }
        )
    }
    
    @objc func resetBtnClicked() {
        
    }
    
    @objc func backBtnPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension EVFilterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedItem = dataSource.itemIdentifier(for: indexPath) {
            selectedItem.isSelected.toggle()
            var snapshot = dataSource.snapshot()
            snapshot.reloadItems([selectedItem])
            
            dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}
