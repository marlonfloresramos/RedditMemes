//
//  RequestPermissionViewModel.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 20/04/23.
//

import Foundation

enum RequestPages {
    case camera
    case pushNotifications
    case location
}

class RequestPermissionViewModel: ObservableObject {
    let permissionsManager: PermissionsManagerRepresentable
    let persistanceManager: DefaultsManagerRepresentable
    let flowComplete: () -> Void

    init(permissionsManager: PermissionsManagerRepresentable = PermissionsManager.shared,
         persistanceManager: DefaultsManagerRepresentable = DefaultsManager.shared,
         flowComplete: @escaping () -> Void
    ) {
        self.permissionsManager = permissionsManager
        self.persistanceManager = persistanceManager
        self.flowComplete = flowComplete
    }

    var pages: [RequestPermissionPage] = [
        RequestPermissionPage(
            type: .camera,
            imageName: "RequestPermission/camera",
            title: "Camera Access",
            subTitle: "Please allow access to your camera to take photos",
            primaryButton: "Allow",
            secondaryButton: "Cancel"
        ),
        RequestPermissionPage(
            type: .pushNotifications,
            imageName: "RequestPermission/push",
            title: "Enable Push",
            subTitle: "Enable push notifications to let send you personal news and updates.",
            primaryButton: "Enable",
            secondaryButton: "Cancel"
        ),
        RequestPermissionPage(
            type: .location,
            imageName: "RequestPermission/location",
            title: "Enable location services",
            subTitle: "We wants to access your location only to provide a better experience by helping you find new friends nearby",
            primaryButton: "Enable",
            secondaryButton: "Cancel"
        )
    ]

    var currentPage = 0

    var page: RequestPermissionPage {
        return pages[currentPage]
    }

    func requestPermission(completion: @escaping (Bool) -> ()) {
        switch page.type {
        case .camera:
            permissionsManager.requestCameraPermission { accessGranted in
                completion(accessGranted)
            }
        case .pushNotifications:
            permissionsManager.requestPushNotificationsPermission { accessGranted in
                completion(accessGranted)
            }
        default:
            completion(false)
        }
    }

    func goToNextScreen(next: () -> Void) {
        if currentPage == pages.count - 1 {
            flowComplete()
        } else {
            currentPage += 1
            next()
        }
    }

    func saveOnboardingCompleted() {
        if currentPage == pages.count - 1 {
            persistanceManager.saveObject(object: true, key: .finishOnboarding)
        }
    }
}
