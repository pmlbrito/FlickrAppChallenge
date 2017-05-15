//
//  PhotoListTableViewCell.swift
//  FlickrAppChallenge
//
//  Created by Pedro Brito on 05/02/2017.
//  Copyright © 2017 Pedro Brito. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoListTableViewCell: UITableViewCell {
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    func setupWithPhoto(flickrPhoto: FlickrPhoto) {
        cellTitleLabel.text = flickrPhoto.title
        let resource = ImageResource(downloadURL: flickrPhoto.photoUrl, cacheKey: flickrPhoto.photoUrl.absoluteString)
        cellImage.kf.setImage(with: resource)
    }
}
