//
//  ThankYouView.swift
//  DonationApp
//
//  Created by ketan patel on 5/25/25.
//

import SwiftUI

struct ThankYouView: View {
    @EnvironmentObject var appState: AppState
    var onFinish: () -> Void

    var body: some View {
        ZStack {
            // Black background
            Color.black.ignoresSafeArea()

            // Background image
            Image("ThankYouHands")
                .resizable()
                .scaledToFill()
                .opacity(0.15)
                .ignoresSafeArea()

            // Content stack, vertically centered
            VStack(spacing: 20) {
                Text("🎉 Thank You!")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.brown)
                    .padding(.horizontal)

                Text("Your donation has been received.")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.brown)
                    .padding(.horizontal)

                Image("jai_swaminarayan")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400)
                    .padding(.vertical, 20)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                // Reset payment flag and trigger exit
                onFinish()
            }
        }
    }
}


struct ThankYouView_Previews: PreviewProvider {
    static var previews: some View {
        ThankYouView(onFinish: {
            // Do nothing for preview
        })
    }
}
