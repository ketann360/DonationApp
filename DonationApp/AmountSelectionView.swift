//
//  AmountSelectionView.swift
//  DonationApp
//
//  Created by ketan patel on 5/31/25.
//
import SwiftUI

struct AmountSelectionView: View {
    let donationAmounts = [5, 11, 21, 51, 101]
       var onSelectAmount: (Int) -> Void

       var body: some View {
           ZStack {
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

                   LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 20)], spacing: 20) {
                       ForEach(donationAmounts, id: \.self) { amount in
                           Button(action: {
                               onSelectAmount(amount)
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
                   .frame(maxWidth: 600) 
                   Spacer()
               }
               .padding()
           }
       }
}
