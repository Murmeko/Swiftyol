//
//  ProductsViewModel.swift
//  Swiftyol
//
//  Created by Yiğit Erdinç on 24.07.2021.
//

import ImageIO
import SwiftyolLibrary
import MobileCoreServices

class ProductListViewModel {
    var productList: [ProductModel] = []
    var productImages: [UIImage]?
    var productImageURLs: [URL] = []
    
    var electronicsList: [ProductModel] = []
    var electronicsImages: [UIImage]?
    var electronicsImageURLs: [URL] = []
    
    var jeweleryList: [ProductModel] = []
    var jeweleryImages: [UIImage]?
    var jeweleryImageURLs: [URL] = []
    
    var mensClothingList: [ProductModel] = []
    var mensClothingImages: [UIImage]?
    var mensClothingImageURLs: [URL] = []
    
    var womensClothingList: [ProductModel] = []
    var womensClothingImages: [UIImage]?
    var womensClothingImageURLs: [URL] = []
    
    var networkManager = NetworkManager()
    var imageManager = SwiftyolLibrary()
    var reloadTableView: (()->())?
    
    init() {
        getProducts(.all)
        getProducts(.electronics)
        getProducts(.jewelery)
        getProducts(.mensClothing)
        getProducts(.womensClothing)
    }
}

extension ProductListViewModel {
    func getProducts(_ productCategory: productCategory) {
        switch productCategory {
        case .all:
            networkManager.fetchProducts("") { data, error in
                if let safeData = data {
                    let allProductsGroup = DispatchGroup()
                    self.productList = safeData
                    for product in safeData {
                        allProductsGroup.enter()
                        let imageUrl = URL(string: product.image)
                        self.productImageURLs.append(imageUrl!)
                        allProductsGroup.leave()
                    }
                    allProductsGroup.notify(queue: .main) {
                        self.getProductImages(.all)
                    }
                } else {
                    print(error!.localizedDescription)
                }
            }
        case .electronics:
            networkManager.fetchProducts("/category/electronics") { data, error in
                if let safeData = data {
                    let electronicsGroup = DispatchGroup()
                    self.electronicsList = safeData
                    for product in safeData {
                        electronicsGroup.enter()
                        let imageUrl = URL(string: product.image)
                        self.electronicsImageURLs.append(imageUrl!)
                        electronicsGroup.leave()
                    }
                    electronicsGroup.notify(queue: .main) {
                        self.getProductImages(.electronics)
                    }
                } else {
                    print(error!.localizedDescription)
                }
            }
        case .jewelery:
            networkManager.fetchProducts("/category/jewelery") { data, error in
                if let safeData = data {
                    let jeweleryGroup = DispatchGroup()
                    self.jeweleryList = safeData
                    for product in safeData {
                        jeweleryGroup.enter()
                        let imageUrl = URL(string: product.image)
                        self.jeweleryImageURLs.append(imageUrl!)
                        jeweleryGroup.leave()
                    }
                    jeweleryGroup.notify(queue: .main) {
                        self.getProductImages(.jewelery)
                    }
                } else {
                    print(error!.localizedDescription)
                }
            }
        case .mensClothing:
            networkManager.fetchProducts("/category/men's clothing") { data, error in
                if let safeData = data {
                    let mensClothingGroup = DispatchGroup()
                    self.mensClothingList = safeData
                    for product in safeData {
                        mensClothingGroup.enter()
                        let imageUrl = URL(string: product.image)
                        self.mensClothingImageURLs.append(imageUrl!)
                        mensClothingGroup.leave()
                    }
                    mensClothingGroup.notify(queue: .main) {
                        self.getProductImages(.mensClothing)
                    }
                } else {
                    print(error!.localizedDescription)
                }
            }
        case .womensClothing:
            networkManager.fetchProducts("/category/women's clothing") { data, error in
                if let safeData = data {
                    let womensClothingGroup = DispatchGroup()
                    self.womensClothingList = safeData
                    for product in safeData {
                        womensClothingGroup.enter()
                        let imageUrl = URL(string: product.image)
                        self.womensClothingImageURLs.append(imageUrl!)
                        womensClothingGroup.leave()
                    }
                    womensClothingGroup.notify(queue: .main) {
                        self.getProductImages(.womensClothing)
                    }
                } else {
                    print(error!.localizedDescription)
                }
            }
        }
    }
    
