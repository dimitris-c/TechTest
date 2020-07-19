//
//  Created by Dimitrios Chatzieleftheriou on 16/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<Cell: UITableViewCell>(identifier: String, indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("could not dequeue cell with identifier: \(identifier)")
        }
        return cell
    }
    
    func dequeueSupplementaryView<View: UITableViewHeaderFooterView>(identifier: String, kind: String, indexPath: IndexPath) -> View {
        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? View else {
            fatalError("could not dequeue reusable view of kind: \(kind) with identifier: \(identifier)")
        }
        return view
    }
}
