
//
//  PhotosViewModelTests.swift
//  FlickrAppTests
//
//  Created by Ashwani on 21/01/19.
//  Copyright © 2019 Ashwani. All rights reserved.
//

import XCTest

class PhotosViewModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitialisation() {
        let JSON = "{\"page\":1, \"pages\":10, \"photo\":[{\"id\": \"46817080071\", \"owner\": \"69408027@N08\", \"secret\": \"ddd9ef029a\",\"server\": \"7840\",\"farm\": 8,\"title\": \"Osmington tonight\"}]}"
        do {
            let data = JSON.data(using: .utf8)
            let photos = try JSONDecoder().decode(Photos.self, from: data!)
            let photosViewModel = PhotosViewModel(photos:photos)
            XCTAssert(photosViewModel.page! == 1, "Page does not match")
            XCTAssert(photosViewModel.pages! == 10, "Pages does not match")
            XCTAssert(photosViewModel.viewModels?.count == 1, "View Model array count does not match")
        }
        catch {
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testUpdate() {
        let JSON = "{\"page\":1, \"pages\":10, \"photo\":[{\"id\": \"46817080071\", \"owner\": \"69408027@N08\", \"secret\": \"ddd9ef029a\",\"server\": \"7840\",\"farm\": 8,\"title\": \"Osmington tonight\"}]}"
        
        let updateJSON = "{\"page\":2, \"pages\":10, \"photo\":[{\"id\": \"45817080071\", \"owner\": \"69408027@N08\", \"secret\": \"ddd9ef029a\",\"server\": \"7840\",\"farm\": 9,\"title\": \"Dogs\"}]}"
        do {
            let data = JSON.data(using: .utf8)
            let newData = updateJSON.data(using: .utf8)
            //Original Instance
            let photos = try JSONDecoder().decode(Photos.self, from: data!)
            var photosViewModel = PhotosViewModel(photos:photos)
            
            //New Instance for update
            let photosNew = try JSONDecoder().decode(Photos.self, from: newData!)
            let photosViewModelNew = PhotosViewModel(photos:photosNew)
            
            
            photosViewModel.update(with: photosViewModelNew)
            XCTAssert(photosViewModel.page! == 2, "Updated Page is not correct")
            XCTAssert(photosViewModel.pages! == 10, "Updated Pages are not correct")
            XCTAssert(photosViewModel.viewModels?.count == 2, "Post update View Model array count does not match")
        }
        catch {
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testUpdateForFirstPage() {
        let JSON = "{\"page\":3, \"pages\":10, \"photo\":[{\"id\": \"46817080071\", \"owner\": \"69408027@N08\", \"secret\": \"ddd9ef029a\",\"server\": \"7840\",\"farm\": 8,\"title\": \"Osmington tonight\"}]}"
        
        let updateJSON = "{\"page\":1, \"pages\":100, \"photo\":[{\"id\": \"45817080071\", \"owner\": \"69408027@N08\", \"secret\": \"ddd9ef029a\",\"server\": \"7840\",\"farm\": 9,\"title\": \"Dogs\"}]}"
        do {
            let data = JSON.data(using: .utf8)
            let newData = updateJSON.data(using: .utf8)
            //Original Instance
            let photos = try JSONDecoder().decode(Photos.self, from: data!)
            var photosViewModel = PhotosViewModel(photos:photos)
            
            //New Instance for update
            let photosNew = try JSONDecoder().decode(Photos.self, from: newData!)
            let photosViewModelNew = PhotosViewModel(photos:photosNew)
            
            
            photosViewModel.update(with: photosViewModelNew)
            XCTAssert(photosViewModel.page! == 1, "Updated Page is not correct")
            XCTAssert(photosViewModel.pages! == 100, "Updated Pages are not correct")
            XCTAssert(photosViewModel.viewModels?.count == 1, "Post update View Model array count does not match")
        }
        catch {
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testShouldLoadMoreForNewPages() {
        let JSON = "{\"page\":1, \"pages\":10, \"photo\":[{\"id\": \"46817080071\", \"owner\": \"69408027@N08\", \"secret\": \"ddd9ef029a\",\"server\": \"7840\",\"farm\": 8,\"title\": \"Osmington tonight\"}]}"
        do {
            let data = JSON.data(using: .utf8)
            let photos = try JSONDecoder().decode(Photos.self, from: data!)
            let photosViewModel = PhotosViewModel(photos:photos)
            XCTAssert(photosViewModel.shouldLoadMore(), "Incorrect value for page < pages")
        }
        catch {
            XCTAssert(false, error.localizedDescription)
        }
    }
    func testShouldNotLoadMoreForNewPages() {
        let JSON = "{\"page\":10, \"pages\":10, \"photo\":[{\"id\": \"46817080071\", \"owner\": \"69408027@N08\", \"secret\": \"ddd9ef029a\",\"server\": \"7840\",\"farm\": 8,\"title\": \"Osmington tonight\"}]}"
        do {
            let data = JSON.data(using: .utf8)
            let photos = try JSONDecoder().decode(Photos.self, from: data!)
            let photosViewModel = PhotosViewModel(photos:photos)
            XCTAssert(photosViewModel.shouldLoadMore() == false, "Incorrect value for page == pages")
        }
        catch {
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testShouldLoadMoreForIsFetchingState() {
        let JSON = "{\"page\":1, \"pages\":10, \"photo\":[{\"id\": \"46817080071\", \"owner\": \"69408027@N08\", \"secret\": \"ddd9ef029a\",\"server\": \"7840\",\"farm\": 8,\"title\": \"Osmington tonight\"}]}"
        do {
            let data = JSON.data(using: .utf8)
            let photos = try JSONDecoder().decode(Photos.self, from: data!)
            var photosViewModel = PhotosViewModel(photos:photos)
            photosViewModel.isFetching = false
            XCTAssert(photosViewModel.shouldLoadMore(), "Incorrect value for should load more for isFetching == false")
        }
        catch {
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testShouldNotLoadMoreForIsFetchingState() {
        let JSON = "{\"page\":1, \"pages\":10, \"photo\":[{\"id\": \"46817080071\", \"owner\": \"69408027@N08\", \"secret\": \"ddd9ef029a\",\"server\": \"7840\",\"farm\": 8,\"title\": \"Osmington tonight\"}]}"
        do {
            let data = JSON.data(using: .utf8)
            let photos = try JSONDecoder().decode(Photos.self, from: data!)
            var photosViewModel = PhotosViewModel(photos:photos)
            photosViewModel.isFetching = true
            XCTAssert(photosViewModel.shouldLoadMore() == false, "Incorrect value for should load more for isFetching == true")
        }
        catch {
            XCTAssert(false, error.localizedDescription)
        }
    }
}
