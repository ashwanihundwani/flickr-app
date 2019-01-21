//
//  PhotoViewModelTests.swift
//  FlickrAppTests
//
//  Created by Ashwani on 21/01/19.
//  Copyright © 2019 Ashwani. All rights reserved.
//

import XCTest

class PhotoViewModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitialisation() {
        
        let JSON = "{\"id\": \"46817080071\", \"owner\": \"69408027@N08\", \"secret\": \"ddd9ef029a\",\"server\": \"7840\",\"farm\": 8,\"title\": \"Osmington tonight\"}"
        do {
            let data = JSON.data(using: .utf8)
            let photo = try JSONDecoder().decode(Photo.self, from: data!)
            let photoViewModel = PhotoViewModel(photo:photo)
            
            XCTAssert(photoViewModel.farm == 8, "Farm does not match")
            XCTAssert(photoViewModel.server == "7840", "Server does not match")
            XCTAssert(photoViewModel.secret == "ddd9ef029a", "Secret does not match")
            XCTAssert(photoViewModel.title == "Osmington tonight", "Title does not match")
            XCTAssert(photoViewModel.id == "46817080071", "Identifier does not match")
        }
        catch {
            XCTAssert(false, error.localizedDescription)
        }
    }

}
