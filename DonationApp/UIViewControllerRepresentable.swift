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
        let onFail: (Error?) -> Void
        let onCancel: () -> Void

//        func makeCoordinator() -> PaymentCoordinator {
//            return PaymentCoordinator(
//                onSuccess: onSuccess,
//                onFail: onFail,
//                onCancel: onCancel
//            )
//        }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .clear
//        DispatchQueue.main.async {
//            context.coordinator.startPayment(amount: amount, from: viewController)
//        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
