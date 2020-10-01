//
//  InfoView.swift
//  ShakeList
//
//  Created by Jan Kott on 30.09.20.
//  Copyright © 2020 Jan Kott. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 30){
        Image(systemName: "info.circle")
            .resizable()
            .foregroundColor(Color(.systemBlue))
            .frame(width: 100, height: 100)
        Text("Diese App wurde von Jan Kott, Ivo Eid und Laurel Mayer entwickelt.")
        .multilineTextAlignment(.center)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
