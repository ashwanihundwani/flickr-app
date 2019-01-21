//
//  URLBuilder.swift
//  FlickrApp
//
//  Created by Ashwani on 19/01/19.
//  Copyright © 2019 Ashwani. All rights reserved.
//

import UIKit
/**
 This class builds and returns the URL for all the specific Flickr api usages. It is the common access point for building the URLs for all the specific cases.
 */
class URLBuilder {

    //MARK: Initialisation
    static let shared = URLBuilder()
    private init() {} //This prevents others from using the default '()' initializer for this class.
    
    //MARK: Private Methods
    /**
     Encodes the provided URL
     - Parameters:
        - URLString: The URL string
     - Returns: Resulting encoded URL string
     */
    private func encodedURLString(URLString: String) -> String? {
        return URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    //MARK: Public Methods
    /**
     Prepares the recent photos URL
     - Parameters:
        - page: The page number
     
     - Returns: The prepared URL
     */
    internal func recentPhotosURL(page:Int) -> URL? {
        let URLString = String(format: "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=3e7cc266ae2b0e0d78e279ce8e361736&&format=json&nojsoncallback=1&safe_search=1&page=%d", page)
        return URL(string: encodedURLString(URLString: URLString)!)
        
    }
    
    /**
     Prepares the URL for the searched text
     - Parameters:
        - searchText : The searched text
        - page: The page number
     - Returns: The prepared URL
     */
    internal func photosURL(searchText:String, page:Int) -> URL? {
        let URLString = String(format: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&&format=json&nojsoncallback=1&safe_search=1&text=%@&page=%d", searchText, page)
         return URL(string: encodedURLString(URLString: URLString)!)
        
    }
    
    internal func imageURL(parameters:(farm:Int, server:String, id:String, secret:String)) -> URL? {
        let URLString = String(format: "https://farm%d.static.flickr.com/%@/%@_%@.jpg", parameters.farm, parameters.server, parameters.id, parameters.secret)
        return URL(string: encodedURLString(URLString: URLString)!)
        
    }
    
}
