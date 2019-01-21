//
//  PhotosViewModel.swift
//  FlickrApp
//
//  Created by Ashwani on 19/01/19.
//  Copyright © 2019 Ashwani. All rights reserved.
//

import UIKit
/**
 Fetch api types
 */
enum PhotosFetchType {
    case recent
    case search
}

/**
 ViewModel for Flickr photos listing screen.
 */
struct PhotosViewModel {
    /**
     Page number
     */
    var page:Int?
    
    /**
     Total number of pages
     */
    var pages:Int?
    
    /**
     Array of PhotoViewModel instances
     */
    var viewModels:[PhotoViewModel]?
    
    /**
     Sets or gets the search text entered by the user.
     */
    var searchText:String = "" {
        didSet {
            fetchType = searchText == "" ? .recent : .search
        }
    }
    
    /**
     ViewModel's current fetch type
     */
    var fetchType:PhotosFetchType = .recent
    
    /**
     Tells if the data is being fetched currently. Used to avoid multiple api calls. Once the data is downloaded the isFetching should be set to false explicitly.
     */
    var isFetching:Bool? = false
    
    /**
     Returns the next page for the data to be fetched.
     */
    var nextPage:Int {
        return page! + 1
    }
    
    //MARK: Initialisation
    /**
     Initialises the PhotoViewModel instance with the Photos Instance.
     - Parameters:
        - The photos instance
     */
    init(photos:Photos) {
        page = photos.page
        pages = photos.pages
        viewModels = photos.photos?.map({
            return PhotoViewModel(photo:$0)
        })
    }
    
    //MARK: Public Methods
    /**
     ViewModel decides based on its current state(page number & isFetching) whether to load more data or not while explicitly requested.
     - Returns: true or false - should load more data or not.
     */
    internal func shouldLoadMore() -> Bool {
        guard let page = page, let pages = pages, isFetching == false else {
            return false
        }
        return page < pages ? true: false
    }
    /**
     Updates the ViewModel with the newly received data in the api reponse.
     - Parameters:
        - viewModel: The new PhotosViewModel instance.
     */
    internal mutating func update(with viewModel:PhotosViewModel) {
        page = viewModel.page
        pages = viewModel.pages
        if page == 1 {
            viewModels?.removeAll()
        }
        if let newViewModels = viewModel.viewModels {
            viewModels? += newViewModels
        }
        
    }
}
