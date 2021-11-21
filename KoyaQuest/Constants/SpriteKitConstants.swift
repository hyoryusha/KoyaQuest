//
//  SpriteKitConstants.swift
//  SpriteKitConstants
//
//  Created by Kevin K Collins on 2021/04/02.
//

import SpriteKit

// MARK: - CHECK ANSWER BUTTON
class CheckAnswerButton: SKSpriteNode {
    init() {
        super.init(texture: nil, color: SKColor.orange, size: SKButtonSize.checkButton)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BigLabel: SKLabelNode {

    override init() {
        super.init()
    }

    init(fontNamed: String = SKFont.bold, text: String!, fontSize: CGFloat, fontColor: UIColor ) {
        super.init(fontNamed: fontNamed)
        self.text = text
        self.fontSize = fontSize
        self.fontColor = fontColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SuccessLabel: SKLabelNode {
    override init() {
        super.init()
    }
    init(fontNamed: String = SKFont.Condensed.bold,
         text: String!,
         fontSize: CGFloat = CGFloat(30),
         fontColor: UIColor = SKColor.green) {
        super.init(fontNamed: fontNamed)
        self.text = text
        self.fontSize = fontSize
        self.fontColor = fontColor
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FailLabel: SKLabelNode {
    override init() {
        super.init()
    }
    init(fontNamed: String = SKFont.Condensed.bold,
         text: String!,
         fontSize: CGFloat = CGFloat(30),
         fontColor: UIColor = SKColor.red) {
        super.init(fontNamed: fontNamed)
        self.text = text
        self.fontSize = fontSize
        self.fontColor = fontColor
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ButtonLabel: SKLabelNode {
    override init() {
        super.init()
    }
    init(fontNamed: String = SKFont.Condensed.bold,
         text: String!,
         fontSize: CGFloat = CGFloat(20),
         fontColor: UIColor = UIColor(.white),
         position: CGPoint = CGPoint(x: 0, y: -8) ) {
        super.init(fontNamed: fontNamed)
        self.text = text
        self.fontSize = fontSize
        self.fontColor = fontColor
        self.position = position
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Scorelabel: SKLabelNode {
    override init() {
        super.init()
    }
    init(fontNamed: String = SKFont.medium,
         text: String!,
         fontSize: CGFloat = CGFloat(24),
         fontColor: UIColor  ) {
        super.init(fontNamed: fontNamed)
        self.text = text
        self.fontSize = fontSize
        self.fontColor = fontColor
        self.position = position
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BasicLabel: SKLabelNode {
    override init() {
        super.init()
    }
    init(fontNamed: String = SKFont.Condensed.black,
         text: String!, fontSize: CGFloat = CGFloat(20),
         fontColor: UIColor) {
        super.init(fontNamed: fontNamed)
        self.text = text
        self.fontSize = fontSize
        self.fontColor = fontColor
        self.position = position
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class OrangeButton: SKSpriteNode {

    init() {
        // let buttonSize = CGSize(width: 140, height: 34 )
        super.init(texture: nil, color: SKColor.orange, size: SKButtonSize.basic )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GrayButton: SKSpriteNode {

    init() {
        // let buttonSize = CGSize(width: 140, height: 34 )
        super.init(texture: nil, color: UIColor.gray, size: SKButtonSize.basic )

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

func animateLabelScale(label: SKLabelNode) {

    let scaleUp = SKAction.scale(to: 1.1, duration: 0.5)
    let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
    let sequence = SKAction.sequence([scaleUp, scaleDown])
    label.run(SKAction.repeatForever(sequence))
}
func animateLabelFade(label: SKLabelNode) {
    let fadeOut = SKAction.fadeOut(withDuration: 1.5)
    let pause = SKAction.pause()
    let fadeIn = SKAction.fadeIn(withDuration: 1.5)
    let sequence = SKAction.sequence([fadeOut, pause, fadeIn])
    label.run(SKAction.repeatForever(sequence))
}

enum SKButtonSize {
    public static let basic: CGSize = CGSize(width: 140, height: 34)
    public static let small: CGSize = CGSize(width: 80, height: 24)
    public static let checkButton: CGSize = CGSize(width: 220, height: 44)
}

enum SKFont {
    enum Condensed {

        public static let bold: String              = "HelveticaNeue-CondensedBold"
        public static let black: String             = "HelveticaNeue-CondensedBlack"
    }
    public static let regular: String           = "HelveticaNeue"
    public static let medium: String            = "HelveticaNeue-Medium"
    public static let italic: String            = "HelveticaNeue-Italic"
    public static let bold: String              = "HelveticaNeue-Bold"
    public static let light: String             = "HelveticaNeue-UltraLight"
    public static let lightItalic: String       = "HelveticaNeue-LightItalic"
    public static let mediumItalic: String      = "HelveticaNeue-MediumItalic"
    public static let heavyItalic: String       = "HelveticaNeue-HeavyItalic"
    public static let heavy: String             = "HelveticaNeue-CondensedBlack"
    public static let kanji: String             = "HiraginoSans-W3"

}

/*
 AVAILABLE JAPANESE FONTS
 HiraMaruProN-W4
 HiraMinProN-W3
 HiraMinProN-W6
 HiraginoSans-W3
 HiraginoSans-W6
 HiraginoSans-W7
 */

enum SKColor { // to be discontinued?
    public static let black     = UIColor(red: 0.098, green: 0.098, blue: 0.098, alpha: 1.0)
    public static let purple    = UIColor(red: 0.118, green: 0.125, blue: 0.208, alpha: 1.0)
    public static let orange    = UIColor(red: 0.898, green: 0.498, blue: 0.165, alpha: 1.0)
    public static let red       = UIColor(red: 0.675, green: 0.271, blue: 0.098, alpha: 1.0)
    // public static let green     = UIColor(red: 0.090, green: 0.302, blue: 0.227, alpha: 1.0)
    public static let green     = UIColor.systemGreen
    public static let clear     = UIColor.clear
}

// converts degrees to radians for rotation action // this is used in other files of the complete app
func degToRad(degree: Double) -> CGFloat {
    return CGFloat(Double(degree) / 180.0 * .pi)
}
