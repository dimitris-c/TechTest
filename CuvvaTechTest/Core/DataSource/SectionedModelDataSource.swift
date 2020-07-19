//
//  Created by Dimitrios Chatzieleftheriou on 19/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

class SectionedModelDataSource<Section: SectionModelType> {
    private(set) var data: [Section] = []
    
    func sectionModel(at index: Int) -> Section? {
        return data[index]
    }
    
    func model(at indexPath: IndexPath) -> Section.Item? {
        return data[indexPath.section].items[indexPath.row]
    }
    
    func numberOfSections() -> Int {
        return data.count
    }
    
    func numberOfItems(for section: Int) -> Int {
        guard let sectionModel = sectionModel(at: section) else { return 0 }
        return sectionModel.items.count
    }
    
    func update(data: [Section]) {
        self.data = data
    }
}
