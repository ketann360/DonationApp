//
//  ThankYouView.swift
//  DonationApp
//
//  Created by ketan patel on 5/25/25.
//

import SwiftUI

struct ThankYouView: View {
    @Environment(\.presentationMode) var presentationMode
    var onFinish: () -> Void
    var body: some View {
        ZStack {
                    // Background image (replace with your asset name)
                    Image("ThankYouHands")
                        .resizable()
                        .scaledToFill()
                        .opacity(0.15)
                        .ignoresSafeArea()

                    VStack(spacing: 30) {
                        Spacer()

                        Text("🎉 Thank You!")
                            .font(.largeTitle)
                            .bold()
                            .multilineTextAlignment(.center)

                        Text("Your donation has been received.")
                            .font(.title2)
                            .multilineTextAlignment(.center)

                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                onFinish()
                
            }
        }
            
        }
    }
}
