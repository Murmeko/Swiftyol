//
//  ProductsTableViewCell.swift
//  Swiftyol
//
//  Created by Yiğit Erdinç on 21.07.2021.
//

import Kingfisher
import SwiftyolLibrary

protocol CollectionViewCellDelegate: AnyObject {
    func collectionView(collectionviewcell: UICollectionViewCell?, viewModel: ProductViewModel?, didTappedInTableViewCell: UITableViewCell)
    // other delegate methods that you can define to perform action in viewcontroller
}

protocol ProductsTableViewCellDelegate {
    func didPressButton(_ tag: Int)
}

class ProductsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
   
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var productsCategoriesLabel: UILabel!
    @IBOutlet weak var productShowAllButton: UIButton!
    
    var buttonDelegate: ProductsTableViewCellDelegate?
    
    @IBAction func productShowAllButtonPressed(_ sender: UIButton) {
        buttonDelegate?.didPressButton(sender.tag)
    }
    
    private var productListViewModel = ProductListViewModel.init()
    weak var productCellDelegate: CollectionViewCellDelegate?
    private var imageManager = SwiftyolLibrary.init()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViewModel()
        initCollectionView()
    }
    
    private func initViewModel(){
        productListViewModel.reloadTableView = {
            DispatchQueue.main.async { self.productsCollectionView.reloadData() }
        }
    }
    
    private func initCollectionView() {
        self.productsCollectionView.register(UINib(nibName: K.productsCollectionViewCellNibName, bundle: nil), forCellWithReuseIdentifier: K.productsCollectionViewCellIdentifier)
        if let layout = productsCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
                layout.minimumLineSpacing = 10
                layout.minimumInteritemSpacing = 10
                layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                let size = CGSize(width:(productsCollectionView!.bounds.width-30)/2, height: 200)
                layout.itemSize = size
        }
        self.productsCollectionView.dataSource = self
        self.productsCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if productsCollectionView.tag == 1 {
                return productListViewModel.numberOfProducts(.electronics)
            } else if productsCollectionView.tag == 2 {
                return productListViewModel.numberOfProducts(.jewelery)
            } else if productsCollectionView.tag == 3 {
                return productListViewModel.numberOfProducts(.mensClothing)
            } else {
                return productListViewModel.numberOfProducts(.womensClothing)
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productsCollectionView.dequeueReusableCell(withReuseIdentifier: K.productsCollectionViewCellIdentifier, for: indexPath) as! ProductsCollectionViewCell
        if productsCollectionView.tag == 1 {
            let productViewModel = self.productListViewModel.getProductViewModel(.electronics, indexPath)
            cell.productViewModel = productViewModel
            cell.productsTitleLabel.text = productViewModel.title
            cell.productsPriceLabel.text = "$\(productViewModel.price)"
            cell.productsImageView.image = productViewModel.productImage
        } else if productsCollectionView.tag == 2 {
            let productViewModel = self.productListViewModel.getProductViewModel(.jewelery, indexPath)
            cell.productViewModel = productViewModel
            cell.productsTitleLabel.text = productViewModel.title
            cell.productsPriceLabel.text = "$\(productViewModel.price)"
            cell.productsImageView.image = productViewModel.productImage

        } else if productsCollectionView.tag == 3 {
            let productViewModel = self.productListViewModel.getProductViewModel(.mensClothing, indexPath)
            cell.productViewModel = productViewModel
            cell.productsTitleLabel.text = productViewModel.title
            cell.productsPriceLabel.text = "$\(productViewModel.price)"
            cell.productsImageView.image = productViewModel.productImage
        } else if productsCollectionView.tag == 4 {
            let productViewModel = self.productListViewModel.getProductViewModel(.womensClothing, indexPath)
            cell.productViewModel = productViewModel
            cell.productsTitleLabel.text = productViewModel.title
            cell.productsPriceLabel.text = "$\(productViewModel.price)"
            cell.productsImageView.image = productViewModel.productImage
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = productsCollectionView.cellForItem(at: indexPath) as? ProductsCollectionViewCell
        self.productCellDelegate?.collectionView(collectionviewcell: cell, viewModel: cell?.productViewModel, didTappedInTableViewCell: self)
    }
}
