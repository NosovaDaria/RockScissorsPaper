//
//  Background.swift
//  RockScissorsPaper
//
//  Created by Дарья Носова on 15.10.2023.
//

import SpriteKit

class Background: SKSpriteNode {

    static func populateBackground(at point: CGPoint) -> Background {
        let background = Background(imageNamed: "paperBackground")
        background.position = point
        background.zPosition = 0
        
        return background
    }
    
}
