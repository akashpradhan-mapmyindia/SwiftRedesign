//
//  MyLayers.swift
//  SwiftRedesign
//
//  Created by rento on 14/10/24.
//

import UIKit
import FittedSheets

struct CellData {
    let cellName: String
    let cellId: String
}

struct SectionInfo {
    let header: String
    var cells: [CellData]
}

protocol MyLayersVCDelegate: AnyObject {
    func dismissSheet()
}

class MyLayersVC: UIViewController {
    var containerTblV: UITableView!
    var sections: [SectionInfo] = []
    var mapStyles: [MapStyles] = [.init(style: .defaultMap, isSelected: true), .init(style: .satelliteMap), .init(style: .terrainMap), .init(style: .greyMap), .init(style: .sublimeGreyMap), .init(style: .darkClassicMap)]
    weak var delegate: MyLayersVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
    }
    
    func setCellData() {
        var section = SectionInfo(header: "", cells: [])
        var cell = CellData(cellName: "", cellId: MyLayersTopComponent.identifier)
        section.cells.append(cell)
        sections.append(section)
        section.cells.removeAll()
        cell = CellData(cellName: "", cellId: MyLayersStyleComponent.identifier)
        section.cells.append(cell)
        sections.append(section)
        section.cells.removeAll()
        cell = CellData(cellName: "", cellId: "LayersHeaderCell")
        section.cells.append(cell)
        cell = CellData(cellName: "My Layers", cellId: LayersListItemCell.identifier)
        section.cells.append(cell)
        cell = CellData(cellName: "Posts", cellId: LayersListItemCell.identifier)
        section.cells.append(cell)
        sections.append(section)
    }
    
    func setUpUI() {
        setCellData()
        
        containerTblV = UITableView()
        containerTblV.delegate = self
        containerTblV.dataSource = self
        containerTblV.register(MyLayersTopComponent.self, forCellReuseIdentifier: MyLayersTopComponent.identifier)
        containerTblV.register(MyLayersStyleComponent.self, forCellReuseIdentifier: MyLayersStyleComponent.identifier)
        containerTblV.register(LayersHeaderCell.self, forCellReuseIdentifier: LayersHeaderCell.identifier)
        containerTblV.register(LayersListItemCell.self, forCellReuseIdentifier: LayersListItemCell.identifier)
        containerTblV.separatorStyle = .none
        view.addSubview(containerTblV)
        containerTblV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerTblV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerTblV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerTblV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerTblV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MyLayersVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        if section == 2 {
            view.backgroundColor = .lightGray
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 10
        }else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = sections[indexPath.section].cells[indexPath.row]
        
        switch cellData.cellId {
        case MyLayersTopComponent.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyLayersTopComponent.identifier, for: indexPath) as? MyLayersTopComponent else {return UITableViewCell()}
            cell.delegate = self
            cell.selectionStyle = .none
            return cell

        case MyLayersStyleComponent.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyLayersStyleComponent.identifier, for: indexPath) as? MyLayersStyleComponent else {return UITableViewCell()}
            cell.setUpUI(mapStyles: mapStyles)
            cell.stylesItems.delegate = self
            cell.selectionStyle = .none
            return cell
            
        case LayersHeaderCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LayersHeaderCell.identifier, for: indexPath) as? LayersHeaderCell else {return UITableViewCell()}
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        case LayersListItemCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LayersListItemCell.identifier, for: indexPath) as? LayersListItemCell else {return UITableViewCell()}
            if cellData.cellName == "My Layers" {
                cell.setUpUI(title: "My Layers", subtitle: "My Saves, My Favourites, My Gadgets etc.")
            }else if cellData.cellName == "Posts" {
                cell.setUpUI(title: "Posts", subtitle: "Traffic, Safety and Commnunity Reports Overlays")
            }
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension MyLayersVC: LayersHeaderCellDelegate {
    func layersInfoBtnClicked() {
        
    }
}

extension MyLayersVC: UICollectionViewDelegate {    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = containerTblV.cellForRow(at: .init(row: 0, section: 1)) as? MyLayersStyleComponent else {return}
        if let selectedItem = cell.dataSource.itemIdentifier(for: indexPath) {
            var snapshot = cell.dataSource.snapshot()
            let cells = cell.dataSource.snapshot().itemIdentifiers(inSection: .one)
            var cellsToRelaod: [MapStyles] = []
            cells.forEach { style in
                if style != selectedItem {
                    if style.isSelected {
                        style.isSelected = false
                        cellsToRelaod.append(style)
                    }else {
                        style.isSelected = false
                    }
                }else{
                    style.isSelected = true
                    cellsToRelaod.append(style)
                }
            }
            snapshot.reloadItems(cellsToRelaod)
            cell.dataSource.apply(snapshot)
        }
    }
}

