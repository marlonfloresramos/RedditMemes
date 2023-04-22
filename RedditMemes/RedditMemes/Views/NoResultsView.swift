//
//  NoResultsView.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 20/04/23.
//

import SwiftUI

struct NoResultsView: View {
    var body: some View {
        ZStack {
            CustomColor.background
                .ignoresSafeArea()
            VStack(spacing: 48) {
                Image("NoResults/search")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 262, height: 230)
                VStack(spacing: 8) {
                    Text("No Results ")
                        .font(Font.system(size: 20).weight(.semibold))
                        .foregroundColor(CustomColor.text)
                    Text("Sorry, there are no results for this search. Please try another phrase")
                        .font(Font.system(size: 15).weight(.regular))
                        .foregroundColor(CustomColor.text)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: 195)
            }
            .padding(.horizontal, 60)
        .navigationBarBackButtonHidden(true)
        }
    }
}

struct NoResultsView_Previews: PreviewProvider {
    static var previews: some View {
        NoResultsView()
    }
}
