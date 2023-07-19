//
//  ViewControllerFactory.swift
//  PetFinder
//
//  Created by Sayam Patel on 6/20/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import Foundation
import UIKit

private func vcFactory<T: UIViewController>(_ storyboardName: String,
                                            metaController: MetaController?) -> T {
    // NB: We're assuming the storyboard is set up correctly, so running without the safeties.
    //     If storyboards doen't work as advertised, the ! will cause a crash.
    let sBoard = UIStoryboard(name: storyboardName, bundle: nil)
    let viewController = sBoard.instantiateInitialViewController()
    metaController?.passController(viewController)
    // swiftlint:disable:next force_cast
    return viewController as! T
}

enum ViewControllerFactory {
    
    /// Shows pet of a given type and from a given location
    static func searchTableView(metaController: MetaController?) -> SearchTableViewController {
        return vcFactory("SearchTableView", metaController: metaController)
    }
    
    /// shows detail on a specific pet (phone, website, etc)
    static func detailView(metaController: MetaController?) -> DetailViewController {
        return vcFactory("DetailView", metaController: metaController)
    }
    static func masterTabView(metaController: MetaController?) -> MasterTabViewController {
        return vcFactory("Master", metaController: metaController)
    }
    /// Displays types of pets
    static func typesTableView(metaController: MetaController?) -> TypesTableViewController {
        return vcFactory("TypesTableView", metaController: metaController)
    }
}
