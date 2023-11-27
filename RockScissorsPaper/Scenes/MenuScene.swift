//
//  MenuScene.swift
//  RockScissorsPaper
//
//  Created by Дарья Носова on 16.10.2023.
//

import SpriteKit

class MenuScene: ParentScene, UITextFieldDelegate {
    let playTexture = SKTexture(imageNamed: "play")
    let resultsTexture = SKTexture(imageNamed: "results")
    let submitNameText = SKLabelNode(fontNamed: "arial")
    var nameTextField: UITextField!
    
    var playerName = "User"
    var playerScore: Int!
    
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor(ciColor: .white)
        configureUI()
        configureTextField()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "playButton" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let gameScene = GameScene(size:  self.size)
            gameScene.playerName = playerName
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
            nameTextField.removeFromSuperview()
            gameScene.configureStartScene()
            gameScene.createHUD()
        }
        
        if node.name == "resultsButton" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let scoreScene = ScoreScene(size:  self.size)
            scoreScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(scoreScene, transition: transition)
            nameTextField.removeFromSuperview()
        }
    }
        
    private func configureUI() {
        let playButton = SKSpriteNode(texture: playTexture)
        playButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        playButton.xScale = 0.29
        playButton.yScale = 0.29
        playButton.name = "playButton"
        self.addChild(playButton)
            
        let resultsButton = SKSpriteNode(texture: resultsTexture)
        resultsButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY / 2)
        resultsButton.xScale = 0.3
        resultsButton.yScale = 0.3
        resultsButton.name = "resultsButton"
        self.addChild(resultsButton)
    }
        
    func configureTextField() {
        nameTextField = UITextField(frame: CGRectMake(self.frame.midX - 320 / 2, self.frame.midY / 2, 320, 40) )
        view?.addSubview(nameTextField)
            
        nameTextField.delegate = self
            
        nameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        nameTextField.textColor = SKColor.black
        nameTextField.placeholder = "Enter your name here"
        nameTextField.backgroundColor = SKColor.white
        nameTextField.autocorrectionType = UITextAutocorrectionType.no
            
        nameTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        nameTextField.autocapitalizationType = UITextAutocapitalizationType.sentences
        self.view?.addSubview(nameTextField)
            
        submitNameText.fontSize = 22
        submitNameText.position = CGPoint(x: self.frame.midX, y: self.frame.height / 1.2)
        submitNameText.text = ""
        submitNameText.fontColor = .black
        
        addChild(submitNameText)
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            submitNameText.text = ("Hi, \(textField.text ?? "User"):)   Let's play!")
            playerName = textField.text ?? "User"
            textField.resignFirstResponder()
            return true
        }
    }


