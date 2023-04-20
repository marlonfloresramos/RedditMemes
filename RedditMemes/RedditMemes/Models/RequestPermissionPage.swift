//
//  RequestPermissionPage.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 20/04/23.
//

import Foundation

struct RequestPermissionPage: Identifiable {
    let id = UUID()
    let type: RequestPages
    let imageName: String
    let title: String
    let subTitle: String
    let primaryButton: String
    let secondaryButton: String
}
