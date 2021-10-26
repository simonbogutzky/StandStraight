//
//  Alerts.swift
//  StandStraight
//
//  Created by Dr. Simon Bogutzky on 24.10.21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {

    // MARK: - Headphone motion manager alerts

    static let authorizationStatusRestricted = AlertItem(
        title: Text("Authorization status is restricted"),
        message: Text("Please, activate the fitness protocol."),
        dismissButton: .default(Text("OK"))
    )

    static let authorizationStatusDenied = AlertItem(
        title: Text("Authorization status is denied"),
        message: Text("Please, activate the StandStraight in the fitness protocol."),
        dismissButton: .default(Text("OK"))
    )

    static let authorizationStatusUnknown = AlertItem(
        title: Text("Authorization status is unknown"),
        message: Text("Please, re-connect your headphones."),
        dismissButton: .default(Text("OK"))
    )

    static let deviceMotionIsNotAvailable = AlertItem(
        title: Text("Your device is not supported"),
        message: Text("Please, try another device."),
        dismissButton: .default(Text("OK"))
    )

    static let deviceMotionIsActive = AlertItem(
        title: Text("Device motion is active"),
        message: Text("Device motion is already active."),
        dismissButton: .default(Text("OK"))
    )
}
