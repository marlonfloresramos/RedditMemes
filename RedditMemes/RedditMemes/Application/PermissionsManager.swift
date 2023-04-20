//
//  PermissionsManager.swift
//  RedditMemes
//
//  Created by Marlon Gabriel Flores Ramos on 20/04/23.
//

import Foundation
import AVFoundation

protocol PermissionsManagerRepresentable {
    func requestCameraPermission(completion: @escaping (Bool) -> ())
}

class PermissionsManager: PermissionsManagerRepresentable {
    static let shared = PermissionsManager()

    private init() { }

    func requestCameraPermission(completion: @escaping (Bool) -> ()) {
         AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
             DispatchQueue.main.async {
                 completion(accessGranted)
             }
         })
     }
}
