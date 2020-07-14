//
//  PolicyDataTests.swift
//  CuvvaTechTestTests
//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//


import Foundation
import XCTest
@testable import CuvvaTechTest

class PolicyDataTests: XCTestCase {
    
    private let url = URL(string: "http://some.domain.com")!
    
    func testPolicyDataCanBeDecodedFromJSON() {
        let data = PolicyMockData.jsonData
        
        let decodedData = policyData(from: data)
        
        XCTAssertNotNil(decodedData)
        
    }
    
    func testPolicyDataCanReturnPolicies() {
        let data = PolicyMockData.jsonData
        
        let decodedData = policyData(from: data)
        
        XCTAssertNotNil(decodedData)
        
        let policies = decodedData?.policies()
        XCTAssertNotNil(policies)
        XCTAssertEqual(policies!.count, 1)
        
    }
    
    func testPolicyDataCanReturnTransactions() {
        let data = PolicyMockData.jsonData
        
        let decodedData = policyData(from: data)
        
        XCTAssertNotNil(decodedData)
        
        let transactions = decodedData?.transactions()
        XCTAssertNotNil(transactions)
        XCTAssertEqual(transactions!.count, 1)
        
    }
    
    func testPolicyDataCanReturnCanceled() {
        let data = PolicyMockData.jsonData
        
        let decodedData = policyData(from: data)
        
        XCTAssertNotNil(decodedData)
        
        let cancelled = decodedData?.cancelled()
        XCTAssertNotNil(cancelled)
        XCTAssertEqual(cancelled!.count, 1)
        
    }
    
    private func policyData(from data: Data) -> PolicyData? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.iso8601)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try? decoder.decode(PolicyData.self, from: data)
    }
}
