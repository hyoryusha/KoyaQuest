//
//  NyonindoGameScene.swift
//  NyonindoChallengeSwiftUI
//
//  Created by Kevin K Collins on 2021/04/22.
//
import SwiftUI
import SpriteKit
import CoreMotion

class NyonindoGameScene: SKScene  {
    var viewModel : NyonindoChallengeViewModel?

    let startButton = SKSpriteNode(color: .systemOrange, size: CGSize(width: 252, height: 66))
    //var background = SKSpriteNode(imageNamed: "nyonindo_challenge_bg")
    let background = SKSpriteNode(imageNamed: "nyonindo_bg")
    var selectedNode = SKSpriteNode()
    var invasion = 0
    var capture = 0
    var counter = 0
    var points = 0
    var attempts = 0
    var rikishiHitPilgrim = false
    var counterTimer = Timer()
    var counterStartValue = 40 // seconds
    var gameIsOver = false
    let directionsLabel = SKLabelNode(text: "")
    let scoreLabel = SKLabelNode(text: "0")
    let pilgrimLabel = SKLabelNode(text: "(because you hit a pilgrim)")
    let timerLabel = SKLabelNode(text: "-- secs remaining")
    let roundOver = SKLabelNode(text: "Round Over!")
    let pointsEarnedLabel = SKLabelNode(text: "Points this round:")
    let motionManager = CMMotionManager()
    let fadeOut = SKAction.fadeOut(withDuration: 3)
    var startButtonLabelText: String = ""
    
    let rikishi = Rikishi()
    let gate = SKSpriteNode(imageNamed: "daimon_illustration")
    let choishi = SKSpriteNode(imageNamed: "choishi_on_path")
    private var oni = SKSpriteNode()
    private var oniDancingFrames: [SKTexture] = []
    private var pilgrim = SKSpriteNode()
    private var pilgrimDancingFrames: [SKTexture] = []
    
        
//MARK: - DID MOVE TO VIEW
    override func didMove(to view: SKView) {
        
        UIApplication.shared.isIdleTimerDisabled = true
        motionManager.startAccelerometerUpdates()
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        counter = counterStartValue
        //startCounter()
    
        background.size = self.frame.size
        background.zPosition = -1
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
        addStartButton()

        //choishi.setScale(0.5)
        choishi.size = CGSize(width: frame.size.width * 0.17,
                              height: frame.size.height * 0.25)
        choishi.position = CGPoint(x: frame.size.width * 0.1, y: frame.size.height / 2 )
        choishi.zPosition = 3
        addChild(choishi)
        
// MARK: - Labels
        scoreLabel.fontName = SKFont.bold
        scoreLabel.fontSize = 28.0
        scoreLabel.fontColor = UIColor.black
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.minY)
        scoreLabel.zPosition = 100
        scoreLabel.text = "\(points)"
        
        pilgrimLabel.fontName = SKFont.bold
        pilgrimLabel.fontSize = 22.0
        pilgrimLabel.fontColor = UIColor.red
        pilgrimLabel.position = CGPoint(x: frame.midX, y: frame.midY + 120)
        pilgrimLabel.zPosition = 100

        timerLabel.fontName = SKFont.bold // AvenirNext-Bold
        timerLabel.fontSize = 20.0
        timerLabel.fontColor = UIColor.black
        timerLabel.position = CGPoint(x: frame.midX, y: frame.minY + 36)
        timerLabel.text = "00:00"
        addChild(timerLabel)
        
