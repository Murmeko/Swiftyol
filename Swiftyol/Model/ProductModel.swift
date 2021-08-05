//
//  ProductsModel.swift
//  Swiftyol
//
//  Created by Yiğit Erdinç on 21.07.2021.
//

import Foundation

// MARK: - ProductModel
struct ProductModel: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case price = "price"
        case description = "description"
        case category = "category"
        case image = "image"
    }
}
