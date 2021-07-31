//
//  ProductsTableViewCell.swift
//  Swiftyol
//
//  Created by Yiğit Erdinç on 21.07.2021.
//

import Kingfisher

class ProductsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
   
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var productsCategoriesLabel: UILabel!
    @IBOutlet weak var productsShowAllButton: UIButton!
    
    private var productListViewModel = ProductListViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViewModel()
        initCollectionView()
    }
    
    private func initViewModel(){
        productListViewModel.reloadTableView = {
            DispatchQueue.main.async { self.productsCollectionView.reloadData() }
        }
        productListViewModel.getProductList()
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
        if productListViewModel.numberOfProducts() == 0 {
            return 0
        } else {
            if productsCollectionView.tag == 1 {
                return productListViewModel.electronicsProductList.count
            } else if productsCollectionView.tag == 2 {
                return productListViewModel.jeweleryProductList.count
            } else if productsCollectionView.tag == 3 {
                return productListViewModel.mensClothingProductList.count
            } else {
                return productListViewModel.womensClothingProductList.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productsCollectionView.dequeueReusableCell(withReuseIdentifier: K.productsCollectionViewCellIdentifier, for: indexPath) as! ProductsCollectionViewCell
        if productsCollectionView.tag == 1 {
            cell.productsTitleLabel.text = productListViewModel.electronicsProductList[indexPath.row].title
            cell.productsPriceLabel.text = "$\(productListViewModel.electronicsProductList[indexPath.row].price)"
            let resource = ImageResource(downloadURL: URL(string: productListViewModel.electronicsProductList[indexPath.row].image)!)
            cell.productsImageView.kf.setImage(with: resource)
        } else if productsCollectionView.tag == 2 {
            cell.productsTitleLabel.text = productListViewModel.jeweleryProductList[indexPath.row].title
            cell.productsPriceLabel.text = "$\(productListViewModel.jeweleryProductList[indexPath.row].price)"
            let resource = ImageResource(downloadURL: URL(string: productListViewModel.jeweleryProductList[indexPath.row].image)!)
            cell.productsImageView.kf.setImage(with: resource)
        } else if productsCollectionView.tag == 3 {
            cell.productsTitleLabel.text = productListViewModel.mensClothingProductList[indexPath.row].title
            cell.productsPriceLabel.text = "$\(productListViewModel.mensClothingProductList[indexPath.row].price)"
            let resource = ImageResource(downloadURL: URL(string: productListViewModel.mensClothingProductList[indexPath.row].image)!)
            cell.productsImageView.kf.setImage(with: resource)
        } else if productsCollectionView.tag == 4 {
            cell.productsTitleLabel.text = productListViewModel.womensClothingProductList[indexPath.row].title
            cell.productsPriceLabel.text = "$\(productListViewModel.womensClothingProductList[indexPath.row].price)"
            let resource = ImageResource(downloadURL: URL(string: productListViewModel.womensClothingProductList[indexPath.row].image)!)
            cell.productsImageView.kf.setImage(with: resource)
        }
        return cell
    }
}
