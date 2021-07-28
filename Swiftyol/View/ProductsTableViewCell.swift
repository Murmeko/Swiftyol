//
//  ProductsTableViewCell.swift
//  Swiftyol
//
//  Created by Yiğit Erdinç on 21.07.2021.
//

import UIKit

class ProductsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var productsCategoriesLabel: UILabel!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productsCollectionView.dequeueReusableCell(withReuseIdentifier: K.productsCollectionViewCellIdentifier, for: indexPath) as! ProductsCollectionViewCell
        return cell
    }
}
