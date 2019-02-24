//
//  ImageDetailViewController.swift
//  NationalParkExplorer
//
//  Created by student1 on 2/22/19.
//  Copyright © 2019 clara. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    @IBOutlet var photoDetails: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    var flickrImage: FlickrImage?
    var flickrService = FlickrService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Photo"
        
        let photoData = flickrImage!.photoData
        
        loadingIndicator.startAnimating()
        
        photoDetails.text = photoData!.title
        let url = flickrImage!.fullURL
        
        flickrService.downloadImage(url: url!) { (image: UIImage?, error: Error?) -> Void in
            
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
                
                if let error = error {
                    print(error)
                    self.present(ErrorAlertController.alert(message: "Error fetching photo"), animated: true)
                }
                else {
                    self.imageView.image = image
                }
            }
        }
    }
}

