//
//  PolicyAPIClientTests.swift
//  CuvvaTechTestTests
//
//  Created by Dimitrios Chatzieleftheriou on 14/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import XCTest
import RealmSwift

@testable import CuvvaTechTest


class PolicyAPIClientTests: XCTestCase {
    
    private let url = URL(string: "http://some.domain.com")!
    
    override func setUp() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }
    
    func testApiClientReturnsDataAndSavesResposeToPersistence() {
        let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let data = PolicyMockData.jsonData
        let mockSession = MockNetworkingSession(response: response, data: data, error: nil)
        let networking = NetworkingClient(session: mockSession)
        
        let expectation = self.expectation(description: "data expectation")
        
        let sut = PolicyAPIClient(networking: networking, baseUrl: self.url)
        sut.getData { result in
            switch result {
                case .success(let result):
                    dispatchPrecondition(condition: .onQueue(.main))
                    XCTAssertFalse(result.data.isEmpty)
                    expectation.fulfill()
                case .failure:
                    XCTFail()
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testApiClientReturnsDataOnSpecifiedQueue() {
        let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let data = PolicyMockData.jsonData
        let mockSession = MockNetworkingSession(response: response, data: data, error: nil)
        let networking = NetworkingClient(session: mockSession)
                
        let dispatchQueue = DispatchQueue(label: "some.queue")
        
        let expectation = self.expectation(description: "data expectation")
        
        let sut = PolicyAPIClient(networking: networking, baseUrl: self.url)
        sut.getData(on: dispatchQueue) { result in
            switch result {
                case .success(let result):
                    dispatchPrecondition(condition: .onQueue(dispatchQueue))
                    XCTAssertFalse(result.data.isEmpty)
                    expectation.fulfill()
                case .failure:
                    XCTFail()
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testApiClientReturnsDataWithEmptyPayloadShouldError() {
        let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let data = PolicyMockData.jsonEmptyPayloadData
        let mockSession = MockNetworkingSession(response: response, data: data, error: nil)
        let networking = NetworkingClient(session: mockSession)
        
        let sut = PolicyAPIClient(networking: networking, baseUrl: self.url)
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
        
        let sut = PolicyAPIClient(networking: networking, baseUrl: self.url)
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