    func getProductImages(_ productCategory: productCategory) {
        switch productCategory {
        case .all:
            self.networkManager.fetchProductImages(urls: productImageURLs) { data, error in
                if let safeData = data {
                    self.productImages = safeData
                    let gifDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    let gifFileURL = gifDirectory.appendingPathComponent("header.gif")
                    self.imageManager.generateGifFromImages(images: self.productImages!, fileURL: gifFileURL, colorSpace: .gray, delayTime: 1.5)
                    self.reloadTableView?()
                } else {
                    print(error!.localizedDescription)
                }
            }
        case .electronics:
            self.networkManager.fetchProductImages(urls: electronicsImageURLs) { data, error in
                if let safeData = data {
                    self.electronicsImages = self.imageManager.convertImagesToGrayscale(images: safeData)
                    self.reloadTableView?()
                } else {
                    print(error!.localizedDescription)
                }
            }
        case .jewelery:
            self.networkManager.fetchProductImages(urls: jeweleryImageURLs) { data, error in
                if let safeData = data {
                    self.jeweleryImages = self.imageManager.convertImagesToGrayscale(images: safeData)
                    self.reloadTableView?()
                } else {
                    print(error!.localizedDescription)
                }
            }
        case .mensClothing:
            self.networkManager.fetchProductImages(urls: mensClothingImageURLs) { data, error in
                if let safeData = data {
                    self.mensClothingImages = self.imageManager.convertImagesToGrayscale(images: safeData)!
                    self.reloadTableView?()
                } else {
                    print(error!.localizedDescription)
                }
            }
        case .womensClothing:
            self.networkManager.fetchProductImages(urls: womensClothingImageURLs) { data, error in
                if let safeData = data {
                    self.womensClothingImages = self.imageManager.convertImagesToGrayscale(images: safeData)!
                    self.reloadTableView?()
                } else {
                    print(error!.localizedDescription)
                }
            }
        }
    }
    
    func numberOfProducts(_ productCategory: productCategory) -> Int {
        switch productCategory {
        case .all:
            return self.productList.count
        case .electronics:
            return self.electronicsList.count
        case .jewelery:
            return self.jeweleryList.count
        case .mensClothing:
            return self.mensClothingList.count
        case .womensClothing:
            return self.womensClothingList.count
        }
    }
         
    func getProductViewModel(_ productCategory: productCategory, _ indexPath: IndexPath) -> ProductViewModel {
        switch productCategory {
        case .all:
            let product = self.productList[indexPath.row]
            return ProductViewModel(product: product, productsGifIsPresent: true)
        case .electronics:
            let product = self.electronicsList[indexPath.row]
            return ProductViewModel(product: product, productImage: electronicsImages?[indexPath.row])
        case .jewelery:
            let product = self.jeweleryList[indexPath.row]
            return ProductViewModel(product: product, productImage: jeweleryImages?[indexPath.row])
        case .mensClothing:
            let product = self.mensClothingList[indexPath.row]
            return ProductViewModel(product: product, productImage: mensClothingImages?[indexPath.row])
        case .womensClothing:
            let product = self.womensClothingList[indexPath.row]
            return ProductViewModel(product: product, productImage: womensClothingImages?[indexPath.row])
        }
    }
}

struct ProductViewModel {
    var product: ProductModel
    var productImage: UIImage?
    var productsGifIsPresent: Bool?
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
    var description: String {
        return self.product.description
    }
    var category: String {
        return self.product.category
    }
    var image: String {
        return self.product.image
    }
}
