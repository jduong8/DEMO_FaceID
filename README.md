# Description

### Atelier Face ID (SwiftUI)

Étape 1:
Documentation sur face id [ici](https://www.hackingwithswift.com/books/ios-swiftui/using-touch-id-and-face-id-with-swiftui)

Étape 2:
Création du projet

Étape 3:

Configuration du projet pour le face id
Ajout de la key: `Privacy - Face ID Usage Description`
Ajout de la value: `Unlock data` ou autre chose d'explicite.

Étape 4:

Ajout des différentes assets récupéré dans le [Figma](https://www.figma.com/file/hpb4dhAz0CoB2ihXAMQZWs/ChestApp?type=design&node-id=0%3A1&mode=design&t=crUgKj8yDUL8wd5H-1)
Ajout d'un fichier Image+Generated.swift

Étape 5:

Implémentation des différentes composants de l'interface.
- Un titre
- Une image
- Un bouton

Étape 6:

Importation de la librairie `LocalAuthentication`

```swift
import LocalAuthentication
```

Implémentation du service de dévérouillage par face id
```swift
func authenticate() {
    let context = LAContext() // --> instance de LAContext (Local Authentication Contexte) pour gérer le contexte de l'authentification locale
    var error: NSError? // --> une variable d'erreur pour capturer toute erreur lors de la vérification de l'authentification

    // Vérifirication: si l'appareil peut effectuer une authentification biométrique (Touch ID ou Face ID)
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
        let reason = "We need to unlock your data." // -> Définit le message qui sera affiché à l'utilisateur lors de la demande d'authentification

        // Démarrage du processus d'authentification biométrique qui prend en paramètre (le type d'authentification et le message de raison)

        // La méthode evaluatePolicy est asynchrone et utilise une closure pour gérer le résultat de l'authentification (success, authenticationError).
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
            // authentication has now completed
            if success {
                // on renvoie une action
            } else {
                // On devrait renvoyer une erreur en cas d'échec.
            }
        }
    } else {
        // On devrait renvoyer une erreur si l'appareil ne prend pas en charge l'authentification biométrique.
    }
}
```

# Resources

https://www.hackingwithswift.com/books/ios-swiftui/using-touch-id-and-face-id-with-swiftui
