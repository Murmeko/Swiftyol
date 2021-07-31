//
//  ProductsViewModel.swift
//  Swiftyol
//
//  Created by Yiğit Erdinç on 24.07.2021.
//

import UIKit

class ProductListViewModel {
    var productList: [ProductModel] = []
    var electronicsProductList: [ProductModel] = []
    var jeweleryProductList: [ProductModel] = []
    var mensClothingProductList: [ProductModel] = []
    var womensClothingProductList: [ProductModel] = []
    var productImages: [UIImage] = []
    var productImageURLs: [URL] = []
    var networkManager = NetworkManager()
    var reloadTableView: (()->())?
}

extension ProductListViewModel {
    func getProductList() {
        networkManager.fetchAllProducts { data, error in
            if let safeData = data {
                self.productList = safeData
                let disGroup = DispatchGroup()
                for product in safeData {
                    disGroup.enter()
                    if product.category == "electronics" {
                        self.electronicsProductList.append(product)
                    } else if product.category == "jewelery" {
                        self.jeweleryProductList.append(product)
                    } else if product.category == "men's clothing" {
                        self.mensClothingProductList.append(product)
                    } else if product.category == "women's clothing" {
                        self.womensClothingProductList.append(product)
                    }
                    self.productImageURLs.append(URL(string: product.image)!)
                    disGroup.leave()
                }
                disGroup.notify(queue: .main) {
                    self.getProductImages()
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    func getProductImages() {
        self.networkManager.fetchProductImages(urls: productImageURLs) { data, error in
            if let safeData = data {
                self.productImages = safeData
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
