//
//  Service.swift
//  FlickrApp
//
//  Created by Ashwani on 19/01/19.
//  Copyright © 2019 Ashwani. All rights reserved.
//

import UIKit

/**
 This class is the common access point for all the Flickr api calls made in this application.
 */
class Service {
    
    //MARK: Initialisation
    static let shared = Service()
    private init() {} //This prevents others from using the default '()' initializer for this class.
    
    //MARK: Public Methods
    /**
     Fetches the recent photos using the Flickr api
     - Parameters:
        - page: The page number
        - result: The result either response data or error from the api.
     */
    internal func fetchRecentPhotos(page:Int, result:@escaping (Photos?, Error?) -> Void)  {
        
        if let photosURL = URLBuilder.shared.recentPhotosURL(page: page) {
            fetchPhotos(photosURL: photosURL, result: result)
        } else {
            print("Error in creating URL")
        }
    }
    
    /**
     Fetches the photos based on user's search using the Flickr api
     - Parameters:
        - searchText: The search query from the user
        - page: The page number
        - result: The result either response data or error from the api.
     */
    internal func fetchPhotos(searchText:String, page:Int, result:@escaping (Photos?, Error?) -> Void)  {
        if let photosURL = URLBuilder.shared.photosURL(searchText: searchText, page: page) {
            fetchPhotos(photosURL: photosURL, result: result)
        } else {
            print("Error in creating URL")
        }
    }
    
    //MARK: Private Methods
    /**
     Designated method, fetches the photos based on the provided URL from the Flickr api
     - Parameters:
        - photosURL: The URL to fetch the photos.
        - result: The result either response data or error from the api.
     */
    private func fetchPhotos(photosURL:URL, result:@escaping (Photos?, Error?) -> Void) {
        URLSession.shared.dataTask(with: photosURL) { (data, response, error) in
            guard let data = data else {
                result(nil, error)
                return
            }
            do {
                let photos = try JSONDecoder().decode(PhotosResponse.self, from: data)
                result(photos.photos, nil)
            }
            catch {
                print("Error: \(error)")
            }
        }.resume()
        
    }
}
