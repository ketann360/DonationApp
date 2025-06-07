//
//  ContentView.swift
//  DonationApp
//
//  Created by ketan patel on 5/25/25.
//

import SwiftUI

enum AppStep: Equatable {
    case welcome
    case selectAmount
    case confirm(amount: Int)
    case thankYou
}

struct ContentView: View {
    @StateObject private var locationManager = LocationPermissionManager()
    @StateObject private var bluetoothManager = BluetoothPermissionManager()

    @State private var step: AppStep = .welcome

    var body: some View {
        ZStack {
            if case .welcome = step {
                WelcomeView {
                        step = .selectAmount
                    }
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))

            }

            if case .selectAmount = step {
                AmountSelectionView(
                    onAmountSelected: { selectedAmount in
                            step = .confirm(amount: selectedAmount)
                    },
                    onBack: {
                            step = .welcome
                    }
                )
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))

            }

            if case .confirm(let amount) = step {
                DonationConfirmationView(
                    amount: amount,
                    onPaymentCompleted: {
                            step = .thankYou
                    },
                    onBack: {
                            step = .selectAmount
                    }
                )
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))

            }

            if case .thankYou = step {
                ThankYouView {
                        step = .welcome
                }
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .bottom).combined(with: .opacity)
                ))

            }
        }
        .animation(.easeInOut(duration: 0.5), value: step)
        .onAppear {
            locationManager.requestLocationPermission()
            bluetoothManager.requestBluetoothPermission()

            SquarePaymentManager.shared.authorizeSDK(
                accessToken:
                    "EAAAl0Mvh1op1g8fTuC0d6mA491Jccwpkdkam6quBmvqrld0lNEK6lXvtwccXC43",
                locationID: "<YOUR_SANDBOX_LOCATION_ID>"
            ) { error in
                if let error = error {
                    print(
                        "❌ Square SDK authorization failed: \(error.localizedDescription)"
                    )
                } else {
                    print("✅ Square SDK successfully authorized.")
                }
            }
        }
    }

    private var locationStatusText: String {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            return "Authorized"
        case .denied:
            return "Denied"
        case .notDetermined:
            return "Not Determined"
        case .restricted:
            return "Restricted"
        default:
            return "Unknown"
        }
    }

    private var bluetoothStatusText: String {
        switch bluetoothManager.bluetoothAuthorization {
        case .allowedAlways:
            return "Authorized"
        case .denied:
            return "Denied"
        case .notDetermined:
            return "Not Determined"
        case .restricted:
            return "Restricted"
        default:
            return "Unknown"
        }
    }
}

#Preview {
    ContentView()
}
