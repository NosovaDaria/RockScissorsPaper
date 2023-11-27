//
//  GameScene.swift
//  RockScissorsPaper
//
//  Created by Дарья Носова on 13.10.2023.
//

import SpriteKit
import GameplayKit

class GameScene: ParentScene {
    
    
    fileprivate let hud = HUD()
    fileprivate let screenSize = UIScreen.main.bounds.size
    var randomDealerCards = DealersCards.dealerLogic()
    let nameKey = "name"
    let scoreKey = "score"
    let returnTexture = SKTexture(imageNamed: "return")
    
    var playerName: String?
    var playerCards: [PlayersCards] = []
    var dealerCards: [DealersCards] = []
    var round = 1
    var countDraw = 0
    var clickDisabled = false
   
    
    override func didMove(to view: SKView) {
        guard sceneManager.gameScene == nil else { return }
        sceneManager.gameScene = self
    }
    
    func createHUD() {
        addChild(hud)
        hud.configureUI(screenSize: screenSize)
        hud.changeRound(round: round)
    }
    
   func configureStartScene() {
        clickDisabled = false
        self.removeChildren(in: playerCards)
        self.removeChildren(in: dealerCards)
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        
        let background = Background.populateBackground(at: screenCenterPoint)
        playerCards = PlayersCards.populateCard(width: self.size.width, height: self.size.height)
        dealerCards = DealersCards.populateCard(width: self.size.width, height: self.size.height)
        
       configureUI()
        
        self.addChild(background)
        for card in playerCards {
            self.addChild(card)
        }
        for card in dealerCards {
            self.addChild(card)
        }
    }
    func configureUI() {
        let returnButton = SKSpriteNode(texture: returnTexture)
        returnButton.position = CGPoint(x: screenSize.width / 9, y: screenSize.height / 1.035)
        returnButton.xScale = 0.1
        returnButton.yScale = 0.1
        returnButton.zPosition = 7
        returnButton.name = "returnButton"
        self.addChild(returnButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if clickDisabled == false {
            let movePointPlayer = CGPoint(x: self.size.width / 3.5, y: self.size.height / 2)
            let movePointDealer = CGPoint(x: self.size.width / 1.4, y: self.size.height / 2)
            let fadeOutAction = SKAction.fadeOut(withDuration: 2)
            let moveActionPlayer = SKAction.move(to: movePointPlayer, duration: 0.5)
            let moveActionDealer = SKAction.move(to: movePointDealer, duration: 0.5)
            let groupMoveAndFadeActionPlayer = SKAction.group([moveActionPlayer, fadeOutAction])
            let groupMoveAndFadeActionDealer = SKAction.group([moveActionDealer, fadeOutAction])
            
            let firstCard = CGRect(x: 19.847999572753906, y: 76.12100219726562, width: 116.6, height: 186.6)
            let secondCard = CGRect(x: 156.66700744628906, y: 76.12100219726562, width: 116.6, height: 186.6)
            let thirdCard = CGRect(x: 293.8370056152344, y: 76.12100219726562, width: 116.6, height: 186.6)
            
           
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let node = self.atPoint(touchLocation)
              
                if node.name == "returnButton" {
                    let transition = SKTransition.crossFade(withDuration: 1.0)
                    let menuScene = MenuScene(size:  self.size)
                    menuScene.scaleMode = .aspectFill
                    self.scene?.view?.presentScene(menuScene, transition: transition)
                }
                
                
                if firstCard.contains(touchLocation) {
                    playerCards[0].run(groupMoveAndFadeActionPlayer)
                    let dealerCard = dealerCards[randomDealerCards[0]]
                    dealerCard.run(groupMoveAndFadeActionDealer)
                    scoreLogic(playerCard: playerCards[0], dealerCard: dealerCard)
                    
                } else if  secondCard.contains(touchLocation) {
                    playerCards[1].run(groupMoveAndFadeActionPlayer)
                    let dealerCard = dealerCards[randomDealerCards[1]]
                    dealerCard.run(groupMoveAndFadeActionDealer)
                    scoreLogic(playerCard: playerCards[1], dealerCard: dealerCard)
                    
                } else if thirdCard.contains(touchLocation) {
                    playerCards[2].run(groupMoveAndFadeActionPlayer)
                    let dealerCard = dealerCards[randomDealerCards[2]]
                    dealerCard.run(groupMoveAndFadeActionDealer)
                    scoreLogic(playerCard: playerCards[2], dealerCard: dealerCard)
                }
            }
            
            
        }

    }
    
    private func scoreLogic(playerCard: PlayersCards, dealerCard: DealersCards) {
        
        if playerCard == playerCards[0] && dealerCard == dealerCards[0] ||  playerCard == playerCards[1] && dealerCard == dealerCards[1] || playerCard == playerCards[2] && dealerCard == dealerCards[2] {
            countDraw += 1
            if countDraw >= 3 {
                reloadRound(winner: 0, draw: true)
                countDraw = 0
            }
            
        } else if playerCard == playerCards[0] && dealerCard == dealerCards[1] ||  playerCard == playerCards[1] && dealerCard == dealerCards[2] || playerCard == playerCards[2] && dealerCard == dealerCards[0] {
            if round <= 5 {
                reloadRound(winner: 0, draw: false)
            }
         
        } else if playerCard == playerCards[0] && dealerCard == dealerCards[2] ||  playerCard == playerCards[1] && dealerCard == dealerCards[0] || playerCard == playerCards[2] && dealerCard == dealerCards[1] {
            if round <= 5 {
                reloadRound(winner: 1, draw: false)
            }
        } else {
            print("Error")
        }
    }
    
    private func reloadRound(winner: Int, draw: Bool) {
        
        randomDealerCards = DealersCards.dealerLogic()
        if winner == 0 && draw == false {
            hud.playerScore += 1
        } else if winner == 1 {
            hud.dealerScore += 1
        }
        clickDisabled = true
        round += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) { [self] in
            if self.round <= 5 {self.configureStartScene()
                self.hud.changeRound(round: self.round)
            } else {
                winOrLoseLabel()
                saveScores()
                endOfGame()
            }
        }
    }
    
    private func endOfGame() {

        let transition = SKTransition.crossFade(withDuration: 2.0)
        let scoreScene = ScoreScene(size:  self.size)
        scoreScene.scaleMode = .aspectFill
        self.scene?.view?.presentScene(scoreScene, transition: transition)
    }
    
    private func saveScores() {
        guard playerName != nil else { return }
        gameResults.playerName.append(playerName ?? "User")
        gameResults.currentScore = hud.playerScore
        gameResults.saveGameResults()
    }
    
    private func winOrLoseLabel() {
        if hud.playerScore >= 3 {
            addChild(hud.winLabel)
            print("Win")
        } else {
            addChild(hud.loseLabel)
            print("Win")
        }
    }
}
