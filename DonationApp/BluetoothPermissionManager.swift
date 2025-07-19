//
//  BluetoothPermissionManager.swift
//  DonationApp
//
//  Created by ketan patel on 5/25/25.
//

import CoreBluetooth
import Combine

class BluetoothPermissionManager: NSObject, ObservableObject, CBCentralManagerDelegate {
    private var centralManager: CBCentralManager?

//    @Published var bluetoothAuthorization: CBManagerAuthorization

    override init() {
//        self.bluetoothAuthorization = CBCentralManager.authorization
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main, options: nil)
    }

    func requestBluetoothPermission() {
        guard CBManager.authorization == .notDetermined else {
                return
            }

            centralManager = CBCentralManager(
                delegate: self,
                queue: .main,
                options: nil
            )
        }
    

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        DispatchQueue.main.async {
            //            self.bluetoothAuthorization = CBCentralManager.authorization
            switch central.state {
            case .poweredOn:
                print("Bluetooth is powered on and ready")
            case .poweredOff:
                print("Bluetooth is off - prompt user to turn it on")
            case .unauthorized:
                print("Bluetooth permission denied")
            default:
                break
            }
        }
    }
}
