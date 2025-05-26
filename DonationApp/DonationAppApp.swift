//
//  DonationAppApp.swift
//  DonationApp
//
//  Created by ketan patel on 5/25/25.
//

import SwiftUI

@main
struct DonationAppApp: App {
    // Link your AppDelegate here
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
