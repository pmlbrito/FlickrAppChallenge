//
//  PhotosListTableViewController.swift
//  FlickrAppChallenge
//
//  Created by Pedro Brito on 03/02/2017.
//  Copyright © 2017 Pedro Brito. All rights reserved.
//

import Foundation
import UIKit
import SwinjectStoryboard

protocol PhotosListTableViewProtocol {
    func bindDataFetchResults(photos:[FlickrPhoto])
    
    func goToPictureDetail(photo: FlickrPhoto)
}

class PhotosListTableViewController: UITableViewController, PhotosListTableViewProtocol {
    
    static let photoCellIdentifier = "FlickrPhotoCell"
    
    weak var delegate: PhotoSelectionChangedDelegate?
    
    var photosListPresenter: PhotosListPresenterProtocol!
    
    var photos: [FlickrPhoto] = []
    var userName: String = ""

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.photosListPresenter = SwinjectStoryboard.getResolver().resolve(PhotosListPresenterProtocol.self)
    }
    
    override func viewDidLoad() {
        self.photosListPresenter.bindView(view: self)
        
        if  let infoPlist = Bundle.main.infoDictionary, let userDefault = infoPlist["FlickrAPISearchUser"] as? String {
            self.userName = userDefault
            self.title = userDefault
        }
        
        self.photosListPresenter.getDefaultUserPhotos()
    }
    
    // MARK - Because we are using storyboard master detail navigation, won't be using Navigator class or segues
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguePhotoListToDetail" {
            let photoViewController = segue.destination as! PhotoDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            photoViewController.photo = photos[selectedIndexPath!.row]
            photoViewController.userName = self.userName
        }
    }*/

    //MARK: - tbleview datasource and delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: PhotosListTableViewController.photoCellIdentifier, for: indexPath as IndexPath) as? PhotoListTableViewCell
        cell!.setupWithPhoto(flickrPhoto: photos[indexPath.row])
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPhoto = photos[indexPath.row]
        self.goToPictureDetail(photo: selectedPhoto)
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}

//Mark: - Photos List Protocol
extension PhotosListTableViewController {
    func bindDataFetchResults(photos:[FlickrPhoto]) {
        if(photos.count == 0){
            return;
        }
        
        //auto set selected
        self.delegate?.selectedPhoto(photo: photos[0])
        
        self.photos.append(contentsOf: photos)
        
        self.hideLoadingOverlay()
        
        self.tableView.reloadData()
    }
    
    func goToPictureDetail(photo: FlickrPhoto) {
        self.delegate?.selectedPhoto(photo: photo)
        if let detailViewController = self.delegate as? PhotoDetailViewController {
            splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }
    }
}
