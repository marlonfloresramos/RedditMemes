//
//  InitialSettings.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 20/04/23.
//

import Foundation

enum InitialViewState {
    case showOnboarding
    case showRequestPermission
    case showHome
}

class InitialSettings: ObservableObject {
    @Published var state: InitialViewState = .showOnboarding
}
