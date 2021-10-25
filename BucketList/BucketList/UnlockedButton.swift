//
//  UnlockedButton.swift
//  BucketList
//
//  Created by Denys on 25.10.2021.
//

import SwiftUI
import LocalAuthentication

struct UnlockedButton: View {
    
    @Binding var isUnlocked : Bool
    @State private var noBiometry = false
    @State var mistake = ""
    
    var body: some View {
        Button("Unlock Places") {
            self.authenticate()
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(Capsule())
        .alert(isPresented: $noBiometry){
            Alert(title: Text("Error with your FACE ID"), message: nil, dismissButton: .default(Text("Ok")))
        }
    }
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let resaon = "Please authenticate yourself to unlock your places."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: resaon) {success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                        
                    } else {
                        noBiometry = true
                    }
                }
            }
        } else {
            noBiometry = true
        }
    }
}
