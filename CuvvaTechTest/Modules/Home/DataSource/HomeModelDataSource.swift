//
//  Created by Dimitrios Chatzieleftheriou on 16/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

final class HomeModelDataSource {
    
    private(set) var data: [HomeSectionModel] = []
    
    func sectionModel(at index: Int) -> HomeSectionModel? {
        return data[index]
    }
    
    func model(at indexPath: IndexPath) -> HomeSectionItem? {
        return data[indexPath.section].items[indexPath.row]
    }
    
    func numberOfSections() -> Int {
        return data.count
    }
    
    func numberOfItems(for section: Int) -> Int {
        guard let sectionModel = sectionModel(at: section) else { return 0 }
        return sectionModel.items.count
    }
    
    func update(data: [HomeSectionModel]) {
        self.data = data
    }
    
}
