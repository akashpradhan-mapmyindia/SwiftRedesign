//
//  GadgetsStatusCell.swift
//  SwiftRedesign
//
//  Created by rento on 18/10/24.
//

import UIKit

enum VehicleMovingStatusEnum: String {
    case moving = "Moving"
    case stopped = "Stopped"
    case idle = "Idle"
    case caution = "Caution"
}

class VehicleMovingStatus: Hashable {
    
    var state: VehicleMovingStatusEnum
    var count: Int
    var isSelected: Bool
    
    init(state: VehicleMovingStatusEnum, count: Int = 0, isSelected: Bool = false) {
        self.state = state
        self.count = count
        self.isSelected = isSelected
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(state.rawValue)
    }
    
    static func == (lhs: VehicleMovingStatus, rhs: VehicleMovingStatus) -> Bool {
        return lhs.state.rawValue == rhs.state.rawValue
    }
}

class GadgetsStatusCell: UICollectionViewCell {
    static let identifier: String = "GadgetsStatusCell"
    
    var countLbl: UILabel?
    var movingTxt: UILabel?
    
    func setUpUI(state: VehicleMovingStatusEnum, count: Int, isSelected: Bool) {
        backgroundColor = .clear
        
        let vehicleCountLbl = UILabel()
        vehicleCountLbl.font = .systemFont(ofSize: 14)
        vehicleCountLbl.text = String(count)
        vehicleCountLbl.backgroundColor = colorForCountBg(state: state)
        vehicleCountLbl.layer.cornerRadius = 3
        vehicleCountLbl.textColor = .white
        vehicleCountLbl.clipsToBounds = true
        vehicleCountLbl.textAlignment = .center
        contentView.addSubview(vehicleCountLbl)
        vehicleCountLbl.translatesAutoresizingMaskIntoConstraints = false
        countLbl = vehicleCountLbl
        
        NSLayoutConstraint.activate([
            vehicleCountLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            vehicleCountLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            vehicleCountLbl.heightAnchor.constraint(equalToConstant: 20),
            vehicleCountLbl.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        let stateLabel = UILabel()
        stateLabel.text = state.rawValue
        stateLabel.font = .systemFont(ofSize: 14)
        stateLabel.backgroundColor = .clear
        stateLabel.textAlignment = .left
        contentView.addSubview(stateLabel)
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        movingTxt = stateLabel
        
        NSLayoutConstraint.activate([
            stateLabel.leadingAnchor.constraint(equalTo: vehicleCountLbl.trailingAnchor, constant: 5),
            stateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            stateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
    
    func showSelectedView() {
        
    }
    
    func hideSelectedView() {
        
    }
    
    func colorForCountBg(state: VehicleMovingStatusEnum) -> UIColor {
        switch state {
        case .stopped:
            return .orange
        case .moving:
            return .red
        case .idle:
            return .yellow
        case .caution:
            return .green
        }
    }
}

