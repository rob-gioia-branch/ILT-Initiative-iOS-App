//
//  MainPage.swift
//  bumonsterapp
//
//  Created by Anish Somani on 06/10/2023.
//

import SwiftUI
import BranchSDK

struct MainPage: View {
    

    
    // Current Tab...
    @State var currentTab: Tab = .Home
    @StateObject var sharedData: SharedDataModel = SharedDataModel()
    // @State var selectedProduct: Product?
    
    // Animation Namespace...
    @Namespace var animation
    
    // Hiding Tab Bar...
    init(){
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        
        VStack {
            // Tab View...
            TabView(selection: $currentTab) {
                ReferAFriendView()
                    .environmentObject(sharedData)
                    .tag(Tab.Home)

                ProductListing()
                    .environmentObject(sharedData)
                    .tag(Tab.Menu)

                ProfilePage()
                    .tag(Tab.Profile)

                /* Old Code
                LikedPage()
                    .environmentObject(sharedData)
                    .tag(Tab.Liked)
                CartPage()
                    .environmentObject(sharedData)
                    .tag(Tab.Cart)
                 */
            }

            TabBarView(currentTab: $currentTab)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onAppear{
            NotificationCenter.default.addObserver(forName: Notification.Name("HANDLEDEEPLINK"), object: nil, queue: nil) { notification in
                guard let userInfo = notification.userInfo as? Dictionary<String, Any> else {return}
               
                if let productIDURL = userInfo["product_id"] as? String {
                    let productID = productIDURL.replacingOccurrences(of: "https://monster-site.github.io/shop/item-detail.html?id=", with: "")
                    print("UserID = \(productID)")
                    let homeViewModel = HomeViewModel()
                   let filteredProducts =  homeViewModel.products.filter {$0.productId == productID}
                    print("filter product == \(filteredProducts)")
                    if filteredProducts.count != 0 {
                        
                        //sharedData.detailProduct = filteredProducts[0]
                        //sharedData.showDetailProduct = true
                        
                        sharedData.selectedProduct = filteredProducts.first
                        
                    }
                }
            }
            
        }
        .fullScreenCover(item: $sharedData.selectedProduct) { product in
                    ProductDetailsPage(product: product)
                        .environmentObject(sharedData)
                }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

// Making Case Iteratable...
// Tab Cases...
enum Tab: String,CaseIterable{
    
    // Raw Value must be image Name in asset..
    case Home = "Home"
    case Profile = "Profile"
    case Menu = "Menu"
    
    /* Old Code
    //case Liked = "Liked"
    //case Cart = "Cart"
    */
    
     }

struct TabBarView: View {
    @Binding var currentTab: Tab
    var body: some View {
        HStack(spacing: 0){
            ForEach(Tab.allCases,id: \.self){ tab in

                Button {
                    // updating tab...
                    currentTab = tab
                } label: {

                    Image(tab.rawValue)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                    // Applying little shadow at bg...
                        .background(

                            Color("ThemeButtonColor")
                                .opacity(0.1)
                                .cornerRadius(5)
                            // blurring...
                                .blur(radius: 5)
                            // Making little big...
                                .padding(-7)
                                .opacity(currentTab == tab ? 1 : 0)

                        )
                        .frame(maxWidth: .infinity)
                        .foregroundColor(currentTab == tab ? Color("ThemeButtonColor") : Color.black.opacity(0.3))
                }
            }
        }
    }
}
