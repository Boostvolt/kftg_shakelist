//
//  SignInView.swift
//  ShakeList
//
//  Created by Jan Kott on 30.09.20.
//  Copyright © 2020 Jan Kott. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var coordinator: SignInWithAppleCoordinater?
    
    var body: some View {
        VStack(spacing: 30){
            Image(systemName: "person.circle")
                .resizable()
                .foregroundColor(Color(.systemBlue))
                .frame(width: 100, height: 100)
            Text("Melde dich an, um deine Artikel geräteübergreifend zu synchronisieren.")
                .multilineTextAlignment(.center)
            SignInWithAppleButton()
                .frame(width: 280, height: 45)
                .onTapGesture {
                    self.coordinator = SignInWithAppleCoordinater()
                    if let coordinator = self.coordinator {
                        coordinator.startSignInWithAppleFlow {
                            print("Erfolgreich angemeldet.")
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
