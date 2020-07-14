//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

final class AppController {
    
    let window: UIWindow
    let services: Services
    
    init(window: UIWindow, services: Services) {
        self.window = window
        self.services = services
    }
    
    func start() {
        window.rootViewController = buildMain()
        window.makeKeyAndVisible()
    }
    
    private func buildMain() -> UIViewController {
         return UIViewController()
    }
    
}
