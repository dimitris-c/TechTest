//
//  HomeViewModelTests.swift
//  CuvvaTechTestTests
//
//  Created by Dimitrios Chatzieleftheriou on 19/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import XCTest
import RealmSwift
@testable import CuvvaTechTest

class HomeViewModelTests: XCTestCase {
    
    override func setUp() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }

    func testViewModelCanPerformViewLoadedActionAndLoadsData() throws {
        
        let policyApi = MockPolicyAPIClient()
        let policyPersistence = PolicyPersistenceService(persistence: PersistenceService())
        let homeNavigable = MockHomeNavigable()
        let viewModel = HomeViewModel(apiClient: policyApi, policyPersistence: policyPersistence, navigable: homeNavigable)
        
        let policyData = convertDataToPolicyData(from: PolicyMockData.jsonData)!
        policyApi.policyDataResult = .success(policyData)
        
        let effectExpectation = self.expectation(description: "should effect with loading and loaded")
        effectExpectation.expectedFulfillmentCount = 2
        
        viewModel.updateContent = { effect in
            switch effect {
                case .loading:
                    effectExpectation.fulfill()
                case .loaded:
                    XCTAssertTrue(policyPersistence.hasStoredContent)
                    effectExpectation.fulfill()
                case .error:
                    XCTFail()
            }
        }
        
        viewModel.perform(action: .viewLoaded)
        self.wait(for: [effectExpectation], timeout: 2)
    }
    
    func testViewModelCanPerformViewLoadedAction_OnError_WithoutStored_ShouldEffectWithError() throws {
        
        let policyApi = MockPolicyAPIClient()
        let policyPersistence = PolicyPersistenceService(persistence: PersistenceService())
        let homeNavigable = MockHomeNavigable()
        let viewModel = HomeViewModel(apiClient: policyApi, policyPersistence: policyPersistence, navigable: homeNavigable)
        
        let error = NetworkError.error(message: "Internet connection is unavailable")
        policyApi.policyDataResult = .failure(error)
        
        let effectExpectation = self.expectation(description: "should effect with loading and error")
        effectExpectation.expectedFulfillmentCount = 2
        
        viewModel.updateContent = { effect in
            switch effect {
                case .loading:
                    effectExpectation.fulfill()
                case .loaded:
                    XCTFail()
                case .error(let title, let message):
                    XCTAssertFalse(policyPersistence.hasStoredContent)
                    XCTAssertEqual(title, "Network Error")
                    XCTAssertEqual(message, error.localizedDescription)
                    effectExpectation.fulfill()
                    
            }
        }
        
        viewModel.perform(action: .viewLoaded)
        
        self.wait(for: [effectExpectation], timeout: 2)
    }
    
    func testViewModelCanPerformViewLoadedAction_OnError_WithStored_ShouldEffectWithLoaded() throws {
        
        let policyApi = MockPolicyAPIClient()
        let policyPersistence = PolicyPersistenceService(persistence: PersistenceService())
        let homeNavigable = MockHomeNavigable()
        let viewModel = HomeViewModel(apiClient: policyApi, policyPersistence: policyPersistence, navigable: homeNavigable)
        
        let policyData = convertDataToPolicyData(from: PolicyMockData.jsonData)!
        policyPersistence.store(policyData: policyData)
        
        policyApi.policyDataResult = .failure(.error(message: "Internet connection is unavailable"))
        
        let effectExpectation = self.expectation(description: "should effect with loading and error")
        effectExpectation.expectedFulfillmentCount = 2
        
        viewModel.updateContent = { effect in
            switch effect {
                case .loading:
                    effectExpectation.fulfill()
                case .loaded:
                    XCTAssertTrue(policyPersistence.hasStoredContent)
                    effectExpectation.fulfill()
                case .error:
                    XCTFail()
                    
            }
        }
        
        viewModel.perform(action: .viewLoaded)
        
        self.wait(for: [effectExpectation], timeout: 2)
    }
    
    func testViewModelCanPerformReloadActionAndLoadsData() throws {
        
        let policyApi = MockPolicyAPIClient()
        let policyPersistence = PolicyPersistenceService(persistence: PersistenceService())
        let homeNavigable = MockHomeNavigable()
        let viewModel = HomeViewModel(apiClient: policyApi, policyPersistence: policyPersistence, navigable: homeNavigable)
        
        let policyData = convertDataToPolicyData(from: PolicyMockData.jsonData)!
        policyApi.policyDataResult = .success(policyData)
        
        let effectExpectation = self.expectation(description: "should effect with loading and loaded")
        effectExpectation.expectedFulfillmentCount = 2
        
        viewModel.updateContent = { effect in
            switch effect {
                case .loading:
                    effectExpectation.fulfill()
                case .loaded:
                    XCTAssertTrue(policyPersistence.hasStoredContent)
                    effectExpectation.fulfill()
                case .error:
                    XCTFail()
            }
        }
        
        viewModel.perform(action: .reload)
        self.wait(for: [effectExpectation], timeout: 2)
    }
    
    func testViewModelCanPerformShowVehicleProfile_Should_Call_Navigable() throws {
        
        let policyApi = MockPolicyAPIClient()
        let policyPersistence = PolicyPersistenceService(persistence: PersistenceService())
        let homeNavigable = MockHomeNavigable()
        let viewModel = HomeViewModel(apiClient: policyApi, policyPersistence: policyPersistence, navigable: homeNavigable)
        
        let policyData = convertDataToPolicyData(from: PolicyMockData.jsonData)!
        policyApi.policyDataResult = .success(policyData)
        // view loaded
        viewModel.perform(action: .viewLoaded)
        
        let indexPath = IndexPath(row: 0, section: 0)
        let model = viewModel.dataSource.model(at: indexPath)
        
        // perform vehicle tap
        viewModel.perform(action: .showvehicleProfile(indexPath))
        
        XCTAssertTrue(homeNavigable.presentVehicleProfileCalled.called)
        if case let .vehicle(item) = model {
            XCTAssertEqual(homeNavigable.presentVehicleProfileCalled.id, item.vehicleId)            
        }
    }

}

class MockHomeNavigable: HomeNavigable {
    
    var presentVehicleProfileCalled: (called: Bool, id: String) = (false, "")
    func presentVehicleProfile(with id: String) {
        presentVehicleProfileCalled = (true, id)
    }
}

class MockPolicyAPIClient: PolicyAPI {
    
    var policyDataResult: Result<PolicyData, NetworkError>?
    func getData(on queue: DispatchQueue, completion: @escaping (Result<PolicyData, NetworkError>) -> Void) {
        if let policyDataResult = policyDataResult {
            completion(policyDataResult)
        }
    }
}
