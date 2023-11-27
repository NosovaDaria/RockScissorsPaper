//
//  ScoreScene.swift
//  RockScissorsPaper
//
//  Created by Дарья Носова on 16.10.2023.
//

import SpriteKit

class ScoreScene: ParentScene {
    let returnTexture = SKTexture(imageNamed: "return")
    
    var results: [Int]!
    var names: [String]!
    
    override func didMove(to view: SKView) {
        self.view?.accessibilityScroll(.down) 
        gameResults.loadGameResults()
        results = gameResults.playerScore
        names = gameResults.playerName
        
        
        self.backgroundColor = SKColor(ciColor: .white)
        
        configureUI()
        
        for (index, value) in results.enumerated() {
            let result = SKLabelNode(text: "\(index + 1). \(names[index]): \(value)")
            result.fontColor = .black
            result.fontName = "arial"
            result.fontSize = 30
            result.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(index * 70) + 70)
            addChild(result)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "returnButton" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let menuScene = MenuScene(size:  self.size)
            menuScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(menuScene, transition: transition)
        }
    }
    
    private func configureUI() {
        let returnButton = SKSpriteNode(texture: returnTexture)
        returnButton.position = CGPoint(x: self.frame.midX / 5.2, y: self.frame.maxY / 1.05)
        returnButton.xScale = 0.1
        returnButton.yScale = 0.1
        returnButton.zPosition = 2
        returnButton.name = "returnButton"
        self.addChild(returnButton)
        
        let results = SKLabelNode(text: "Last results:")
        results.fontColor = .black
        results.fontName = "arial"
        results.fontSize = 30
        results.position = CGPoint(x: self.frame.midX, y: self.frame.maxY / 1.12)
        addChild(results)
        
    }
}

