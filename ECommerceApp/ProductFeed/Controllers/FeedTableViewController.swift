//
//  FeedTableViewController.swift
//  ECommerceApp
//
//  Created by PEARSON BASHAM on 4/3/18.
//  Copyright © 2018 darqfox. All rights reserved.
//

import UIKit
import Firebase

class FeedTableViewController: UITableViewController {
    
    var products: [Product]?
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // one time sign-in -> if the user logs in already or not
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                // we do have the user, the user did log in
                // TODO: - fetch posts, update productfeed
            } else {
                // the user has not logged in or is already logged out
                self.performSegue(withIdentifier: Constants.UserAuthentication.Segues.SHOW_WELCOME_SCREEN, sender: nil)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        navigationItem.title = Constants.ProductFeed.TITLE
        fetchProducts()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    @IBAction func logoutDitTouch(_ sender: Any) {
        try! Auth.auth().signOut()
        
        self.performSegue(withIdentifier: Constants.UserAuthentication.Segues.SHOW_WELCOME_SCREEN, sender: nil)
    }
    
    // MARK: - Fetching from Firbase
    
    func fetchProducts() {
        Product.fetchProductsFromFirebase { (products) in
            self.products = products
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let products = products {
            return products.count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ProductFeed.Cells.PRODUCT_FEED_CELL, for: indexPath) as! ProductFeedCell
        
        if let products = products {
            let product = products[indexPath.row]
            cell.product = product
        }

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let products = self.products else { return }


        // 2.
        if segue.identifier == Constants.ProductFeed.Segues.DETAIL_VIEW_SEGUE {
            let viewController = segue.destination as! ProductDetailTableViewController

            if  let indexPath = tableView.indexPathForSelectedRow {
                viewController.product = products[indexPath.row]
            }
        }
    }
}
