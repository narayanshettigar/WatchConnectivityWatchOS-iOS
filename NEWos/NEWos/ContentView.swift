import SwiftUI

struct ContentView: View {
    @State private var inputText = ""
    @EnvironmentObject var phoneConnectivityManager: PhoneConnectivityManager
    @State private var displayedText = ""

    var body: some View {
        VStack {
            TextField("Enter text", text: $inputText)
                .padding()

            Button(action: {
                phoneConnectivityManager.displayedText = ""
                displayedText = inputText
                // Send the entered text to the Watch app
                phoneConnectivityManager.sendTextToWatch(displayedText)
                inputText = ""
            }) {
                Text("Update Label")
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            if !phoneConnectivityManager.displayedText.isEmpty {
                            Text(phoneConnectivityManager.displayedText)
                        } else {
                            Text(displayedText)
                        }
            
        }
        .padding()
        .onAppear {
            // Activate the WCSession when the ContentView appears
            phoneConnectivityManager.activateWCSession()
        }
//        }.onReceive(phoneConnectivityManager.$displayedText) { text in // Add this block
//            displayedText = text
       // }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
