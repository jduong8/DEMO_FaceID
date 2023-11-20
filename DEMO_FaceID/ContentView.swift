//
//  ContentView.swift
//  DEMO_FaceID
//
//  Created by Jonathan Duong on 20/11/2023.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {

    @StateObject private var manager = AuthenticationManager()

    var body: some View {
        VStack(spacing: 80) {
            displayLabelState(isUnlocked: manager.unlocked)
            displayImage(isUnlocked: manager.unlocked)
            authenticateButton(isUnlocked: manager.unlocked) {
                manager.connexion()
            }
        }
    }
}

#Preview {
    ContentView()
}

// MARK: - Components

extension ContentView {
    private func displayLabelState(isUnlocked: Bool) -> some View {
        Text(isUnlocked == false ? "Application \n locked" : "Application \n unlocked")
            .font(.largeTitle)
            .bold()
            .lineLimit(2)
            .multilineTextAlignment(.center)
    }
    private func displayImage(isUnlocked: Bool) -> some View {
        ZStack {
            isUnlocked == false ? Image.closeChest : Image.openChest
            Circle()
                .stroke(lineWidth: 4)
                .fill(isUnlocked == false ? .red : .green)
                .frame(width: 135, height: 135)
        }
    }
    private func authenticateButton(isUnlocked: Bool, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
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
