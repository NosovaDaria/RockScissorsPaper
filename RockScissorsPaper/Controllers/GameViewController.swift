//
//  GameViewController.swift
//  RockScissorsPaper
//
//  Created by Дарья Носова on 13.10.2023.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            let scene = MenuScene(size: self.view.bounds.size)
                scene.scaleMode = .aspectFill
                scene.size = self.view.bounds.size

                view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
        
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}


