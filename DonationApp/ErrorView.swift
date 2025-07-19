//
//  ErrorView.swift
//  DonationApp
//
//  Created by ketan patel on 6/15/25.
//
import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    let onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "xmark.octagon.fill")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text("Error")
                .font(.title)
                .bold()
                .foregroundColor(.primary)
            Text(errorMessage)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            Button("Go Back") {
                onDismiss()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white) // Or a different background
        .ignoresSafeArea(.all)
    }
}
