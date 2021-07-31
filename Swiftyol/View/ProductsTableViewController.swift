//
//  ProductsTableViewController.swift
//  Swiftyol
//
//  Created by Yiğit Erdinç on 28.07.2021.
//

import UIKit

class ProductsTableViewController: UITableViewController {
    @IBOutlet var productsTableView: UITableView!
    
    private var productListViewModel = ProductListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViewModel()
        initTableView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func initViewModel(){
        productListViewModel.reloadTableView = {
            DispatchQueue.main.async { self.productsTableView.reloadData() }
        }
        productListViewModel.getProductList()
    }
    
    private func initTableView() {
        self.productsTableView.register(UINib(nibName: K.productsTableViewCellNibName, bundle: nil), forCellReuseIdentifier: K.productsTableViewCellIdentifier)
        self.productsTableView.register(UINib(nibName: K.productsHeaderImageCellNibName, bundle: nil), forCellReuseIdentifier: K.productsHeaderImageCellIdentifier)
        self.productsTableView.dataSource = self
        self.productsTableView.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300
        } else {
            return 250
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if productListViewModel.numberOfProducts() == 0 {
            return 0
        } else {
            return 5
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = self.productsTableView.dequeueReusableCell(withIdentifier: K.productsHeaderImageCellIdentifier, for: indexPath) as! ProductsHeaderImageCell
            cell.productsHeaderImageView.image = productListViewModel.productImages[0]
            return cell
        } else if indexPath.row == 1 {
            let cell = self.productsTableView.dequeueReusableCell(withIdentifier: K.productsTableViewCellIdentifier, for: indexPath) as! ProductsTableViewCell
            cell.productsCategoriesLabel.text = "Electronics"
            cell.productsCollectionView.tag = indexPath.row
            cell.productsCollectionView.reloadData()
            return cell
        } else if indexPath.row == 2 {
            let cell = self.productsTableView.dequeueReusableCell(withIdentifier: K.productsTableViewCellIdentifier, for: indexPath) as! ProductsTableViewCell
            cell.productsCategoriesLabel.text = "Jewelery"
            cell.productsCollectionView.tag = indexPath.row
            cell.productsCollectionView.reloadData()
            return cell
        } else if indexPath.row == 3 {
            let cell = self.productsTableView.dequeueReusableCell(withIdentifier: K.productsTableViewCellIdentifier, for: indexPath) as! ProductsTableViewCell
            cell.productsCategoriesLabel.text = "Men Clothing"
            cell.productsCollectionView.tag = indexPath.row
            cell.productsCollectionView.reloadData()
            return cell
        } else {
            let cell = self.productsTableView.dequeueReusableCell(withIdentifier: K.productsTableViewCellIdentifier, for: indexPath) as! ProductsTableViewCell
            cell.productsCategoriesLabel.text = "Women Clothing"
            cell.productsCollectionView.tag = indexPath.row
            cell.productsCollectionView.reloadData()
            return cell
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
