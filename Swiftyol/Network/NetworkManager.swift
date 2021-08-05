//
//  NetworkManager.swift
//  Swiftyol
//
//  Created by Yiğit Erdinç on 21.07.2021.
//

import Moya
import Kingfisher

enum NetworkManagerError: Error {
    case failedRequest
    case invalidData
}

struct NetworkManager {
    let fakeStoreAPIProvider = MoyaProvider<FakeStoreAPI>()
    
    typealias ProductListDataCompletion = ([ProductModel]?, NetworkManagerError?) -> ()
    typealias ProductsInCategoryDataCompletion = ([ProductModel]?, NetworkManagerError?) -> ()
    typealias ProductDetailsDataCompletion = (ProductModel?, UIImage?, NetworkManagerError?) -> ()
    typealias ProductImagesDataCompletion = ([UIImage]?, NetworkManagerError?) -> ()
    
    func fetchProducts(_ productCategory: String, completion: @escaping ProductsInCategoryDataCompletion) {
        fakeStoreAPIProvider.request(.getProducts(productCategory)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let productsData = try filteredResponse.map([ProductModel].self)
                    completion(productsData, nil)
                }
                catch let error {
                    print("Unable to decode FakeStoreAPI response: \(error.localizedDescription)")
                    completion(nil, .invalidData)
                    return
                }
            case let .failure(error):
                print("Failed request from FakeStoreAPI: \(error.localizedDescription)")
                completion(nil, .failedRequest)
                return
            }
        }
    }
    
    func fetchProductDetails(_ productId: Int, completion: @escaping ProductDetailsDataCompletion) {
        fakeStoreAPIProvider.request(.getProductDetails(productId)) { result in
            switch result {
            case .success(let moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let productsData = try filteredResponse.map(ProductModel.self)
                    let imageResource = ImageResource(downloadURL: URL(string: productsData.image)!)
                    KingfisherManager.shared.retrieveImage(with: imageResource) { imageResult in
                        switch imageResult {
                        case .success(let imageData):
                            completion(productsData, imageData.image, nil)
                        case .failure(let imageError):
                            print("Failed request from FakeStoreAPI: \(imageError.localizedDescription)")
                            completion(nil, nil, .failedRequest)
                        }
                    }
                    completion(productsData, nil, nil)
                }
                catch let error {
                    print("Unable to decode FakeStoreAPI response: \(error.localizedDescription)")
                    completion(nil, nil, .invalidData)
                    return
                }
            case .failure(let error):
                print("Failed request from FakeStoreAPI: \(error.localizedDescription)")
                completion(nil, nil, .failedRequest)
                return
            }
        }
    }
    
    func fetchProductImages(urls: [URL], completion: @escaping ProductImagesDataCompletion) {
        var temp: [UIImage] = []
        let group = DispatchGroup()
        for url in urls {
            group.enter()
            let imageResource = ImageResource(downloadURL: url)
            KingfisherManager.shared.retrieveImage(with: imageResource) { result in
                switch result {
                case .success(let data):
                    temp.append(data.image)
                    group.leave()
                case .failure(let error):
                    print("Failed request from FakeStoreAPI: \(error.localizedDescription)")
                    completion(nil, .failedRequest)
                }
            }
        }
        group.notify(queue: .main) {
            completion(temp, nil)
        }
    }
}
