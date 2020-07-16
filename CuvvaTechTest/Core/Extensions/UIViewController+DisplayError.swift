//
//  Created by Dimitrios Chatzieleftheriou on 16/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit.UIViewController

public protocol DisplayError {
    func showError(error: Error, okAction: (() -> Void)?)
    func showError(title: String, message: String, okAction: (() -> Void)?, okActionTitle: String, cancelAction: (() -> Void)?)
}

extension UIViewController: DisplayError {
    public func showError(title: String, message: String, okAction: (() -> Void)?, okActionTitle: String = "OK", cancelAction: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okHandler: (UIAlertAction) -> Void = { _ in okAction?() }
        alertController.addAction(UIAlertAction(title: okActionTitle, style: .default, handler: okHandler))
        if let cancelAction = cancelAction {
            let cancelHandler: (UIAlertAction) -> Void = { _ in cancelAction() }
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: cancelHandler))
        }
        self.present(alertController, animated: true, completion: nil)
    }

    public func showError(error: Error, okAction: (() -> Void)?) {
        showError(title: "Error", message: error.localizedDescription, okAction: okAction)
    }
}
