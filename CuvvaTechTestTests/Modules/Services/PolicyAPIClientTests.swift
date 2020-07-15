//
//  PolicyAPIClientTests.swift
//  CuvvaTechTestTests
//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation
import XCTest
@testable import CuvvaTechTest


class PolicyAPIClientTests: XCTestCase {
    
    private let url = URL(string: "http://some.domain.com")!

    func testApiClientReturnsData() {
        let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let data = PolicyMockData.jsonData
        let mockSession = MockNetworkingSession(response: response, data: data, error: nil)
        let networking = NetworkingClient(session: mockSession)
        let persistence = PolicyPersistenceService(persistence: PersistenceService())
        
        let expectedData = convertDataToPolicyData(from: data)
        
        let sut = PolicyAPIClient(networking: networking, baseUrl: self.url, persistence: persistence)
        sut.getData { result in
            switch result {
                case .success(let data):
                    dispatchPrecondition(condition: .onQueue(.main))
                    XCTAssertEqual(data, expectedData)
                case .failure:
                    XCTFail()
            }
        }
    }
    
    func testApiClientReturnsDataOnSpecifiedQueue() {
        let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let data = PolicyMockData.jsonData
        let mockSession = MockNetworkingSession(response: response, data: data, error: nil)
        let networking = NetworkingClient(session: mockSession)
        let persistence = PolicyPersistenceService(persistence: PersistenceService())
        
        let expectedData = convertDataToPolicyData(from: data)
        
        let dispatchQueue = DispatchQueue(label: "some.queue")
        
         let sut = PolicyAPIClient(networking: networking, baseUrl: self.url, persistence: persistence)
        sut.getData(on: dispatchQueue) { result in
            switch result {
                case .success(let data):
                    dispatchPrecondition(condition: .onQueue(dispatchQueue))
                    XCTAssertEqual(data, expectedData)
                case .failure:
                    XCTFail()
            }
        }
    }
    
    func testApiClientReturnsDataWithEmptyPayloadShouldError() {
        let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let data = PolicyMockData.jsonEmptyPayloadData
        let mockSession = MockNetworkingSession(response: response, data: data, error: nil)
        let networking = NetworkingClient(session: mockSession)
        let persistence = PolicyPersistenceService(persistence: PersistenceService())
        
         let sut = PolicyAPIClient(networking: networking, baseUrl: self.url, persistence: persistence)
        sut.getData { result in
            switch result {
                case .success:
                    XCTFail()
                case .failure(let error):
                    XCTAssertEqual(error, NetworkError.decodingFailed(message: error.localizedDescription))
            }
        }
    }
    
    func testApiClientReturnsErrorOnFailure() {
        let givenError = NetworkError.error(message: "some error message")
        let mockSession = MockNetworkingSession(response: nil, data: nil, error: givenError)
        let networking = NetworkingClient(session: mockSession)
        let persistence = PolicyPersistenceService(persistence: PersistenceService())
        
         let sut = PolicyAPIClient(networking: networking, baseUrl: self.url, persistence: persistence)
        sut.getData { result in
            switch result {
                case .success:
                    XCTFail()
                case .failure(let error):
                    XCTAssertEqual(error, givenError)
            }
        }
    }
    
}
