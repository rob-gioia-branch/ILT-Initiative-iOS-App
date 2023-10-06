//
//  ProductListing.swift
//  bumonsterapp
//
//  Created by Anish Somani on 06/10/2023.
//

import SwiftUI

class ProductListingViewModel: ObservableObject {
    @Published var allProducts = HomeViewModel().products
    @Published var filteredProducts: [Product] = []
    @Published var products: [Product] = []
    @Published var searchText = ""

    init() {
        products = allProducts
    }
    func performSearch(text: String) {
        filteredProducts = allProducts.filter {
            $0.title.localizedCaseInsensitiveContains(text)
        }

        products = text.isEmpty ? allProducts : filteredProducts
    }
}
struct ProductListing: View {
    @StateObject var viewModel = ProductListingViewModel()
    @EnvironmentObject var sharedData: SharedDataModel
    
    var body: some View {
        VStack {
            SearchField(searchTerm: $viewModel.searchText)
                .padding()
                .onChange(of: viewModel.searchText) { searchTerm in
                    print("Searching for \(searchTerm)")
                    viewModel.performSearch(text: searchTerm)
                }
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.products) { product in
                    VStack {
                        ProductView(product: product)
                            .onTapGesture {
                                sharedData.selectedProduct = product
                            }
                    }
                }
            }.padding(.horizontal)
        }
        .background(Constants.Colors.appBackground)
    }
}

struct SearchField: View {
    @Binding var searchTerm: String
    var body: some View {
        HStack {
            TextField("Search", text: $searchTerm)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray, lineWidth: 1)
        }
    }
}


struct ProductListing_Previews: PreviewProvider {
    static var previews: some View {
        ProductListing()
    }
}

