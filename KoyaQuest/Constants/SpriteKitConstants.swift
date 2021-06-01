//
//  SpriteKitConstants.swift
//  SpriteKitConstants
//
//  Created by Kevin K Collins on 2021/04/02.
//

import SpriteKit

class BigLabel : SKLabelNode {
    
    override init() {
        super.init()
    }
    init(fontNamed: String = SKFont.bold, text: String!, fontSize: CGFloat , fontColor: UIColor ) {
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
    init(fontNamed: String = SKFont.Condensed.bold, text: String!, fontSize: CGFloat = CGFloat(30) , fontColor: UIColor = SKColor.green) {
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
    init(fontNamed: String = SKFont.Condensed.bold, text: String!, fontSize: CGFloat = CGFloat(30) , fontColor: UIColor = SKColor.red) {
        super.init(fontNamed: fontNamed)
        self.text = text
        self.fontSize = fontSize
        self.fontColor = fontColor
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ButtonLabel : SKLabelNode {
    override init() {
        super.init()
    }
    init(fontNamed: String = SKFont.Condensed.bold, text: String!, fontSize: CGFloat = CGFloat(20) , fontColor: UIColor = UIColor(.white), position: CGPoint = CGPoint(x: 0, y: -8) ) {
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

class Scorelabel : SKLabelNode {
    override init() {
        super.init()
    }
    init(fontNamed: String = SKFont.medium, text: String!, fontSize: CGFloat = CGFloat(24) , fontColor: UIColor  ) {
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

class BasicLabel : SKLabelNode {
    override init() {
        super.init()
    }
    init(fontNamed: String = SKFont.Condensed.regular, text: String!, fontSize: CGFloat = CGFloat(20) , fontColor: UIColor  ) {
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


class OrangeButton : SKSpriteNode {
    
    init() {
        //let buttonSize = CGSize(width: 140, height: 34 )
        super.init(texture: nil, color: SKColor.orange, size: SKButtonSize.basic )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GrayButton : SKSpriteNode {
    
    init() {
        //let buttonSize = CGSize(width: 140, height: 34 )
        
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
}



enum SKFont {
    enum Condensed {
        public static let regular: String           = "AvenirNextCondensed-Regular"
        public static let medium: String            = "AvenirNextCondensed-Medium"
        public static let italic: String            = "AvenirNextCondensed-Italic"
        public static let bold: String              = "AvenirNextCondensed-Bold"
        public static let light: String             = "AvenirNextCondensed-UltraLight"
        public static let lightItalic: String       = "AvenirNextCondensed-UltraLightItalic"
        public static let mediumItalic: String      = "AvenirNextCondensed-MediumItalic"
    }
    public static let regular: String           = "AvenirNext-Regular"
    public static let medium: String            = "AvenirNext-Medium"
    public static let italic: String            = "AvenirNext-Italic"
    public static let bold: String              = "AvenirNext-Bold"
    public static let light: String             = "AvenirNext-UltraLight"
    public static let lightItalic: String       = "AvenirNext-UltraLightItalic"
    public static let mediumItalic: String      = "AvenirNext-MediumItalic"
    //heavy is too heavy
    public static let heavyItalic: String       = "AvenirNext-HeavyItalic"
    public static let heavy: String             = "AvenirNext-Heavy"
 
}
enum SKColor {
    public static let black     = UIColor(red: 0.098, green: 0.098, blue: 0.098, alpha: 1.0)
    public static let purple    = UIColor(red: 0.118, green: 0.125, blue: 0.208, alpha: 1.0)
    public static let orange    = UIColor(red: 0.898, green: 0.498, blue: 0.165, alpha: 1.0)
    public static let red       = UIColor(red: 0.675, green: 0.271, blue: 0.098, alpha: 1.0)
    //public static let green     = UIColor(red: 0.090, green: 0.302, blue: 0.227, alpha: 1.0)
    public static let green     = UIColor.systemGreen
    public static let clear     = UIColor.clear
}

