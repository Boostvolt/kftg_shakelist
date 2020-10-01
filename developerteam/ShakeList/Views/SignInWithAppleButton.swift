//
//  SignInWithAppleButton.swift
//  ShakeList
//
//  Created by Jan Kott on 30.09.20.
//  Copyright © 2020 Jan Kott. All rights reserved.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct SignInWithAppleButton: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .signIn, style: .white)
    }
    
    func updateUIView(_ uiView:ASAuthorizationAppleIDButton, context: Context) {
    }
}
