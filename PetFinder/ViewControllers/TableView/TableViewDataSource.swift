//
//  TableViewDataSource.swift
//  PetFinder
//
//  Created by Sayam Patel on 7/17/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import RealmSwift
import UIKit

enum CellIdEnum: String {
    case petCell = "PetTableViewCell"
}

class TableViewDataSource<ObjectType: Object>: NSObject, UITableViewDataSource, MetaControllerConsumer {

    var realmResultsNotif: NotificationToken?
    
    var cellIdentifier: CellIdEnum = .petCell
    weak var tableViewController: UITableViewController?
    
    //friendly neighborhood meta controller
    var metaController: MetaController?
    
    ///List of Pets to set from decoded json data
    var results: Results<ObjectType>? {
        didSet {
            debugLog("results in dataSource set, now observing changes to realm results data base")
            //petResults = mData?.petSearch()
            realmResultsNotif = self.results?.observe { changes in
                switch changes {
                case .initial, .update:
                    // Query results have changed, so apply them to the UITableView
                    self.verboseLog("\(type(of: self.results)) updated.")
                    self.verboseLog("Reloading data in the \(type(of: self.tableViewController))")
                    self.tableViewController?.tableView.reloadData()
                    
                case .error(let error):
                    self.errorLog("Error while observing petResults token: \(error)")
                }
            }
        }
    }
    
    init(withTableViewController tableVC: UITableViewController? = nil,
         cellIdentifier: CellIdEnum = .petCell,
         metaController: MetaController?) {
        super.init()
        self.cellIdentifier = cellIdentifier
        self.tableViewController = tableVC
        self.metaController = metaController
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch cellIdentifier {
        case .petCell:
            return 1
        }
    }
    
    ///sets the cell in the table with the appropriate data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellIdentifier {
            
        case .petCell:
            // swiftlint:disable:next force_cast line_length
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.rawValue, for: indexPath) as! SearchTableViewCell
            
            //setting pet cell data
            cell.pet = item(at: indexPath) as? RealmPet
            cell.metaController = metaController
            
            return cell
            
        //TODO: add more cases once we make different cells
        }

    }
    
    /// returns the object at the given index path in results
    func item(at indexPath: IndexPath) -> ObjectType? {
        return results?[indexPath.row]
    }
    
}
