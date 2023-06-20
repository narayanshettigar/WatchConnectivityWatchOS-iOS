import Foundation
import WatchConnectivity

class PhoneConnectivityManager: NSObject, ObservableObject, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        return
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        return
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        return
    }
    
    @Published var displayedText: String = ""

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

    func sendTextToWatch(_ text: String) {
        if WCSession.default.isReachable {
            let message = ["text": text]
            WCSession.default.sendMessage(message, replyHandler: nil) { error in
                print("Error sending message to Watch app: \(error.localizedDescription)")
            }
        } else {
            print("Watch app is not reachable")
        }
    }

    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        if let receivedText = message["text"] as? String {
            DispatchQueue.main.async {
                self.displayedText = receivedText
            }
        }
    }
}

