//
//  PetTableViewCell.swift
//  PetFinder
//
//  Created by Sayam Patel on 6/7/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell, MetaControllerConsumer {
    
    var metaController: MetaController?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var iconImageView: RemoteImageView!
    
    let defaultImage = UIImage(named: "bunny")
    
    //When set, fills the cell with pet data
    var pet: RealmPet? {
        didSet {
            updateInterface()
        }
    }

    /**
        Sets label (and other thing in future) for the pet cell type
    */
    func updateInterface() {
        //setting label
        nameLabel.text = pet?.name
        typeLabel.text = pet?.type
        
        //setting the image if url is valid. Sets the default bunny silohouette
        iconImageView.loadImage(urlString: pet?.smallPhoto, defaultImage: defaultImage)
        
    }
}
