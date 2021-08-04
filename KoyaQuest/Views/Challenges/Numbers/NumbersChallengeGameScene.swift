//
//  NumbersChallengeGameScene.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/12.
//

import SpriteKit
import GameplayKit
import ARKit

class NumbersChallengeGameScene: SKScene {
    var viewModel : NumbersChallengeViewModel?
    var points = 0
    var counter = 0
    var matchesMade = 0
    var counterTimer = Timer()
    var counterStartValue = 60 // seconds

    var touchCount = 0

    let backTileUL = Tile(tileType: .temples)
    let backTileUC = Tile(tileType: .choishiCount)
    let backTileUR = Tile(tileType: .meals)

    let backTile2L = Tile(tileType: .gorintoCount)
    let backTile2C = Tile(tileType: .mealsCount)
    let backTile2R = Tile(tileType: .hakaCount)

    let backTile3L = Tile(tileType: .haka)
    let backTile3C = Tile(tileType: .templesCount)
    let backTile3R = Tile(tileType: .gorinto)

    let backTile4L = Tile(tileType: .lotusPetalsCount)
    let backTile4C = Tile(tileType: .lotusPetals)
    let backTile4R = Tile(tileType: .choishi)

    var flippedTiles: [Tile] = []
    let scoreLabel = SKLabelNode(text: "0")
    let timerLabel = SKLabelNode(text: "-- secs remaining")
    var roundOver = false
   // let gameOverLabel = SKLabelNode(text: "Game Over!")
   // let finalScoreLabel = SKLabelNode(text: "You earned")

    let fadeOut = SKAction.fadeOut(withDuration: 3)
    let remove = SKAction.removeFromParent()

    override func sceneDidLoad() {
        print("Scene did load")
    }
    
    override func didMove(to view: SKView) {
        print("did move to view")
        UIApplication.shared.isIdleTimerDisabled = true
        do {
            let sounds:[String] = ["flip_sound"]
            for sound in sounds {
                let path:String = Bundle.main.path(forResource: sound, ofType: "mp3")!
                let url:URL = URL(fileURLWithPath: path)
                let audioPlayer:AVAudioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer.prepareToPlay()
                }
            } catch {
            }


        backgroundColor = UIColor(red: 30 / 255, green: 32 / 255, blue: 53 / 255, alpha: 1.0)
        layoutScene()
        if self.viewModel?.complete != true{

            counter = counterStartValue
            startCounter()
            }

        }

    func layoutScene() {

        //backgroundColor = UIColor.black

        let tileSize = CGSize(width: frame.size.width/3 - 10 , height: frame.size.width/3 - 10)



        let upperRowLPosition = CGPoint(x: frame.midX - tileSize.width ,y: frame.midY + tileSize.width*2)
        let upperRowCPosition = CGPoint(x: frame.midX  ,y: frame.midY + tileSize.width*2)
        let upperRowRPosition = CGPoint(x: frame.midX + tileSize.width ,y: frame.midY + tileSize.width*2)

        let row2LPosition = CGPoint(x: frame.midX - tileSize.width ,y: frame.midY + tileSize.width)
        let row2CPosition = CGPoint(x: frame.midX  ,y: frame.midY + tileSize.width)
        let row2RPosition = CGPoint(x: frame.midX + tileSize.width ,y: frame.midY + tileSize.width)

        let row3LPosition = CGPoint(x: frame.midX - tileSize.width ,y: frame.midY )
        let row3CPosition = CGPoint(x: frame.midX  ,y: frame.midY )
        let row3RPosition = CGPoint(x: frame.midX + tileSize.width ,y: frame.midY )

        let row4LPosition = CGPoint(x: frame.midX - tileSize.width ,y: frame.midY - tileSize.width )
        let row4CPosition = CGPoint(x: frame.midX  ,y: frame.midY - tileSize.width)
        let row4RPosition = CGPoint(x: frame.midX + tileSize.width ,y: frame.midY - tileSize.width )


        var positions = [CGPoint]()

        positions.append(upperRowLPosition)
        positions.append(upperRowCPosition)
        positions.append(upperRowRPosition)

        positions.append(row2LPosition)
        positions.append(row2CPosition)
        positions.append(row2RPosition)

        positions.append(row3LPosition)
        positions.append(row3CPosition)
        positions.append(row3RPosition)

        positions.append(row4LPosition)
        positions.append(row4CPosition)
        positions.append(row4RPosition)
        //this shuffles the cgpoints so that the layout of the tiles will be random.
        //the index will be used on the elements in the positions array
        positions.shuffle()

        scoreLabel.fontName = SKFont.bold
        scoreLabel.fontSize = 28.0
        scoreLabel.fontColor = UIColor.white
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.minY + 20)
        scoreLabel.zPosition = 100
        scoreLabel.text = "\(points)"
        addChild(scoreLabel)


