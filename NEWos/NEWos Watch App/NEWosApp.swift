import SwiftUI
import WatchConnectivity

@main
struct NEWos_Watch_AppApp: App {
    // Create an instance of the WatchConnectivityManager
    @StateObject private var watchConnectivityManager = WatchConnectivityManager()

    var body: some Scene {
        WindowGroup {
            // Pass the WatchConnectivityManager to ContentView
            ContentView().environmentObject(watchConnectivityManager)
        }
    }
}
