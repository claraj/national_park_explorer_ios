//
//  FlickrImage.swift
//  NationalParkExplorer
//
//  Created by student1 on 2/22/19.
//  Copyright © 2019 clara. All rights reserved.
//

import UIKit


class FlickrImage {
    
    var photo: FlickrPhoto?
    var thumbnail: UIImage?
    var full: UIImage?
    
    init(photo: FlickrPhoto) {
        self.photo = photo
    }
    
    var thumbnailURL: String? {
        
        guard let photo = photo else { return nil }
        
        return "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_q.jpg"
        }
    
    
    var fullURL: String? {
        
        guard let photo = photo else { return nil }
        
          return "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_h.jpg"
    }

    
    func downloadPhotoFor(index: Int, completion:  (FlickrImage?, Error?) -> Void ) {
        
    }
    
    func downloadThumbnailFor(index: Int, completion:  (FlickrImage?, Error?) -> Void ) {
//        
//        if images![index] != nil {
//            completion(images![index], nil)
//        } else {
//            
//            
//        }
//        
    }

    
}
