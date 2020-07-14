//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

enum PolicyAPIConfig {
    case staging
    
    var baseUrl: URL {
        switch self {
            case .staging:
                return URL(string: "https://cuvva.herokuapp.com")!
        }
    }
}
