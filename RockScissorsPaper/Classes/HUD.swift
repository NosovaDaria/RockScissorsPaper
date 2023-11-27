//
//  HUD.swift
//  RockScissorsPaper
//
//  Created by Дарья Носова on 16.10.2023.
//

import SpriteKit

class HUD: SKScene {
    let playerScoreBackground = SKSpriteNode(imageNamed: "score")
    let dealerScoreBackground = SKSpriteNode(imageNamed: "score")
    let playerScoreLabel = SKLabelNode(text: "0")
    let dealerScoreLabel = SKLabelNode(text: "0")
    var roundLabel = SKLabelNode(text: "Round")
    var winLabel = SKLabelNode(text: "You won!")
    var loseLabel = SKLabelNode(text: "You lose :( Try again!")
    
    var playerScore: Int = 0 {
        didSet {
            playerScoreLabel.text = playerScore.description
        }
    }
    var dealerScore: Int = 0 {
        didSet {
            dealerScoreLabel.text = dealerScore.description
        }
    }
    
    func configureUI(screenSize: CGSize) {
        playerScoreBackground.position = CGPoint(x: playerScoreBackground.size.width / 2.5, y: 20)
        playerScoreBackground.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        playerScoreBackground.zPosition = 5
        playerScoreBackground.yScale = 0.2
        playerScoreBackground.xScale = 0.3
        addChild(playerScoreBackground)
        
        dealerScoreBackground.position = CGPoint(x: screenSize.width / 1.05, y: screenSize.height - 30)
        dealerScoreBackground.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        dealerScoreBackground.zPosition = 5
        dealerScoreBackground.yScale = 0.2
        dealerScoreBackground.xScale = 0.3
        addChild(dealerScoreBackground)
        
        playerScoreLabel.horizontalAlignmentMode = .center
        playerScoreLabel.verticalAlignmentMode = .center
        playerScoreLabel.position = CGPoint(x: -125, y: 20)
        playerScoreLabel.zPosition = 6
        playerScoreLabel.fontName = "arial"
        playerScoreLabel.fontColor = .white
        playerScoreLabel.fontSize = 60
        playerScoreBackground.addChild(playerScoreLabel)
        
        dealerScoreLabel.horizontalAlignmentMode = .center
        dealerScoreLabel.verticalAlignmentMode = .center
        dealerScoreLabel.position = CGPoint(x: -125, y: 20)
        dealerScoreLabel.zPosition = 6
        dealerScoreLabel.fontName = "arial"
        dealerScoreLabel.fontColor = .white
        dealerScoreLabel.fontSize = 60
        dealerScoreBackground.addChild(dealerScoreLabel)
        
        roundLabel.fontName = "arial"
        roundLabel.position = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
        roundLabel.zPosition = 40
        roundLabel.fontColor = .white
        roundLabel.fontSize = 60
        
        winLabel.fontName = "arial"
        winLabel.position = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
        winLabel.zPosition = 60
        winLabel.fontColor = .white
        winLabel.fontSize = 60
        
        loseLabel.fontName = "arial"
        loseLabel.position = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
        loseLabel.zPosition = 60
        loseLabel.fontColor = .white
        loseLabel.fontSize = 60
    }
    
    func changeRound(round: Int) {
        roundLabel.text = ("Round \(round) ")
        self.addChild(self.roundLabel)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.roundLabel.removeFromParent()
        }
    }

}
