//
//  FlickrImageSet.swift
//  NationalParkExplorer
//
//  Created by student1 on 2/22/19.
//  Copyright © 2019 clara. All rights reserved.
//

import UIKit

class FlickrPhotoSet {
    
    var photoData: [FlickrPhotoData]  // made from JSON data from server
    var images: [FlickrImage]   // Image contains a UIImage and a wrap UIImage objects for display
    
    let flickrService = FlickrService()
    
    init(photoData: [FlickrPhotoData]) {
        self.photoData = photoData
        self.images = self.photoData.map( { FlickrImage(photoData: $0) } )
    }
    
    func downloadThumbnailFor(index: Int, completion: @escaping (UIImage?, Error?) -> Void) {
        let image = images[index]
        flickrService.downloadImage(url: image.thumbnailURL!, completion: { (image: UIImage?, error: Error?) in
            self.images[index].thumbnail = image
            completion(image, error)
        })
    }
    
    var count: Int {
        return images.count
    }
    
    func photoAt(index: Int) -> FlickrPhotoData? {
        return photoData[index]
    }
}


