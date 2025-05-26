//
//  PaymentCoordinator.swift
//  DonationApp
//
//  Created by ketan patel on 5/25/25.
//

import UIKit
import SquareMobilePaymentsSDK

class PaymentCoordinator: NSObject {
    private var paymentHandle: PaymentHandle?
    private weak var presentingViewController: UIViewController?
    private var onSuccess: (() -> Void)?

    func startPayment(amount: Int, from viewController: UIViewController, onSuccess: @escaping () -> Void) {
        self.presentingViewController = viewController
        self.onSuccess = onSuccess

        let parameters = PaymentParameters(
            idempotencyKey: UUID().uuidString,
            amountMoney: Money(amount: UInt(Int64(amount * 100)), currency: .USD),
            processingMode: .onlineOnly
        )

        paymentHandle = MobilePaymentsSDK.shared.paymentManager.startPayment(
            parameters,
            promptParameters: PromptParameters(
                mode: .default,
                additionalMethods: .all
            ),
            from: viewController,
            delegate: self
        )
    }
}

extension PaymentCoordinator: PaymentManagerDelegate {
    func paymentManager(_ paymentManager: PaymentManager, didFinish payment: Payment) {
        print("✅ Payment succeeded: \(payment)")
        onSuccess?()
        // You can notify SwiftUI view here (using Combine or delegate if needed)
    }

    func paymentManager(_ paymentManager: PaymentManager, didFail payment: Payment, withError error: Error) {
        print("❌ Payment failed: \(error.localizedDescription)")
    }

    func paymentManager(_ paymentManager: PaymentManager, didCancel payment: Payment) {
        print("⚠️ Payment canceled by user")
    }
}
