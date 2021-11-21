//
//  Alert.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/03/24.

import SwiftUI
struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var dismissButton: Alert.Button
}

struct AlertActionItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var dismissButton: Alert.Button
    var actionButton: Alert.Button
}

struct AlertContext { // cf SA
    // MARK: - NETWORK ALERTS
    static let invalidData = AlertItem(title: Text("Server Error"),
                                       message: Text("The data received from the server was invalid."),
                                       dismissButton: .default(Text("OK")))

    static let invalidResponse = AlertItem(title: Text("Server Error"),
                                           message: Text("Invalid response from the server. Please try again later."),
                                           dismissButton: .default(Text("OK")))

    static let invalidURL = AlertItem(title: Text("Server Error"),
                                      message: Text("There was an issue connecting to the server."),
                                      dismissButton: .default(Text("OK")))

    static let unableToComplete = AlertItem(title: Text("Server Error"),
                                            // swiftlint:disable:next line_length
                                            message: Text("Unable to complete your request at this time. Please check your Internet connection."),
                                            dismissButton: .default(Text("OK")))

    static let invalidSomething = AlertItem(title: Text("Invalid Something"),
                                            message: Text("Unable to complete your request at this time."),
                                            dismissButton: .default(Text("OK")))

    // MARK: - ACCOUNT FORM ALERTS
    static let emptyFormField = AlertItem(title: Text("Missing Information"),
                                          // swiftlint:disable:next line_length
                                          message: Text("Please ensure that your have entered the required information."),
                                          dismissButton: .default(Text("OK")))

    static let invalidEmail = AlertItem(title: Text("Invalid Email Address"),
                                        message: Text("Please enter a valid email address."),
                                        dismissButton: .default(Text("OK")))

    static let scoreSaveSuccess = AlertItem(title: Text("Score Saved"),
                                            message: Text("Your score has been saved successfully."),
                                            dismissButton: .default(Text("OK")))

    static let invalidUserData = AlertItem(title: Text("Profile Error"),
                                           message: Text("Your information could not be saved or retrieved."),
                                           dismissButton: .default(Text("OK")))

    static let invalidUserName = AlertActionItem(title: Text("User Name Unavailable"),
                                                 // swiftlint:disable:next line_length
                                                 message: Text("The username you selected is already in use. Try entering a different name."),
                                                 // dismissButton: .default(Text("OK")))
                                                 dismissButton: .default(Text("Okay")),
                                                 actionButton: .default(Text("View Usernames"),
                                                                        action: {
        print("Will show usernames")
    }))

    // MARK: - LOCATION ALERTS

    static let authorizationRequest = AlertItem(title: Text("Authorization Required"),
                                                // swiftlint:disable:next line_length
                                                message: Text("Authorization for the use of your location must be reset. Please change the location settings for this app in your device's Settings."),
                                                dismissButton: .default(Text("OK")))

    static let outOfRange = AlertItem(title: Text("Out of Range"),
                                      // swiftlint:disable:next line_length
                                      message: Text("To access the features of this app, you must be inside a 5km circular region centered on Mt. Kōya. You current location is too far."),
                                      dismissButton: .default(Text("OK")))

    static let regionMonitorFailure = AlertItem(title: Text("Region Monitor Failure"),
                                                // swiftlint:disable:next line_length
                                                message: Text("Due to an error, this app is unable to monitor for regions used in gameplay."),
                                                dismissButton: .default(Text("OK")))

    static let updatingFailure = AlertItem(title: Text("Region Monitor Failure"),
                                           // swiftlint:disable:next line_length
                                           message: Text("Due to an error, this app is unable update regions used in gameplay."),
                                           dismissButton: .default(Text("OK")))

    static let lowAccuracy = AlertItem(title: Text("Poor Accuracy"),
                                       // swiftlint:disable:next line_length
                                       message: Text("The app's location services is having trouble determining your location."),
                                       dismissButton: .default(Text("OK")))

    // MARK: - AUDIO ALERTS
    static let noAudioFile = AlertItem(title: Text("Missing Audio"),
                                       message: Text("The app cannot locate the requested audio file."),
                                       dismissButton: .default(Text("OK")))
}
