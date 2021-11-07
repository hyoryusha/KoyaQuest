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
    var viewModel = NyonindoChallengeViewModel()


    @Binding var challengeCompleted: Bool
    @Binding var earnedPoints: Int

    init(_ challengeCompleted: Binding<Bool>, _ earnedPoints: Binding<Int>) {
            _challengeCompleted = challengeCompleted
            _earnedPoints = earnedPoints
            super.init(size: CGSize(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height))
            self.scaleMode = .aspectFill
        }

        required init?(coder aDecoder: NSCoder) {
            _challengeCompleted = .constant(false)
            _earnedPoints = .constant(0)
            super.init(coder: aDecoder)
        }

    let background = SKSpriteNode(imageNamed: "nyonindo_bg")
    var selectedNode = SKSpriteNode()
    var invasion = 0
    var capture = 0
    var counter = 0
    var points = 0
    var gameOver: Bool = false
    //var attempts: Int
    var rikishiHitPilgrim = false
    var counterTimer = Timer()
    var counterStartValue = 40 // seconds
    var roundIsOver = false
   // var showingPostRoundFeedback = false
    let directionsLabel = SKLabelNode(text: "")
    let scoreLabel = SKLabelNode(text: "0")
    let pilgrimLabel = SKLabelNode(text: "(because you hit a pilgrim)")
    let timerLabel = SKLabelNode(text: "-- secs remaining")
    let roundOverLabel = SKLabelNode(text: "Round Over!")
    let pointsEarnedLabel = SKLabelNode(text: "Points this round:")
    var roundCounterLabel = SKLabelNode(text: "Round X of 3")
    var roundCounterText = ""
    var scoreToBeatText = ""
    var scoreToBeatLabel = SKLabelNode(text: "")


    let motionManager = CMMotionManager()
    let startButton = SKSpriteNode(color: .systemOrange, size: CGSize(width: 258, height: 66))
    let startButtonLabel = SKLabelNode(text: "Start!")

    let rikishi = SKSpriteNode(imageNamed: "rikishi2")
    let gate = SKSpriteNode(imageNamed: "daimon_illustration")
    let choishi = SKSpriteNode(imageNamed: "choishi_on_path")
    private var oni = SKSpriteNode()
    private var oniDancingFrames: [SKTexture] = []
    private var pilgrim = SKSpriteNode()
    private var pilgrimDancingFrames: [SKTexture] = []

    // MARK: -SOUNDS
    let oniCollisionSound: SKAction = SKAction.playSoundFileNamed(
      "oni_collision.wav", waitForCompletion: false)
    let pilgrimCollisionSound: SKAction = SKAction.playSoundFileNamed(
      "pilgrim_collision.wav", waitForCompletion: false)
    let oniEntersGateSound: SKAction = SKAction.playSoundFileNamed(
      "oni_enters_gate.wav", waitForCompletion: false)
    let pilgrimEntersGateSound: SKAction = SKAction.playSoundFileNamed(
      "pilgrim_enters_gate.wav", waitForCompletion: false)

