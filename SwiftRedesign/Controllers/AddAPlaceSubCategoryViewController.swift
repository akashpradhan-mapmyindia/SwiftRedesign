//
//  AddAPlaceSubCategoryViewController.swift
//  SwiftRedesign
//
//  Created by rento on 05/11/24.
//

import UIKit
import FittedSheets

protocol AddAPlaceSubCategoryViewControllerDelegate: Sendable {
    func didSelectSubCategory(_ category: AddAPlaceCategoryTableViewHashable.SubCategoryHashable) async
}

class AddAPlaceSubCategoryViewController: UIViewController {
    
    var delegate: AddAPlaceSubCategoryViewControllerDelegate?
    
    var tblView: UITableView!
    var titleLbl: UILabel!
    var category: AddAPlaceCategoryTableViewHashable!
    var dataSource: UITableViewDiffableDataSource<Int, AddAPlaceCategoryTableViewHashable.SubCategoryHashable>!
    
    convenience init(for item: AddAPlaceCategoryTableViewHashable) {
        self.init()
        category = item
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
    
    func setUpUI() {
        titleLbl = UILabel()
        titleLbl.text = category.title
        titleLbl.font = .sfProText.semiBold.ofSize(size: .medium)
        titleLbl.textAlignment = .left
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLbl)
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            titleLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        let cancelBtn = CustomButton()
        cancelBtn.setImage(UIImage(named: "clear 1"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(self.cancelBtnClicked), for: .touchUpInside)
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cancelBtn)
        
        NSLayoutConstraint.activate([
            cancelBtn.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor),
            cancelBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            cancelBtn.heightAnchor.constraint(equalToConstant: 22),
            cancelBtn.widthAnchor.constraint(equalToConstant: 22)
        ])
        
        tblView = UITableView()
        tblView.register(AddAPlaceCategoryCell.self, forCellReuseIdentifier: AddAPlaceCategoryCell.identifier)
        tblView.delegate = self
        tblView.separatorInset = .zero
        tblView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tblView)
        
        NSLayoutConstraint.activate([
            tblView.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 10),
            tblView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            tblView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            tblView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        dataSource = makeDataSource()
        applyIntialSnapshot()
    }
    
    func makeDataSource() -> UITableViewDiffableDataSource<Int, AddAPlaceCategoryTableViewHashable.SubCategoryHashable> {
        let dataSource = UITableViewDiffableDataSource<Int, AddAPlaceCategoryTableViewHashable.SubCategoryHashable>(tableView: tblView) { tableView, indexPath, itemIdentifier in
            let cellData = self.category.subCategories[indexPath.row]
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddAPlaceCategoryCell.identifier, for: indexPath) as? AddAPlaceCategoryCell else {return UITableViewCell()}
            cell.setUpUI(forSubcategory: cellData)
            cell.selectionStyle = .none
            return cell
        }
        
        return dataSource
    }
    
    func applyIntialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, AddAPlaceCategoryTableViewHashable.SubCategoryHashable>()
        snapshot.appendSections([0])
        snapshot.appendItems(category.subCategories, toSection: 0)
        
        dataSource.apply(snapshot)
    }
    
    @objc func cancelBtnClicked() {
        customDismiss(animated: true)
    }
}

extension AddAPlaceSubCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Task {
            let subCat = category.subCategories[indexPath.row]
            await delegate?.didSelectSubCategory(subCat)
        }
    }
}
