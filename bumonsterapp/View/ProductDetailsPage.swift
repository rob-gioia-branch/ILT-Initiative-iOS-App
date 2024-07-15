//
//  ProductDetailsPage.swift
//  bumonsterapp
//
//  Created by Anish Somani on 06/10/2023.
//

import SwiftUI
import BranchSDK

struct ProductDetailsPage: View {
    
    @Environment(\.dismiss) var dismiss
    
    var product: Product
    
    internal var buo = BranchUniversalObject()
    internal var lp = BranchLinkProperties()
    
    // Shared Data Model...
    @EnvironmentObject var sharedData: SharedDataModel
    @EnvironmentObject var homeData: HomeViewModel
    @StateObject var deepLinkVM: DeepLinkViewModel = DeepLinkViewModel()
    @StateObject private var branchEvents = BranchEvents()

    @State private var isShareSheetPresented = false
    @State private var shareLink: String?
    @State private var showToast = false
    @State private var toastMessage = ""
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                BackButton { dismiss() }
                // .padding()
                productType
                productTitle
                productImage
                buttonsStack
                productSubTitle
                Spacer()
            }
            .padding()
        }
        .background(Constants.Colors.appBackground)
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
        //Text(product.subtitle)
        Text("Monsters of every type to delight and cause a smile")
    }
    
    @ViewBuilder
    var buttonsStack: some View {
        HStack(spacing: 12) {
            ThemeButton(title: "Add to cart", fontSize: 18, weight: .medium /*disabled: isAddedToCart()*/) {
                //addToCart()
                branchEvents.trackAddToCartEvent()
                showToast(message: "ADD_TO_CART event triggered")
            }
            
            ThemeButton(title: "Buy now", fontSize: 18, weight: .medium) {
                branchEvents.trackPurchaseEvent()
                showToast(message: "PURCHASE event triggered")
            }
            
            Button {
                deepLinkVM.createDeepLink(product: product)
                deepLinkVM.dataBinding = {
                    self.isShareSheetPresented.toggle()
                }
                
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .renderingMode(.template)
                    .foregroundColor(Constants.Colors.themeBlue)
                    .font(.title)
            }.sheet(isPresented: $isShareSheetPresented) {
                ActivityViewController(activityItems: ["my fav monster: \(deepLinkVM.shareUrl ?? "")"])
            }
            
            Button {
                
            } label: {
                Image(systemName: "bell.fill")
                    .renderingMode(.template)
                    .foregroundColor(Constants.Colors.themeBlue)
                    .font(.title)
            }
        }
        .overlay(
            ToastView(message: toastMessage, isPresented: $showToast)
                .opacity(showToast ? 1 : 0)
                .onChange(of: showToast) { newValue in
                    withAnimation(.easeInOut(duration: 0.2)) {}
                }
        )
        .padding(.horizontal)
    }
    
    
    func isLiked()->Bool{
        
        return sharedData.likedProducts.contains { product in
            return self.product.id == product.id
        }
    }
    
    func isAddedToCart()->Bool{
        
        return sharedData.cartProducts.contains { product in
            return self.product.id == product.id
        }
    }
    
    func addToLiked(){
        
        if let index = sharedData.likedProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }){
            // Remove from liked....
            sharedData.likedProducts.remove(at: index)
        }
        else{
            // add to liked
            sharedData.likedProducts.append(product)
        }
    }
    
    func addToCart(){
        
        if let index = sharedData.cartProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }){
            // Remove from liked....
            sharedData.cartProducts.remove(at: index)
        }
        else{
            // add to liked
            sharedData.cartProducts.append(product)
        }
    }
    
    func showToast(message: String) {
        toastMessage = message
        showToast.toggle()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            showToast.toggle()
        }
    }
    
    struct ProductDetails_Previews: PreviewProvider {
        static var previews: some View {
            ProductDetailsPage(product: Product(type: .ECOMMERCE, title: "Branch Product", subtitle: "This is a test product", productImage: "ECOMMERCE-1"))
                .environmentObject(SharedDataModel())
        }
    }
}
