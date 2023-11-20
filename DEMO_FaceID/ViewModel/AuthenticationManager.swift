//
//  AuthenticationManager.swift
//  DEMO_FaceID
//
//  Created by Jonathan Duong on 20/11/2023.
//

import Foundation
import LocalAuthentication

/// `AuthenticationManager` est une classe responsable de gérer l'authentification biométrique.
class AuthenticationManager: ObservableObject {

    /// indique si l'utilisateur est authentifié.
    @Published var unlocked: Bool = false

    /// Méthode pour initier ou révoquer l'authentification.
    func connexion() {
        if !unlocked {
            authenticate()
        } else {
            unlocked = false
        }
    }

    /// Méthode privée pour gérer l'authentification biométrique.
    private func authenticate() {
         let context = LAContext()
         var error: NSError?
         
         // Vérifie si l'appareil est capable d'évaluer l'authentification biométrique.
         if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
             let reason = "Unlock data"
             
             // Demande l'authentification biométrique à l'utilisateur.
             context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticateError in
                 // S'assure que la mise à jour de l'état se fait sur le thread principal.
                 DispatchQueue.main.async {
                     if success {
                         self?.unlocked = true // Marque l'utilisateur comme authentifié si l'authentification réussit.
                     } else {
                         // Ici, on peut gérer les erreurs d'authentification, comme informer l'utilisateur.
                     }
                 }
             }
         } else {
             // Ici, on peut gérer le cas où l'appareil ne supporte pas l'authentification biométrique.
         }
     }
}
