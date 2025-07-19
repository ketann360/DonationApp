import SquarePointOfSaleSDK
import SwiftUI // Assuming you're still using SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {

    // 1. Declare your PaymentCoordinator instance.
    // Make it accessible globally or via environment objects if needed,
    // but for the AppDelegate to route the URL, it needs a reference.
    // We'll initialize it in application(_:didFinishLaunchingWithOptions:).

    // This method is called when your app launches.
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {


        return true
    }


    // This is the crucial method that handles incoming URLs (including the Square POS callback).
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {

        // Check if the URL is a callback from Square Point of Sale SDK
        guard SCCAPIResponse.isSquareResponse(url) else {
            // If it's not a Square response, return false or handle other URL schemes
            // that your app might support (e.g., deep links).
            print("Recieved URL is not a square response")
            return false
        }

        // 3. Route the incoming Square response URL to your PaymentCoordinator.
        // The coordinator will then parse the response and publish the outcome.
        POSPaymentManager.shared.handle(url: url)
        print("Routed Square callback URL to POSPaymentManager")

        // Indicate that this URL was handled by your app.
        return true
    }

    // You can optionally add a deinit if you need to clean up resources,
    // but for this simple setup, it's not strictly necessary.
    deinit {
        print("AppDelegate deinitialized.")
    }
}
