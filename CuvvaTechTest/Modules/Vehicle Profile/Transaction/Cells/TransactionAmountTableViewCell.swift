//
//  Created by Dimitrios Chatzieleftheriou on 19/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

class TransactionAmountTableViewCell: UITableViewCell {
    static let identifier = "transaction.amount.tableview.id"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
        self.textLabel?.font = DesignStyling.Fonts.subtitle
        self.textLabel?.textColor = DesignStyling.Colours.titleDarkBlue
        
        self.detailTextLabel?.font = DesignStyling.Fonts.subtitle
        self.detailTextLabel?.textColor = DesignStyling.Colours.titleDarkBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: TransactionDisplayItem) {
        self.textLabel?.text = item.title
        self.detailTextLabel?.text = item.amountTitle
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.textLabel?.text = nil
        self.detailTextLabel?.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
}
