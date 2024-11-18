//
//  GadgetsTableViewCell.swift
//  SwiftRedesign
//
//  Created by rento on 21/10/24.
//

import UIKit

class GadgetsTableViewCell: UITableViewCell {
    static let identifier: String = "GadgetsTableViewCell"
    
    var carStatusLabel: UILabel!
    var deviceNameLabel: UILabel!
    var carNumberLabel: UILabel!
    var batteryImageView: UIImageView!
//    var cautionDescriptionLabel: UILabel!
    var viaLabel: UILabel!
    var vehicleIcon: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(gadget: GadgetsTableViewHashable) {
        backgroundColor = .clear
        
        vehicleIcon = UIImageView(image: UIImage(named: gadget.vehicleIcon) ?? UIImage(systemName: "car.circle")!)
        vehicleIcon.backgroundColor = .clear
        vehicleIcon.contentMode = .scaleAspectFit
        vehicleIcon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vehicleIcon)
        
        NSLayoutConstraint.activate([
            vehicleIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            vehicleIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            vehicleIcon.heightAnchor.constraint(equalToConstant: 30),
            vehicleIcon.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        batteryImageView = UIImageView(image: UIImage(named: gadget.batteryImage) ?? UIImage(systemName: "iphone.smartbatterycase.gen1"))
        batteryImageView.contentMode = .scaleAspectFit
        batteryImageView.backgroundColor = .clear
        batteryImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(batteryImageView)
        NSLayoutConstraint.activate([
            batteryImageView.topAnchor.constraint(equalTo: vehicleIcon.topAnchor),
            batteryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            batteryImageView.widthAnchor.constraint(equalToConstant: 30),
            batteryImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        deviceNameLabel = UILabel()
        deviceNameLabel.text = gadget.deviceName
        deviceNameLabel.font = .sfProText.semiBold.ofSize(size: .regular)
        deviceNameLabel.backgroundColor = .clear
        deviceNameLabel.textColor = .init(hex: "#797979")
        deviceNameLabel.numberOfLines = 0
        deviceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(deviceNameLabel)
        
        NSLayoutConstraint.activate([
            deviceNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            deviceNameLabel.leadingAnchor.constraint(equalTo: vehicleIcon.trailingAnchor, constant: 20),
            deviceNameLabel.trailingAnchor.constraint(equalTo: batteryImageView.leadingAnchor, constant: -20)
        ])
        
        carNumberLabel = UILabel()
        carNumberLabel.text = gadget.carNumber
        carNumberLabel.backgroundColor = .clear
        carNumberLabel.font = .sfProText.regular.ofSize(size: .small)
        contentView.addSubview(carNumberLabel)
        carNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            carNumberLabel.topAnchor.constraint(equalTo: deviceNameLabel.bottomAnchor, constant: 10),
            carNumberLabel.leadingAnchor.constraint(equalTo: deviceNameLabel.leadingAnchor),
            carNumberLabel.trailingAnchor.constraint(equalTo: deviceNameLabel.trailingAnchor)
        ])
        
        carStatusLabel = UILabel()
        carStatusLabel.text = gadget.carStatus
        carStatusLabel.font = .sfProText.regular.ofSize(size: .small)
        carStatusLabel.textAlignment = .center
        carStatusLabel.textColor = .white
        carStatusLabel.layer.cornerRadius = 11
        carStatusLabel.clipsToBounds = true
        contentView.addSubview(carStatusLabel)
        carStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            carStatusLabel.topAnchor.constraint(equalTo: carNumberLabel.bottomAnchor, constant: 10),
            carStatusLabel.leadingAnchor.constraint(equalTo: carNumberLabel.leadingAnchor),
            carStatusLabel.widthAnchor.constraint(equalToConstant: 80),
            carStatusLabel.heightAnchor.constraint(equalToConstant: 22),
            carStatusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        viaLabel = UILabel()
        viaLabel.text = gadget.viaText
        viaLabel.backgroundColor = .clear
        viaLabel.font = .sfProText.regularItalic.ofSize(size: .extra_small)
        contentView.addSubview(viaLabel)
        viaLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viaLabel.centerYAnchor.constraint(equalTo: carStatusLabel.centerYAnchor),
            viaLabel.leadingAnchor.constraint(equalTo: carStatusLabel.trailingAnchor, constant: 10)
        ])
    }
}
