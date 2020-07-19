//
//  Created by Dimitrios Chatzieleftheriou on 19/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

enum TransactionSectionModel {
    case transaction(title: String, items: [TransactionSectionItem])
}

enum TransactionSectionItem: Equatable {
    case payment(item: TransactionDisplayItem)
    case total(item: TransactionDisplayItem)
}

struct TransactionDisplayItem: Equatable {
    let title: String
    let amount: Int
    
    var amountTitle: String {
        return NumberFormatter.receiptCurrency.string(from: NSNumber(integerLiteral: amount / 100)) ?? ""
    }
}

extension TransactionSectionModel: SectionModelType {
    var items: [TransactionSectionItem] {
        switch self {
            case .transaction(_, let items):
                return items
        }
    }
    
    var title: String {
        switch self {
            case .transaction(let title, _):
                return title
        }
    }
    
    init(section: TransactionSectionModel, items: [TransactionSectionItem]) {
        switch section {
            case .transaction(let title, _):
                self = .transaction(title: title, items: items)
        }
    }
}