        timerLabel.fontName = SKFont.bold
        timerLabel.fontSize = 20.0
        timerLabel.fontColor = UIColor.orange
        timerLabel.position = CGPoint(x: frame.midX, y: frame.minY + 50)
        timerLabel.text = "00:00"
        addChild(timerLabel)

        backTileUL.size = tileSize
        backTileUL.position = positions[0]
        addChild(backTileUL)

        backTileUC.size = tileSize
        backTileUC.position = positions[1]
        addChild(backTileUC)

        backTileUR.size = tileSize
        backTileUR.position = positions[2]
        addChild(backTileUR)

        backTile2L.size = tileSize
        backTile2L.position = positions[3]
        addChild(backTile2L)

        backTile2C.size = tileSize
        backTile2C.position = positions[4]
        addChild(backTile2C)

        backTile2R.size = tileSize
        backTile2R.position = positions[5]
        addChild(backTile2R)

        backTile3L.size = tileSize
        backTile3L.position = positions[6]
        addChild(backTile3L)

        backTile3C.size = tileSize
        backTile3C.position = positions[7]
        addChild(backTile3C)

        backTile3R.size = tileSize
        backTile3R.position = positions[8]
        addChild(backTile3R)

        backTile4L.size = tileSize
        backTile4L.position = positions[9]
        addChild(backTile4L)

        backTile4C.size = tileSize
        backTile4C.position = positions[10]
        addChild(backTile4C)

        backTile4R.size = tileSize
        backTile4R.position = positions[11]
        addChild(backTile4R)

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if counter > 0 {
            for touch in touches {
                touchCount += 1
                let location = touch.location(in: self)
                if touchCount < 3 { // stop after two tiles have been flipped
                    if let tile = atPoint(location) as? Tile  {
                        if touch.tapCount == 1 { // > 1 for double click
                            //print("ID = \(tile.setID)")
                            //add the tile to an array
                            flippedTiles.append(tile)
                            tile.flip()
                            //here is where I need to evaluate if a match has been made...
                            if(flippedTiles.count == 2) {

                                if flippedTiles[0].setID == flippedTiles[1].setID
                                && flippedTiles[0].isText != flippedTiles[1].isText  {//if they match
                                    isUserInteractionEnabled = false
                                    handleMatch()
                                } else {//no match
                                    //add sound?
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [unowned self] in
                                    self.flippedTiles[0].flip()
                                    self.flippedTiles[1].flip()
                                    self.flippedTiles.removeAll()
                                    touchCount = 0
                                    }
                                }
                            }
                        }
                    }
                } //end for touchCount less than 3
            }//end of for touch in touches
        }
    }
    func startCounter() {
        counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
    }

    func stopCounter() {
        counterTimer.invalidate()
    }

    func handleMatch() {
        //add sound?
        flippedTiles[0].run(SKAction.sequence([fadeOut,remove]))
        flippedTiles[1].run(SKAction.sequence([fadeOut,remove]))
        points += 2
        matchesMade += 1
        flippedTiles.removeAll()
        scoreLabel.text = "\(points)"
        touchCount = 0
        isUserInteractionEnabled = true
    }

    func gameOver() {
        print("Game over")
        roundOver = true
        stopCounter()
        self.viewModel?.points = self.points
        self.viewModel?.complete = true
    }

    @objc func decrementCounter() {
        counter -= 1
        timerLabel.text = "\(counter) secs remaining"
        if counter == 0 {
            stopCounter()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if !self.roundOver {
                    self.gameOver()
                }
                
            }
        }
        if matchesMade == 6 { // is this the best place for this ???
            timerLabel.removeFromParent()
            stopCounter()
            points = 20
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                if !self.roundOver {
                    self.gameOver()
                }
            }
        }
    }
}
