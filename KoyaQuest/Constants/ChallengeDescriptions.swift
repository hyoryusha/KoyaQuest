//
//  Details.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/02/03.
// swiftlint:disable line_length

import Foundation
struct ChallengeDescription {
    var header: String
    var teaser: String
    var synopsis: String
    var instructions: String = "Your Challenge"
    var extra: String
    var image: String

    init(header: String, teaser: String, synopsis: String, instructions: String, extra: String, image: String) {
        self.header = header
        self.teaser = teaser
        self.synopsis = synopsis
        self.instructions = instructions
        self.extra = extra
        self.image = image
    }
}

// MARK: - KOYAKUN CATCH -
let koyakunChallengeHeader: String = "Catch Koya-kun"
let koyakunChallengeTeaser: String = "How many dancing mascots can you catch?"
let koyakunChallengeSynopsis: String = "In this challenge, you will be surrounded by floating images of \"Koya-kun,\"the cute character mascot of Mt. Kōya.\nYour task is to try to \"catch\" as many as you can in 60 seconds by moving your device within 20 centimeters of the image before it fades away."
let koyakunChallengeInstructions: String = "Koya-kun is the official mascot of Mt. Kōya. In this challenge, you will be surrounded by floating images of this cute little character.\nYour task is to try to \"catch\" each Koya-kun by moving your device within 20 centimeters of the image before it fades away. (You don't need to tap the screen; just move it close.)\nHow many can you catch in 60 seconds?"
let koyakunChallengeExtra: String = "Scan in all directions and wait for the images to appear.\nBe mindful of others and any obstacles as you chase after points!"
let koyakunChallengeDescription = ChallengeDescription(header: koyakunChallengeHeader, teaser: koyakunChallengeTeaser, synopsis: koyakunChallengeSynopsis, instructions: koyakunChallengeInstructions, extra: koyakunChallengeExtra, image: ChallengePix.koyakun)

// MARK: - DAIMON CHALLENGE -
let daimonChallengeHeader: String = "Daimon Challenge"
let daimonChallengeTeaser: String = "Find the difference between the real Daimon and an altered image."
let daimonChallengeSynopsis: String = "This challenge tests your powers of observation as you compare an altered photo of the Daimon, or \"Great Gate,\" with the actual object."
let daimonChallengeInstructions: String = "The following challenge asks you to compare the actual Daimon with an altered photo.\nIn the next screen, you will see a photo of the Daimon. Examine it closely. (You may zoom and pan around.) Try to spot the difference between the photo and the real Daimon.\nWhen you think you've found it, tap \"Ready to Solve.\" Good luck!"
let daimonChallengeExtra = ""
let daimonChallengeDescription = ChallengeDescription(header: daimonChallengeHeader, teaser: daimonChallengeTeaser, synopsis: daimonChallengeSynopsis, instructions: daimonChallengeInstructions, extra: daimonChallengeExtra, image: ChallengePix.daimon)

// MARK: - CHOISHI CHALLENGE
let choishiChallengeHeader: String = "Chōishi Challenge"
let choishiChallengeTeaser: String = "Decipher the number of the stone column."
let choishiChallengeSynopsis: String = "A 22-kilometer trail runs from the foot of Mt. Kōya to the Great Pagoda (Konpon-daitō) located at the center of the Danjō Garan area. This route, known as the Chōishi-michi, is the same followed in ancient times by both Kūkai and the many thousands of pilgrims, including emperors, who made the journey to the sacred mountain.\nThe route is marked by 180 stone pillars known as \"chōishi\" 町石. Another 36 pillars measure the distance to the mausoleum of Kōbō-daishi deep inside Oku-no-in.\nIn this challenge, you will be directed to one of these stone markers and asked to identify its number which will be carved into the stone (in Japanese)."
let choishiChallengeInstructions: String = "From the foot of the mountain, the 22-kilometer route to Mt. Kōya is marked by 180 stone pillars known as \"chōishi\" 町石. Each is numbered starting from their origin point at the Great Pagoda (Konpon-daitō) located at the center of the Danjō Garan area. Another 36 pillars measure the distance to the mausoleum of Kōbō-daishi deep inside Oku-no-in.\nYour next challenge is an easy one. Look for the nearest chōishi. Find its number. It will be carved into the stone (in Japanese)."
let choishiChallengeExtra: String = ""
let choishiChallengeDescription = ChallengeDescription(header: choishiChallengeHeader, teaser: choishiChallengeTeaser, synopsis: choishiChallengeSynopsis, instructions: choishiChallengeInstructions, extra: choishiChallengeExtra, image: ChallengePix.choishi)

