//
//  AuthenticationManager.swift
//  DEMO_FaceID
//
//  Created by Jonathan Duong on 20/11/2023.
//

import Foundation
import LocalAuthentication

class AuthenticationManager: ObservableObject {

    @Published var unlocked: Bool = false

    func connexion() {
        if !unlocked {
            authenticate()
        } else {
            unlocked = false
        }
    }

    private func authenticate() {
         let context = LAContext()
         var error: NSError?
         
         if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
             let reason = "Unlock data"
             
             context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticateError in
                 DispatchQueue.main.async {
                     if success {
                         self?.unlocked = true
                     } else {

                     }
                 }
             }
         } else {

         }
     }

}
