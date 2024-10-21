//
//  GadgetsSheet.swift
//  SwiftRedesign
//
//  Created by rento on 14/10/24.
//

import UIKit

class GadgetsTableViewHashable: Hashable {
    var isFooterView: Bool
    var carStatus: String
    var deviceName: String
    var carNumber: String
    var batteryImage: String
    var viaText: String
    var vehicleIcon: String
    
    init(isFooterView: Bool = false, carStatus: String, deviceName: String, carNumber: String, batteryImage: String, viaText: String, vehicleIcon: String) {
        self.isFooterView = isFooterView
        self.carStatus = carStatus
        self.deviceName = deviceName
        self.carNumber = carNumber
        self.batteryImage = batteryImage
        self.viaText = viaText
        self.vehicleIcon = vehicleIcon
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(carNumber)
    }
    
    static func == (lhs: GadgetsTableViewHashable, rhs: GadgetsTableViewHashable) -> Bool {
        return lhs.carNumber == rhs.carNumber
    }
}

class MyGadgetsVC: UIViewController {
    
    var gadgetTblView: UITableView!
    var dataSource: UITableViewDiffableDataSource<Section, GadgetsTableViewHashable>!
    var section1: [GadgetsTableViewHashable] = [.init(carStatus: "Stopped", deviceName: "Suzuki", carNumber: "HDKA9999", batteryImage: "iphone.smartbatterycase.gen1", viaText: "", vehicleIcon: "car.circle"), .init(carStatus: "Stopped", deviceName: "Suzuki", carNumber: "HDKA9999", batteryImage: "iphone.smartbatterycase.gen1", viaText: "", vehicleIcon: "car.circle"), .init(carStatus: "Stopped", deviceName: "Suzuki", carNumber: "HDKA9999", batteryImage: "iphone.smartbatterycase.gen1", viaText: "", vehicleIcon: "car.circle"), .init(carStatus: "Stopped", deviceName: "Suzuki", carNumber: "HDKA9999", batteryImage: "iphone.smartbatterycase.gen1", viaText: "", vehicleIcon: "car.circle")]
    var section2: [GadgetsTableViewHashable] = [.init(isFooterView: true, carStatus: "", deviceName: "", carNumber: "", batteryImage: "", viaText: "", vehicleIcon: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }

    func setUpUI() {
        setPullBar()
        
        gadgetTblView = UITableView()
        gadgetTblView.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
        gadgetTblView.register(GadgetsTableViewCell.self, forCellReuseIdentifier: GadgetsTableViewCell.identifier)
        gadgetTblView.register(GadgetsTableFooterCell.self, forCellReuseIdentifier: GadgetsTableFooterCell.identifier)
        gadgetTblView.delegate = self
        view.addSubview(gadgetTblView)
        gadgetTblView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gadgetTblView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35),
            gadgetTblView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            gadgetTblView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            gadgetTblView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        dataSource = makeDataSource()
        applyInitialSnapshot()
    }
    
    func makeDataSource() -> UITableViewDiffableDataSource<Section, GadgetsTableViewHashable> {
        
        let datasource = UITableViewDiffableDataSource<Section, GadgetsTableViewHashable>(tableView: gadgetTblView) { tableView, indexPath, itemIdentifier in
            if indexPath.section == 0 {
                let gadget = self.section1[indexPath.row]
                guard let cell = tableView.dequeueReusableCell(withIdentifier: GadgetsTableViewCell.identifier) as? GadgetsTableViewCell else {return UITableViewCell()}
                cell.setUpUI(gadget: gadget)
                cell.carStatusLabel.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.3921568627, blue: 0.01568627451, alpha: 1)
                cell.selectionStyle = .none
                return cell
            }else if indexPath.section == 1 {
                let gadget = self.section2[indexPath.row]
                if gadget.isFooterView {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: GadgetsTableFooterCell.identifier) as? GadgetsTableFooterCell else {return UITableViewCell()}
                    cell.delegate = self
                    cell.selectionStyle = .none
                    return cell
                }
            }
            return UITableViewCell()
        }
        return datasource
    }
    
    func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, GadgetsTableViewHashable>()
        snapshot.appendSections([.one, .two])
        snapshot.appendItems(section1, toSection: .one)
        snapshot.appendItems([.init(isFooterView: true, carStatus: "", deviceName: "", carNumber: "", batteryImage: "", viaText: "", vehicleIcon: "")], toSection: .two)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func setPullBar() {
        let pullBar = UIView()
        pullBar.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
        pullBar.layer.cornerRadius = 5
        view.addSubview(pullBar)
        pullBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pullBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            pullBar.heightAnchor.constraint(equalToConstant: 6),
            pullBar.widthAnchor.constraint(equalToConstant: 50),
            pullBar.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}

extension MyGadgetsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension MyGadgetsVC: GadgetsTableFooterCellDelegate {
    func addNewGadgetBtnClicked() {
        
    }
}
