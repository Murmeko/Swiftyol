//
//  ProductDetailsTableViewController.swift
//  Swiftyol
//
//  Created by Yiğit Erdinç on 4.08.2021.
//

import UIKit
import Kingfisher

class ProductDetailsTableViewController: UITableViewController {
    @IBOutlet var productDetailsTableView: UITableView!

    var productDetailsModel: ProductViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    func configureTableView() {
        self.productDetailsTableView.register(UINib(nibName: K.productDetailsCellNibName, bundle: nil), forCellReuseIdentifier: K.productDetailsTableViewCellIdentifier)
        self.productDetailsTableView.dataSource = self
        self.productDetailsTableView.delegate = self
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.productDetailsTableViewCellIdentifier, for: indexPath) as! ProductDetailsCell
        let imageResource = ImageResource(downloadURL: URL(string: productDetailsModel!.image)!)
        cell.productDetailsImageView.kf.setImage(with: imageResource)
        cell.productDetailsTitleLabel.text = productDetailsModel?.title
        cell.productDetailsPriceLabel.text = "$\(productDetailsModel!.price)"
        cell.productDetailsDescriptionLabel.text = productDetailsModel?.description
        return cell
    }
}
