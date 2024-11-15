//
//  AddAPlaceCategoryViewController.swift
//  SwiftRedesign
//
//  Created by rento on 29/10/24.
//

import UIKit
import FittedSheets

class AddAPlaceCategoryTableViewHashable: Hashable {
    
    class SubCategoryHashable: Hashable {
        var title: String
        
        init(title: String) {
            self.title = title
        }
        
        func hash(into hasher: inout Hasher) {
            return hasher.combine(title)
        }
        
        static func == (lhs: SubCategoryHashable, rhs: SubCategoryHashable) -> Bool {
            return lhs.title == rhs.title
        }
    }
    
    var title: String
    var subCategories: [SubCategoryHashable]
    
    init(title: String, subCategories: [SubCategoryHashable]) {
        self.title = title
        self.subCategories = subCategories
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(title)
    }
    
    static func == (lhs: AddAPlaceCategoryTableViewHashable, rhs: AddAPlaceCategoryTableViewHashable) -> Bool {
        return lhs.title == rhs.title
    }
}

class AddAPlaceCategoryViewController: UIViewController {
    
    var topView: UIView!
    var searchBar: CustomSearchBarView!
    var categoryTblView: UITableView!
    var sections: [[AddAPlaceCategoryTableViewHashable]] = []
    var dataSource: UITableViewDiffableDataSource<Int, AddAPlaceCategoryTableViewHashable>!
    var filterSectionsData: [[AddAPlaceCategoryTableViewHashable]] = [[]]
    var subCategorySheetVC: SheetViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
    
    func setUpSectionsData() {
        var section: [AddAPlaceCategoryTableViewHashable] = []
        section.append(.init(title: "Hotel", subCategories: [.init(title: "Commercial Complex & Building"), .init(title: "Category")]))
        section.append(.init(title: "Restaurant", subCategories: [.init(title: "Commercial Complex & Building"), .init(title: "Category")]))
        section.append(.init(title: "Cafe", subCategories: [.init(title: "Commercial Complex & Building"), .init(title: "Category")]))
        section.append(.init(title: "Hospital or Clinic", subCategories: [.init(title: "Commercial Complex & Building"), .init(title: "Category")]))
        section.append(.init(title: "Education", subCategories: [.init(title: "Commercial Complex & Building"), .init(title: "Category")]))
        section.append(.init(title: "Doctor", subCategories: [.init(title: "Commercial Complex & Building"), .init(title: "Category")]))
        section.append(.init(title: "Pub & Bar", subCategories: [.init(title: "Commercial Complex & Building"), .init(title: "Category")]))
        section.append(.init(title: "Offices", subCategories: [.init(title: "Commercial Complex & Building"), .init(title: "Category")]))

        sections.append(section)
        filterSectionsData = sections
    }
    
    func setUpUI() {
        setUpSectionsData()
        
        view.backgroundColor = .white
        
        let topView = UIView()
        topView.backgroundColor = .white
        topView.layer.shadowRadius = 1
        topView.layer.shadowColor = UIColor(hex: "#0000004D").cgColor
        topView.layer.shadowOpacity = 0.7
        topView.layer.shadowOffset = .zero
        topView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topView)
        
        self.topView = topView
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let backBtn = UIButton()
        backBtn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backBtn.contentMode = .scaleAspectFit
        backBtn.addTarget(self, action: #selector(self.backBtnClicked), for: .touchUpInside)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(backBtn)
        
        NSLayoutConstraint.activate([
            backBtn.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            backBtn.leadingAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            backBtn.heightAnchor.constraint(equalToConstant: 22),
            backBtn.widthAnchor.constraint(equalToConstant: 22)
        ])
        
        let titleLbl = UILabel()
        titleLbl.text = "Category"
        titleLbl.font = .sfProText.semiBold.ofSize(size: .medium)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(titleLbl)
        
        NSLayoutConstraint.activate([
            titleLbl.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            titleLbl.centerXAnchor.constraint(equalTo: topView.centerXAnchor)
        ])
        
        let searchBar = CustomSearchBarView()
        searchBar.searchTextField.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        self.searchBar = searchBar
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        setCategoryTableView()
        
        dataSource = makeDataSource()
        applyInitialSnapshot()
    }
    
