//
//  GadgetsHandler.swift
//  SwiftRedesign
//
//  Created by rento on 18/10/24.
//

import UIKit

class GadgetsHandler: NSObject {
    
    static let shared: GadgetsHandler = GadgetsHandler()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, VehicleMovingStatus>?
    
    func applyInitialSnapshot(states: [VehicleMovingStatus]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, VehicleMovingStatus>()
        snapshot.appendSections([.one])
        
        snapshot.appendItems(states, toSection: .one)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    func setCollectionViewDelegate(collectionView: UICollectionView) {
        collectionView.delegate = self
    }
    
    func makeDataSource(gadgetsStatusCollectionView: UICollectionView) {
        
        let cellRegistration = UICollectionView.CellRegistration<GadgetsStatusCell, VehicleMovingStatus> { cell, indexPath, state in
            
            cell.setUpUI(state: state)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, VehicleMovingStatus>(
            collectionView: gadgetsStatusCollectionView,
            cellProvider: { collectionView, indexPath, item in
                collectionView.dequeueConfiguredReusableCell(
                    using: cellRegistration,
                    for: indexPath,
                    item: item
                )
            }
        )
    }
}

extension GadgetsHandler: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedItem = dataSource?.itemIdentifier(for: indexPath) {
            selectedItem.isSelected = !selectedItem.isSelected
            if var snapshot = dataSource?.snapshot() {
                snapshot.reloadItems([selectedItem])
                dataSource?.apply(snapshot, animatingDifferences: false)
            }
        }
    }
}
