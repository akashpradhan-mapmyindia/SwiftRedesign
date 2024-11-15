//
//  PostOnMapSubCategoryViewController.swift
//  SwiftRedesign
//
//  Created by rento on 13/11/24.
//

import UIKit

class PostOnMapSubCategoryViewController: UIViewController {
    
    var subCategoryTblView: UITableView!
    var category: PostOnMapCategoryHashable
    var dataSource: UITableViewDiffableDataSource<Int, PostOnMapSubCategoryHashable>!
    var topView: UIView!
    
    init(category: PostOnMapCategoryHashable) {
        self.category = category
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
        titleLbl.text = "Post on Map"
        titleLbl.font = .sfProText.semiBold.ofSize(size: .medium)
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
        
        subCategoryTblView = UITableView()
        subCategoryTblView.delegate = self
        subCategoryTblView.register(PostOnMapSubCategoryCell.self, forCellReuseIdentifier: PostOnMapSubCategoryCell.identifier)
        subCategoryTblView.separatorStyle = .none
        if #available(iOS 15.0, *) {
            subCategoryTblView.sectionHeaderTopPadding = 0
        }
        subCategoryTblView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subCategoryTblView)
        
        NSLayoutConstraint.activate([
            subCategoryTblView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            subCategoryTblView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            subCategoryTblView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            subCategoryTblView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        sheetViewController?.handleScrollView(subCategoryTblView)
        
        dataSource = makeDataSource()
        applyInitialSnapshot()
    }
    
    func makeDataSource() -> UITableViewDiffableDataSource<Int, PostOnMapSubCategoryHashable> {
        let dataSource = UITableViewDiffableDataSource<Int, PostOnMapSubCategoryHashable>(tableView: subCategoryTblView) { tableView, indexPath, itemIdentifier in
            let cellData = self.category.subCategories[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostOnMapSubCategoryCell.identifier) as? PostOnMapSubCategoryCell else {return UITableViewCell()}
            cell.setUpUI(for: cellData, with: self.category.image)
            cell.selectionStyle = .none
            return cell
        }
        return dataSource
    }
    
    func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, PostOnMapSubCategoryHashable>()
        snapshot.appendSections([0])
        snapshot.appendItems(category.subCategories, toSection: 0)
        dataSource.apply(snapshot)
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

extension PostOnMapSubCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PostOnMapFixOnMapEnterDetailsViewController(postOnMapCategory: category, subCategoryIndex: indexPath.row)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = CommonTableHeaderFooterView()
        header.setUpUI(for: "Select Category", font: .sfProText.medium.ofSize(size: .regular))
        header.backgroundColor = .white
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

