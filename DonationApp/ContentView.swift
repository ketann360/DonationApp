import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    // No direct @EnvironmentObject for POSPaymentManager here,
    // as ContentView doesn't directly interact with it beyond navigation.
    // DonationConfirmationView will get it from the environment.

    var body: some View {
        VStack {
            switch appState.step {
            case .selectAmount:
                AmountSelectionView { selectedAmount in
                    appState.step = .confirm(amount: selectedAmount)
                }

            case .confirm(let amount):
                DonationConfirmationView(
                    amount: amount,
                    onPaymentCompleted: {
                        // This closure is called by DonationConfirmationView
                        // when POSPaymentManager signals a successful payment.
                        print("✅ Payment completed in ContentView - transitioning to ThankYou.")
                        appState.step = .thankYou
                    },
                    onCancel: {
                        // This closure is called by DonationConfirmationView
                        // when the user presses 'Cancel' within that view.
                        print("❌ Payment canceled in ContentView - returning to Amount Selection.")
                        appState.step = .selectAmount
                    }
                    // onPaymentFailed closure is no longer needed here for DonationConfirmationView
                    // because the view itself now handles all PaymentResult cases and triggers onPaymentCompleted/onCancel directly.
                    // If you *really* need to catch a failure at this ContentView level
                    // for a generic error screen, you'd do it by adding an error state/publisher
                    // to your AppState or POSPaymentManager.
                    // For now, let's assume DonationConfirmationView's internal logic is sufficient for failed cases.
                )

            case .thankYou:
                ThankYouView {
                    // This closure is called by ThankYouView (e.g., "Make another donation" button)
                    print("🥳 ThankYouView dismissed - returning to Amount Selection.")
                    appState.step = .selectAmount
                }

            case .paymentError:
                ErrorView(errorMessage: "Payment could not be processed. Please try again.") {
                    // This closure is called by ErrorView (e.g., "Try Again" button)
                    print("🚫 Payment error dismissed - returning to Amount Selection.")
                    appState.step = .selectAmount
                }
            }
        }
        // REMOVED: .onReceive(NotificationCenter.default.publisher(for: .paymentCompleted))
        // This is no longer needed because DonationConfirmationView directly
        // observes POSPaymentManager and calls onPaymentCompleted, which then
        // updates appState.step. Using NotificationCenter would be redundant
        // and could lead to issues.
    }
}
