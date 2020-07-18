//
//  Created by Dimitrios Chatzieleftheriou on 17/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

final class VehicleProfileCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private let dataSource: VehicleProfileModelDataSource
    
    init(dataSource: VehicleProfileModelDataSource) {
        self.dataSource = dataSource
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.numberOfItems(for: section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataSource.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let model = dataSource.model(at: indexPath) {
            switch model {
                case .activePolicy(let item):
                    let cell: VehicleProfileActivePolicyCell = collectionView.dequeueReusableCell(identifier: VehicleProfileActivePolicyCell.identifier, indexPath: indexPath)
                    cell.configure(item: item)
                    return cell
                case .previousPolicy(let item):
                    let cell: VehicleProfilePolicyCell = collectionView.dequeueReusableCell(identifier: VehicleProfilePolicyCell.identifier, indexPath: indexPath)
                    cell.configure(item: item)
                    return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let model = dataSource.sectionModel(at: indexPath.section) else {
                return UICollectionReusableView()
            }
            let view: TitleHeaderCollectionView = collectionView.dequeueSupplementaryView(identifier: TitleHeaderCollectionView.identifier, kind: kind, indexPath: indexPath)
            view.titleLabel.text = model.title
            return view
        }
        
        return UICollectionReusableView()
    }
    
}
