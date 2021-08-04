//
//  UserDefaults+extension.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/07/16.
//

import Foundation
extension UserDefaults {

    func valueIsTrue(forKey key: String) -> Bool {
        return bool(forKey: key)
    }

}
