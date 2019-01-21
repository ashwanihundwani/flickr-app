//
//  PhotosTests.swift
//  FlickrAppTests
//
//  Created by Ashwani on 21/01/19.
//  Copyright © 2019 Ashwani. All rights reserved.
//

import XCTest

class PhotosTests: XCTestCase {

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
            let photos = try JSONDecoder().decode(Photos.self, from: data!)
            XCTAssert(photos.page == nil, "Page should be nil")
            XCTAssert(photos.pages == nil, "Pages should be nil")
            XCTAssert(photos.photos == nil, "Photos array should be nil")
        }
        catch {
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testInitialisationByValidJSON() {
        
        let JSON = "{\"page\":1, \"pages\":10, \"photo\":[{\"id\": \"46817080071\", \"owner\": \"69408027@N08\", \"secret\": \"ddd9ef029a\",\"server\": \"7840\",\"farm\": 8,\"title\": \"Osmington tonight\"}]}"
        do {
            let data = JSON.data(using: .utf8)
            let photos = try JSONDecoder().decode(Photos.self, from: data!)
            XCTAssert(photos.page! == 1, "Page does not match")
            XCTAssert(photos.pages! == 10, "Pages does not match")
            XCTAssert(photos.photos?.count == 1, "Photos array count does not match")
        }
        catch {
            XCTAssert(false, error.localizedDescription)
        }
    }
}
