//
//  DealersCards.swift
//  RockScissorsPaper
//
//  Created by Дарья Носова on 15.10.2023.
//

import SpriteKit

class DealersCards: SKSpriteNode {
    
    static func populateCard(width: Double, height: Double) -> [DealersCards] {
        
        let cardRockDealer = DealersCards(imageNamed: "rock")
        cardRockDealer.xScale = 0.7
        cardRockDealer.yScale = 0.7
        cardRockDealer.position = CGPoint(x: width / 5.5, y: height / 1.22)
        cardRockDealer.zPosition = 1
        cardRockDealer.run(rotateDealerCards())
        
        let cardScissorsDealer = DealersCards(imageNamed: "scissors")
        cardScissorsDealer.xScale = 0.7
        cardScissorsDealer.yScale = 0.7
        cardScissorsDealer.position = CGPoint(x: width / 2, y: height / 1.22)
        cardScissorsDealer.zPosition = 1
        cardScissorsDealer.run(rotateDealerCards())
        
        let cardPaperDealer = DealersCards(imageNamed: "paper")
        cardPaperDealer.xScale = 0.7
        cardPaperDealer.yScale = 0.7
        cardPaperDealer.position = CGPoint(x: width / 1.221, y: height / 1.22)
        cardPaperDealer.zPosition = 1
        cardPaperDealer.run(rotateDealerCards())
        
        return [cardRockDealer, cardScissorsDealer, cardPaperDealer]
    }
    
    static func rotateDealerCards() -> SKAction {
        return SKAction.rotate(byAngle: 180 * Double.pi / 180, duration: 0)
    }
    
    static func dealerLogic() -> [Int] {
        let indexes = [0, 1, 2].shuffled()
        return indexes
    }
}
