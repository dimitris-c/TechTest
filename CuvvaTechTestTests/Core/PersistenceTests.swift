//
//  PersistenceTests.swift
//  CuvvaTechTestTests
//
//  Created by Dimitrios Chatzieleftheriou on 15/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import XCTest
import RealmSwift

@testable import CuvvaTechTest

class PersistenceTests: XCTestCase {

    override func setUp() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }
    
    func testPersistencePersistsObjects() {
        
        let persistence = PersistenceService()
        
        let vehicle = Vehicle()
        vehicle.make = "Mini"
        
        persistence.store(vehicle)
        
        let realm = try! Realm()
        let object = realm.objects(Vehicle.self).last
        XCTAssertNotNil(object)
    }

    
    func testPersistenceCanRetrieveObjects() {
        
        let persistence = PersistenceService()
        let vehiclesMakes = ["Mini", "Peugeot", "BMW"]
        let vehicles: [Vehicle] = vehiclesMakes.map { make in
            let vehicle = Vehicle()
            vehicle.make = make
            return vehicle
        }

        let realm = try! Realm()
        try? realm.write {
            for vehicle in vehicles {
                realm.add(vehicle)
            }
        }
        
        let objects = persistence.retrieve(type: Vehicle.self)
        XCTAssertNotNil(objects)
        XCTAssertEqual(objects.count, 3)
    }
    
    func testPersistenceCanWriteObjects() {
        let persistence = PersistenceService()
        let vehiclesMakes = ["Mini", "Peugeot", "BMW"]
        let vehicles: [Vehicle] = vehiclesMakes.map { make in
            let vehicle = Vehicle()
            vehicle.make = make
            return vehicle
        }

        persistence.write { realm in
            for vehicle in vehicles {
                realm.add(vehicle)
            }
        }
        
        let objects = persistence.retrieve(type: Vehicle.self)
        XCTAssertNotNil(objects)
        XCTAssertEqual(objects.count, 3)
    }

}
