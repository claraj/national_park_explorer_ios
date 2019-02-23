//
//  ImageCollectionViewController.swift
//  NationalParkExplorer
//
//  Created by student1 on 2/22/19.
//  Copyright © 2019 clara. All rights reserved.
//

import UIKit


class ImageCollectionViewController: UICollectionViewController {
    
    var park: NationalPark?
    let reuseIdentifier = "UICollectionViewCell"
    var photoSet: FlickrPhotoSet?
    
    let flickrService = FlickrService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.title = "Photos"
        
        // get pictures for park, put in collection view
        flickrService.searchPhotos(query: park!.fullName,  completion: { ( photos: [FlickrPhoto]?, error: Error?) -> Void in
    
             DispatchQueue.main.async {
           // self.activityIndicator.stopAnimating()
            }
            if error != nil {
                DispatchQueue.main.async {
                    self.present(ErrorAlertController.alert(message: "Unable to fetch photos"), animated: true)
                }
            }
            
            else if let photos = photos {
                
                if photos.count == 0 {
                    self.present(ErrorAlertController.alert(message: "No photos found, go back and try another park"), animated: true)
                }
                else {
                    print(photos)
                    self.photoSet = FlickrPhotoSet(photos: photos)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        })
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        
        // if already thumbnail, set and return
        // if no thumbnail, set placeholder, initiate request, set image once downloaded.
        
        if let photoSet = photoSet {
            
            if let thumbnail = photoSet.images[indexPath.row].thumbnail {
                cell.image.image = thumbnail
                  return cell
            }
            else {
                cell.image.image = UIImage(named: "placeholder")
                // initiate request
                requestThumbnail(for: indexPath.row)
                return cell
            }
        }
            
        else {
            // no photos at all. return place holder
            cell.image.image = UIImage(named: "placeholder")
            return cell
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let photoSet = photoSet {
            return photoSet.count
        }
        return 0
    }
    
    
    func requestThumbnail(for index: Int) {
        
        let imageObj = self.photoSet?.images[index]
    
        flickrService.downloadImage(url: imageObj!.thumbnailURL!, completion: { ( thumbnail: UIImage?, error: Error?) in
            self.photoSet?.images[index].thumbnail = thumbnail
            DispatchQueue.main.async {
                self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
            }
            })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "parkDetail" {
            
            let selectedIndex = collectionView.indexPathsForSelectedItems?.first?.row
            let selectedImage = photoSet!.images[selectedIndex!]
            let destination = segue.destination as! ImageDetailViewController
            destination.flickrImage = selectedImage
        }
    }
    
    
}