extension MyLayersVC: MyLayersTopComponentDelegate {
    func infoBtnPressed() {
        
    }
    
    func closeBtnPressed() {
        delegate?.dismissSheet()
    }
}

protocol MyLayersTopComponentDelegate: AnyObject {
    func infoBtnPressed()
    func closeBtnPressed()
}

class MyLayersTopComponent: UITableViewCell {
    static let identifier: String = "MyLayersTopComponent"
    
    weak var delegate: MyLayersTopComponentDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        let titleLbl = UILabel()
        titleLbl.text = "My Map"
        titleLbl.font = .systemFont(ofSize: 17, weight: .medium)
        contentView.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
        
        let infoBtn = UIButton(type: .system)
        infoBtn.setImage(UIImage(systemName: "info.circle"), for: .normal)
        infoBtn.addTarget(self, action: #selector(self.infoBtnPressed), for: .touchUpInside)
        contentView.addSubview(infoBtn)
        infoBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            infoBtn.leadingAnchor.constraint(equalTo: titleLbl.trailingAnchor, constant: 10),
            infoBtn.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor),
            infoBtn.heightAnchor.constraint(equalToConstant: 30),
            infoBtn.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        let closeBtn = UIButton()
        closeBtn.setBackgroundImage(UIImage(systemName: "xmark.circle.fill")!, for: .normal)
        closeBtn.imageView?.contentMode = .scaleAspectFit
        closeBtn.addTarget(self, action: #selector(self.closeBtnPressed), for: .touchUpInside)
        contentView.addSubview(closeBtn)
        closeBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closeBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            closeBtn.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor),
            closeBtn.heightAnchor.constraint(equalToConstant: 25),
            closeBtn.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    @objc func infoBtnPressed() {
        delegate?.infoBtnPressed()
    }
    
    @objc func closeBtnPressed() {
        delegate?.closeBtnPressed()
    }
}

enum Style: String {
    case defaultMap = "Default Map"
    case satelliteMap = "Satellite Map"
    case terrainMap = "Terrain Map"
    case greyMap = "Grey Map"
    case sublimeGreyMap = "Sublime Grey Map"
    case darkClassicMap = "Dark Classic Map"
}

class MapStyles: Hashable {
    
    var name: String
    var image: UIImage
    var isSelected: Bool
    
    init(style: Style, image: UIImage = UIImage(systemName: "photo")!, isSelected: Bool = false) {
        self.name = style.rawValue
        self.image = image
        self.isSelected = isSelected
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(name)
    }
    
    static func == (lhs: MapStyles, rhs: MapStyles) -> Bool {
        return lhs.name == rhs.name
    }
}

class MyLayersStyleComponent: UITableViewCell {
    
    enum Section: CaseIterable {
        case one
    }
    
    static let identifier: String = "MyLayersStyleComponent"
    