        directionsLabel.fontName = SKFont.medium // AvenirNext-Medium
        directionsLabel.fontSize = 15.0
        directionsLabel.fontColor = UIColor.black
        directionsLabel.position = CGPoint(x: frame.midX, y: frame.minY + 58)
        directionsLabel.text = "Tilt to move the guardian in that direction."
        addChild(directionsLabel)
        
// MARK: - Gate
        //gate.physicsBody = SKPhysicsBody(rectangleOf: gate.size)
        gate.physicsBody = SKPhysicsBody(circleOfRadius: gate.size.width * 0.25)
        gate.physicsBody?.isDynamic = false
        gate.physicsBody?.categoryBitMask = NyonindoPhysicsCategory.gate
        gate.physicsBody?.contactTestBitMask = NyonindoPhysicsCategory.oni
        gate.physicsBody?.collisionBitMask = NyonindoPhysicsCategory.none
        gate.physicsBody?.usesPreciseCollisionDetection = true
        gate.position = CGPoint(x: size.width * 0.5, y: size.height * 0.86)
        addChild(gate)
        
        

// MARK: - Rikishi
        rikishi.physicsBody = SKPhysicsBody(circleOfRadius: rikishi.size.width * 0.44)
        //rikishi.position = CGPoint(x: 10, y: size.height / 2 + (rikishi.size.height / 3 ))
        rikishi.position = CGPoint(x: size.width * 0.5, y: size.height / 2 + (rikishi.size.height / 3 ))
        rikishi.zPosition = 2
        rikishi.name = "rikishi"
        //rikishi.setScale(1.5)
        rikishi.physicsBody?.isDynamic = true
        rikishi.physicsBody?.categoryBitMask = NyonindoPhysicsCategory.rikishi
        rikishi.physicsBody?.contactTestBitMask = NyonindoPhysicsCategory.oni |  NyonindoPhysicsCategory.pilgrim
        rikishi.physicsBody?.collisionBitMask = NyonindoPhysicsCategory.none // this was changed from none to oni; why?
        rikishi.physicsBody?.usesPreciseCollisionDetection = true
        

