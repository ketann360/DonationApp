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
    let onPaymentCompleted: () -> Void
    let onCancel: () -> Void
    let onPaymentFailed: (Error?) -> Void
    @State private var showThankYou = false

    var body: some View {
        ZStack {
            if showThankYou {
                ThankYouView {
                    onFinish()
                }
            } else {
                PaymentLauncher(amount: amount, onSuccess: {
                    // This callback is triggered when payment is truly successful.
                    // It will then dismiss the PaymentLauncher's UIViewControllerRepresentable,
                    // which then dismisses this DonationConfirmationView's fullScreenCover.
                    // After dismissal, ContentView's onPaymentCompleted will be triggered.
                    onPaymentCompleted() // This tells ContentView to navigate to ThankYouView
                },
                onFail: { error in
                    onPaymentFailed(error) // Handles error, then dismisses PaymentLauncher/this view
                },
                onCancel: {
                    onCancel() // Handles cancel, then dismisses PaymentLauncher/this view
                })
                }
            
        }
    }
}
