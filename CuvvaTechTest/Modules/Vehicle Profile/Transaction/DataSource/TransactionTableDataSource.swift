//
//  Created by Dimitrios Chatzieleftheriou on 19/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

final class TransactionTableDataSource: NSObject, UITableViewDataSource {
    
    private let dataSource: SectionedModelDataSource<TransactionSectionModel>
    init(dataSource: SectionedModelDataSource<TransactionSectionModel>) {
        self.dataSource = dataSource
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.numberOfItems(for: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let model = dataSource.model(at: indexPath) {
            switch model {
                case .payment(let item):
                    let identifier = TransactionAmountTableViewCell.identifier
                    let cell: TransactionAmountTableViewCell = tableView.dequeueReusableCell(identifier: identifier,
                                                                                             indexPath: indexPath)
                    cell.configure(item: item)
                    return cell
                case .total(let item):
                    let identifier = TransactionTotalAmountTableViewCell.identifier
                    let cell: TransactionTotalAmountTableViewCell = tableView.dequeueReusableCell(identifier: identifier,
                                                                                                  indexPath: indexPath)
                    cell.configure(item: item)
                    return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let model = dataSource.sectionModel(at: section) else {
            return nil
        }
        return model.title
    }
    
}
