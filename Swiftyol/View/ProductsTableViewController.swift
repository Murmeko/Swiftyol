//
//  ProductsTableViewController.swift
//  Swiftyol
//
//  Created by Yiğit Erdinç on 28.07.2021.
//

import UIKit
import ImageIO
import MobileCoreServices
import SwiftyGif

class ProductsTableViewController: UITableViewController {
    @IBOutlet var productsTableView: UITableView!
    
    private var productListViewModel = ProductListViewModel.init()
    private var selectedProductModel: ProductViewModel?
    
    private var selectedCategory: productCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewModel()
        configureTableView()
    }
    
    private func configureViewModel(){
        productListViewModel.reloadTableView = {
            DispatchQueue.main.async { self.productsTableView.reloadData() }
        }
    }
    
    private func configureTableView() {
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
        if productListViewModel.numberOfProducts(.all) >= 0 {
            return 5
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = self.productsTableView.dequeueReusableCell(withIdentifier: K.productsHeaderImageCellIdentifier, for: indexPath) as! ProductsHeaderImageCell
            let gifDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let gifFileURL = gifDirectory.appendingPathComponent("header.gif")
            let gifLoader = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
            cell.productsHeaderImageView.setGifFromURL(gifFileURL, customLoader: gifLoader)
            return cell
        } else if indexPath.row == 1 {
            let cell = self.productsTableView.dequeueReusableCell(withIdentifier: K.productsTableViewCellIdentifier, for: indexPath) as! ProductsTableViewCell
            cell.buttonDelegate = self
            cell.productCellDelegate = self
            cell.productShowAllButton.tag = indexPath.row
            cell.productsCollectionView.tag = indexPath.row
            cell.productsCategoriesLabel.text = "Electronics"
            cell.productsCollectionView.reloadData()
            return cell
        } else if indexPath.row == 2 {
            let cell = self.productsTableView.dequeueReusableCell(withIdentifier: K.productsTableViewCellIdentifier, for: indexPath) as! ProductsTableViewCell
            cell.buttonDelegate = self
            cell.productCellDelegate = self
            cell.productShowAllButton.tag = indexPath.row
            cell.productsCollectionView.tag = indexPath.row
            cell.productsCategoriesLabel.text = "Jewelery"
            cell.productsCollectionView.reloadData()
            return cell
        } else if indexPath.row == 3 {
            let cell = self.productsTableView.dequeueReusableCell(withIdentifier: K.productsTableViewCellIdentifier, for: indexPath) as! ProductsTableViewCell
            cell.buttonDelegate = self
            cell.productCellDelegate = self
            cell.productShowAllButton.tag = indexPath.row
            cell.productsCollectionView.tag = indexPath.row
            cell.productsCategoriesLabel.text = "Men Clothing"
            cell.productsCollectionView.reloadData()
            return cell
        } else {
            let cell = self.productsTableView.dequeueReusableCell(withIdentifier: K.productsTableViewCellIdentifier, for: indexPath) as! ProductsTableViewCell
            cell.buttonDelegate = self
            cell.productCellDelegate = self
            cell.productShowAllButton.tag = indexPath.row
            cell.productsCollectionView.tag = indexPath.row
            cell.productsCategoriesLabel.text = "Women Clothing"
            cell.productsCollectionView.reloadData()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            self.selectedCategory = .electronics
            performSegue(withIdentifier: K.productsToProductsInCategorySegue, sender: self)
        } else if indexPath.row == 2 {
            self.selectedCategory = .jewelery
            performSegue(withIdentifier: K.productsToProductsInCategorySegue, sender: self)
        } else if indexPath.row == 3 {
            self.selectedCategory = .mensClothing
            performSegue(withIdentifier: K.productsToProductsInCategorySegue, sender: self)
        } else if indexPath.row == 4 {
            self.selectedCategory = .womensClothing
            performSegue(withIdentifier: K.productsToProductsInCategorySegue, sender: self)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.productsToProductDetailsSegue {
            let productDetailsViewController = segue.destination as! ProductDetailsTableViewController
            productDetailsViewController.productDetailsModel = self.selectedProductModel
        } else if segue.identifier == K.productsToProductsInCategorySegue {
            let productsInCategoryViewController = segue.destination as! ProductsInCategoryCollectionViewController
            productsInCategoryViewController.productsCategory = self.selectedCategory
        }
    }
}

extension ProductsTableViewController: CollectionViewCellDelegate {
    func collectionView(collectionviewcell: UICollectionViewCell?, viewModel: ProductViewModel?, didTappedInTableViewCell: UITableViewCell) {
        self.selectedProductModel = viewModel
        performSegue(withIdentifier: K.productsToProductDetailsSegue, sender: self)
    }
}

extension ProductsTableViewController: ProductsTableViewCellDelegate {
    func didPressButton(_ tag: Int) {
        if tag == 1 {
            self.selectedCategory = .electronics
            performSegue(withIdentifier: K.productsToProductsInCategorySegue, sender: self)
        } else if tag == 2 {
            self.selectedCategory = .jewelery
            performSegue(withIdentifier: K.productsToProductsInCategorySegue, sender: self)
        } else if tag == 3 {
            self.selectedCategory = .mensClothing
            performSegue(withIdentifier: K.productsToProductsInCategorySegue, sender: self)
        } else if tag == 4 {
            self.selectedCategory = .womensClothing
            performSegue(withIdentifier: K.productsToProductsInCategorySegue, sender: self)
        }
    }
}
