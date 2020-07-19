//
//  Created by Dimitrios Chatzieleftheriou on 19/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

protocol SectionModelType {
    associatedtype Item
    
    var items: [Item] { get }
    
    init(section: Self, items: [Item])
}

struct SectionModel<Section, Item>: SectionModelType {
    var model: Section
    var items: [Item]
    
    init(section: Section, items: [Item]) {
        self.model = section
        self.items = items
    }
}

extension SectionModel {
    public typealias Identity = Section
    
    public var identity: Section {
        return model
    }
}

extension SectionModel {
    init(section: SectionModel<Section, Item>, items: [Item]) {
        self.model = section.model
        self.items = items
    }
}

extension SectionModel: Equatable where Section: Equatable, Item: Equatable {
    static func == (lhs: SectionModel, rhs: SectionModel) -> Bool {
        return lhs.model == rhs.model && lhs.items == rhs.items
    }
}
