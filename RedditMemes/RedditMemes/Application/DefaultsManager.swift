//
//  PersistanceManager.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 21/04/23.
//

import Foundation

protocol DefaultsManagerRepresentable {
    func saveObject<T>(object: T, key: DefaultsKeys)
    func retreiveObject<T>(key: DefaultsKeys) -> T?
    var onboardingCompleted: Bool { get }
}

enum DefaultsKeys: String {
    case finishOnboarding
}

class DefaultsManager: DefaultsManagerRepresentable {
    static let shared = DefaultsManager()
    let defaults = UserDefaults.standard
    var onboardingCompleted = false

    private init() {
        let onboardingCompleted: Bool = retreiveObject(key: .finishOnboarding) ?? false
        self.onboardingCompleted = onboardingCompleted
    }

    func saveObject<T>(object: T, key: DefaultsKeys) {
        defaults.set(object, forKey: key.rawValue)
    }

    func retreiveObject<T>(key: DefaultsKeys) -> T? {
        return defaults.object(forKey: key.rawValue) as? T
    }
}