// MARK: - VAJRA CHALLENGE -
let vajraChallengeHeader: String = "Vajra Challenge"
let vajraChallengeTeaser: String = "Find the miraculous ritual sceptre!"
let vajraChallengeSynopsis: String = "According to legend, as Kūkai was leaving China to return to Japan in 806, he threw a vajra (depicted above) into the air in the direction of Japan with the prayer that it would guide him to the place where he was meant to establish his monastery. It landed, in the area of Mt. Kōya known as the Danjō-garan.\nIn this challenge, you will, like Kūkai himself, try to locate the spot where his vajra is said to have landed."

let vajraChallengeInstructions: String = "The object depicted here is a ritual implement known as a\"vajra\" (kongō 金剛 in Japanese).\nThe word vajra can mean both \"thunderbolt\" and \"diamond.\" (The three-pronged type you see here is called a sankosho 三鈷杵 in Japanese.)\nThe diamond is of great importance to the Shingon Buddhism practiced at Mt. Kōya and the reason Kūkai chose the name Kongōbuji, or Diamond Peak Temple, as the name for his monastic complex. Most portraits of Kūkai show him with a vajra in his right hand.\nAccording to legend, as Kūkai was leaving China to return to Japan in 806, he threw a vajra into the air in the direction of Japan with the prayer that it would land in the place where he was meant to establish his monastery. Miraculously, the vajra flew more than 1,400 kilometers and landed here at Mt. Kōya, in the area known as the Danjō-garan.\nIn this next challenge, you will, like the Great Master himself, try to locate the spot where his vajra is said to have landed.\nUse your iPhone to scan the area where you think the vajra might be. When you are close, it will appear. Line up the green sight (☉) and tap to \"capture\" the vajra and earn points."
let vajraChallengeExtra: String = ""
let vajraChallengeDescription = ChallengeDescription( header: vajraChallengeHeader, teaser: vajraChallengeTeaser, synopsis: vajraChallengeSynopsis, instructions: vajraChallengeInstructions, extra: vajraChallengeExtra, image: ChallengePix.vajra)

// MARK: - SAIGYO ZAKURA
let saigyoChallegeHeader = "Saigyō Cherry"
let saigyoChallengeTeaser = "Complete a famous poem"
let saigyoChallengeSynopsis: String = "Mt. Kōya was home to one of Japan's greatest poets, a priest named Saigyō 西行 (1118 -1190).\nIn this challenge, which is loosely based on a traditional Japanese card game called \"uta-garuta,\" you will be given the first three lines of one of his poems and asked to select the correct final pair of lines from among four options."
let saigyoChallengeInstructions = "The poet Saigyō 西行 (1118 -1190) is one of Japan's most admired and influential literary figures\nThough born into a military family, he became a Buddhist priest at the age of 22. After traveling through the northern-most areas of Japan, he came to Mt. Kōya in 1150 and lived here for most of the next thirty years.\nWhile he composed on various topics, Saigyō today is best remembered for his poems celebrating the ephemeral beauty of cherry blossoms.\nHere at the Danjō-garan, there are two cherry trees which are believed to have stood before the temple where Saigyō resided."
let saigyoChallengeExtra = "Your next challenge is to complete one of Saigyō's most famous poems.\nAt the top-right side of the screen, you will see, in both the original Japanese and an English translation, the first three lines of the poem. Below are four cards with possible conclusions to the poem. If you don't know, try to decide which one you think best completes the poem. Drag the card to the top-left and check. Keep trying until you get it."
let saigyoChallengeDescription = ChallengeDescription(header: saigyoChallegeHeader, teaser: saigyoChallengeTeaser, synopsis: saigyoChallengeSynopsis, instructions: saigyoChallengeInstructions, extra: saigyoChallengeExtra, image: ChallengePix.saigyo)

// MARK: - GORINTO CHALLENGE
let gorintoChallengeHeader = "Gorintō Challenge"
let gorintoChallengeTeaser = "Decode the Meaning of the Five-tiered Stone pillars."
let gorintoChallengeSynopsis = "Each ring of the \"five-ringed towers,\" or \"Gorintō\" 五輪塔, found throughout the Oku-no-in cemetery symbolizes one of the five elements: earth, wind (or air), fire, water and space and are marked with the corresponding Sanskrit letter.\nIn this challenge, you must identify the element associated with each section."
let gorintoChallengeInstructions = "Throughout Oku-no-in, we can see thousands of stone monuments known as \"Gorintō\" 五輪塔. The name means \"five-ringed tower.\" Each section symbolizes one of the five elements: earth, wind (or air), fire, water and space. They are brought together in the gorintō to represent consciousness through which all phenomena are produced."
let gorintoChallengeExtra = "In this next challenge, you will be asked to guess which of the sections represents which of the five elements.\nAnswer by dragging each of the five labels to the appropriate place alongside the diagram in the next screen. Good luck!"
let gorintoChallengeDescription = ChallengeDescription(header: gorintoChallengeHeader, teaser: gorintoChallengeTeaser, synopsis: gorintoChallengeSynopsis, instructions: gorintoChallengeInstructions, extra: gorintoChallengeExtra, image: ChallengePix.gorinto)

