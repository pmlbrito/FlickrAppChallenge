//
//  PhotoDetailViewController.swift
//  FlickrAppChallenge
//
//  Created by Pedro Brito on 05/02/2017.
//  Copyright © 2017 Pedro Brito. All rights reserved.
//

import UIKit
import Kingfisher

protocol PhotoSelectionChangedDelegate: class {
    func selectedPhoto(photo: FlickrPhoto)
}

class PhotoDetailViewController: UIViewController, PhotoSelectionChangedDelegate {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoTitleLabel: UILabel!

    var photo: FlickrPhoto!
    var userName: String = ""
    
    override func viewDidLoad() {
        self.title = self.userName
        self.setViewState()
    }
    
    fileprivate func setViewState() {
        if self.photo != nil {
            self.photoTitleLabel.text = photo.title
            let resource = ImageResource(downloadURL: photo.largePhotoUrl, cacheKey: photo.largePhotoUrl.absoluteString)
            self.photoImageView.kf.setImage(with: resource)
        }else {
            self.photoTitleLabel.text = "Waiting for photo selection"
        }
    }
}

extension PhotoDetailViewController {
    func selectedPhoto(photo: FlickrPhoto) {
        self.photo = photo
        self.setViewState()
    }
}
