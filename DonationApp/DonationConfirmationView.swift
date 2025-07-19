import SwiftUI
import SquarePointOfSaleSDK // Correct SDK import
import Combine // Import Combine for PassthroughSubject and subscriptions

struct DonationConfirmationView: View {
    let amount: Int
    let onPaymentCompleted: () -> Void // Closure to be called on successful payment
    let onCancel: () -> Void           // Closure to be called when the user cancels
    // onPaymentFailed: (Error?) -> Void // This callback is less critical here, as the coordinator handles errors, but could be used for specific UI feedback.

    @EnvironmentObject var posPaymentManager: POSPaymentManager // Inject the shared instance via EnvironmentObject

    @State private var cancellables = Set<AnyCancellable>() // To manage Combine subscriptions

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                Text("Confirm Donation")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.brown)

                Text("You selected: $\(amount)")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.brown)

                Button(action: {
                    // Call the launchPayment method on your injected POSPaymentManager
                    posPaymentManager.launchPayment(amountCents: amount * 100, notes: "Donation")
                }) {
                    Text("Proceed to Payment")
                        .frame(maxWidth: 450, minHeight: 100)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .padding(.vertical, 10)

                Button(action: {
                    onCancel() // Call the provided cancel closure
                }) {
                    Text("Cancel")
                        .frame(maxWidth: 450, minHeight: 100)
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .padding(.vertical, 10)

                Spacer()
            }
        }
        .onAppear {
            // Subscribe to payment outcomes from the POSPaymentManager when the view appears.
            // This is how DonationConfirmationView reacts to the payment result
            // that comes back from the Square POS app.
            posPaymentManager.paymentOutcomeSubject
                .sink { result in
                    switch result {
                    case .success:
                        print("Payment successful in DonationConfirmationView, triggering completion.")
                        self.onPaymentCompleted() // Payment succeeded, trigger navigation in parent view
                    case .canceled:
                        print("Payment canceled by user in DonationConfirmationView.")
                        // If payment is canceled, you might want to keep this view open
                        // or call onCancel() to dismiss it, depending on UX.
                        // For now, we'll just print, keeping the view open.
                        // self.onCancel() // Uncomment if you want to dismiss on cancel
                    case .failed:
                        print("Payment failed in DonationConfirmationView:")
                        // Call the onPaymentFailed closure (if you still need it here)
                        // Or trigger an alert within this view to show the error
                        // For simplicity, we'll dismiss on failure.
                        self.onCancel() // Dismiss on failure, or show an alert
                    }
                }
                .store(in: &cancellables) // Store the subscription to manage its lifecycle
        }
        .onDisappear {
            // Important: Cancel all subscriptions when the view disappears
            // to prevent memory leaks and ensure Combine streams are properly managed.
            cancellables.forEach { $0.cancel() }
            cancellables.removeAll()
            print("DonationConfirmationView subscriptions cancelled.")
        }
    }
}
