//
//  ContentView.swift
//  DonationApp
//
//  Created by ketan patel on 5/25/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var locationManager = LocationPermissionManager()
    @StateObject private var bluetoothManager = BluetoothPermissionManager()

    let donationAmounts = [5, 11, 21, 51, 101]
    @State private var selectedAmount: Int?
    @State private var navigateToConfirm = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                Text("Select Donation Amount")
                    .font(.largeTitle)
                    .bold()
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 20)], spacing: 20) {
                    ForEach(donationAmounts, id: \.self) { amount in
                        Button(action: {
                            selectedAmount = amount
                            navigateToConfirm = true
                        }) {
                            Text("$\(amount)")
                                .frame(width: 100, height: 60)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(16)
                                .font(.title2)
                        }
                    }
                }
                
                NavigationLink(
                    destination: DonationConfirmationView(amount: selectedAmount ?? 0),
                    isActive: $navigateToConfirm
                ) {
                    EmptyView()
                }
                
                Spacer()
            }
            .padding()
            .onAppear {
                locationManager.requestLocationPermission()
                bluetoothManager.requestBluetoothPermission()
                SquarePaymentManager.shared.authorizeSDK(
                    accessToken: "<YOUR_SQUARE_ACCESS_TOKEN>",
                    locationID: "<YOUR_LOCATION_ID>"
                ) { error in
                    if let error = error {
                        print("Square SDK authorization failed: \(error.localizedDescription)")
                    } else {
                        print("Square SDK successfully authorized.")
                    }
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