        //view.showsPhysics = true


    } // end did move to view
    
    func startGameAction() {
        startCounter()
        let sequence = SKAction.sequence([SKAction.rotate(byAngle: degToRad(degree: -4.0), duration: 0.1),
                                          SKAction.rotate(byAngle: 0.0, duration: 0.1),
                                          SKAction.rotate(byAngle: degToRad(degree: 4.0), duration: 0.1)])
        rikishi.run(SKAction.repeatForever(sequence))
        self.addChild(rikishi)

        run(SKAction.repeatForever(
          SKAction.sequence([
            SKAction.run(spawnOni),
            SKAction.wait(forDuration: 0.75)
            ])
        ))
        
        run(SKAction.repeat(
          SKAction.sequence([
            SKAction.wait(forDuration: 10.0),
            SKAction.run(spawnPilgrim),
            SKAction.wait(forDuration: 6.0)
          ]), count: 6
        ))
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
    }

    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(0xFFFFFFFF))
    }
    func randomMinMax(min: CGFloat, max: CGFloat) -> CGFloat {
      return random() * (max - min) + min
    }
    
 //MARK: -ADD START BUTTON
    func addStartButton() {
        switch self.viewModel?.attempts {
        case 0:
            startButtonLabelText = "Start!"
        case 1:
            startButtonLabelText = "Try Again"
        case 2:
            startButtonLabelText = "Last Chance!"
        default:
            startButtonLabelText = "Start"
        }
        let startButtonLabel = SKLabelNode(text: startButtonLabelText)
        startButtonLabel.fontName = SKFont.bold // AvenirNext-Bold
        startButtonLabel.fontSize = 40.0
        startButtonLabel.fontColor = UIColor.white
        startButtonLabel.position = CGPoint(x: 0, y: -12)
        startButton.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        startButton.addChild(startButtonLabel)
        self.addChild(startButton)
    }
 // MARK: - SPAWN ONI
    func spawnOni() {
        if gameIsOver {return}
        let oniAtlas = SKTextureAtlas(named: "Oni")
        var walkFrames: [SKTexture] = []
        let numImages = oniAtlas.textureNames.count
        for i in 1...numImages {
        let oniName = "oni_\(i)"
        walkFrames.append(oniAtlas.textureNamed(oniName))
        }
        
        oniDancingFrames = walkFrames
        let firstFrameTexture = oniDancingFrames[0]
        oni = SKSpriteNode(texture: firstFrameTexture)
        oni.name = "oni"
        oni.setScale(0.6)
        let randomX = randomMinMax(min: -700, max: size.width + 700)
        oni.position = CGPoint(x: randomX, y: -size.height - oni.size.height )
        addChild(oni)
        
        oni.physicsBody = SKPhysicsBody(circleOfRadius: oni.size.width * 0.44)
        oni.physicsBody?.isDynamic = true // 2
        oni.physicsBody?.categoryBitMask = NyonindoPhysicsCategory.oni // 3
        oni.physicsBody?.contactTestBitMask = NyonindoPhysicsCategory.rikishi // 4
        oni.physicsBody?.contactTestBitMask = NyonindoPhysicsCategory.gate // 4
        oni.physicsBody?.collisionBitMask = NyonindoPhysicsCategory.none // 5 I changed this to gate from none; again, why?
        //it creates a momentary glide? along the surface of the gate before the oni disappears
        oni.physicsBody?.usesPreciseCollisionDetection = true

    
        // Determine speed of the oni
        let randomDuration = randomMinMax(min: CGFloat(4.0), max: CGFloat(8.0))
        let randomXtarget = randomMinMax(min: size.width * 0.4 , max: size.width * 0.6)
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: randomXtarget, y: size.height - gate.size.height * 0.66),
                                       duration: TimeInterval(randomDuration))
        let actionMoveDone = SKAction.removeFromParent()
        let oniAction = SKAction.animate(with: oniDancingFrames, timePerFrame: 0.1, resize: false, restore: true)
        let oniRepeat = SKAction.repeatForever(oniAction)
        let oniAttack = SKAction.group([oniRepeat, actionMove])
        oni.run(SKAction.sequence([oniAttack, actionMoveDone]))

    }
    
    // MARK: - SPAWN PILGRM
       func spawnPilgrim() {
        if gameIsOver {return}
        let pilgrimAtlas = SKTextureAtlas(named: "Pilgrim")
        var pilgrimWalkFrames: [SKTexture] = []
        let numImages = pilgrimAtlas.textureNames.count
        for i in 1...numImages {
        let pilgrimName = "pilgrim_\(i)"
        pilgrimWalkFrames.append(pilgrimAtlas.textureNamed(pilgrimName))
        }
        
            pilgrimDancingFrames = pilgrimWalkFrames
            let firstFrameTexture = pilgrimDancingFrames[0]
            pilgrim = SKSpriteNode(texture: firstFrameTexture)
            pilgrim.setScale(0.3)
            pilgrim.name = "pilgrim"
            pilgrim.zPosition = rikishi.zPosition + 1 // i.e. 3
            addChild(pilgrim)

            pilgrim.physicsBody = SKPhysicsBody(circleOfRadius: pilgrim.size.width * 0.25)
            pilgrim.physicsBody?.isDynamic = true // 2
            pilgrim.physicsBody?.categoryBitMask = NyonindoPhysicsCategory.pilgrim //
            pilgrim.physicsBody?.contactTestBitMask = NyonindoPhysicsCategory.rikishi | NyonindoPhysicsCategory.pilgrim
            pilgrim.physicsBody?.contactTestBitMask = NyonindoPhysicsCategory.gate //
            pilgrim.physicsBody?.collisionBitMask = NyonindoPhysicsCategory.none //
            pilgrim.physicsBody?.usesPreciseCollisionDetection = true

//        if pilgrim.position.y > size.height / 2 + rikishi.size.height / 2 {
//            pilgrim.zPosition = 0
//            print("pilgrim above rikishi")
//        } // this is not working
        
        let pilgrimAction = SKAction.animate(with: pilgrimDancingFrames, timePerFrame: 0.4, resize: false, restore: true)
        let actionMoveDone = SKAction.removeFromParent()
        let pilgrimRepeat = SKAction.repeatForever(pilgrimAction)

        let path = CGMutablePath()
        //starting point (off screen):
        path.move(to: CGPoint(x: size.width + pilgrim.size.width , y: -pilgrim.size.height))
        //entry point:
        path.addLine(to: CGPoint(x: size.width  , y: 0))
        //first curve:
        path.addLine(to: CGPoint(x: size.width * 0.1 - (pilgrim.size.width * 0.5) , y: size.height * 0.45 - (pilgrim.size.height )))
        //second curve:
        path.addLine(to: CGPoint(x: size.width * 0.9 + (pilgrim.size.width * 0.25) , y: size.height * 0.55 - (pilgrim.size.height * 0.25)))
        //third curve:
        path.addLine(to: CGPoint(x: size.width * 0.12 , y: size.height * 0.7 - (pilgrim.size.height * 0.25)))
        //fourth curve?:
        path.addLine(to: CGPoint(x: size.width * 0.75 , y: size.height * 0.75 ))
        //gate entrance
        path.addLine(to: (CGPoint(x: size.width * 0.5 , y: size.height * 0.9)))
        
        let scaleDown = SKAction.scale(by: 0.75, duration: 20)
        let followPath = SKAction.follow(path, asOffset: false, orientToPath: false, speed: 80.0) //speed = points per second
        let pilgrimProgress = SKAction.group([scaleDown, pilgrimRepeat , followPath ])
        pilgrim.run(SKAction.sequence([pilgrimProgress, actionMoveDone]))
       }


    //MARK: - TOUCHES BEGAN
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//      guard let touch = touches.first else {
//        return
//      }
//        let touchLocation = touch.location(in: self)
//        selectNodeForTouch(touchLocation: touchLocation)
    }
