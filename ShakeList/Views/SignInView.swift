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
    
    var body: some View {
        VStack(spacing: 30){
        Text("Melde dich an, um deine Artikel geräteübergreifend zu synchronisieren.")
        .multilineTextAlignment(.center)
        SignInWithAppleButton()
        .frame(width: 280, height: 45)
            .onTapGesture {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
