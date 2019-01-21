//
//  URLBuilderTests.swift
//  FlickrAppTests
//
//  Created by Ashwani on 21/01/19.
//  Copyright © 2019 Ashwani. All rights reserved.
//

import XCTest

class URLBuilderTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRecentPhotosURL() {
        let testURL = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=3e7cc266ae2b0e0d78e279ce8e361736&&format=json&nojsoncallback=1&safe_search=1&page=2")
        
        let recentPhotosURL = URLBuilder.shared.recentPhotosURL(page: 2)
        
        XCTAssert(testURL == recentPhotosURL, "Recent Photos URLs do not match")
    }

    
    func testSearchPhotosURL() {
        let testURL = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&&format=json&nojsoncallback=1&safe_search=1&text=Kitten&page=2")
        
        let searchPhotosURL = URLBuilder.shared.photosURL(searchText: "Kitten", page: 2)
        
        XCTAssert(testURL == searchPhotosURL, "Search URLs do not match")
    }
    
    func testImageURL() {
        let testURL = URL(string: "https://farm1.static.flickr.com/7768/46817080071_ddd9ef029a.jpg")
        
        let imageURL = URLBuilder.shared.imageURL(parameters: (farm: 1, server: "7768", id: "46817080071", secret: "ddd9ef029a"))
        
        XCTAssert(testURL == imageURL, "URLs do not match")
    }
}