    func setCategoryTableView() {
        categoryTblView = UITableView()
        categoryTblView.delegate = self
        categoryTblView.register(AddAPlaceCategoryCell.self, forCellReuseIdentifier: AddAPlaceCategoryCell.identifier)
        categoryTblView.separatorInset = .zero
        categoryTblView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryTblView)
        
        NSLayoutConstraint.activate([
            categoryTblView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5),
            categoryTblView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            categoryTblView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            categoryTblView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func makeDataSource() -> UITableViewDiffableDataSource<Int, AddAPlaceCategoryTableViewHashable> {
        let dataSource = UITableViewDiffableDataSource<Int, AddAPlaceCategoryTableViewHashable>(tableView: categoryTblView) { tableView, indexPath, itemIdentifier in
            let cellData = self.filterSectionsData[indexPath.section][indexPath.row]
            guard let cell = self.categoryTblView.dequeueReusableCell(withIdentifier: AddAPlaceCategoryCell.identifier) as? AddAPlaceCategoryCell else {return UITableViewCell()}
            cell.setUpUI(with: cellData)
            cell.selectionStyle = .none
            return cell
        }
        
        return dataSource
    }
    
    func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, AddAPlaceCategoryTableViewHashable>()
        for (index, section) in filterSectionsData.enumerated() {
            snapshot.appendSections([index])
            snapshot.appendItems(section, toSection: index)
        }
        dataSource.apply(snapshot)
    }
    
    override func viewDidLayoutSubviews() {
        let shadowSize: CGFloat = 20
        let contactRect = CGRect(x: -shadowSize, y: topView.frame.height - (shadowSize * 0.4), width: topView.frame.width + shadowSize * 2, height: 10)
        topView.layer.shadowPath = UIBezierPath(rect: contactRect).cgPath
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setSheetSize(isPortrait: traitCollection.verticalSizeClass == .regular)
    }
    
    func setSheetSize(isPortrait: Bool) {
        if isPortrait {
            subCategorySheetVC?.sizes = [.percent(0.25), .percent(0.9)]
            if subCategorySheetVC?.currentSize == .percent(1.0) {
                subCategorySheetVC?.resize(to: .percent(0.9))
            }else {
                subCategorySheetVC?.resize(to: .percent(0.25))
            }
        }else {
            subCategorySheetVC?.sizes = [.percent(0.16), .percent(1.0)]
            if subCategorySheetVC?.currentSize == .percent(0.9) {
                subCategorySheetVC?.resize(to: .percent(1.0))
            }else {
                subCategorySheetVC?.resize(to: .percent(0.16))
            }
        }
    }
    
    @objc func backBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
}

extension AddAPlaceCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = filterSectionsData[indexPath.section][indexPath.row]
        let vc = AddAPlaceSubCategoryViewController(for: cellData)
        vc.delegate = self
        var options = SheetOptions()
        options.transitionAnimationOptions = .curveLinear
        options.useInlineMode = true
        options.pullBarHeight = 40
        
        let sheet = SheetViewController(controller: vc, options: options)
        sheet.dismissOnPull = false
        sheet.cornerRadius = 15.0
        sheet.gripColor = .init(hex: "#DDDDDD")
        sheet.allowPullingPastMaxHeight = false
        sheet.allowPullingPastMinHeight = false
        sheet.allowGestureThroughOverlay = false
        sheet.animateIn(to: view, in: self)
        
        subCategorySheetVC = sheet
        
        setSheetSize(isPortrait: traitCollection.verticalSizeClass == .regular)
        
        sheet.handleScrollView(vc.tblView)
    }
}

extension AddAPlaceCategoryViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, AddAPlaceCategoryTableViewHashable>()
        if textField.text == "" {
            filterSectionsData = sections
        } else {
            filterSectionsData = []
            for (_, section) in sections.enumerated() {
                let section = section.filter { $0.title.lowercased().contains(textField.text?.lowercased() ?? "") }
                filterSectionsData.append(section)
            }
        }
        for (index, section) in filterSectionsData.enumerated() {
            snapshot.appendSections([index])
            snapshot.appendItems(section, toSection: index)
        }
        dataSource.apply(snapshot)
    }
}

extension AddAPlaceCategoryViewController: AddAPlaceSubCategoryViewControllerDelegate {
    func didSelectSubCategory(_ category: AddAPlaceCategoryTableViewHashable.SubCategoryHashable) {
        
    }
}
