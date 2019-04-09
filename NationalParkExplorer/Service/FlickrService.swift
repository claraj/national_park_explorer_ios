//
//  FlickrService.swift
//  NationalParkExplorer
//
//  Created by student1 on 2/22/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation
import UIKit


enum FlickrServiceError: Error {
    case RequestFailed
    case CouldNotParseResponse
    case ImageDownloadFailed
}

class FlickrService {
    
    // flickr's dev key, replace with real version
    //let apiKey = "c213e2d6cc8ee75c8ff471cbf955ac40"
    let apiKey = "a6d819499131071f158fd740860a5a88"
    
    func searchPhotos(query: String, completion: @escaping ([FlickrPhotoData]?, Error?) -> Void ) {
        
        // example
        // https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=6ca54d834c43949de7b3c9c742e4430e&tags=arches+national+park&format=json&nojsoncallback=1
        
        let url = buildSearchURL(query: query)
        
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            
            if let results = data {
                let decoder = JSONDecoder()
                do {
                 let results = try decoder.decode(FlickrResponse.self, from: results)
                    completion(results.photos.photo, nil)
                } catch {
                    print(error)  // this is a local constant containing the parsing error
                    completion(nil, FlickrServiceError.CouldNotParseResponse)
                }
            }
                
            else {
                print(error)  // response error - for debugging
                completion(nil, FlickrServiceError.RequestFailed)
            }
            
        }
        task.resume()
    }
    
    func buildSearchURL(query: String) -> URL? {
        let components: URLComponents = {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.flickr.com"
            components.path = "/services/rest"
            components.queryItems = [
                URLQueryItem(name: "method", value: "flickr.photos.search"),
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "tags", value: query),
                URLQueryItem(name: "sort", value: "relevance"),
                URLQueryItem(name: "per_page", value: "40"),
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "nojsoncallback", value: "1"),
            ]
            return components
        }()
        
        let url = components.url
        return url
    }
    
    
    func downloadImage(url: String, completion:  @escaping (UIImage?, Error?) -> Void ) {
        
        let url = URL(string: url)
        print(url)
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            
            if let data = data {
                let image = UIImage(data: data)
                completion(image, nil )
            } else {
                print(error)
                completion(nil, FlickrServiceError.ImageDownloadFailed)
            }
        }
        
        task.resume()
    }
}
