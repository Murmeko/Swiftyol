//
//  FakeStoreAPI.swift
//  Swiftyol
//
//  Created by Yiğit Erdinç on 21.07.2021.
//

import Moya

public enum FakeStoreAPI {
    case getAllProducts
    case getProductDetails(_id: Int)
}

extension FakeStoreAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://fakestoreapi.com")!
    }
    
    public var path: String {
        switch self {
        case .getAllProducts:
            return "/products"
        case .getProductDetails(let productId):
            return "/products/\(productId)"
        }
    }
    
    public var method: Method {
        return .get
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getAllProducts:
            return .requestPlain
        case .getProductDetails(_):
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
