//
//  FeedTableViewController.swift
//  ECommerceApp
//
//  Created by PEARSON BASHAM on 4/3/18.
//  Copyright © 2018 darqfox. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {
    
    var products: [Product]?
    var selectedProduct: Product!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        navigationItem.title = Constants.PRODUCT_FEED_TITLE
        fetchProducts()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    func fetchProducts() {
        products = Product.fetchProducts()
        tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.PRODUCT_FEED_CELL, for: indexPath) as! ProductFeedCell
        
        if let products = products {
            let product = products[indexPath.row]
            cell.product = product
        }

        return cell
    }
    
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = self.products?[(indexPath?.row)!]
        
       selectedProduct = currentCell
        //performSegue(withIdentifier: "DetailViewSegue", sender: self)
        
        
//        DispatchQueue.global(qos: .userInitiated).async {
//            guard let selectedProduct = self.products?[indexPath.row] else {
//                return
//            }
//            let productDetailViewVC = ProductDetailTableViewController()
//            productDetailViewVC.product = selectedProduct
//            DispatchQueue.main.async {
//            self.performSegue(withIdentifier: "DetailViewSegue", sender: self)
//            }
//        } // loka.to2a // imokhles
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewSegue" {
            let viewController = segue.destination as! ProductDetailTableViewController
            viewController.product = selectedProduct
        }
    }
    
    
    
    

}
