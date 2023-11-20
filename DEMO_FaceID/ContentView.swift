//
//  ContentView.swift
//  DEMO_FaceID
//
//  Created by Jonathan Duong on 20/11/2023.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    
    @State private var unlocked: Bool = false
    
    var body: some View {
        VStack(spacing: 80) {
            displayLabelState(isUnlocked: unlocked)
            displayImage(isUnlocked: unlocked)
            authenticateButton(isUnlocked: unlocked)
        }
    }
}

#Preview {
    ContentView()
}

// MARK: - Authenticate service

extension ContentView {
   fileprivate func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Unlock data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticateError in
                if success {
                    self.unlocked = true
                } else {
                    
                }
            }
        } else {
            
        }
    }
}

// MARK: - Components

extension ContentView {
    func displayLabelState(isUnlocked: Bool) -> some View {
        Text(isUnlocked == false ? "Application \n locked" : "Application \n unlocked")
            .font(.largeTitle)
            .bold()
            .lineLimit(2)
            .multilineTextAlignment(.center)
    }
    func displayImage(isUnlocked: Bool) -> some View {
        ZStack {
            isUnlocked == false ? Image.closeChest : Image.openChest
            Circle()
                .stroke(lineWidth: 4)
                .fill(isUnlocked == false ? .red : .green)
                .frame(width: 135, height: 135)
        }
    }
    func authenticateButton(isUnlocked: Bool) -> some View {
        Button {
            if !unlocked {
                authenticate()
            } else {
                unlocked = false
            }        } label: {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(isUnlocked == false ? .green : .red)
                    .frame(width: 138, height: 69)
                Text(isUnlocked == false ? "Open" : "Lock")
                    .foregroundStyle(.white)
                    .font(.title)
                    .bold()
            }
        }
    }
}
