//
//  Product.swift
//  bumonsterapp
//
//  Created by Anish Somani on 06/10/2023.
//

import SwiftUI

// Product Model....
struct Product: Identifiable,Hashable {
    var id = UUID().uuidString
    var type: ProductType
    var title: String
    var subtitle: String
    var description: String = ""
    var price: String = ""
    var productImage: String = ""
    var quantity: Int = 1
    var productId: String = ""
    var sellingPrice: NSDecimalNumber = 1.00
}
// Product Types...
enum ProductType: String,CaseIterable{
    
    /*
    case Astronaut = "Astronaut"
    case Baby = "Baby"
    case Bear = "Bear"
    case Bird = "Bird"
    case Blue = "Blue"
    case Cute = "Cute"
    case Fluff = "Fluff"
    case Gears = "Gears"
    */

    case ECOMMERCE = "ECOMMERCE"
    case ENTERTAINMENT = "ENTERTAINMENT"
    case FINANCE = "FINANCE"
    case FINTECH = "FINTECH"
    case LIFESTYLE = "LIFESTYLE"
    case QSR = "QSR"
    case RETAIL = "RETAIL"
    case TRAVEL = "TRAVEL"
    
    var color: Color {
        switch self {
        case .ECOMMERCE:
            return Constants.Colors.ecommerce
        case .ENTERTAINMENT:
            return Constants.Colors.entertainment
        case .FINANCE:
            return Constants.Colors.finance
        case .FINTECH:
            return Constants.Colors.fintech
        case .LIFESTYLE:
            return Constants.Colors.lifestyle
        case .QSR:
            return Constants.Colors.qsr
        case .RETAIL:
            return Constants.Colors.retail
        case .TRAVEL:
            return Constants.Colors.travel
        }
    }
    
}

