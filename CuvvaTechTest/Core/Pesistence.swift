//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation
import RealmSwift

protocol Persistence {
    func write(block: @escaping (Realm) -> Void)
    func store(_ object: Object, update: Realm.UpdatePolicy)
    func retrieve<Value: Object>(type: Value.Type) -> Results<Value>
}

final class PersistenceService: Persistence {

    
    func store(_ value: Object, update: Realm.UpdatePolicy = .error) {
        let realm = try! Realm()
        try? realm.write {
            realm.add(value, update: update)
        }
    }
    
    func retrieve<Value>(type: Value.Type) -> Results<Value> where Value : Object {
        let realm = try! Realm()
        return realm.objects(type)
    }
    
    func write(block: @escaping (Realm) -> Void) {
        let realm = try! Realm()
        try? realm.write {
            block(realm)
        }
    }
}
