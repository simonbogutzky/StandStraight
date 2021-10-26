//
//  MainViewModel.swift
//  StandStraight
//
//  Created by Dr. Simon Bogutzky on 24.10.21.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
    @Published var attituteRollInDegree: Double?
    @Published var alertItem: AlertItem?

    private let headphoneMotionManager = HeadphoneMotionManager.shared

    var cancellables = Set<AnyCancellable>()

    var deviceMotionUpdatesAreRunning: Bool {
        attituteRollInDegree != nil
    }

    func startHeadphoneMotionUpdates() {
        do {
            try headphoneMotionManager.startDeviceMotionUpdates()
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { motion in
                    self.attituteRollInDegree = motion.attitude.roll * 180.0 / Double.pi
            }).store(in: &cancellables)
        } catch {
            let headphoneMotionManagerError = error as? HeadphoneMotionManagerError

            switch headphoneMotionManagerError {
            case .authorizationStatusRestricted:
                alertItem = AlertContext.authorizationStatusRestricted
            case .authorizationStatusDenied:
                alertItem = AlertContext.authorizationStatusDenied
            case .authorizationStatusUnknown:
                alertItem = AlertContext.authorizationStatusUnknown
            case .deviceMotionIsNotAvailable:
                alertItem = AlertContext.deviceMotionIsNotAvailable
            case .deviceMotionIsActive:
                alertItem = AlertContext.deviceMotionIsActive
            case .none:
                break
            }
        }
    }

    func stopHeadphoneMotionUpdates() {
        headphoneMotionManager.stopDeviceMotionUpdates()
        cancellables.removeAll()
        attituteRollInDegree = nil
    }
}
