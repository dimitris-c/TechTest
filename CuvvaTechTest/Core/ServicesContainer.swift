//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

protocol Services {
    var networkingClient: Networking { get }
    var persistence: Persistence { get }
    
    var policyPeristence: PolicyPersistence { get }
}

final class ServicesContainer: Services {
    
    lazy var networkingClient: Networking = NetworkingClient()
    
    lazy var persistence: Persistence = PersistenceService()
    
    lazy var policyPeristence: PolicyPersistence = {
        return PolicyPersistenceService(persistence: persistence)
    }()
}
