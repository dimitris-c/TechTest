//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

protocol PolicyPersistence {
    func getData() -> PolicyData?
    func save(data: PolicyData)
}


final class PolicyPersistenceService: PolicyPersistence {
    
    private let persistence: Persistence
    private let key: String = "policy_data"
    
    init(persistence: Persistence) {
        self.persistence = persistence
    }
    
    func getData() -> PolicyData? {
        guard let data = self.persistence.get(key: key) else {
            return nil
        }
        return self.persistence.decode(PolicyData.self, data: data, decoder: policyDecoder)
    }
    
    func save(data: PolicyData) {
        guard let encoded = self.persistence.encode(object: data, encoder: policyEncoder) else {
            return
        }
        self.persistence.save(value: encoded, key: key)
    }
    
}
