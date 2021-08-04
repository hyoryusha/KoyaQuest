//
//  BonusQuestion.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/15.
//

import SwiftUI

enum BonusState {
    case locked, active, completed
}

struct Bonus: Identifiable, Equatable {

    var id: Int
    var question: String
    var choices: [Answers]

    static func == (lhs: Bonus, rhs: Bonus) -> Bool {
        return lhs.id == rhs.id
    }

    static let mockBonus = Bonus(
        id: 0,
        question: "Placeholder question",
        choices: [
            Answers(text: "Placeholder Wrong Answer", correct: false),
            Answers(text: "Placeholder Correct Answer", correct: true),
            Answers(text: "Placeholder Wrong Answer", correct: false),
            Answers(text: "Placeholder Wrong Answer", correct: false)
        ]
    )

     static let daimonBonus = Bonus(
        id: 1,
        question: "In what year was the monastery at Mt. Kōya founded by the priest known as Kūkai?",
         choices: [
             Answers(text: "794 AD", correct: false),
             Answers(text: "817 AD", correct: true),
             Answers(text: "1011 AD", correct: false),
             Answers(text: "1185 AD", correct: false)
         ]
    )

    static let kukaiBonus = Bonus(
        id: 2,
        // swiftlint:disable:next line_length
        question: "In which of the following buildings is the famous portrait of Kūkai housed and concealed from the view of all but the head priest of Mt. Kōya?",
        choices: [
            Answers(text: "Miedō", correct: true),
            Answers(text: "Kondō", correct: false),
            Answers(text: "Fudōdō", correct: false),
            Answers(text: "Konpon Daitō", correct: false)
            ]
        )

    static let shogunBonus = Bonus(
        id: 3,
        question: "Whose family crest has Kongōbuji Temple adopted as one of its two emblems?",
        choices: [
            Answers(text: "Taira no Kiyomori", correct: false),
            Answers(text: "Ōda Nobunaga", correct: false),
            Answers(text: "Toyotomi Hideyoshi", correct: true),
            Answers(text: "Tokugawa Ieyasu", correct: false)
            ]
    )

    static let choishiBonus = Bonus(
        id: 4,
        question: "Mt. Kōya is the headquarters for which Buddhist sect?",
        choices: [
            Answers(text: "Shingon", correct: true),
            Answers(text: "Jōdō", correct: false),
            Answers(text: "Tendai", correct: false),
            Answers(text: "Zen", correct: false)
            ]
        )

    static let mizumukeBonus = Bonus(
        id: 5,
        question: "The founder of Mt. Kōya is also known by which of these posthumous titles?",
        choices: [
            Answers(text: "Dengyō-daishi", correct: false),
            Answers(text: "Kōbō-daishi", correct: true),
            Answers(text: "Jaku-daishi", correct: false),
            Answers(text: "Shugyō-daishi", correct: false)
            ]
        )

    static let numbersBonus = Bonus(
        id: 6,
        question: "Did you notice the big coffee cup? What three letters were on it?",
        choices: [
            Answers(text: "UCA", correct: false),
            Answers(text: "CUP", correct: false),
            Answers(text: "UCC", correct: true),
            Answers(text: "JCC", correct: false)
            ]
        )

    static let bonusQuestions: [Bonus] = [daimonBonus,
                                          kukaiBonus,
                                          shogunBonus,
                                          choishiBonus,
                                          mizumukeBonus,
                                          numbersBonus
    ]
}

struct Answers {
    var text: String
    var correct: Bool
}
/*
 static let ???Bonus = Bonus(id: ???,
                question: "What famous waka poet lived at Mt. Kōya for nearly 30 years?",
                choices: [
                     Answers(text: "Sōgi", correct: false),
                     Answers(text: "Nōin", correct: false),
                     Answers(text: "Sosei", correct: false),
                     Answers(text: "Saigyō", correct: true)
                    ]
             )
         )
 */
