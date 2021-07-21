//
//  ProductsCollectionViewCell.swift
//  Swiftyol
//
//  Created by Yiğit Erdinç on 21.07.2021.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productsImageView: UIImageView!
    @IBOutlet weak var productsPriceLabel: UILabel!
    @IBOutlet weak var productsTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
