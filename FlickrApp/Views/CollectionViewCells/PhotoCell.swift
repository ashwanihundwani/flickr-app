//
//  PhotoCell.swift
//  FlickrApp
//
//  Created by Ashwani on 19/01/19.
//  Copyright © 2019 Ashwani. All rights reserved.
//

import UIKit
/**
 This class displays the photo infomation(Image & title) for the each photo retreived from the server
 */
class PhotoCell: UICollectionViewCell {
    /**
     Title label to display the photo title
     */
    @IBOutlet weak var titleLabel: UILabel!
    /**
    Image View to display the photo.
     */
    @IBOutlet weak var photoImageView: CustomImageView!
    
    /**
     Sets the PhotoViewModel, assign the values to the UI controls
     */
    var photoViewModel:PhotoViewModel? {
        didSet {
            guard let viewModel = photoViewModel else {
                return
            }
            titleLabel.text = viewModel.title
            if let farm = viewModel.farm, let server = viewModel.server, let id = viewModel.id, let secret = viewModel.secret {
                if let imageURL = URLBuilder.shared.imageURL(parameters:(farm, server, id, secret)) {
                    photoImageView.download(from: imageURL)
                }
            }
        }
    }

}
