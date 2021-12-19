//
//  LocationManagerProtocol.swift
//  KoyaQuestTests
//
//  Created by Kevin K Collins on 2021/12/02.
//

import CoreLocation

protocol LocationManagerProtocol {
        func isLocationServicesEnabled() -> Bool
        func verifyGPSAuthorization()
}

