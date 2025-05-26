import SwiftUI

struct DonationConfirmationView: View {
    let amount: Int
    @State private var showPaymentLauncher = false
    @State private var showThankYou = false

    var body: some View {
        VStack(spacing: 30) {
            Text("Confirm Donation")
                .font(.largeTitle)
                .bold()

            Text("You selected: $\(amount)")
                .font(.title)

            Button("Proceed to Payment") {
                showPaymentLauncher = true
            }

            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $showPaymentLauncher) {
            PaymentLauncher(amount: amount) {
                showPaymentLauncher = false
                showThankYou = true
            }
        }
        .fullScreenCover(isPresented: $showThankYou) {
            ThankYouView()
        }
    }
}
