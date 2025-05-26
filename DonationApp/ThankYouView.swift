//
//  ThankYouView.swift
//  DonationApp
//
//  Created by ketan patel on 5/25/25.
//

import SwiftUI

struct ThankYouView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 30) {
            Text("🎉 Thank You!")
                .font(.largeTitle)
                .bold()

            Text("Your donation has been received.")
                .font(.title2)

            Spacer()
        }
        .padding()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