// MARK: - KENSHIN'S GHOST
let kenshinChallengeHeader = "Two Feudal Warlords"
let kenshinChallengeTeaser = "The ghost of Uesugi Kenshin has a mission for you!"
let kenshinChallengeSynopsis = "Many might disagree, but, in our opinion, no visit to an ancient cemetery would be complete without an encounter with a ghost.\nIn this spooky (?) challenge, you must seek out the resting place of Uesugi Kenshin 上杉謙信 (1530 -1578), one of Japan's most famous samurai. He has an important mission for you!"
let kenshinChallengeInstructions = "Uesugi Kenshin 上杉謙信 (1530 -1578) is one of many famous Japanese warriors with a mortuary shrine here among the many thousands at Oku-no-in. Admired for his skill and integrity, he is said to have wept when one of his former enemies died.\nYour next, two-part mission is a somewhat spooky one. First, you must find the ghost  of Uesgi Kenshin. (Where might that be?) He has a message for you!\nAs for the second part of your mission...? Well, we can't tell you now! 👻"
let kenshinChallengeExtra = ""
let kenshinChallengeDescription = ChallengeDescription(header: kenshinChallengeHeader, teaser: kenshinChallengeTeaser, synopsis: kenshinChallengeSynopsis, instructions: kenshinChallengeInstructions, extra: kenshinChallengeExtra, image: ChallengePix.kenshin)

// MARK: - MIZUMUKE JIZO CHALLENGE
let mizumukeChallengeHeader = "Mizumuke Jizō"
let mizumukeChallengeTeaser = "Rearrange the images to match the statues."
let mizumukeChallengeSynopsis = "In another test of your powers of observation, you will be asked to match three silhouettes with three of the statues standing alongside the Tamagawa River and to place them in the correct left-to-right order."
let mizumukeChallengeInstructions = "This next challenge will again test your powers of observation as you will be presented with the silhouettes of three of the statues found alongside the Tamagawa River. Your task is to match them with three of the actual statues and place them in their correct order (as you face them)."
let mizumukeChallengeExtra = "First, try to find the three statues. Then spin the picker wheels to place them in the correct order. You can check as many times as you like, but be careful, the more attempts you need, the lower your score will be!"
let mizumukeChallengeDescription = ChallengeDescription(header: mizumukeChallengeHeader, teaser: mizumukeChallengeTeaser, synopsis: mizumukeChallengeSynopsis, instructions: mizumukeChallengeInstructions, extra: mizumukeChallengeExtra, image: ChallengePix.mizumuke)

// MARK: - KUKAI CHALLENGE
let kukaiChallengeHeader: String = "Find Kūkai"
let kukaiChallengeTeaser: String = "Find the Portrait of the Patriarch."
let kukaiChallengeSynopsis: String = "This challenge is an easy one. Simply find one of the many pictures of Kūkai here at Mt. Kōya in the viewfinder of your device. That's all there is to it!"
let kukaiChallengeInstructions: String = "Kūkai, known posthumously as Kōbō-daishi, was the founder of the monastic complex at Mt. Kōya. In addition to his role as the Eighth Patriarch of Shingon Buddhism, Kūkai was also an accomplished poet, calligrapher, scholar and civil engineer.\nHis presence dominates Mt. Kōya. His resting place at Oku-no-in has become as important as the temple that he founded here more than 12 centuries ago.\nAs you explore the many points of interest and religious significance here at Mt. Kōya, you are likely to find many images of Kūkai based on a portrait painted by a member of the Japanese royal family."
let kukaiChallengeExtra: String = "Your next mission is an easy one. Simply find one of the many pictures of Kūkai here at Mt. Kōya. Go to the next screen of this challenge and point your camera at the picture. That's all there is to it!"
let kukaiChallengeDescription = ChallengeDescription(header: kukaiChallengeHeader, teaser: kukaiChallengeTeaser, synopsis: kukaiChallengeSynopsis, instructions: kukaiChallengeInstructions, extra: kukaiChallengeExtra, image: ChallengePix.kukai)

