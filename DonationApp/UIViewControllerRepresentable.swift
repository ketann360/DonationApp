//
//  UIViewControllerRepresentable.swift
//  DonationApp
//
//  Created by ketan patel on 5/25/25.
//

import SwiftUI

struct PaymentLauncher: UIViewControllerRepresentable {
    let amount: Int
    let onSuccess: () -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        DispatchQueue.main.async {
            let coordinator = PaymentCoordinator()
            coordinator.startPayment(amount: amount, from: viewController) {
                onSuccess()
            }
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

