//
//  Constants.swift
//  Swiftyol
//
//  Created by Yiğit Erdinç on 21.07.2021.
//

import Foundation

struct K {
    static let productsTableViewCellIdentifier = "ReuseableProductsTableViewCell"
    static let productsCollectionViewCellIdentifier = "ReuseableProductsCollectionViewCell"
    static let productsHeaderImageCellIdentifier = "ReuseableProductsHeaderImageCell"
    static let productDetailsTableViewCellIdentifier = "ReuseableProductDetailsTableViewCell"
    
    static let productsTableViewCellNibName = "ProductsTableViewCell"
    static let productsCollectionViewCellNibName = "ProductsCollectionViewCell"
    static let productsHeaderImageCellNibName = "ProductsHeaderImageCell"
    static let productDetailsCellNibName = "ProductDetailsCell"
    
    static let productsToProductDetailsSegue = "productsToProductDetails"
    static let productsToProductsInCategorySegue = "productsToProductsInCategory"
    static let productsInCategoryToProductDetailsSegue = "productsInCategoryToProductDetails"
}

public enum productCategory {
    case all
    case electronics
    case jewelery
    case mensClothing
    case womensClothing
}