// MARK: - Accelerometer Action
    func processUserMotion(forUpdate currentTime: CFTimeInterval) {
      // 1
      if let rikishi = childNode(withName: "rikishi") as? SKSpriteNode {
        // 2
        if let data = motionManager.accelerometerData {
          // 3
          if fabs(data.acceleration.x) > 0.2 {
            rikishi.physicsBody!.applyForce(CGVector(dx: 200 * CGFloat(data.acceleration.x), dy: 0))
          }
        }
      }
    }
    //converts degress to radians for rotation action
    func degToRad(degree: Double) -> CGFloat {
        return CGFloat(Double(degree) / 180.0 * .pi)
    }
    
    func selectNodeForTouch(touchLocation: CGPoint) {
        let touchedNode = self.atPoint(touchLocation)
          
          if touchedNode is SKSpriteNode {
            
            if !selectedNode.isEqual(touchedNode) {
                selectedNode.removeAllActions()
                selectedNode.run(SKAction.rotate(toAngle: 0.0, duration: 0.1))
                selectedNode = touchedNode as! SKSpriteNode

                if touchedNode == rikishi {
                    let sequence = SKAction.sequence([SKAction.rotate(byAngle: degToRad(degree: -4.0), duration: 0.1),
                                                      SKAction.rotate(byAngle: 0.0, duration: 0.1),
                                                      SKAction.rotate(byAngle: degToRad(degree: 4.0), duration: 0.1)])
                    selectedNode.run(SKAction.repeatForever(sequence))
              }
            }
          }
        }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.rikishi.move(touchLocation: (touches.first?.location(in: self))!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Get the location of the touch in this scene
        for touch in touches {
        let location = touch.location(in: self)
        // Check if the location of the touch is within the button's bounds
            if startButton.contains(location) {
                startButton.removeFromParent()
                startGameAction()
            }
        }
    }
 
//MARK: - GAME MANAGEMENT METHODS
    func startCounter() {
        counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
    }
    @objc func decrementCounter() {
        counter -= 1
        timerLabel.text = "\(counter) secs remaining"
        if counter == 0 {
            gameIsOver = true
            gameOver()
        }
    }
    func stopCounter() {
        counterTimer.invalidate()
    }
    
    func calculateScore(captures: Int, invasions: Int) -> Int {
        if captures > invasions {
            return captures - invasions
        } else {
            return 0
        }
    }
    
    
//MARK: - GAME OVER
    func gameOver() {

        gameIsOver = true
        
        
        rikishi.removeAllActions()
        pilgrim.removeAllActions()
        enumerateChildNodes(withName: "oni") { (node, _) in
             node.removeFromParent()
        }
        enumerateChildNodes(withName: "pilgrim") { (node, _) in
             node.removeFromParent()
        }
        timerLabel.removeFromParent()
        directionsLabel.removeFromParent()
        stopCounter()
        points = calculateScore(captures: capture, invasions: invasion)
       
        let scoreLabelAnimation = SKAction.moveBy(x: 0, y: frame.midY - 102, duration: 1.0)
        let rikishiToCenterAnimation = SKAction.move(to: CGPoint(x: frame.midX, y: frame.midY + 58), duration: 1.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [unowned self] in
            roundOver.fontName = SKFont.bold
            roundOver.fontSize = 36.0
            roundOver.fontColor = UIColor.black
            roundOver.position = CGPoint(x: frame.midX, y: frame.midY + 142)
            roundOver.zPosition = 100
            pointsEarnedLabel.fontSize = 26
            pointsEarnedLabel.fontName = SKFont.medium
            pointsEarnedLabel.fontColor = UIColor.black
            pointsEarnedLabel.position = CGPoint(x: frame.midX, y: frame.midY - 60)
            pointsEarnedLabel.zPosition = 100
            if rikishiHitPilgrim {addChild(pilgrimLabel) }
            addChild(pointsEarnedLabel)
            rikishi.run(rikishiToCenterAnimation)
            scoreLabel.text = "\(points)"
            addChild(scoreLabel)
            scoreLabel.run(scoreLabelAnimation)
            //scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - 64)
            addChild(roundOver)
            //createReplayButton()
            physicsWorld.speed = 0
            //isUserInteractionEnabled = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) { [unowned self] in
            UserDefaults.standard.set(points, forKey: "NyonindoRecentScore")
            if points > UserDefaults.standard.integer(forKey: "NyonindoHighScore") {
                UserDefaults.standard.set(points, forKey: "NyonindoHighScore")
            }

            self.viewModel?.recentScore = points
            attempts += 1
            self.viewModel?.attempts += 1
            if attempts <  3 {
                addStartButton()
            }
        }
    }
    
