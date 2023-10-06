//
//  HomeViewModel.swift
//  bumonsterapp
//
//  Created by Anish Somani on 06/10/2023.
//

import SwiftUI

// Using Combine to monitor search field and if user leaves for .5 secs then starts searching...
// to avoid memory issue...
import Combine

class HomeViewModel: ObservableObject {

    @Published var productType: ProductType = .ECOMMERCE
    
    // Sample Products...
    @Published var products: [Product] = [
    
        Product(type: .ECOMMERCE, title: "Little Critter", subtitle: "ECOMMERCE", price: "$5", productImage: "ECOMMERCE-1", productId: "1", sellingPrice: 5.00),
        Product(type: .ENTERTAINMENT, title: "Snugglebug", subtitle: "ENTERTAINMENT", price: "$5", productImage: "ENTERTAINMENT-1", productId: "2", sellingPrice: 5.00),
        Product(type: .FINANCE, title: "Cuddlekins", subtitle: "FINANCE", price: "$5", productImage: "FINANCE-1", productId: "3", sellingPrice: 5.00),
        Product(type: .FINTECH, title: "Cosmic Critter", subtitle: "FINTECH", price: "$5", productImage: "FINTECH-1", productId: "4", sellingPrice: 5.00),
        Product(type: .LIFESTYLE, title: "Galaxy Gobbler", subtitle: "LIFESTYLE", price: "$5", productImage: "LIFESTYLE-1", productId: "5", sellingPrice: 5.00),
        Product(type: .QSR, title: "Pipsqueak", subtitle: "QSR", price: "$5", productImage: "QSR-1", productId: "6", sellingPrice: 5.00),
        Product(type: .RETAIL, title: "Starbeast", subtitle: "RETAIL", price: "$5", productImage: "RETAIL-1", productId: "7", sellingPrice: 5.00),
        Product(type: .TRAVEL, title: "Astrocreep", subtitle: "TRAVEL", price: "$5", productImage: "TRAVEL-1", productId: "8", sellingPrice: 5.00),
    ]
    
    // Filtered Products...
    @Published var filteredProducts: [Product] = []
    
    // More products on the type..
    @Published var showMoreProductsOnType: Bool = false
    
    // Search Data...
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchedProducts: [Product]?
    
    var searchCancellable: AnyCancellable?
    
    init(){
        filterProductByType()
        
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != ""{
                    self.filterProductBySearch()
                }
                else{
                    self.searchedProducts = nil
                }
            })
    }
    
    func filterProductByType(){
        
        // Filtering Product By Product Type...
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.products
            // Since it will require more memory so were using lazy to perform more...
                .lazy
                .filter { product in
                    
                    return product.type == self.productType
                }
            // Limiting result...
                .prefix(4)
            
            DispatchQueue.main.async {
                
                self.filteredProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
    
    func filterProductBySearch(){
        
        // Filtering Product By Product Type...
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.products
            // Since it will require more memory so were using lazy to perform more...
                .lazy
                .filter { product in
                    
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
            
            DispatchQueue.main.async {
                
                self.searchedProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
}
