//
//  WithoutNetworkView.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 21/04/23.
//

import SwiftUI

struct WithoutNetworkView: View {
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.yellow)
            Text("Network connection seems to be offline")
                .font(.system(size: 24))
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 20)
    }
}

struct WithoutNetworkView_Previews: PreviewProvider {
    static var previews: some View {
        WithoutNetworkView()
    }
}
