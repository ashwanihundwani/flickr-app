//
//  PhotoViewModel.swift
//  FlickrApp
//
//  Created by Ashwani on 19/01/19.
//  Copyright © 2019 Ashwani. All rights reserved.
//

import UIKit
/**
 ViewModel for a Flickr photo item UI
 */
struct PhotoViewModel {
    /**
     The identifier for the photo
     */
    let id: String?
    
    /**
     The secret
     */
    let secret: String?
    
    /**
     The farm identifier to which photo belongs
     */
    let farm:Int?
    
    /**
     The server identifier
     */
    let server:String?
    
    /**
     The photo title
     */
    let title:String?
    
    //MARK: Initialisation
    /**
     Initialises a new PhotoViewModel instance with the Photo instance
     - Parameters: The photo instance
     */
    init(photo: Photo) {
        id = photo.id
        secret = photo.secret
        farm = photo.farm
        server = photo.server
        title = photo.title
    }
}