    var stylesItems: UICollectionView!
    var threeDBtn: ToggleView!
    var visualTrafficBtn: ToggleView!
    var dataSource: UICollectionViewDiffableDataSource<Section, MapStyles>!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, MapStyles> {
        
        let cellRegistration = UICollectionView.CellRegistration<MapStyleItemCell, MapStyles> { cell, indexPath, style in
            
            cell.setUpUI(image: style.image, styleName: style.name, isSelected: style.isSelected)
        }
        
        return UICollectionViewDiffableDataSource<Section, MapStyles>(
            collectionView: stylesItems,
            cellProvider: { collectionView, indexPath, item in
                collectionView.dequeueConfiguredReusableCell(
                    using: cellRegistration,
                    for: indexPath,
                    item: item
                )
            }
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyInitialSnapshot(mapStyles: [MapStyles]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MapStyles>()
        snapshot.appendSections([.one])
        
        snapshot.appendItems(mapStyles, toSection: .one)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func setUpUI(mapStyles: [MapStyles]) {
        let titleLbl = UILabel()
        titleLbl.text = "Style"
        titleLbl.font = .systemFont(ofSize: 18, weight: .regular)
        contentView.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/3.5), heightDimension: .absolute(130))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = .init(leading: .flexible(5), top: .fixed(0), trailing: .flexible(5), bottom: .fixed(0))
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(280))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        
        let layout = UICollectionViewCompositionalLayout(section: section)
    
        let stylesItems = UICollectionView(frame: .zero, collectionViewLayout: layout)
        stylesItems.translatesAutoresizingMaskIntoConstraints = false
        stylesItems.register(MapStyleItemCell.self, forCellWithReuseIdentifier: MapStyleItemCell.identifier)
        stylesItems.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(stylesItems)
        
        NSLayoutConstraint.activate([
            stylesItems.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 10),
            stylesItems.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor),
            stylesItems.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stylesItems.heightAnchor.constraint(equalToConstant: 280)
        ])
        
        self.stylesItems = stylesItems
        dataSource = makeDataSource()
        applyInitialSnapshot(mapStyles: mapStyles)
        
        let threeDBtn = ToggleView(title: "3D View")
        self.threeDBtn = threeDBtn
        threeDBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let visualTrafficBtn = ToggleView(title: "Visual Traffic")
        self.visualTrafficBtn = visualTrafficBtn
        visualTrafficBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let btnStack = UIStackView(arrangedSubviews: [threeDBtn, visualTrafficBtn])
        btnStack.axis = .vertical
        btnStack.distribution = .fillEqually
        btnStack.spacing = 5
        contentView.addSubview(btnStack)
        btnStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btnStack.topAnchor.constraint(equalTo: stylesItems.bottomAnchor, constant: 10),
            btnStack.leadingAnchor.constraint(equalTo: stylesItems.leadingAnchor),
            btnStack.trailingAnchor.constraint(equalTo: stylesItems.trailingAnchor),
            btnStack.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        let earthTitle = UILabel()
        earthTitle.textAlignment = .left
        earthTitle.text = "Earth Observation Data"
        earthTitle.font = .systemFont(ofSize: 15, weight: .medium)
        earthTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let sourceLbl = UILabel()
        sourceLbl.textAlignment = .left
        sourceLbl.text = "Source: ISRO"
        sourceLbl.font = .systemFont(ofSize: 13, weight: .regular)
        sourceLbl.translatesAutoresizingMaskIntoConstraints = false
        
        let earthImgV = UIImageView(image: UIImage(systemName: "globe.asia.australia")!)
        earthImgV.contentMode = .scaleAspectFit
        earthImgV.translatesAutoresizingMaskIntoConstraints = false
        
        let rightIconImgV = UIImageView(image: UIImage(systemName: "chevron.right")!)
        rightIconImgV.contentMode = .scaleAspectFit
        rightIconImgV.translatesAutoresizingMaskIntoConstraints = false
    
        let titleStack = UIStackView(arrangedSubviews: [earthTitle, sourceLbl])
        titleStack.axis = .vertical
        titleStack.spacing = 5
        titleStack.alignment = .leading
        titleStack.distribution = .equalSpacing
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        
        let earthObsrvButton = UIView()
        contentView.addSubview(earthObsrvButton)
        earthObsrvButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            earthObsrvButton.topAnchor.constraint(equalTo: btnStack.bottomAnchor, constant: 10),
            earthObsrvButton.leadingAnchor.constraint(equalTo: btnStack.leadingAnchor),
            earthObsrvButton.trailingAnchor.constraint(equalTo: btnStack.trailingAnchor),
            earthObsrvButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        earthObsrvButton.addSubview(titleStack)
        
        NSLayoutConstraint.activate([
            titleStack.leadingAnchor.constraint(equalTo: earthObsrvButton.leadingAnchor),
            titleStack.topAnchor.constraint(equalTo: earthObsrvButton.topAnchor),
            titleStack.bottomAnchor.constraint(equalTo: earthObsrvButton.bottomAnchor)
        ])

        earthObsrvButton.addSubview(earthImgV)
        
        NSLayoutConstraint.activate([
            earthImgV.leadingAnchor.constraint(equalTo: titleStack.trailingAnchor, constant: 10),
            earthImgV.centerYAnchor.constraint(equalTo: titleStack.centerYAnchor),
            earthImgV.heightAnchor.constraint(equalToConstant: 25),
            earthImgV.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        earthObsrvButton.addSubview(rightIconImgV)
        
        NSLayoutConstraint.activate([
            rightIconImgV.trailingAnchor.constraint(equalTo: earthObsrvButton.trailingAnchor),
            rightIconImgV.centerYAnchor.constraint(equalTo: titleStack.centerYAnchor),
            rightIconImgV.heightAnchor.constraint(equalToConstant: 16),
            rightIconImgV.widthAnchor.constraint(equalToConstant: 16)
        ])
    }
}

protocol LayersHeaderCellDelegate: AnyObject {
    func layersInfoBtnClicked()
}

