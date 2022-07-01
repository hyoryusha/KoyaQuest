//
//  Constants.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/30.
//

import Foundation
import SpriteKit

enum ChallengeState {
    case idle, active, paused
}

enum GameState {
    case initial, idle, active, complete, exited
}
enum Level: String, CaseIterable, Identifiable {
    var id: String { UUID().uuidString }
    case
    myoo = "Wisdom King",
    mstr = "Master",
    adept = "Adept",
    journeyman = "Journeyman",
    novice = "Novice"
}

enum Proximity: String { // messages used to help user navigate to target
    case cooler     = "You're getting cooler..."
    case warmer     = "You're getting warmer!"
    case unknown    = "Cannot determine distance."
    case tooFar     = "You are very far away."
    case hit        = "Let's confirm..."
}

enum Radii {
    static let TZRadius   = 35.0
    static let LMRadius   = 10.0
}

enum LMPix {// image for the main menu
    static let daimon           = "daimon"
    static let konponDaito      = "konpondaito_at_angle"
    static let kondo            = "kondo"
    static let miedo            = "miedo"
    static let kongobuji        = "kongobuji"
    static let rokkakuKyozo     = "rokkaku_kyozo"
    static let asekaki          = "asekaki"
    static let fudodo           = "fudodo"
    static let kenshin          = "kenshin"
    static let mizukoJizo       = "sanhei_mizuko_jizo"
    static let okunoinSando     = "okunoin_sando"
    static let tamagawa         = "mizumuke_jizo"
    static let nestorian        = "nestorian"
    static let kazutoriJizo     = "kazutori_jizo"
    static let mitsuhideHaka    = "mitsuhide"
    static let danjoGaran       = "danjo_garan"
    static let nyonindo         = "nyonindo"
    static let hasuike          = "hasuike"
    static let banryutei        = "banryutei"
    static let torodo           = "torodo"
    static let saito            = "saito"
    static let sammaiin         = "sanmai_in"
    static let miyashiro        = "miyashiro"
    static let sannoin          = "sanno-in"
    static let tokugawake       = "tokugawake"
    // static let choishimichi = "choishimichi"
}

enum ChallengePix {// image for individual challenges
    static let koyakun    = "koyakun_preview"
    static let daimon     = "daimon"
    static let choishi    = "choishimichi"
    static let vajra      = "sanko_preview"
    static let saigyo     = "saigyo_portrait"
    static let gorinto    = "gorinto_preview"
    static let kenshin    = "Uesugi Kenshin"
    static let mizumuke   = "mizumuke_jizo"
    static let kukai      = "kukai_2"
    static let nyonindo   = "nyonindo_preview"
    static let sugatami   = "asekakijizo.jpg"
    static let numbers    = "purple_curtain"
    static let shoguns    = "kamon"

}

enum ChallengeNames {
    static let daimon     = "Daimon Challenge"
    static let koyakun    = "Koya-kun Catch"
    static let saigyo     = "Saigyō's Cherry Tree"
    static let kukai      = "Find Kūkai"
    static let choishi    = "Chōishi Challenge"
    static let vajra      = "Vajra Challenge"
    static let gorinto    = "Gorintō Challenge"
    static let kenshin    = "Find the Ghost"
    static let mizumuke   = "Mizumuke Jizō Challenge"
    static let nyonindo   = "Nyonindō Challenge"
    static let sugatami   = "Sugatami Well Challenge"
    static let numbers    = "Mt. Kōya by the Numbers"
    static let shoguns    = "Three Shogun Challenge"
}

enum RatingsConstants {
    public static let maxRating = Int(5)
    public static let onImage = "star.fill"
    public static let offImage = "star"
}

enum ActiveSheet: Identifiable {
    case first, second, none
    var id: Int {
        hashValue
    }
}

enum FeedbackType {
    case bonus, challenge
}

struct FeedbackConstants {
    static let feedbackImages = ["fb_oku-no-in",
                                 "fb_bronze_komainu",
                                 "fb_lone_priest",
                                 "fb_six_priests",
                                 "fb_shojingu_snow",
                                 "fb_daito_interior",
                                 "fb_gobyo_bridge",
                                 "fb_four_lanterns"]

    static let positiveFeedbackStrings = ["Excellent!", "Well Done!", "Good Job!", "Success!"]
    static let negativeFeedbackStrings = ["Too Bad", "Better Luck Next Time", "Can't Win 'em All", "Sorry"]

    static func randomImage() -> String {
        let index = Int.random(in: 0...FeedbackConstants.feedbackImages.count - 1)
        return FeedbackConstants.feedbackImages[index]
    }

    //    static func getFeedbackString(success: Bool) -> String {
    //        if success {
    //            let index = Int.random(in: 0...positiveFeedbackStrings.count - 1)
    //            return positiveFeedbackStrings[index]
    //        } else {
    //            let index = Int.random(in: 0...negativeFeedbackStrings.count - 1)
    //            return negativeFeedbackStrings[index]
    //        }
    //    }

    static func getFeedbackString(type: FeedbackType, success: Bool) -> String {
        if type == .challenge {
            if success {
                let index = Int.random(in: 0...positiveFeedbackStrings.count - 1)
                return positiveFeedbackStrings[index]
            } else {
                let index = Int.random(in: 0...negativeFeedbackStrings.count - 1)
                return negativeFeedbackStrings[index]
            }
        } else {
            if success {
                return "Correct!"
            } else {
                return "Zannen!"
            }
        }
    }
    
}

struct D2R2D {
    static  func degreesToRadians(_ number: Double) -> Double {
        return number * .pi / 180
    }

    static func radiansToDegrees(_ number: Double) -> Double {
        return number * 180 / .pi
    }
}
struct KenshinStage {
    enum Stage {
        case first, second
    }
}
