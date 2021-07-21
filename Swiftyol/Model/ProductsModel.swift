//
//  ProductsModel.swift
//  Swiftyol
//
//  Created by Yiğit Erdinç on 21.07.2021.
//

//   let productModel = try? newJSONDecoder().decode(ProductModel.self, from: jsonData)

import Foundation

// MARK: - ProductsModelElement
struct ProductsModelElement: Codable {
    let id: Int
    let title: String
    let price: Double
    let productsModelDescription: String
    let category: Category
    let image: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case price = "price"
        case productsModelDescription = "description"
        case category = "category"
        case image = "image"
    }
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

typealias ProductsModel = [ProductsModelElement]
