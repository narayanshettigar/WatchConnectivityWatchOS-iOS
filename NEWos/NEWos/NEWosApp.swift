import SwiftUI
import WatchConnectivity

@main
struct NEWosApp: App {
    // Create an instance of the PhoneConnectivityManager
    @StateObject private var phoneConnectivityManager = PhoneConnectivityManager()

    var body: some Scene {
        WindowGroup {
            // Pass the PhoneConnectivityManager to ContentView
            ContentView().environmentObject(phoneConnectivityManager)
        }
    }
}
