//
//  SearchTableViewController.swift
//  PetFinder
//
//  Created by Sayam Patel on 6/7/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//
import UIKit

class SearchTableViewController: UITableViewController, MetaControllerConsumer {
    
    var metaController: MetaController?
    
    //table's data source (needs to be here otherwise it will be dealloc)
    var petSearchDataSource: TableViewDataSource<RealmPet>?
    
    //token notif observer
    var authTokenObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        
        //setting height manually. storyboard has a few buildtime warnins'
        tableView.rowHeight = tableView.frame.size.width * 0.2 + 16
        
        super.viewDidLoad()
        
        //setting the data source
        petSearchDataSource = TableViewDataSource(withTableViewController: self, metaController: metaController)
        tableView.dataSource = petSearchDataSource
        
        title = "Pets"
        
        debugLog("Starting Table view. Listening for .didReceiveToken")
        
        //Notification center magic now
        //observing for auth token
        let defaultCenter = NotificationCenter.default
        authTokenObserver = defaultCenter.addObserver(forName: .didReceiveToken,
                                                      object: nil,
                                                      queue: .main) { [weak self] (_) in
                                                        self?.updateSearch()
                                                        
        }
        // calling incase auth token is already sets
        updateSearch()
    }
    /**
     This is to be done when a auth token is received from PetFinder API
     */
    func updateSearch() {
        
        debugLog("Received auth token, now calling petSearch() to set data source's results")
        petSearchDataSource?.results = mData?.petSearch()
        
    }
    
    /**
     Shows a detailed view of the pet cell selected
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = ViewControllerFactory.detailView(metaController: metaController)
        detailVC.pet = petSearchDataSource?.item(at: indexPath)
        
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
}
