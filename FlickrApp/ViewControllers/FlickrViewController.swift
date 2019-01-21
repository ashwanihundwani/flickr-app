//
//  FlickrViewController.swift
//  FlickrApp
//
//  Created by Ashwani on 19/01/19.
//  Copyright © 2019 Ashwani. All rights reserved.
//

import UIKit

/**
 FlickrViewController is the main screen for this application. It allows user to search the photos
 on Flickr, by default this screen displays the recent photos using the Flickr api.
 */
class FlickrViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var photosViewModel:PhotosViewModel?
    var searchRequestTimer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchRecentPhotos(page: 0)
    }
    
    //MARK: Private Methods
    /**
     This method updates the view model and refreshes the UI with the newly received data from the Flickr api.
     - Parameters:
        - photos: An array of photos received from the server
        - error:  Error received while using the Flickr api
     */
    private func prepareDataAndUpdateUI(photos: Photos?, error: Error?) {
        photosViewModel?.isFetching = false
        if let photos = photos {
            if let _ = photosViewModel {
                photosViewModel?.update(with: PhotosViewModel(photos: photos))
            }
            else {
                photosViewModel = PhotosViewModel(photos: photos)
            }
            DispatchQueue.main.async {[unowned self] in
                self.collectionView.reloadData()
            }
            
        } else {
            DispatchQueue.main.async {[unowned self] in
                let alert = UIAlertController(title: "FlickrApp", message: "Error in loading data", preferredStyle: .alert)
                let action = UIAlertAction(title: "Try Again", style: .default) {[unowned self] (action: UIAlertAction) in
                    
                    //By default - fetching the recent photos, could be improved for the specific cases.
                    self.fetchRecentPhotos(page: 0)
                }
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
            
            
        }
    }
    
    /**
     This method fetches the recent photos from the Flickr api.
     - Parameters:
        - page: The page number used in the Flickr api.
     */
    private func fetchRecentPhotos(page:Int) {
        Service.shared.fetchRecentPhotos(page: page, result: {[unowned self] (photos: Photos?, error: Error?) in
            self.prepareDataAndUpdateUI(photos: photos, error: error)
        })
    }
    
    /**
     This method fetches the photos from the Flickr api based on user search text.
     - Parameters:
        - text: The input text entered by the user in the search box.
        - page: The page number used in the Flickr api.
     */
    private func fetchPhotos(text:String, page:Int) {
        Service.shared.fetchPhotos(searchText: text, page: page) {[unowned self] (photos: Photos?, error: Error?) in
            self.prepareDataAndUpdateUI(photos: photos, error: error)
        }
    }
}

/*
 FlickrViewController extension for CollectionView delegate & datasource methods
 */
extension FlickrViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: Collection View Delegate & Datasource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let _ = photosViewModel {
            return (photosViewModel?.viewModels?.count)!;
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width / 3.0 - 15.0, height: CGFloat(view.frame.size.width / 3.0 + 20))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:PhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        if let _ = photosViewModel {
            // Nullify the image object as cell is reused and old image should not apply.
            cell.photoImageView.image = nil
            cell.photoViewModel = (photosViewModel?.viewModels?[indexPath.row])!
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (photosViewModel?.viewModels?.count)! - 1 {
            if (photosViewModel?.shouldLoadMore())! {
                photosViewModel?.isFetching = true
                if photosViewModel?.fetchType == .recent  {
                    fetchRecentPhotos(page: (photosViewModel?.nextPage)!)
                }
                else {
                    fetchPhotos(text: (photosViewModel?.searchText)!, page: (photosViewModel?.nextPage)!)
                }
                
            }
        }
    }
    
}

/**
 FlickrViewController extension for search bar related tasks.
 */
extension FlickrViewController: UISearchBarDelegate {
    
    //MARK: Private Methods
    /**
     This is a helper method which fetches the photos for the first page of the Flickr api based on user search text.
     */
    @objc private func fetchPhotosForSearchedText() {
        fetchPhotos(text: (photosViewModel?.searchText)!, page: 0)
    }
    
    //MARK: SearchBar Delegate methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let _ = photosViewModel {
            photosViewModel?.searchText = searchText
            
            if let timer = searchRequestTimer {
                timer.invalidate()
            }
            if(searchText == "") {
                fetchRecentPhotos(page: 0)
            } else {
                searchRequestTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: (#selector(FlickrViewController.fetchPhotosForSearchedText)), userInfo: nil, repeats: false)
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

