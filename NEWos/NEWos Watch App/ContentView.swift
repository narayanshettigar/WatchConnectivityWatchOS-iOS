import SwiftUI

struct ContentView: View {
    @State public var inputText = ""
    @EnvironmentObject var watchConnectivityManager: WatchConnectivityManager
    @State public var displayedText = ""

    var body: some View {
        VStack {
            TextField("Enter text", text: $inputText)
                .padding()

            Button(action: {
                displayedText = inputText
                // Send the entered text to the iPhone app
                watchConnectivityManager.sendTextToPhone(displayedText)
                inputText = ""
            }) {
                Text("Update Label")
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            if !watchConnectivityManager.displayedText.isEmpty {
                            Text(displayedText)
                        } else {
                            Text(displayedText)
                        }

//            Text(watchConnectivityManager.displayedText) // Update here

        }
        .padding()
        .onAppear {
            // Activate the WCSession when the ContentView appears
            watchConnectivityManager.activateWCSession()
        }
        .onReceive(watchConnectivityManager.$displayedText) { text in // Add this block
            displayedText = text
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