class LayersHeaderCell: UITableViewCell {
    static let identifier: String = "LayersHeaderCell"
    
    weak var delegate: LayersHeaderCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        let titleLbl = UILabel()
        titleLbl.textAlignment = .left
        titleLbl.font = .systemFont(ofSize: 18, weight: .medium)
        titleLbl.text = "Layers"
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLbl)
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        let infoBtn = UIButton(type: .system)
        infoBtn.setImage(UIImage(systemName: "info.circle")!, for: .normal)
        infoBtn.contentMode = .scaleAspectFit
        infoBtn.translatesAutoresizingMaskIntoConstraints = false
        infoBtn.addTarget(self, action: #selector(self.infoBtnClicked), for: .touchUpInside)
        contentView.addSubview(infoBtn)
        
        NSLayoutConstraint.activate([
            infoBtn.leadingAnchor.constraint(equalTo: titleLbl.trailingAnchor, constant: 10),
            infoBtn.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor),
            infoBtn.widthAnchor.constraint(equalToConstant: 15),
            infoBtn.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    @objc func infoBtnClicked() {
        delegate?.layersInfoBtnClicked()
    }
}

class LayersListItemCell: UITableViewCell {
    static let identifier: String = "LayersListItemCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(title: String, subtitle: String) {
        let titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.font = .systemFont(ofSize: 16, weight: .medium)
        titleLbl.textAlignment = .left
        contentView.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
        
        let subtitleLbl = UILabel()
        subtitleLbl.textAlignment = .left
        subtitleLbl.font = .systemFont(ofSize: 13, weight: .regular)
        subtitleLbl.text = subtitle
        contentView.addSubview(subtitleLbl)
        subtitleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subtitleLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 5),
            subtitleLbl.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor),
            subtitleLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        let rightIconImgV = UIImageView(image: UIImage(systemName: "chevron.right")!)
        rightIconImgV.contentMode = .scaleAspectFit
        contentView.addSubview(rightIconImgV)
        rightIconImgV.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rightIconImgV.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rightIconImgV.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            rightIconImgV.heightAnchor.constraint(equalToConstant: 16),
            rightIconImgV.widthAnchor.constraint(equalToConstant: 16)
        ])
    }
}

protocol ToggleViewDelegate: AnyObject {
    func toggleChanged(isOn: Bool)
}

class ToggleView: UIView {
    
    weak var delegate: ToggleViewDelegate?
    var toggleBtn: UISwitch!
    var title: String
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        let titleLbl = UILabel()
        titleLbl.text = self.title
        titleLbl.font = .systemFont(ofSize: 15, weight: .medium)
        titleLbl.textAlignment = .left
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        let toggleBtn = UISwitch()
        toggleBtn.addTarget(self, action: #selector(self.toggleChanged), for: .touchUpInside)
        self.toggleBtn = toggleBtn
        toggleBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let stackV = UIStackView(arrangedSubviews: [titleLbl, toggleBtn])
        stackV.axis = .horizontal
        stackV.distribution = .equalSpacing
        stackV.alignment = .center
        addSubview(stackV)
        stackV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackV.topAnchor.constraint(equalTo: topAnchor),
            stackV.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackV.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackV.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc func toggleChanged() {
        delegate?.toggleChanged(isOn: toggleBtn.isOn)
    }
}

class MapStyleItemCell: UICollectionViewCell {
    static let identifier: String = "MapStyleItemCell"
    
    private var imageView: UIImageView!
    private var styleLbl: UILabel?

    func setUpUI(image: UIImage, styleName: String, isSelected: Bool) {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        contentView.addSubview(imageView)
        self.imageView = imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 110),
            imageView.widthAnchor.constraint(equalToConstant: 110)
        ])
        
        let styleLbl = UILabel()
        styleLbl.text = styleName
        styleLbl.font = .systemFont(ofSize: 12, weight: .light)
        styleLbl.textAlignment = .center
        contentView.addSubview(styleLbl)
        styleLbl.translatesAutoresizingMaskIntoConstraints = false
        self.styleLbl = styleLbl
        
        NSLayoutConstraint.activate([
            styleLbl.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            styleLbl.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            styleLbl.heightAnchor.constraint(equalToConstant: 15)
        ])

        if isSelected {
            print(styleName)
            showBorder()
        }else{
            print(styleName)
            removeBorder()
        }
    }
    
    func showBorder() {
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
    }
    
    func removeBorder() {
        imageView.layer.borderColor = nil
        imageView.layer.borderWidth = 0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        styleLbl?.text = ""
        removeBorder()
    }
}