//MARK: - DID MOVE TO VIEW
    override func didMove(to view: SKView) {
        UIApplication.shared.isIdleTimerDisabled = true
        setUpPhysics()
        layoutScene()
        addStartButton()
    }
     private func setUpPhysics() {
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
     }

    func layoutScene() {
//        counter = counterStartValue
        background.size = self.frame.size
        background.zPosition = 0
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)

        // MARK: - Gate
        gate.physicsBody = SKPhysicsBody(circleOfRadius: gate.size.width * 0.25)
        gate.physicsBody?.isDynamic = false
        gate.physicsBody?.categoryBitMask = NyonindoPhysicsCategory.gate
        gate.physicsBody?.contactTestBitMask = NyonindoPhysicsCategory.oni
        gate.physicsBody?.collisionBitMask = NyonindoPhysicsCategory.none
        gate.physicsBody?.usesPreciseCollisionDetection = true
        gate.position = CGPoint(x: size.width * 0.5, y: size.height * 0.86)
        gate.zPosition = 3
        addChild(gate)

        choishi.size = CGSize(width: frame.size.width * 0.17,
                              height: frame.size.height * 0.25)
        choishi.position = CGPoint(x: frame.size.width * 0.1, y: frame.size.height / 2 )
        choishi.zPosition = 4
        addChild(choishi)

        directionsLabel.fontName = SKFont.medium // AvenirNext-Medium
        directionsLabel.fontSize = 15.0
        directionsLabel.fontColor = UIColor.black
        directionsLabel.position = CGPoint(x: frame.midX, y: frame.minY + 58)
        directionsLabel.zPosition = 3
        directionsLabel.text = "Tilt to move the guardian in that direction."
        addChild(directionsLabel)

        timerLabel.fontName = SKFont.bold // AvenirNext-Bold
        timerLabel.fontSize = 20.0
        timerLabel.fontColor = UIColor.black
        timerLabel.position = CGPoint(x: frame.midX, y: frame.minY + 36)
        timerLabel.zPosition = 3
        timerLabel.text = "00:00"
        addChild(timerLabel)

    }
    //MARK: - ADD START BUTTON
        func addStartButton() {
            startButtonLabel.fontName = SKFont.bold // AvenirNext-Bold
            startButtonLabel.fontSize = 40.0
            startButtonLabel.fontColor = UIColor.white
            startButtonLabel.position = CGPoint(x: 0, y: -12)
            startButtonLabel.name = "startButtonLabel"
            //startButton.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
            startButton.position = CGPoint(x:self.frame.midX, y:self.frame.minY + gate.size.height * 0.7 )
            startButton.zPosition = 3
            //determine label
            var text = ""
            if self.viewModel.attempts == 0 {
                text = "Start"
            }
            else if self.viewModel.attempts ==  1 {
                text = "Try Again!"
            }
            else if self.viewModel.attempts ==  2 {
              text = "Last Chance!"
            }
            startButtonLabel.text = text
            startButton.addChild(startButtonLabel)
            if self.viewModel.attempts < 3{
                addChild(startButton)
            }
        }
    func addRoundCounter() { // and score to beat label
        roundCounterLabel.text = roundCounterText
        roundCounterLabel.fontName = SKFont.medium
        roundCounterLabel.fontSize = 12.0
        roundCounterLabel.fontColor = UIColor.black
        roundCounterLabel.position = CGPoint(x: 46, y: gate.position.y)
        roundCounterLabel.zPosition = 3
        if viewModel.attempts < 3 {
            addChild(roundCounterLabel)
        }

        scoreToBeatLabel.text = scoreToBeatText
        scoreToBeatLabel.fontName = SKFont.medium
        scoreToBeatLabel.fontSize = 12.0
        scoreToBeatLabel.fontColor = UIColor.black
        scoreToBeatLabel.position = CGPoint(x: frame.maxX - 48, y: gate.position.y)
        scoreToBeatLabel.zPosition = 3
        if viewModel.attempts > 0 && viewModel.attempts < 3 {
            addChild(scoreToBeatLabel)
        }
    }

    func startGameAction() {
        startButton.removeFromParent()
        startButtonLabel.removeFromParent()
        roundIsOver = false

        counter = counterStartValue
            roundIsOver = false
            motionManager.startAccelerometerUpdates()
        //viewModel.setGameToActive() ??
            addRikishi()
            startOniAttack()
            startPilgrim()
            beginMusic()
            startCounter()
        self.scoreToBeatText = "Try to beat \(viewModel.highestScore)"
        self.scoreToBeatText = "Try to beat \(earnedPoints)"
        self.roundCounterText = "Round \(viewModel.attempts + 1) of 3"
        addRoundCounter()
    }
// MARK: - MAIN GAME ACTIONS
    func beginMusic() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
        playBackgroundMusic("oni_attack.mp3")
        }
    }
    func addRikishi() {
        rikishi.physicsBody = SKPhysicsBody(circleOfRadius: rikishi.size.width * 0.44)
        rikishi.position = CGPoint(x: size.width * 0.5, y: size.height / 2 + (rikishi.size.height / 3 ))
        rikishi.zPosition = 3
        rikishi.name = "rikishi"
        rikishi.physicsBody?.isDynamic = true
        rikishi.physicsBody?.categoryBitMask = NyonindoPhysicsCategory.rikishi
        rikishi.physicsBody?.contactTestBitMask = NyonindoPhysicsCategory.oni |  NyonindoPhysicsCategory.pilgrim
        rikishi.physicsBody?.collisionBitMask = NyonindoPhysicsCategory.none // this was changed from none to oni; why?
        rikishi.physicsBody?.usesPreciseCollisionDetection = true
        let wobble = SKAction.sequence(
            [SKAction.rotate(
                byAngle: degToRad(degree: -4.0),
                duration: 0.1),
                  SKAction.rotate(byAngle: 0.0, duration: 0.1),
                  SKAction.rotate(byAngle: degToRad(degree: 4.0), duration: 0.1)]
        )
        rikishi.run(SKAction.repeatForever(wobble))
        addChild(rikishi)
    }
    func startOniAttack() {
        run(SKAction.repeatForever(
          SKAction.sequence([
            SKAction.run(spawnOni),
            SKAction.wait(forDuration: 0.75)
            ])
        ))
    }
    func startPilgrim() {
        run(SKAction.repeat(
          SKAction.sequence([
            SKAction.wait(forDuration: 7.0),
            SKAction.run(spawnPilgrim),
            SKAction.wait(forDuration: 3.0)
          ]), count: 4
        ))
    }
