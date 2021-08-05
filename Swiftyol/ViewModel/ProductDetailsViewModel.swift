//
//  ProductDetailsViewModel.swift
//  Swiftyol
//
//  Created by Yiğit Erdinç on 4.08.2021.
//

import UIKit

class ProductDetailsViewModel {
    var product: ProductModel
    var productImage: UIImage?
    var networkManager = NetworkManager()
    var reloadTableView: (()->())?
    init() {
        product = ProductModel(id: 0, title: "", price: 0.0, description: "", category: "", image: "")
    }
}

extension ProductDetailsViewModel {
    var id: Int {
        return self.product.id
    }
    var title: String {
        return self.product.title
    }
    var price: Double {
        return self.product.price
    }
    var productModelDescription: String {
        return self.product.description
    }
    var category: String {
        return self.product.category
    }
    var image: String {
        return self.product.image
    }
}
extension ProductDetailsViewModel {
    func getProductDetails(productId: Int) {
        networkManager.fetchProductDetails(productId) { moyaData, kfImage, error in
            if let safeImage = kfImage {
                self.product = moyaData!
                self.productImage = safeImage
                self.reloadTableView?()
            } else {
                print(error!.localizedDescription)
            }
        }
    }
}
