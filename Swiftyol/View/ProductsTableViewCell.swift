//
//  ProductsTableViewCell.swift
//  Swiftyol
//
//  Created by Yiğit Erdinç on 21.07.2021.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {
    @IBOutlet weak var productsCategoriesLabel: UILabel!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
