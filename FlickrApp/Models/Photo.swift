//
//  Photo.swift
//  FlickrApp
//
//  Created by Ashwani on 19/01/19.
//  Copyright © 2019 Ashwani. All rights reserved.
//

import UIKit
/**
 Represents a photo recieved in the Flickr api response.
 */
struct Photo : Decodable {
    /**
     The identifier for the photo
     */
    let id: String?
    /**
     The secret in photo response JSON
     */
    let secret: String?
    /**
     The farm identifier to which photo belongs
     */
    let farm:Int?
    /**
     The server identifier in photo response JSON
     */
    let server:String?
    /**
     The title of the photo
     */
    let title:String?
}
