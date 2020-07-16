//
//  Created by Dimitrios Chatzieleftheriou on 16/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

final class HomeCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private let dataSource: HomeModelDataSource
    
    init(dataSource: HomeModelDataSource) {
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
                case .activeItem(let item):
                    let cell: HomeActivePolicyCell = collectionView.dequeueReusableCell(identifier: HomeActivePolicyCell.identifier, indexPath: indexPath)
                    return cell
                case .vehicle(let item):
                    let cell: HomeVehicleCell = collectionView.dequeueReusableCell(identifier: HomeVehicleCell.identifier, indexPath: indexPath)
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
