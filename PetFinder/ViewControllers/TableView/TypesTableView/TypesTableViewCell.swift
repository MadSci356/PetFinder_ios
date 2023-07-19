//
//  TypeTableViewCell.swift
//  PetFinder
//
//  Created by Sayam Patel on 7/19/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import UIKit

class TypesTableViewCell: UITableViewCell, MetaControllerConsumer {
    
    var metaController: MetaController?
    
    var color: String? {
        didSet {
            setCellFields()
        }
    }
    
    @IBOutlet weak var petTypeLabel: UILabel!
    
    func setCellFields() {
        petTypeLabel.text = color
    }
}
