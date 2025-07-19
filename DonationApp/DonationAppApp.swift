//
//  DonationAppApp.swift
//  DonationApp
//
//  Created by ketan patel on 5/25/25.
//

import SwiftUI
import SquarePointOfSaleSDK

@main
struct DonationAppApp: App {
    // Link your AppDelegate here
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate // If using AppDelegate
      @StateObject var appState = AppState() // Your app's state controller
      @StateObject var posPaymentManager = POSPaymentManager.shared // Your payment manager singleton

      var body: some Scene {
          WindowGroup {
              ContentView()
                  .environmentObject(appState)           // Provide AppState
                  .environmentObject(posPaymentManager) // Provide POSPaymentManager
                  .onOpenURL { url in
                      // This handles the Square POS callback if using modern SwiftUI lifecycle
                      if SCCAPIResponse.isSquareResponse(url) {
                          posPaymentManager.handle(url: url)
                      }
                  }
          }
      }
}
