import SwiftUI

struct DonationConfirmationView: View {
    let amount: Int
    let onPaymentCompleted: () -> Void
    var onBack: () -> Void

    @State private var showPaymentLauncher = false
    let useMockPaymentLauncher = true

    var body: some View {
        VStack(spacing: 30) {
            Spacer()  // Push content towards center vertically

            Text("Confirm Donation")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)

            Text("You selected: $\(amount)")
                .font(.title)
                .multilineTextAlignment(.center)

            Button(action: {
                showPaymentLauncher = true
            }) {
                Text("Proceed to Payment")
                    .frame(maxWidth: 250, minHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(12)
                    .shadow(radius: 5)
            }

            Spacer()  // Push content towards center vertically
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)  // Fill parent container
        .background(Color(UIColor.systemBackground))
        .padding()
        .fullScreenCover(isPresented: $showPaymentLauncher) {
            if useMockPaymentLauncher {
                MockPaymentLauncher(amount: amount) {
                    showPaymentLauncher = false
                    onPaymentCompleted()
                }
            } else {
                PaymentLauncher(amount: amount) {
                    showPaymentLauncher = false
                    onPaymentCompleted()
                }
            }
        }
        //Back button
        HStack(alignment: .top) {
            Button(action: onBack) {
                HStack(alignment: .top) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .frame(width: 90, height: 75)
                .clipped()
                .foregroundColor(.white)
                .font(.title)
                .background(Color.black.opacity(0.5))
                .clipShape(Capsule())
                .shadow(radius: 3)
            }
            .frame(maxWidth: 1080, maxHeight: 700, alignment: .topLeading)
            .clipped()
            .padding(24)
        }
    }
}

// MockPaymentLauncher for testing UI without real payment

struct MockPaymentLauncher: View {
    let amount: Int
    let onComplete: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Mock Payment Processing")
                .font(.title)
                .padding()

            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(2)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                onComplete()
            }
        }
    }
}
