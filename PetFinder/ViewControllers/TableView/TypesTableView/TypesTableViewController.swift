//
//  TypesTableViewController.swift
//  PetFinder
//
//  Created by Sayam Patel on 7/18/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import UIKit

class TypesTableViewController: UITableViewController, MetaControllerConsumer {
    var metaController: MetaController?
    
    //list of animal types
    var petTypes: [AnimalType]?
    
    let cellIdentifier = "PetTypesCell"
    
    //notification listener for auth token
    var tokenObserver: NSObjectProtocol?
    
    @IBOutlet var typesBarItem: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Pet Colors by Type"

        //observing for auth token
        let defaultCenter = NotificationCenter.default
        tokenObserver = defaultCenter.addObserver(forName: .didReceiveToken,
                                                  object: nil,
                                                  queue: .main) { (_) in
                                                    self.updateTypes()
                                                    
        }
        
        // in case auth token was received before the notif token began listening for it
        updateTypes()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if self.petTypes?.isEmpty == true {
            updateTypes()
        }
    }
    
    /**
     This is to be done when a auth token is received from PetFinder API
     */
    func updateTypes() {
        
        //get a list of types and pet colors from types endpoint resource
        let typesResource = PetFinderTypes.resource
        mApi?.load(resource: typesResource) { result in
            
            // reload the cells with the given data and sections
            switch result {
            case .success(let types):
                self.petTypes = types
                self.tableView.reloadData()
            case .failure(let error):
                self.errorLog("Error while getting Pet Types. \(error)")
            }
        }
        
    }

    // MARK: - Table view data source

    /// Number of rows. Depends on # of pet types PetFinder API has
    override func numberOfSections(in tableView: UITableView) -> Int {
        return petTypes?.count ?? 0
    }

    /// Number of rows in each section depends on # of colors each pet type has
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petTypes?[section].colors?.count ?? 0
    }
    
    /// Title for each section (type of animal. ex: Dog, Cat..)
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return petTypes?[section].name
    }
    
    /// Section title font
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .black
            headerView.textLabel?.textColor = .white
            headerView.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        }
    }

    /// Configuring the cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TypesTableViewCell
        cell.metaController = metaController
        cell.color = petTypes?[indexPath.section].colors?[indexPath.row]

        return cell
    }

}
