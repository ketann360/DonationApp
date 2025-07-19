//
//  POSPaymentManager.swift
//  DonationApp
//
//  Created by ketan patel on 6/24/25.
//

import SwiftUI
import Foundation
import UIKit
import SquarePointOfSaleSDK
import Combine

class POSPaymentManager: ObservableObject {
    static let shared = POSPaymentManager()
    let paymentOutcomeSubject = PassthroughSubject<POSPaymentResult, Never>()

    init() {
        SCCAPIRequest.setApplicationID("sq0idp-8vkQ5TDctNrqsjBQ_XHiWg")
    }

    func launchPayment(amountCents: Int, currency: String = "USD", notes: String? = nil) {
        guard let callbackURL = URL(string: "donationapp://payment-callback") else { return }

        do {
            let money = try SCCMoney(amountCents: amountCents, currencyCode: currency)
            let request = try SCCAPIRequest(
                callbackURL: callbackURL,
                amount: money,
                userInfoString: nil,
                locationID: nil,
                notes: notes,
                customerID: nil,
                supportedTenderTypes: .all,
                clearsDefaultFees: false,
                returnsAutomaticallyAfterPayment: true,
                disablesKeyedInCardEntry: false,
                skipsReceipt: false
            )
            try SCCAPIConnection.perform(request)
        } catch {
            print("❌ POS request error:", error.localizedDescription)
        }
    }

    func handle(url: URL)  {
        do {
                    let response = try SCCAPIResponse(responseURL: url)

                    // Check if there was an error in the Square POS transaction
                    if let error = response.error {
                        print("Payment failed from Square POS: \(error.localizedDescription)")
                        self.paymentOutcomeSubject.send(.failed)
                    } else {
                        // No error means it was either successful or canceled.
                        // A successful transaction will have a transactionID.
                        if let transactionID = response.transactionID {
                            print("Payment successful! Transaction ID: \(transactionID)")
                            self.paymentOutcomeSubject.send(.success)
                        } else {
                            // If no error AND no transactionID, it means the user canceled.
                            print("Payment canceled by user (no error, no transaction ID).")
                            self.paymentOutcomeSubject.send(.canceled)
                        }
                    }
                } catch let error as NSError {
                    // Handle errors thrown during the creation of SCCAPIResponse (e.g., malformed URL)
                    print("Error parsing Square POS response URL: \(error.localizedDescription)")
                    self.paymentOutcomeSubject.send(.failed)
                }
            }
    

}

enum POSPaymentResult {
    case success, canceled, failed
}
