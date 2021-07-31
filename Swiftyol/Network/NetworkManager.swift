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
    typealias ProductDetailsDataCompletion = (ProductModel?, NetworkManagerError?) -> ()
    typealias ProductImagesDataCompletion = ([UIImage]?, NetworkManagerError?) -> ()
    
    func fetchAllProducts(completion: @escaping ProductListDataCompletion) {
        fakeStoreAPIProvider.request(.getAllProducts) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let allProductsData = try filteredResponse.map([ProductModel].self)
                    completion(allProductsData, nil)
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
    
    func fetchProductImages(urls: [URL], completion: @escaping ProductImagesDataCompletion) {
        var temp: [UIImage] = []
        let group = DispatchGroup()
        for url in urls {
            group.enter()
            let resource = ImageResource(downloadURL: url)
            KingfisherManager.shared.retrieveImage(with: resource) { result in
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
