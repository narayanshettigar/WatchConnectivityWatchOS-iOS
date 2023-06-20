import Foundation
import WatchConnectivity

class WatchConnectivityManager: NSObject, ObservableObject, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        return
    }
    
    @Published var displayedText = ""

    override init() {
        super.init()
        activateWCSession()
    }

    func activateWCSession() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    func sendTextToPhone(_ text: String) {
        if WCSession.default.isReachable {
            let message = ["text": text]
            WCSession.default.sendMessage(message, replyHandler: nil) { error in
                print("Error sending message to iPhone app: \(error.localizedDescription)")
            }
        } else {
            print("iPhone app is not reachable")
        }
    }

    // Implement the delegate method for receiving dictionary messages from the iPhone app
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        // Handle the received message from the iPhone app
        if let receivedText = message["text"] as? String {
            // Update the displayed text in the Watch app
            DispatchQueue.main.async {
                // Update the displayed text in the Watch app's ContentView
                self.displayedText = receivedText
            }
        }
    }
}
