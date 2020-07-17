//
//  PolicyTests.swift
//  CuvvaTechTestTests
//
//  Created by Dimitrios Chatzieleftheriou on 15/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import XCTest

@testable import CuvvaTechTest

class PolicyTests: XCTestCase {

    func testPolicyIsCorrectlyReturnsActiveStatusWhen_Is_Active_NoExtensions() throws {
        // Given
        let policy = Policy()
        policy.policyId = "policy.id"
        // When
        // start and end date is between now
        policy.startDate = Date(timeInterval: -20, since: Date())
        policy.endDate = Date(timeInterval: 20, since: Date())
        
        // Then
        let isActive = policy.isActive()
        XCTAssertTrue(isActive)
        
    }
    
    func testPolicyIsCorrectlyReturnsActiveStatusWhen_Not_Active_NoExtensions_OnMissingDates() throws {
        // Given
        let policy = Policy()
        policy.policyId = "policy.id"
        // When
        // start and end date is between now
        policy.startDate = nil
        policy.endDate = Date(timeInterval: 20, since: Date())
        
        // Then
        var isActive = policy.isActive()
        XCTAssertFalse(isActive)
        
        // When
        policy.startDate = Date(timeInterval: 20, since: Date())
        policy.endDate = nil
        
        isActive = policy.isActive()
        XCTAssertFalse(isActive)
    }
    
    func testPolicyIsCorrectlyReturnsActiveStatusWhen_Not_Active_NoExtensions_EndDateInEarlierThanNow() throws {
        // Given
        let policy = Policy()
        policy.policyId = "policy.id"
        // When
        // start and end date is between now
        policy.startDate = nil
        policy.endDate = Date(timeInterval: -20, since: Date())
        
        // Then
        let isActive = policy.isActive()
        XCTAssertFalse(isActive)
    }
    
    func testPolicyIsCorrectlyReturnsActiveStatusWhen_Not_Active_NoExtensions() throws {
        // Given
        let policy = Policy()
        policy.policyId = "policy.id"
        // When
        let sameDateInThePast = Date(timeIntervalSinceNow: -100)
        policy.startDate = Date(timeInterval: -20, since: sameDateInThePast)
        policy.endDate = Date(timeInterval: 20, since: sameDateInThePast)
        
        let isActive = policy.isActive()
        XCTAssertFalse(isActive)
        
    }
    
    func testPolicyIsCorrectlyReturnsActiveStatusWhen_Is_Active_WithExtensions() throws {
        // Given
        let policy = Policy()
        policy.policyId = "policy.id"
        
        let policyExtension = Policy()
        policyExtension.originalPolicyId = policy.policyId
        policyExtension.policyId = "policy.ext.id"
        
        policy.extensionPolicies.append(policyExtension)
        
        // extension end date is 10 seconds later that original policy start date
        policyExtension.endDate = Date(timeInterval: 30, since: Date())
        
        policy.startDate = Date(timeInterval: -20, since: Date())
        policy.endDate = Date(timeInterval: 20, since: Date())
        
        let isActive = policy.isActive()
        XCTAssertTrue(isActive)
        
    }
    
    func testPolicyIsCorrectlyReturnsActiveStatusWhen_Not_Active_WithExtensions() throws {
        // Given
        let policy = Policy()
        policy.policyId = "policy.id"
        
        let policyExtension = Policy()
        policyExtension.originalPolicyId = policy.policyId
        policyExtension.policyId = "policy.ext.id"
        
        policy.extensionPolicies.append(policyExtension)
        
        let sameDateInThePast = Date(timeIntervalSinceNow: -100)
        
        // extension end date is 10 seconds later that original policy start date
        policyExtension.endDate = Date(timeInterval: 20, since: sameDateInThePast)
        
        policy.startDate = Date(timeInterval: -20, since: sameDateInThePast)
        policy.endDate = Date(timeInterval: 20, since: sameDateInThePast)
        
        let isActive = policy.isActive()
        XCTAssertFalse(isActive)
        
    }
    
    func testPolicyIsCorrectlyReturnsActiveStatusWhen_Is_Active_WithVoidedExtensions() throws {
        // Given
        let policy = Policy()
        policy.policyId = "policy.id"
        
        let policyExtension = Policy()
        policyExtension.originalPolicyId = policy.policyId
        policyExtension.policyId = "policy.ext.id"
        policyExtension.cancelled = PolicyCancelled()
        policyExtension.cancelled?.policyId = policyExtension.policyId
        policy.extensionPolicies.append(policyExtension)
        
        // extension end date is 10 seconds later that original policy start date
        policyExtension.endDate = Date(timeInterval: 20, since: Date())
        
        policy.startDate = Date(timeInterval: -20, since: Date())
        policy.endDate = Date(timeInterval: 20, since: Date())
        
        let isActive = policy.isActive()
        XCTAssertTrue(isActive)
        
    }
    
    func testPolicyIsCorrectlyReturnsActiveStatusWhen_Not_Active_WithVoidedExtensions() throws {
        // Given
        let policy = Policy()
        policy.policyId = "policy.id"
        
        let policyExtension = Policy()
        policyExtension.originalPolicyId = policy.policyId
        policyExtension.policyId = "policy.ext.id"
        policyExtension.cancelled = PolicyCancelled()
        policyExtension.cancelled?.policyId = policyExtension.policyId
        policy.extensionPolicies.append(policyExtension)
        
        // extension end date is 10 seconds later that original policy start date
        policyExtension.endDate = Date(timeInterval: 20, since: Date())
        
        let sameDateInThePast = Date(timeIntervalSinceNow: -100)
        
        policy.startDate = Date(timeInterval: -20, since: sameDateInThePast)
        policy.endDate = Date(timeInterval: 10, since: sameDateInThePast)
        
        let isActive = policy.isActive()
        XCTAssertFalse(isActive)
        
    }
    
    func testPolicyIsCorrectlyReturnsActiveStatusWhen_Is_Active_WithExtensions_ExtensionMissingEndDate() throws {
        // Given
        let policy = Policy()
        policy.policyId = "policy.id"
        
        let policyExtension = Policy()
        policyExtension.originalPolicyId = policy.policyId
        policyExtension.policyId = "policy.ext.id"
        
        policyExtension.endDate = nil
        
        policy.startDate = Date(timeInterval: -20, since: Date())
        policy.endDate = Date(timeInterval: 10, since: Date())
        
        let isActive = policy.isActive()
        XCTAssertTrue(isActive)
        
    }
    

}
