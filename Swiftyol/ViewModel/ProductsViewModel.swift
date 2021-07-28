//
//  ProductsViewModel.swift
//  Swiftyol
//
//  Created by Yiğit Erdinç on 24.07.2021.
//

import Foundation

class ProductListViewModel {
    var productList: [ProductModel] = []
    var networkManager = NetworkManager()
    var reloadTableView: (()->())?
}

extension ProductListViewModel {
    func getProductList() {
        networkManager.fetchAllProducts { data, error in
            if let safeData = data {
                self.productList = safeData
                self.reloadTableView?()
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    func numberOfProducts() -> Int {
        return self.productList.count
    }
         
    func productAtIndex(_ index: Int) -> ProductViewModel {
        let product = self.productList[index]
        return ProductViewModel(product: product)
    }
}

struct ProductViewModel {
    var product: ProductModel
}

extension ProductViewModel {
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
