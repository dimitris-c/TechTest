//
//  PolicyPersistenceTests.swift
//  CuvvaTechTestTests
//
//  Created by Dimitrios Chatzieleftheriou on 15/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import XCTest
import RealmSwift

@testable import CuvvaTechTest

class PolicyPersistenceTests: XCTestCase {

    override func setUp() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }

    func testPersistenceCanStorePolicyData() {

        let persistence = PolicyPersistenceService(persistence: PersistenceService())
        
        let policyData = convertDataToPolicyData(from: PolicyMockData.jsonData)
        XCTAssertNotNil(policyData)
        
        persistence.store(policyData: policyData!)
        
        // force an empty sync to delay assertion
        persistence.dispatchQueue.sync { }
        
        let realm = try! Realm()
        let policies = realm.objects(Policy.self)
        XCTAssertFalse(policies.isEmpty)
    }
    
    func testPersistenceCanRetrievePolicies() {
     
        let persistence = PolicyPersistenceService(persistence: PersistenceService())
        
        let policyData = convertDataToPolicyData(from: PolicyMockData.jsonData)
        XCTAssertNotNil(policyData)
        
        persistence.store(policyData: policyData!)
        
        // force an empty sync to delay assertion
        persistence.dispatchQueue.sync { }
        
        let policies = persistence.retrievePolicies()
        XCTAssertFalse(policies.isEmpty)
    }

}
