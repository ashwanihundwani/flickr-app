//
//  Photos.swift
//  FlickrApp
//
//  Created by Ashwani on 19/01/19.
//  Copyright © 2019 Ashwani. All rights reserved.
//

import UIKit

/**
 Represent the root object mapped with the JSON received in the response.
 */
struct PhotosResponse: Decodable {
    let photos:Photos?
}

/**
 Represents an array of photos recieved in the Flickr api response along with the other pagination related properties.
 */
struct Photos: Decodable {
    /**
     The current page number in the Flickr api response
     */
    let page:Int?
    /**
     Total pages in the Flickr api response
     */
    let pages:Int?
    
    /**
     Array of photos in the Flickr api response.
     */
    let photos:[Photo]?
    
    /**
     Decode keys map for the photos response object used to map the received JSON object to the Photos instance.
     */
    private enum CodingKeys : String, CodingKey {
        case page = "page"
        case pages = "pages"
        case photos = "photo"
    }
}