// MARK: - SPAWN ONI
    func spawnOni() {
        if roundIsOver {return}
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
        oni.zPosition = 4
        addChild(oni)

        oni.physicsBody = SKPhysicsBody(circleOfRadius: oni.size.width * 0.44)
        oni.physicsBody?.isDynamic = true // 2
        oni.physicsBody?.categoryBitMask = NyonindoPhysicsCategory.oni
        oni.physicsBody?.contactTestBitMask = NyonindoPhysicsCategory.rikishi
        oni.physicsBody?.contactTestBitMask = NyonindoPhysicsCategory.gate
        oni.physicsBody?.collisionBitMask = NyonindoPhysicsCategory.none
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
        if roundIsOver {return}
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
        pilgrim.zPosition = rikishi.zPosition + 3 // i.e. 3
        addChild(pilgrim)

        pilgrim.physicsBody = SKPhysicsBody(circleOfRadius: pilgrim.size.width * 0.25)
        pilgrim.physicsBody?.isDynamic = true // 2
        pilgrim.physicsBody?.categoryBitMask = NyonindoPhysicsCategory.pilgrim //
        pilgrim.physicsBody?.contactTestBitMask = NyonindoPhysicsCategory.rikishi | NyonindoPhysicsCategory.pilgrim
        pilgrim.physicsBody?.contactTestBitMask = NyonindoPhysicsCategory.gate //
        pilgrim.physicsBody?.collisionBitMask = NyonindoPhysicsCategory.none //
        pilgrim.physicsBody?.usesPreciseCollisionDetection = true

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
        let followPath = SKAction.follow(path, asOffset: false, orientToPath: false, speed: 90.0) //speed = points per second
        let pilgrimProgress = SKAction.group([scaleDown, pilgrimRepeat , followPath ])
        pilgrim.run(SKAction.sequence([pilgrimProgress, actionMoveDone]))
    }
// MARK: - CLEAR
    func clearElements() {
        scoreLabel.removeFromParent()
        pointsEarnedLabel.removeFromParent()
        roundOverLabel.removeFromParent()
        pilgrimLabel.removeFromParent()
    }

//MARK: - TOUCHES
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
        let location = touch.location(in: self)
            if startButton.contains(location) {
                startGameAction()
            }
        }
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

