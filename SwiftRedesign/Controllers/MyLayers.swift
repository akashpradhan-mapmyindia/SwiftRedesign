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

class MyLayersTableViewHashable: Hashable {
    
    var cellId: String
    var cellName: String
    var subtitle: String?
    
    init(cellId: String, cellName: String = "", subtitle: String? = nil) {
        self.cellId = cellId
        self.cellName = cellName
        self.subtitle = subtitle
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(cellId)
    }
    
    static func == (lhs: MyLayersTableViewHashable, rhs: MyLayersTableViewHashable) -> Bool {
        return lhs.cellId == rhs.cellId
    }
}

class MyLayersVC: UIViewController {
    var containerTblV: UITableView!
    var mapStyles: [MapStyles] = [.init(style: .defaultMap, image: UIImage(named: "Image 31")!, isSelected: true), .init(style: .hybridSatelliteMap, image: UIImage(named: "Map-3")!), .init(style: .indicMap, image: UIImage(named: "Map-2")!), .init(style: .greyMap, image: UIImage(named: "Map-1")!), .init(style: .sublimeGreyMap, image: UIImage(named: "Map-1")!), .init(style: .darkClassicMap, image: UIImage(named: "Map")!)]
    var dataSource: UITableViewDiffableDataSource<Section, MyLayersTableViewHashable>!
    var sections: [[MyLayersTableViewHashable]] = []
    
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
        let section1: [MyLayersTableViewHashable] = [.init(cellId: MyLayersTopComponent.identifier)]
        
        let section2: [MyLayersTableViewHashable] = [.init(cellId: MyLayersStyleComponent.identifier)]
        
        let section3: [MyLayersTableViewHashable] = [.init(cellId: MyLayersTopComponent.identifier), .init(cellId: LayersListItemCell.identifier, cellName: "My Layers", subtitle: "My Saves, My Gadgets,My Trips etc."), .init(cellId: LayersListItemCell.identifier, cellName: "Posts", subtitle: "Traffic, Safety and Community Reports Overlays"), .init(cellId: LayersListItemCell.identifier, cellName: "Map Layers", subtitle: "Monuments")]
        
        sections.append(section1)
        sections.append(section2)
        sections.append(section3)
    }
    
    func setUpUI() {
        view.backgroundColor = .white
        
        setCellData()
        
        containerTblV = UITableView()
        containerTblV.delegate = self
        containerTblV.register(MyLayersTopComponent.self, forCellReuseIdentifier: MyLayersTopComponent.identifier)
        containerTblV.register(MyLayersStyleComponent.self, forCellReuseIdentifier: MyLayersStyleComponent.identifier)
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
        
        dataSource = makeDataSource()
        applyInitialSnapshot()
    }
    
    func makeDataSource() -> UITableViewDiffableDataSource<Section, MyLayersTableViewHashable> {
        
        let datasource = UITableViewDiffableDataSource<Section, MyLayersTableViewHashable>(tableView: containerTblV) { tableView, indexPath, itemIdentifier in
            let cellData = self.sections[indexPath.section][indexPath.row]
            
            switch cellData.cellId {
            case MyLayersTopComponent.identifier:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MyLayersTopComponent.identifier, for: indexPath) as? MyLayersTopComponent else {return UITableViewCell()}
                if indexPath.section == 0 {
                    cell.setUpUI(title: "My Map")
                }else {
                    cell.setUpUI(title: "Layers")
                    cell.closeBtn.isHidden = true
                }
                cell.setUpUI(title: indexPath.section == 0 ? "My Map" : "Layers")
                cell.delegate = self
                cell.selectionStyle = .none
                return cell

            case MyLayersStyleComponent.identifier:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MyLayersStyleComponent.identifier, for: indexPath) as? MyLayersStyleComponent else {return UITableViewCell()}
                cell.setUpUI(mapStyles: self.mapStyles)
                cell.stylesItems.delegate = self
                cell.selectionStyle = .none
                return cell

            case LayersListItemCell.identifier:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: LayersListItemCell.identifier, for: indexPath) as? LayersListItemCell else {return UITableViewCell()}
                cell.setUpUI(title: cellData.cellName, subtitle: cellData.subtitle ?? "")
                cell.selectionStyle = .none
                return cell
            default:
                return UITableViewCell()
            }
        }
        return datasource
    }
    
    func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MyLayersTableViewHashable>()
        snapshot.appendSections([.one, .two, .three])
        snapshot.appendItems(sections[0], toSection: .one)
        snapshot.appendItems(sections[1], toSection: .two)
        snapshot.appendItems(sections[2], toSection: .three)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension MyLayersVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        if section == 2 {
            view.backgroundColor = .init(hex: "#F3F3F3")
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 10
        }else {
            return 0
        }
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
            cell.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}

