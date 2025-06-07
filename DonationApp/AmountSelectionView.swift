//
//  AmountSelectionView.swift
//  DonationApp
//
//  Created by ketan patel on 5/31/25.
//
import SwiftUI

struct AmountSelectionView: View {
    let donationAmounts = [5, 11, 21, 51, 101]
    var onAmountSelected: (Int) -> Void
    var onBack: () -> Void

    var body: some View {
        ZStack {
            //Spacer()

            // Background Image
            Image("your_background_image_name")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 40) {
                Spacer()

                Text("Select Donation Amount")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                    .multilineTextAlignment(.center)
                    .padding()

                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 120), spacing: 20)],
                    spacing: 20
                ) {
                    ForEach(donationAmounts, id: \.self) { amount in
                        Button(action: {
                            onAmountSelected(amount)
                        }) {
                            Text("$\(amount)")
                                .frame(width: 120, height: 60)
                                .background(Color.blue.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(16)
                                .font(.title2)
                                .shadow(radius: 3)
                        }
                        .frame(maxWidth: .infinity)  // This centers each button inside its grid cell
                    }
                }
                .frame(maxWidth: 500)
                Spacer()
            }
            .padding()

            //back button
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
}

struct AmountSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AmountSelectionView(
            onAmountSelected: { amount in
                print("Selected $\(amount)")
            },
            onBack: {
                print("Back button tapped")
            }
        )
        .previewDevice(
            PreviewDevice(rawValue: "iPad Pro 11-inch (5th generation)")
        )
    }
}
