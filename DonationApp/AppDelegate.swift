//
//  AppDelegate.swift
//  DonationApp
//
//  Created by ketan patel on 5/25/25.
//

import UIKit
import SquareMobilePaymentsSDK

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        MobilePaymentsSDK.initialize(
            applicationLaunchOptions: launchOptions,
            squareApplicationID: "sandbox-sq0idb-uSN_bFRN8CVZgDTwUOngEQ"
        )
        return true
    }
}
