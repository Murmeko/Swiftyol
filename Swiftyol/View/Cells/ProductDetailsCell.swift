//
//  ProductDetailsCell.swift
//  Swiftyol
//
//  Created by Yiğit Erdinç on 5.08.2021.
//

import UIKit

class ProductDetailsCell: UITableViewCell {
    @IBOutlet weak var productDetailsImageView: UIImageView!
    @IBOutlet weak var productDetailsTitleLabel: UILabel!
    @IBOutlet weak var productDetailsPriceLabel: UILabel!
    @IBOutlet weak var productDetailsDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