extension MyLayersVC: MyLayersTopComponentDelegate {
    func infoBtnPressed(for title: String) {
        
    }
    
    func closeBtnPressed() {
        customDismiss(animated: true)
    }
}

protocol MyLayersTopComponentDelegate: Sendable {
    func infoBtnPressed(for title: String) async
    func closeBtnPressed() async
}

class MyLayersTopComponent: UITableViewCell {
    static let identifier: String = "MyLayersTopComponent"
    
    var delegate: MyLayersTopComponentDelegate?
    
    var titleLbl: UILabel!
    var closeBtn: UIButton!
    var infoBtn: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    func commonInit() {
        let titleLbl = UILabel()
        titleLbl.font = .sfProText.semiBold.ofSize(size: .medium)
        contentView.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleLbl = titleLbl
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])

        let infoBtn = UIButton(type: .system)
        infoBtn.contentMode = .scaleAspectFit
        infoBtn.tintColor = .init(hex: "#707070")
        infoBtn.addTarget(self, action: #selector(self.infoBtnPressed), for: .touchUpInside)
        contentView.addSubview(infoBtn)
        infoBtn.translatesAutoresizingMaskIntoConstraints = false
        
        self.infoBtn = infoBtn
        
        NSLayoutConstraint.activate([
            infoBtn.leadingAnchor.constraint(equalTo: titleLbl.trailingAnchor, constant: 10),
            infoBtn.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor),
            infoBtn.heightAnchor.constraint(equalToConstant: 22),
            infoBtn.widthAnchor.constraint(equalToConstant: 22)
        ])
        
        let closeBtn = UIButton()
        closeBtn.setBackgroundImage(UIImage(named: "clear")!, for: .normal)
        closeBtn.imageView?.contentMode = .scaleAspectFit
        closeBtn.addTarget(self, action: #selector(self.closeBtnPressed), for: .touchUpInside)
        contentView.addSubview(closeBtn)
        closeBtn.translatesAutoresizingMaskIntoConstraints = false
        
        self.closeBtn = closeBtn
        
        NSLayoutConstraint.activate([
            closeBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            closeBtn.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor),
            closeBtn.heightAnchor.constraint(equalToConstant: 25),
            closeBtn.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(title: String) {
        titleLbl.text = title
        infoBtn.setImage(UIImage(named: "info")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    @objc func infoBtnPressed() {
        Task {
            await delegate?.infoBtnPressed(for: titleLbl.text ?? "")
        }
    }
    
    @objc func closeBtnPressed() {
        Task {
            await delegate?.closeBtnPressed()
        }
    }
}

enum Style: String {
    case defaultMap = "Default Map"
    case hybridSatelliteMap = "Hybrid Satellite Map"
    case indicMap = "Indic Map"
    case greyMap = "Grey Mode"
    case sublimeGreyMap = "Sublime Grey"
    case darkClassicMap = "Dark Classic"
}

enum Section: CaseIterable {
    case one
    case two
    case three
}

class MapStyles: Hashable {
    
    var name: String
    var image: UIImage
    var isSelected: Bool
    
    init(style: Style, image: UIImage, isSelected: Bool = false) {
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
    
    static let identifier: String = "MyLayersStyleComponent"
    
    var stylesItems: UICollectionView!
    var threeDBtn: ToggleView!
    var visualTrafficBtn: ToggleView!
    var titleLbl: UILabel!
    var modesSelector: UISegmentedControl!
    var dataSource: UICollectionViewDiffableDataSource<Section, MapStyles>!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    func commonInit() {
        let titleLbl = UILabel()
        titleLbl.text = "Style"
        titleLbl.font = .sfProText.semiBold.ofSize(size: .regular)
        contentView.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleLbl = titleLbl
        
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .estimated(130))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(130))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        
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
        
        let modesLbl = UILabel()
        modesLbl.text = "Modes"
        modesLbl.textColor = .init(hex: "#212121")
        modesLbl.font = .sfProText.semiBold.ofSize(size: .regular)
        modesLbl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(modesLbl)
        
        NSLayoutConstraint.activate([
            modesLbl.topAnchor.constraint(equalTo: stylesItems.bottomAnchor, constant: 5),
            modesLbl.leadingAnchor.constraint(equalTo: stylesItems.leadingAnchor)
        ])
        
        let modeSelector = UISegmentedControl()
        modeSelector.insertSegment(withTitle: "Auto", at: 0, animated: false)
        modeSelector.insertSegment(withTitle: "Day Mode", at: 1, animated: false)
        modeSelector.insertSegment(withTitle: "Night Mode", at: 2, animated: false)
        modeSelector.selectedSegmentTintColor = .init(hex: "#339E82")
        modeSelector.backgroundColor = .white
        modeSelector.selectedSegmentIndex = 0
        modeSelector.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.sfProText.medium.ofSize(size: .small)], for: .normal)
        modeSelector.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.sfProText.medium.ofSize(size: .small)], for: .selected)
        modeSelector.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(modeSelector)
        
        self.modesSelector = modeSelector
        
        NSLayoutConstraint.activate([
            modeSelector.topAnchor.constraint(equalTo: modesLbl.bottomAnchor, constant: 15),
            modeSelector.leadingAnchor.constraint(equalTo: stylesItems.leadingAnchor),
            modeSelector.trailingAnchor.constraint(equalTo: stylesItems.trailingAnchor),
            modeSelector.heightAnchor.constraint(equalToConstant: 34)
        ])
        
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
            btnStack.topAnchor.constraint(equalTo: modeSelector.bottomAnchor, constant: 15),
            btnStack.leadingAnchor.constraint(equalTo: stylesItems.leadingAnchor),
            btnStack.trailingAnchor.constraint(equalTo: stylesItems.trailingAnchor),
            btnStack.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        let earthTitle = UILabel()
        earthTitle.textAlignment = .left
        earthTitle.text = "Earth Observation Data"
        earthTitle.font = .sfProText.semiBold.ofSize(size: .regular)
        earthTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let sourceLbl = UILabel()
        sourceLbl.textAlignment = .left
        sourceLbl.text = "Source: ISRO"
        sourceLbl.font = .sfProText.medium.ofSize(size: .small)
        sourceLbl.textColor = .init(hex: "#707070")
        sourceLbl.translatesAutoresizingMaskIntoConstraints = false
        
        let earthImgV = UIImageView(image: UIImage(named: "New")!)
        earthImgV.contentMode = .scaleAspectFit
        earthImgV.translatesAutoresizingMaskIntoConstraints = false
        
        let rightIconImgV = UIImageView(image: UIImage(named: "forward")!)
        rightIconImgV.contentMode = .scaleAspectFit
        rightIconImgV.translatesAutoresizingMaskIntoConstraints = false
    
        let titleStack = UIStackView(arrangedSubviews: [earthTitle, sourceLbl])
        titleStack.axis = .vertical
        titleStack.spacing = 5
        titleStack.alignment = .leading
        titleStack.distribution = .equalSpacing
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        
        let earthObsrvBgView = UIView()
        contentView.addSubview(earthObsrvBgView)
        earthObsrvBgView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            earthObsrvBgView.topAnchor.constraint(equalTo: btnStack.bottomAnchor, constant: 10),
            earthObsrvBgView.leadingAnchor.constraint(equalTo: btnStack.leadingAnchor),
            earthObsrvBgView.trailingAnchor.constraint(equalTo: btnStack.trailingAnchor),
            earthObsrvBgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        earthObsrvBgView.addSubview(titleStack)
        
        NSLayoutConstraint.activate([
            titleStack.leadingAnchor.constraint(equalTo: earthObsrvBgView.leadingAnchor),
            titleStack.topAnchor.constraint(equalTo: earthObsrvBgView.topAnchor),
            titleStack.bottomAnchor.constraint(equalTo: earthObsrvBgView.bottomAnchor)
        ])

        earthObsrvBgView.addSubview(earthImgV)
        
        NSLayoutConstraint.activate([
            earthImgV.leadingAnchor.constraint(equalTo: titleStack.trailingAnchor, constant: 10),
            earthImgV.topAnchor.constraint(equalTo: titleStack.topAnchor),
            earthImgV.heightAnchor.constraint(equalToConstant: 24),
            earthImgV.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        earthObsrvBgView.addSubview(rightIconImgV)
        
        NSLayoutConstraint.activate([
            rightIconImgV.trailingAnchor.constraint(equalTo: earthObsrvBgView.trailingAnchor),
            rightIconImgV.centerYAnchor.constraint(equalTo: titleStack.centerYAnchor),
            rightIconImgV.heightAnchor.constraint(equalToConstant: 22),
            rightIconImgV.widthAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, MapStyles> {
        
        return UICollectionViewDiffableDataSource<Section, MapStyles>(
            collectionView: stylesItems,
            cellProvider: { collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MapStyleItemCell.identifier, for: indexPath) as! MapStyleItemCell
                cell.setUpUI(image: item.image, styleName: item.name, isSelected: item.isSelected)
                return cell
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
        applyInitialSnapshot(mapStyles: mapStyles)
    }
}

class LayersListItemCell: UITableViewCell {
    static let identifier: String = "LayersListItemCell"
    
    var titleLbl: UILabel!
    var subtitleLbl: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        let titleLbl = UILabel()
        titleLbl.font = .sfProText.semiBold.ofSize(size: .regular)
        titleLbl.textAlignment = .left
        contentView.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleLbl = titleLbl
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
        
        let subtitleLbl = UILabel()
        subtitleLbl.textAlignment = .left
        subtitleLbl.font = .sfProText.medium.ofSize(size: .small)
        subtitleLbl.textColor = .init(hex: "#707070")
        contentView.addSubview(subtitleLbl)
        subtitleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        self.subtitleLbl = subtitleLbl
        
        NSLayoutConstraint.activate([
            subtitleLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 10),
            subtitleLbl.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor),
            subtitleLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        let rightIconImgV = UIImageView(image: UIImage(named: "forward")!)
        rightIconImgV.contentMode = .scaleAspectFit
        contentView.addSubview(rightIconImgV)
        rightIconImgV.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rightIconImgV.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rightIconImgV.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            rightIconImgV.heightAnchor.constraint(equalToConstant: 22),
            rightIconImgV.widthAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func setUpUI(title: String, subtitle: String) {
        titleLbl.text = title
        subtitleLbl.text = subtitle
    }
}

protocol ToggleViewDelegate: Sendable {
    func toggleChanged(isOn: Bool) async
}

class ToggleView: UIView {
    
    var delegate: ToggleViewDelegate?
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
        titleLbl.font = .sfProText.semiBold.ofSize(size: .regular)
        titleLbl.textAlignment = .left
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        let toggleBtn = UISwitch()
        toggleBtn.onTintColor = .init(hex: "#339E82")
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
        Task {
            await delegate?.toggleChanged(isOn: toggleBtn.isOn)
        }
    }
}

class MapStyleItemCell: UICollectionViewCell {
    static let identifier: String = "MapStyleItemCell"
    
    private weak var imageView: UIImageView!
    private weak var styleLbl: UILabel!
    private var tikMarkImgV: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        contentView.addSubview(imageView)
        self.imageView = imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 105)
        ])

        let styleLbl = UILabel()
        styleLbl.font = .sfProText.medium.ofSize(size: .small)
        styleLbl.textAlignment = .center
        styleLbl.numberOfLines = 0
        contentView.addSubview(styleLbl)
        styleLbl.translatesAutoresizingMaskIntoConstraints = false
        self.styleLbl = styleLbl
        
        NSLayoutConstraint.activate([
            styleLbl.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            styleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            styleLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            styleLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        setTikMarkView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(image: UIImage, styleName: String, isSelected: Bool) {
        imageView.image = image
        
        styleLbl.text = styleName

        if isSelected {
            showBorder()
        }else{
            removeBorder()
        }
    }
    
    func setTikMarkView() {
        let markImgV = UIImageView(image: UIImage(named: "tik mark"))
        markImgV.contentMode = .scaleAspectFit
        markImgV.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(markImgV)
        
        self.tikMarkImgV = markImgV
        
        NSLayoutConstraint.activate([
            markImgV.heightAnchor.constraint(equalToConstant: 22),
            markImgV.widthAnchor.constraint(equalToConstant: 22),
            markImgV.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            markImgV.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
    }
    
    func showBorder() {
        imageView.layer.borderColor = UIColor(hex: "#339E82").cgColor
        imageView.layer.borderWidth = 1
        tikMarkImgV.isHidden = false
    }
    
    func removeBorder() {
        imageView.layer.borderColor = nil
        imageView.layer.borderWidth = 0
        tikMarkImgV?.isHidden = true
    }
}
