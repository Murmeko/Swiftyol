//
//  ProductsInCategoryCollectionViewController.swift
//  Swiftyol
//
//  Created by Yiğit Erdinç on 5.08.2021.
//

import UIKit

class ProductsInCategoryCollectionViewController: UICollectionViewController {
    @IBOutlet var productsInCategoryCollectionView: UICollectionView!
    
    var productsInCategoryViewModel = ProductListViewModel.init()
    var productsCategory: productCategory?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewModel()
        configureTableView()
        productsInCategoryCollectionView.reloadData()
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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
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
}
