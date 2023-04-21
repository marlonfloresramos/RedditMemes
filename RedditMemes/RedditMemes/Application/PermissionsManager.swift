//
//  PermissionsManager.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 20/04/23.
//

import SwiftUI
import AVFoundation
import UserNotifications
import CoreLocation

protocol PermissionsManagerRepresentable {
    func requestCameraPermission(completion: @escaping (Bool) -> Void)
    func requestPushNotificationsPermission(completion: @escaping (Bool) -> Void)
    func goToSettings(completion: @escaping () -> Void)
    var isDeniedCameraAuthorization: Bool { get set }
}

class PermissionsManager: NSObject, PermissionsManagerRepresentable {
    static let shared = PermissionsManager()
    var isDeniedCameraAuthorization = AVCaptureDevice.authorizationStatus(for: .video) == .denied

    private override init() { }

    func requestCameraPermission(completion: @escaping (Bool) -> Void) {
        if AVCaptureDevice.authorizationStatus(for: .video) == .denied {
            goToSettings {
                completion(false)
            }
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
                DispatchQueue.main.async {
                    completion(accessGranted)
                }
            })
        }
     }

    func requestPushNotificationsPermission(completion: @escaping (Bool) -> Void) {
        let current = UNUserNotificationCenter.current()

        current.getNotificationSettings(completionHandler: { [weak self] (settings) in
            if settings.authorizationStatus == .notDetermined {
                let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                current.requestAuthorization(
                    options: authOptions,
                    completionHandler: {granted, _ in completion(granted)})
            } else if settings.authorizationStatus == .denied {
                self?.goToSettings() {
                    completion(false)
                }
            } else if settings.authorizationStatus == .authorized {
                completion(true)
            }
        })
//        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//        UNUserNotificationCenter.current().requestAuthorization(
//            options: authOptions,
//            completionHandler: {granted, _ in completion(granted)})
    }
    
    func goToSettings(completion: @escaping () -> ()) {
        let bundleId = Bundle.main.bundleIdentifier ?? ""
        if let url = URL(string: "\(UIApplication.openSettingsURLString)\(bundleId)"),
           UIApplication.shared.canOpenURL(url) {
            DispatchQueue.main.async {
                UIApplication.shared.open(url, options: [:], completionHandler : { _ in
                    completion()
                })
            }
        }
    }
}
