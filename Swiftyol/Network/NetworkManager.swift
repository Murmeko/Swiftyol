//
//  NetworkManager.swift
//  Swiftyol
//
//  Created by Yiğit Erdinç on 21.07.2021.
//

import Moya

enum NetworkManagerError: Error {
    case failedRequest
    case invalidData
}

struct NetworkManager {
    let fakeStoreAPIProvider = MoyaProvider<FakeStoreAPI>()
    
    typealias ProductsDataCompletion = (ProductsModel?, NetworkManagerError?) -> ()
    typealias ProductDetailsDataCompletion = (ProductsModel?, NetworkManagerError?) -> ()
    
    func fetchAllProducts(completion: @escaping ProductsDataCompletion) {
        fakeStoreAPIProvider.request(.getAllProducts) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let allProductsData = try filteredResponse.map(ProductsModel.self)
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
}
