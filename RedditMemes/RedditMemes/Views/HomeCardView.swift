//
//  HomeCardView.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 20/04/23.
//

import SwiftUI

struct HomeCardView: View {
    let post: RedditPost

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(.white)
                .shadow(radius: 4)
            VStack {
                AsyncImage(url: URL(string: post.data?.url ?? "")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 170, alignment: .center)
                        .clipped()
                        .cornerRadius(8, corners: [.topLeft, .topRight])
                } placeholder: {
                    ProgressView()
                        .frame(height: 170, alignment: .center)
                }
                HStack(alignment: .top) {
                    VStack(spacing: 4) {
                        Image(systemName: "chevron.up")
                            .foregroundColor(.gray)
                        Text("\(post.data?.score ?? 0)")
                            .font(.system(size: 12))
                        .foregroundColor(.gray)
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    VStack(alignment: .leading, spacing: 16) {
                        Text(post.data?.title ?? "")
                            .font(.system(size: 18))
                            .foregroundColor(CustomColor.text)
                            .lineLimit(2)
                        HStack(spacing: 4) {
                            Image(systemName: "message.fill")
                                .foregroundColor(.gray)
                            Text("\(post.data?.numberOfComments ?? 0)")
                                .font(.system(size: 12))
                                .foregroundColor(CustomColor.text)
                            .foregroundColor(.gray)
                        }
                    }
                    Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
        }
        .padding(.horizontal, 6)
    }
}

struct HomeCardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeCardView(post: RedditPost(data: nil))
    }
}
