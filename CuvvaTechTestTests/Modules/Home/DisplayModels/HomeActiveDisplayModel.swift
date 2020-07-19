//
//  HomeActiveDisplayModel.swift
//  CuvvaTechTestTests
//
//  Created by Dimitrios Chatzieleftheriou on 19/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import XCTest
import RealmSwift
@testable import CuvvaTechTest

class HomeActiveDisplayModelTests: XCTestCase {
    
    func test_DisplayModel_Has_CorrectValues_ForLabels() {
        
        let policyData = convertDataToPolicyData(from: PolicyMockData.jsonData)
        let policy = policyData?.policies().first
        XCTAssertNotNil(policy)
        XCTAssertNotNil(policy?.vehicle)
        // alter started and end date from json data
        policy?.startDate = Date(timeIntervalSinceNow: -60)
        policy?.endDate = Date(timeIntervalSinceNow: 120)
        
        let model = ActivePolicyDisplayModel(policy: policy!, totalPolicies: 1)
        
        XCTAssertEqual(model.carMakeTitle, policy!.vehicle!.make)
        let carMakeSubtitle = "\(policy!.vehicle!.color) \(policy!.vehicle!.model)"
        XCTAssertEqual(model.carMakeSubtitle, carMakeSubtitle)
        
        XCTAssertEqual(model.regPlateTitle, "Reg Plate")
        XCTAssertEqual(model.regPlateValueTitle, policy!.vehicle!.prettyVrm)
        
        XCTAssertEqual(model.totalPoliciesTitle, "Total Policies")
        XCTAssertEqual(model.totalPoliciesValueTitle, "1")
    }
    
    func test_DisplayModel_Has_CorrectValues_For_Countdown() {
        
        let policyData = convertDataToPolicyData(from: PolicyMockData.jsonData)
        let policy = policyData?.policies().first
        XCTAssertNotNil(policy)
        XCTAssertNotNil(policy?.vehicle)
        // alter started and end date from json data
        policy?.startDate = Date(timeIntervalSinceNow: -60)
        policy?.endDate = Date(timeIntervalSinceNow: 120)
        
        let model = ActivePolicyDisplayModel(policy: policy!, totalPolicies: 1)
        
        XCTAssertEqual(model.elapsedSeconds, -60, accuracy: 0.1)
        XCTAssertEqual(model.remainingSeconds, 120, accuracy: 0.1)
        XCTAssertEqual(model.totalSeconds, 180, accuracy: 0.1)
    }
    
    func test_DisplayModel_Can_FormatRemaining_Seconds() {
        
        let policyData = convertDataToPolicyData(from: PolicyMockData.jsonData)
        let policy = policyData?.policies().first
        XCTAssertNotNil(policy)
        XCTAssertNotNil(policy?.vehicle)
        // alter started and end date from json data
        policy?.startDate = Date(timeIntervalSinceNow: -60)
        policy?.endDate = Date(timeIntervalSinceNow: 120)
        
        let model = ActivePolicyDisplayModel(policy: policy!, totalPolicies: 1)
        
        XCTAssertEqual(model.formattedRemaingTimeTitle!, "2 minutes remaining")
    }
    
    func test_DisplayModel_Outputs_Correct_Effect_For_Action() {
        
        let policyData = convertDataToPolicyData(from: PolicyMockData.jsonData)
        let policy = policyData?.policies().first
        XCTAssertNotNil(policy)
        XCTAssertNotNil(policy?.vehicle)
        // alter started and end date from json data
        policy?.startDate = Date(timeIntervalSinceNow: -60)
        policy?.endDate = Date(timeIntervalSinceNow: 120)
        
        let model = ActivePolicyDisplayModel(policy: policy!, totalPolicies: 1)
        
        let startExpectation = self.expectation(description: "start countdown expectation")
        
        let stopExpectation = self.expectation(description: "stop countdown expectation")
        
        model.updateContent = { effect in
            switch effect {
                case .startCountdown:
                    startExpectation.fulfill()
                case .stopCountdown:
                    stopExpectation.fulfill()
            }
        }
        
        model.perform(action: .startVisualCountdown)
        
        self.wait(for: [startExpectation], timeout: 2)
        
        model.perform(action: .stopVisualCountdown)
        
        self.wait(for: [stopExpectation], timeout: 2)
        
    }
}
