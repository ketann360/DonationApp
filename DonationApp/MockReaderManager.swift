//
//  MockReaderManager.swift
//  DonationApp
//
//  Created by ketan patel on 5/25/25.
//

import MockReaderUI
import SquareMobilePaymentsSDK

class MockReaderManager {
    static let shared = MockReaderManager()
    private var mockReaderUI: MockReaderUI?

    func setupMockReader() {
        do {
            mockReaderUI = try MockReaderUI(for: MobilePaymentsSDK.shared)
            try mockReaderUI?.present()
            print("Mock reader presented.")
        } catch {
            print("Mock reader setup failed: \(error.localizedDescription)")
        }
    }
}
