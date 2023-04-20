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
    var pages: [RequestPermissionPage] = [
        RequestPermissionPage(
            imageName: "RequestPermission/camera",
            title: "Camera Access",
            subTitle: "Please allow access to your camera to take photos",
            primaryButton: "Allow",
            secondaryButton: "Cancel"
        ),
        RequestPermissionPage(
            imageName: "RequestPermission/push",
            title: "Enable Push",
            subTitle: "Enable push notifications to let send you personal news and updates.",
            primaryButton: "Enable",
            secondaryButton: "Cancel"
        ),
        RequestPermissionPage(
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

    func goToNextScreen(next: () -> Void, flowFinished: () -> Void) {
        if currentPage == pages.count - 1 {
            flowFinished()
        } else {
            currentPage += 1
            next()
        }
    }

}
