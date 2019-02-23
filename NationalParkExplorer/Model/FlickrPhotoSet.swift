//
//  FlickrImageSet.swift
//  NationalParkExplorer
//
//  Created by student1 on 2/22/19.
//  Copyright © 2019 clara. All rights reserved.
//

import UIKit

class FlickrPhotoSet {
    
    var photos: [FlickrPhoto]  // made from JSON data from server
    var images: [FlickrImage]   // wrap UIImage objects for display
    
    init(photos: [FlickrPhoto]) {
        self.photos = photos
        
        self.images = []
        for p in photos {
            let img = FlickrImage(photo: p)
            self.images.append(img)
        }
    }
    
    func downloadThumbnailFor(index: Int, completion: @escaping (UIImage?, Error?) -> Void) {
        
        let flickrService = FlickrService()
        let image = images[index]
        flickrService.downloadImage(url: image.thumbnailURL!, completion: { (image: UIImage?, error: Error?) in
            self.images[index].thumbnail = image
            completion(image, nil)
        })
    }
    
    var count: Int {
        return images.count
    }
    
    
    func photoAt(index: Int) -> FlickrPhoto? {
        return photos[index]
    }
    
}
