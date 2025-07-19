//
//  AppState.swift
//  DonationApp
//
//  Created by ketan patel on 6/24/25.
//


import Foundation
import Combine // Important for ObservableObject

class AppState: ObservableObject {
    enum DonationStep: Equatable { // Equatable is good practice for comparison
        case selectAmount
        case confirm(amount: Int)
        case thankYou
        case paymentError
        // Add other states if needed, e.g., .loadingPayment
    }

    @Published var step: DonationStep = .selectAmount
}
