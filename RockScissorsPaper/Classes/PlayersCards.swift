//
//  Cards.swift
//  RockScissorsPaper
//
//  Created by Дарья Носова on 15.10.2023.
//

import SpriteKit
import GameplayKit

class PlayersCards: SKSpriteNode {

    static func populateCard(width: Double, height: Double) -> [PlayersCards] {
        let cardRock = PlayersCards(imageNamed: "rock")
        cardRock.xScale = 0.7
        cardRock.yScale = 0.7
        cardRock.position = CGPoint(x: width / 5.5, y: height / 5.5)
        cardRock.zPosition = 1
        
        let cardScissors = PlayersCards(imageNamed: "scissors")
        cardScissors.xScale = 0.7
        cardScissors.yScale = 0.7
        cardScissors.position = CGPoint(x: width / 2, y: height / 5.5)
        cardScissors.zPosition = 1
        
        let cardPaper = PlayersCards(imageNamed: "paper")
        cardPaper.xScale = 0.7
        cardPaper.yScale = 0.7
        cardPaper.position = CGPoint(x: width / 1.221, y: height / 5.5)
        cardPaper.zPosition = 1
        
        return [cardRock, cardScissors, cardPaper]
    }
    
    static func rotateDealerCards() -> SKAction {
        return SKAction.rotate(byAngle: 180 * Double.pi / 180, duration: 0)
    }
}
