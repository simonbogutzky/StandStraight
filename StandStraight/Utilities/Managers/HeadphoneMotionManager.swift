//
//  HeadphoneMotionManager.swift
//  StandStraight
//
//  Created by Simon Bogutzky on 24.10.21.
//

import Foundation
import CoreMotion
import Combine

enum HeadphoneMotionManagerError: Error {
    case authorizationStatusRestricted
    case authorizationStatusDenied
    case authorizationStatusUnknown
    case deviceMotionIsNotAvailable
    case deviceMotionIsActive
}

final class HeadphoneMotionManager {

    static let shared = HeadphoneMotionManager()

    private let headphoneMotionManager = CMHeadphoneMotionManager()
    private let queue = OperationQueue()

    private let motionSubject = PassthroughSubject<CMDeviceMotion, Never>()

    func startDeviceMotionUpdates() throws -> PassthroughSubject<CMDeviceMotion, Never> {

        switch CMHeadphoneMotionManager.authorizationStatus() {
        case .notDetermined:
            print("Headphone motion manager authorization status is not determined.")
        case .restricted:

            // Deactive fitness protocol
            print("Headphone motion manager authorization status is restricted.")
            throw HeadphoneMotionManagerError.authorizationStatusRestricted
        case .denied:

            // App is deactive in fitness protocol
            print("Headphone motion manager authorization status is denied.")
            throw HeadphoneMotionManagerError.authorizationStatusDenied
        case .authorized:
            print("Headphone motion manager authorization status is authorized.")
        @unknown default:
            print("Headphone motion manager authorization status is unknown.")
            throw HeadphoneMotionManagerError.authorizationStatusUnknown
        }

        if !headphoneMotionManager.isDeviceMotionAvailable {
            print("Device motion is not available.")
            throw HeadphoneMotionManagerError.deviceMotionIsNotAvailable
        }

        guard !headphoneMotionManager.isDeviceMotionActive else {
            print("Device motion is active.")
            throw HeadphoneMotionManagerError.deviceMotionIsActive
        }

        print("Start device motion updates")
        headphoneMotionManager.startDeviceMotionUpdates(to: self.queue) { (motion: CMDeviceMotion?, error: Error?) in
            // print("Device motion update")
            guard let motion = motion, error == nil else { return }

            self.motionSubject.send(motion)
        }

        return motionSubject
    }

    func stopDeviceMotionUpdates() {
        headphoneMotionManager.stopDeviceMotionUpdates()
    }
}
