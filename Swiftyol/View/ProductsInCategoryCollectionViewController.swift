//
//  ProductsInCategoryCollectionViewController.swift
//  Swiftyol
//
//  Created by Yiğit Erdinç on 5.08.2021.
//

import UIKit

class ProductsInCategoryCollectionViewController: UICollectionViewController {
    @IBOutlet var productsInCategoryCollectionView: UICollectionView!
    
    private var productsInCategoryViewModel = ProductListViewModel.init()
    
    private var selectedProductModel: ProductViewModel?
    var productsCategory: productCategory?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureViewModel()
        configureTableView()
    }
    
    private func configureNavigationBar() {
        if productsCategory == .electronics {
            self.title = "🖥️ Electronics"
        } else if productsCategory == .jewelery {
            self.title = "💎 Jewelery"
        } else if productsCategory == .mensClothing {
            self.title = "👔 Men's Clothing"
        } else if productsCategory == .womensClothing {
            self.title = "👚 Women's Clothing"
        }
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureViewModel(){
        productsInCategoryViewModel.reloadTableView = {
            DispatchQueue.main.async { self.productsInCategoryCollectionView.reloadData() }
        }
    }
    
    private func configureTableView() {
        self.productsInCategoryCollectionView.register(UINib(nibName: K.productsCollectionViewCellNibName, bundle: nil), forCellWithReuseIdentifier: K.productsCollectionViewCellIdentifier)
        if let layout = productsInCategoryCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
                layout.minimumLineSpacing = 10
                layout.minimumInteritemSpacing = 10
                layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
                let size = CGSize(width:(productsInCategoryCollectionView!.bounds.width-30)/2, height: 200)
                layout.itemSize = size
        }
        self.productsInCategoryCollectionView.dataSource = self
        self.productsInCategoryCollectionView.delegate = self
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productDetailsViewController = segue.destination as! ProductDetailsTableViewController
        productDetailsViewController.productDetailsModel = self.selectedProductModel
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsInCategoryViewModel.numberOfProducts(productsCategory!)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productsInCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: K.productsCollectionViewCellIdentifier, for: indexPath) as! ProductsCollectionViewCell
        let productInCategoryViewModel = self.productsInCategoryViewModel.getProductViewModel(productsCategory!, indexPath)
        cell.productViewModel = productInCategoryViewModel
        cell.productsTitleLabel.text = productInCategoryViewModel.title
        cell.productsPriceLabel.text = "$\(productInCategoryViewModel.price)"
        cell.productsImageView.image = productInCategoryViewModel.productImage
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedProductModel = self.productsInCategoryViewModel.getProductViewModel(productsCategory!, indexPath)
        performSegue(withIdentifier: K.productsInCategoryToProductDetailsSegue, sender: collectionView)
    }
}
