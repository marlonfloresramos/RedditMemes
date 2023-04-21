//
//  PermissionsManager.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 20/04/23.
//

import Foundation
import AVFoundation
import UserNotifications
import CoreLocation

protocol PermissionsManagerRepresentable {
    func requestCameraPermission(completion: @escaping (Bool) -> Void)
    func requestPushNotificationsPermission(completion: @escaping (Bool) -> Void)
}

class PermissionsManager: NSObject, PermissionsManagerRepresentable {
    static let shared = PermissionsManager()

    private override init() { }

    func requestCameraPermission(completion: @escaping (Bool) -> Void) {
         AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
             DispatchQueue.main.async {
                 completion(accessGranted)
             }
         })
     }

    func requestPushNotificationsPermission(completion: @escaping (Bool) -> Void) {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                  UNUserNotificationCenter.current().requestAuthorization(
                    options: authOptions,
                    completionHandler: {granted, _ in completion(granted)})
    }
}
