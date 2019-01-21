//
//  PhotoTests.swift
//  FlickrAppTests
//
//  Created by Ashwani on 20/01/19.
//  Copyright © 2019 Ashwani. All rights reserved.
//

import XCTest


class PhotoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialisationByEmptyJSON() {
        let JSON = "{}"
        do {
            let data = JSON.data(using: .utf8)
            let photo = try JSONDecoder().decode(Photo.self, from: data!)
            
            XCTAssert(photo.farm == nil, "Farm should be nil")
            XCTAssert(photo.server == nil, "Server should be nil")
            XCTAssert(photo.secret == nil, "Secret should be nil")
            XCTAssert(photo.title == nil, "Title should be nil")
            XCTAssert(photo.id == nil, "Identifier should be nil")
        }
        catch {
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testInitialisationByValidJSON() {
        
        let JSON = "{\"id\": \"46817080071\", \"owner\": \"69408027@N08\", \"secret\": \"ddd9ef029a\",\"server\": \"7840\",\"farm\": 8,\"title\": \"Osmington tonight\"}"
        do {
            let data = JSON.data(using: .utf8)
            let photo = try JSONDecoder().decode(Photo.self, from: data!)
            XCTAssert(photo.farm == 8, "Farm does not match")
            XCTAssert(photo.server == "7840", "Server does not match")
            XCTAssert(photo.secret == "ddd9ef029a", "Secret does not match")
            XCTAssert(photo.title == "Osmington tonight", "Title does not match")
            XCTAssert(photo.id == "46817080071", "Identifier does not match")
        }
        catch {
            XCTAssert(false, error.localizedDescription)
        }
    }
}
