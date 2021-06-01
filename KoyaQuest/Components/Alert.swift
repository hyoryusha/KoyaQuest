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

struct AlertContext { //many of these are from Sean Allen Appetizer app... save for now?
    //MARK: -- NETWORK ALERTS
    
    static let invalidData      = AlertItem(title: Text("Server Error"),
                                                message: Text("The data received from the server was invalid."),
                                                dismissButton: .default(Text("OK")))
    
    static let invalidResponse   = AlertItem(title: Text("Server Error"),
                                                message: Text("Invalid response from the server. Please try again later."),
                                                dismissButton: .default(Text("OK")))
    
    static let invalidURL       = AlertItem(title: Text("Server Error"),
                                                message: Text("There was an issue connecting to the server."),
                                                dismissButton: .default(Text("OK")))
    
    static let unableToComplete = AlertItem(title: Text("Server Error"),
                                                message: Text("Unable to complete your request at this time. Please check your Internet connection."),
                                                dismissButton: .default(Text("OK")))
    
    static let invalidSomething = AlertItem(title: Text("Invalid Something"),
                                                message: Text("Unable to complete your request at this time. "),
                                                dismissButton: .default(Text("OK")))
    
    //MARK: -- ACCOUNT FORM ALERTS
    
    static let emptyFormField = AlertItem(title: Text("Missing Information"),
                                                message: Text("Please ensure that your have entered the required information."),
                                                dismissButton: .default(Text("OK")))
    
    static let invalidEmail = AlertItem(title: Text("Invalid Email Address"),
                                                message: Text("Please enter a valid email address."),
                                                dismissButton: .default(Text("OK")))
    
    static let userSaveSuccess = AlertItem(title: Text("Profile Saved"),
                                                message: Text("Your information has been saved successfully."),
                                                dismissButton: .default(Text("OK")))
    static let invalidUserData = AlertItem(title: Text("Profile Error"),
                                                message: Text("Your information could not be saved or retrieved."),
                                                dismissButton: .default(Text("OK")))
    
    //MARK: -- LOCATION ALERTS
    static let authorizationRequest = AlertItem(title: Text("Authorization Required"),
                                                message: Text("Authorization for the use of your location must be reset. Please change the location settings for this app in your device's Settings."),
                                                dismissButton: .default(Text("OK")))
    static let outOfRange = AlertItem(title: Text("Out of Range"),
                                                message: Text("To access the features of this app, you must be inside a 5km circular region centered on Mt. Kōya. You current location is too far."),
                                                dismissButton: .default(Text("OK")))

    static let regionMonitorFailure = AlertItem(title: Text("Region Monitor Failure"),
                                                message: Text("Due to an error, this app is unable to monitor for regions used in gameplay."),
                                                dismissButton: .default(Text("OK")))
    
    static let updatingFailure = AlertItem(title: Text("Region Monitor Failure"),
                                                message: Text("Due to an error, this app is unable update regions used in gameplay."),
                                                dismissButton: .default(Text("OK")))
    
    static let lowAccuracy = AlertItem(title: Text("Poor Accuracy"),
                                                message: Text("The app's location services is having trouble determining your location."),
                                                dismissButton: .default(Text("OK")))
}


