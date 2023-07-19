//
//  UIRemoteImageView.swift
//  PetFinder
//
//  Created by Sayam Patel on 6/18/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import Foundation
import UIKit

/**
    Subclass of UIImageView.
 
    #### Functionality provided by the class
    - Loads an image on a background thread (from a url, using urlsessions)
    - While downloading in the imageview, loads a default image
 
 */
class RemoteImageView: UIImageView {
    
    /// some required stuff
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
        Loads from the specified url in the background. Sets the default image first if given,
        then starts the data task.
     */
    func loadImage(urlString: String?, defaultImage: UIImage?) {
        
        ///default image is a placeholder
        image = defaultImage
        
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }
        
        //url session task
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            
            //checking for error and data (networking)
            guard error == nil, let data = data else {
                print("Fetch Data Networking error. \(String(describing: error))")
                return
            }
            
            //checking http response
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                print("Fetch Data Server error.")
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            
        }
        task.resume()
        
    }
}
