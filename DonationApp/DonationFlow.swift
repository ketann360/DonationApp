//
//  DonationFlow.swift
//  DonationApp
//
//  Created by ketan patel on 5/31/25.
//
import SwiftUI

struct DonationFlow: View {
    let amount: Int
    let onFinish: () -> Void

    @State private var showThankYou = false

    var body: some View {
        ZStack {
            if showThankYou {
                ThankYouView {
                    onFinish()
                }
            } else {
                PaymentLauncher(amount: amount) {
                    // Wait before switching to thank you view
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showThankYou = true
                    }
                }
            }
        }
    }
}