// MARK: - NYONINDO CHALLENGE
    let nyonindoChallengeHeader: String = "Nyonindō Challenge"
    let nyonindoChallengeTeaser = "Defend the Sacred Precincts!"
    let nyonidoChallengeSynopsis = "The entrances to Mt. Kōya have traditionally been guarded by fierce, warrior-like figures known as Kongō Rikishi (a.k.a. Niō 仁王). These supernatural beings protect the sacred precincts from the enemies of Buddhism.\nThis challenge harnesses your video game skills as you try to prevent evil goblin-like demons from entering the gate. \nBut be careful! Women, who were once prohibited from entering Mt. Kōya, are now welcome here. So make sure you don't impede the progress of any woman on her holy pilgrimage."
    let nyonindoChallengeInstructions: String = "For most of its history, Mt. Kōya was off limits to women, who could only come as far as one of its seven gates, which -- as we have seen -- are often protected by guardian deities known as Kongō Rikishi. \nIn this challenge, you will play an arcade-type game in which you control the left-right movements of one of these guardians as he tries to ward off an attack of evil \"oni,\" or devils. You will score points for every devil you block, but you will lose points when they slip by and make it inside the gate.\nTo make things a little more complicated, female pilgrims will make their way slowly along the path. Since women are now allowed inside Mt. Kōya, you MUST NOT block one of these pious pilgrims! If you block a pilgrim, the round will end."
    let nyonindoChallengeExtra: String = "You can control the Rikishi by tilting your device in the direction you want him to move. He can only go left or right. You can play as many as three 40-second rounds. Your highest score will count."
let nyonindoChallengeDescription = ChallengeDescription(header: nyonindoChallengeHeader, teaser: nyonindoChallengeTeaser, synopsis: nyonidoChallengeSynopsis, instructions: nyonindoChallengeInstructions, extra: nyonindoChallengeExtra, image: ChallengePix.nyonindo)

//// MARK: - SUGATAMI CHALLENGE
//let sugatamiChallengeHeader: String = "The Mystery of the Well"
//let sugatamiChallengeTeaser: String = "Can you face your destiny in the waters of a mysterious well?"
//let nyonindoChallengeSynopsis: String = "Still under construction!"
//let sugatamiChallengeInstructions: String = "instructions go here"
//let sugatamiChallengeExtra = ""
//let sugatamiChallengeDescription = ChallengeDescription(header: sugatamiChallengeHeader, teaser: sugatamiChallengeTeaser, synopsis: nyonindoChallengeSynopsis, instructions: sugatamiChallengeInstructions, extra: sugatamiChallengeExtra, image: ChallengePix.sugatami)

// MARK: - Numbers CHALLENGE
let numbersChallengeHeader: String = "Mt. Kōya by the Numbers"
let numbersChallengeTeaser: String = "Test your memory with facts about Mt. Kōya."
let numbersChallengeSynopsis: String = "Based on the memory game \"Concentration\", this challenge tests your memory and knoweldge of some facts about Mt. Kōya. Tap on tiles to turn them over in pairs. If the information on the pair is a match, you will earn points. And there are bonus points for completing all matches before the timer runs out."
let numbersChallengeInstructions: String = "This game requires some knowledge about Mt. Kōya and some good short-memory skills as you will try to match pairs of tiles. (Think of the card game \"Concentration\".)"
let numbersChallengeExtra = "You will see 12 tiles representing six pairs. Tap on pairs to reveal the information on the other side. If the pair matches, you earn two points. If you match all the pairs before 60 seconds, you will earn 20 points."
let numbersChallengeDescription = ChallengeDescription(header: numbersChallengeHeader, teaser: numbersChallengeTeaser, synopsis: numbersChallengeSynopsis, instructions: numbersChallengeInstructions, extra: numbersChallengeExtra, image: ChallengePix.numbers)

// MARK: - Shoguns CHALLENGE
let shogunsChallengeHeader: String = "Three Shogun and a Cuckoo"
let shogunsChallengeTeaser: String = "Can you complete the poems that describe Japan's three most powerful warlords?"
let shogunsChallengeSynopsis: String = "The personalities of three important Japanese warlords are often contrasted according to the way each is believed to have completed an imaginary haiku about a cuckoo that refuses to sing.\nThis challenge asks you to match the warlord with his supposed reaction to such a uncooperative bird."
let shogunsChallengeInstructions: String = "Three of the most famous military leaders with monuments here at Mt. Kōya are Oda Nobunaga 織田信長, Toyotomi Hideyoshi 豊臣秀吉 and Tokugawa Ieyasu 徳川家康.\n The various personalities and military styles of these men is sometimes explained in the different ways that each is assumed to have completed a haiku that begins, \"If the cuckoo will not sing...\""
let shogunsChallengeExtra = "You will see each of these three warlords along with the three phrases that each (allegedly) used to complete the poem. Drag each phrase next to the man you think would have said it."
let shogunsChallengeDescription = ChallengeDescription(header: shogunsChallengeHeader, teaser: shogunsChallengeTeaser, synopsis: shogunsChallengeSynopsis, instructions: shogunsChallengeInstructions, extra: shogunsChallengeExtra, image: ChallengePix.shoguns)
