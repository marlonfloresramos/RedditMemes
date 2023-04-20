//
//  RedditMemesApp.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 20/04/23.
//

import SwiftUI

@main
struct RedditMemesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let initialSettings = InitialSettings()

    var body: some Scene {
        WindowGroup {
            InitialView()
                .environmentObject(initialSettings)
        }
    }
}
