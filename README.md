# Branch University Monster App

## Overview
This version of the Branch University Monster App is an iOS app with a landing page, profile page, shop, and referral page.

This app is built using SwiftUI and follows MVVM.

## Project Structure
Some of the main files and folders in this repo:
- `bumonsterapp.xcodeproj/`: Xcode project file
- `bumonsterapp/`
  - `Assets.xcassets`: Asset catalog
  - `Model/`: Data models
    - `Product.swift`: Defines product model for commerce items and also defines different product types
  - `Preview Content/`: Preview assets
  - `View/`: SwiftUI views
  - `ViewModel/`:
    -  `DeepLinkViewModel.swift`: Creates Branch Links
    -  `HomeViewModel.swift`: Defines monsters and contains filtering functionality
    -  `LoginPageModel.swift`: User state and credentials management
    -  `SwiftUIView.swift`: Defines some observable product objects and also calculates cart price total
  - `Constants.swift`: App-wide constants
  - `ContentView.swift`: Main content view
  - `Info.plist`: App configuration file, includes Branch iOS SDK configuration
  - `bumonsterapp.entitlements`: App entitlements, includes defining associated domains for the Branch iOS SDK
  - `bumonsterappApp.swift`: App entry point, includes Branch iOS SDK code
 
## Prerequisites
- Xcode 14.3 or later (14.3 is the minimum version for iOS 16.4 support)
- iOS 16.4 or later
- Swift 5.0 or later

Note: This project is configured to use Swift 5. While it may compile with later versions of Swift, it's recommended to use the Swift version specified in the project settings for consistency.

## SDK Requirements
This project requires a minimum Branch iOS SDK version of 2.0.0 - however it is recommended to use the [latest version](https://help.branch.io/developers-hub/docs/ios-version-history) of the Branch iOS SDK whenever possible.

## Getting Started
1. Clone the repo: `git clone https://github.com/rob-gioia-branch/ILT-Initiative-iOS-App.git`
2. Open `bumonsterapp.xcodeproj` in Xcode.
3. Make sure you have the correct Xcode version and iOS SDK versions installed.

## Branch Events Tracked

### Standard
- `BranchStandardEventLogin`
- `BranchStandardEventPurchase`
- `BranchStandardEventAddToCart`

### Custom
- `Logout`
- `Guest_Login`
- `REFER_A_FRIEND`
