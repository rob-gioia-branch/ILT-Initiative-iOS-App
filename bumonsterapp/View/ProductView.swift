//
//  ProductView.swift
//  bumonsterapp
//
//  Created by Anish Somani on 06/10/2023.
//

import SwiftUI

class ProductViewModel: ObservableObject {
    @Published var showDetails: Bool = false
}
struct ProductView: View {
    let product: Product

    @StateObject private var viewModel = ProductViewModel()

    init(product: Product) {
        self.product = product
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            productImage
            productType
            productTitle
            Spacer()
                .frame(height: 20)
            productSubTitle
        }
//        .fullScreenCover(isPresented: $viewModel.showDetails) {
//            ProductDetailsPage(product: product)
//        }
//        .onTapGesture {
//            viewModel.showDetails = true
//        }
    }

    @ViewBuilder
    var productImage: some View {
        Image(product.productImage)
            .resizable()
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .cornerRadius(20)
    }

    @ViewBuilder
    var productType: some View {
        Text(product.type.rawValue)
            .foregroundColor(.white)
            .fontWeight(.medium)
            .padding()
            .background(
                Capsule()
                    .fill(product.type.color)
                    .frame(maxHeight: 30)
            )
    }

    @ViewBuilder
    var productTitle: some View {
        Text(product.title)
            .font(.title)
            .fontWeight(.semibold)

    }

    @ViewBuilder
    var productSubTitle: some View {
        Text(product.subtitle)
            .lineLimit(2)

    }

}
struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(product: Product(type: .ECOMMERCE, title: "Branch Product", subtitle: "This is a test product", productImage: "ECOMMERCE-1"))
    }
}

