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
        
        let realm = try! Realm()
        let policies = realm.objects(Policy.self)
        XCTAssertFalse(policies.isEmpty)
    }
    
    func testPersistenceCanRetrievePolicies() {
     
        let persistence = PolicyPersistenceService(persistence: PersistenceService())
        
        let policyData = convertDataToPolicyData(from: PolicyMockData.jsonData)
        XCTAssertNotNil(policyData)
        
        persistence.store(policyData: policyData!)
        
        let policies = persistence.retrievePolicies()
        XCTAssertFalse(policies.isEmpty)
    }
    
    func testPersistenceCanRetrieveVehicles() {
     
        let persistence = PolicyPersistenceService(persistence: PersistenceService())
        
        let policyData = convertDataToPolicyData(from: PolicyMockData.jsonData)
        XCTAssertNotNil(policyData)
        
        persistence.store(policyData: policyData!)
        
        let vehicles = persistence.retrieveVehicles()
        XCTAssertFalse(vehicles.isEmpty)
    }

}