// MARK: - COLLISION methods
    func oniReachedGate(oni: SKSpriteNode, gate: SKSpriteNode) {
        invasion += 1
        oni.removeFromParent()
    }
    
    func pilgrimReachedGate(pilgrim: SKSpriteNode, gate: SKSpriteNode) {
        let scaleOut = SKAction.scale(to: 0.001, duration: 0.4)
        let fadeOut = SKAction.fadeOut(withDuration: 0.4)
        let group = SKAction.group([scaleOut, fadeOut])
        let sequence = SKAction.sequence([group, .removeFromParent()])
        pilgrim.run(sequence)
        
    }
    
    func rikishiCaughtOni(oni: SKSpriteNode, rikishi: SKSpriteNode) {
        capture += 2
        oni.removeAllActions()
        oni.physicsBody?.affectedByGravity = true
        let randomXtarget = randomMinMax(min: size.width * 0.3 , max: size.width * 0.6)
        let randomRotation = randomMinMax(min: 45, max: 270)
        let actionMove = SKAction.move(to: CGPoint(x: randomXtarget, y: 0 ),
                                       duration: TimeInterval(1.0))
        let actionMoveDone = SKAction.removeFromParent()
        let oniColorized = SKAction.colorize(with: UIColor.green, colorBlendFactor: 1.0, duration: 0.1)
        let oniRotation = SKAction.rotate(toAngle: randomRotation, duration: 1.0, shortestUnitArc: true)
        let oniDeath = SKAction.group([oniColorized, actionMove, oniRotation])
        oni.run(SKAction.sequence([oniDeath, actionMoveDone]))
    }
    
    func rikishiHitPilgrim(pilgrim: SKSpriteNode , rikishi: SKSpriteNode) {
        rikishiHitPilgrim = true
        //addChild(pilgrimLabel)
        gameOver()
        
       
    }
} //end game scene class
extension NyonindoGameScene: SKPhysicsContactDelegate {

    override func update(_ currentTime: TimeInterval) {
        processUserMotion(forUpdate: currentTime)
        // if pilgrim.zPosition > rikishi.position.y - 10 { // move the pilgrim "behind" the rikishi after passing the rikishi
        if pilgrim.position.y > rikishi.position.y + 10 {
            pilgrim.zPosition = rikishi.zPosition - 1 // i.e. 1 (gate is default 0)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
            if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
            } else {
                firstBody = contact.bodyB
                secondBody = contact.bodyA
            }
        
//if RIKISHI hits PILGRIM
            if ((firstBody.categoryBitMask & NyonindoPhysicsCategory.pilgrim != 0) &&
            (secondBody.categoryBitMask & NyonindoPhysicsCategory.rikishi != 0)) {
                if let pilgrim = firstBody.node as? SKSpriteNode,
                let rikishi = secondBody.node as? SKSpriteNode {
                    rikishiHitPilgrim(pilgrim: pilgrim, rikishi: rikishi)
                }
            }
                
        //if RIKISHI catches ONI
            if ((firstBody.categoryBitMask & NyonindoPhysicsCategory.oni != 0) &&
            (secondBody.categoryBitMask & NyonindoPhysicsCategory.rikishi != 0)) {
                if let oni = firstBody.node as? SKSpriteNode,
                let rikishi = secondBody.node as? SKSpriteNode {
                rikishiCaughtOni(oni: oni, rikishi: rikishi)
                }
            }


//if ONI reaches GATE
        if ((firstBody.categoryBitMask & NyonindoPhysicsCategory.oni != 0) &&
        (secondBody.categoryBitMask & NyonindoPhysicsCategory.gate != 0)) {
            if let oni = firstBody.node as? SKSpriteNode,
            let gate = secondBody.node as? SKSpriteNode {
            oniReachedGate(oni: oni, gate: gate)
            }
        }

//if PILGRIM reaches GATE
        if ((firstBody.categoryBitMask & NyonindoPhysicsCategory.pilgrim != 0) &&
        (secondBody.categoryBitMask & NyonindoPhysicsCategory.gate != 0)) {
        if let pilgrim = firstBody.node as? SKSpriteNode,
        let gate = secondBody.node as? SKSpriteNode {
            pilgrimReachedGate(pilgrim: pilgrim, gate: gate)
        }
    }
        
    }
}