//MARK: - GAME MANAGEMENT METHODS
    func startCounter() {
        counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
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
    func roundOver() {
        roundIsOver = true
        //viewModel.setGameToInactive()
        backgroundMusicPlayer.stop()
       // self.attempts += 1
        self.viewModel.attempts += 1
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

        //viewModel.setRecentScore(points: points)
        viewModel.recentScore = points
        if points > viewModel.highestScore {
            viewModel.highestScore = points
            earnedPoints = points
        }
        viewModel.recentScore = points
            if viewModel.attempts > 2 {
                self.gameOver = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
               // self.showingPostRoundFeedback = true
                self.showPostRoundFeedback()
            }
        } // end round over method

// MARK: - SHOW POST ROUND FEEDBACK
    func showPostRoundFeedback() {
        let scoreLabelAnimation = SKAction.moveBy(x: 0, y: frame.midY - 102, duration: 1.0)
        let rikishiToCenterAnimation = SKAction.move(to: CGPoint(x: size.width * 0.5, y: size.height / 2 + (rikishi.size.height / 3 )), duration: 1.0)

             rikishi.run(rikishiToCenterAnimation)

             roundOverLabel.fontName = SKFont.bold
             roundOverLabel.fontSize = 36.0
             roundOverLabel.fontColor = UIColor.black
             roundOverLabel.position = CGPoint(x: frame.midX, y: frame.midY + 142)
             roundOverLabel.zPosition = 100
             roundOverLabel.text = "Round Over"

             scoreLabel.fontName = SKFont.bold
             scoreLabel.fontSize = 28.0
             scoreLabel.fontColor = UIColor.black
             scoreLabel.position = CGPoint(x: frame.midX, y: frame.minY)
             scoreLabel.zPosition = 100
             scoreLabel.text = "\(points)"

             pointsEarnedLabel.fontSize = 26
             pointsEarnedLabel.fontName = SKFont.medium
             pointsEarnedLabel.fontColor = UIColor.black
             pointsEarnedLabel.position = CGPoint(x: frame.midX, y: frame.midY - 60)
             pointsEarnedLabel.zPosition = 100
             addChild(pointsEarnedLabel)

             if rikishiHitPilgrim {
                 pilgrimLabel.fontName = SKFont.bold
                 pilgrimLabel.fontSize = 22.0
                 pilgrimLabel.fontColor = UIColor.red
                 pilgrimLabel.position = CGPoint(x: frame.midX, y: frame.midY + 120)
                 pilgrimLabel.zPosition = 100
                 addChild(pilgrimLabel)
             }

             scoreLabel.text = "\(points)"
             addChild(scoreLabel)
             scoreLabel.run(scoreLabelAnimation)
             addChild(roundOverLabel)
            // physicsWorld.speed = 0

            DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {

                self.clearElements()
                if self.gameOver {

                    self.showSummaryScene(withTransition: .flipVertical(withDuration: 0.5))
                } else {

                    self.showNewScene(withTransition: .flipVertical(withDuration: 0.5))
                }
            } // end dispatch after 6
    }

    private func showNewScene(withTransition transition: SKTransition) {
            let delay = SKAction.wait(forDuration: 1)
            let sceneChange = SKAction.run {
                //let scene = NyonindoGameScene(size: self.size)
                let scene = NyonindoGameScene(self.$challengeCompleted, self.$earnedPoints)
                scene.viewModel = self.viewModel
              self.view?.presentScene(scene, transition: transition)
            }
            run(.sequence([delay, sceneChange]))
          }

    private func showSummaryScene(withTransition transition: SKTransition) {
             let delay = SKAction.wait(forDuration: 1)
             let sceneChange = SKAction.run {
                 let scene = NyonindoSummaryScene(self.$challengeCompleted)
                 scene.viewModel = self.viewModel
               self.view?.presentScene(scene, transition: transition)
             }
             run(.sequence([delay, sceneChange]))
           }

// MARK: - COLLISION METHODS
    func oniReachedGate(oni: SKSpriteNode, gate: SKSpriteNode) {
        invasion += 1
        run(oniEntersGateSound)
        oni.removeFromParent()
    }

    func pilgrimReachedGate(pilgrim: SKSpriteNode, gate: SKSpriteNode) {
        run(pilgrimEntersGateSound)
        let scaleOut = SKAction.scale(to: 0.001, duration: 0.4)
        let fadeOut = SKAction.fadeOut(withDuration: 0.4)
        let group = SKAction.group([scaleOut, fadeOut])
        let sequence = SKAction.sequence([group, .removeFromParent()])
        pilgrim.run(sequence)
    }

    func rikishiCaughtOni(oni: SKSpriteNode, rikishi: SKSpriteNode) {
        capture += 2
        run(oniCollisionSound)
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
        run(pilgrimCollisionSound)
        rikishiHitPilgrim = true
        //addChild(pilgrimLabel)
        roundOver()
    }
}

// MARK: EXTENSION
extension NyonindoGameScene: SKPhysicsContactDelegate {

    override func update(_ currentTime: TimeInterval) {

        processUserMotion(forUpdate: currentTime)
        if pilgrim.position.y > rikishi.position.y + 10 {
            pilgrim.zPosition = rikishi.zPosition - 1 // i.e. 1 (gate is default 0)
        }
    }
// MARK: - DID BEGIN
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

// if RIKISHI hits PILGRIM
            if ((firstBody.categoryBitMask & NyonindoPhysicsCategory.pilgrim != 0) &&
            (secondBody.categoryBitMask & NyonindoPhysicsCategory.rikishi != 0)) {
                if let pilgrim = firstBody.node as? SKSpriteNode,
                let rikishi = secondBody.node as? SKSpriteNode {
                    rikishiHitPilgrim(pilgrim: pilgrim, rikishi: rikishi)
                }
            }

// if RIKISHI catches ONI
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

// MARK: - RANDOMIZERS
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(0xFFFFFFFF))
    }
    func randomMinMax(min: CGFloat, max: CGFloat) -> CGFloat {
      return random() * (max - min) + min
    }

// MARK: - OBJC DECREMENT COUNTER
    @objc func decrementCounter() {
        counter -= 1
        timerLabel.text = "\(counter) secs remaining"
        if counter == 0 {
            roundIsOver = true
            roundOver()
        }
    }
}
