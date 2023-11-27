//
//  GameResults.swift
//  RockScissorsPaper
//
//  Created by Дарья Носова on 16.10.2023.
//

import Foundation

class GameResults: NSObject {
    let ud = UserDefaults.standard
    
    var playerScore: [Int] = []
    var currentScore = 0
    var playerName: [String] = []
    
    let scoreKey = "score"
    let nameKey = "name"

    
    override init() {
        super.init()
        
        loadGameResults()
    }
    
    func saveGameResults() {
        playerScore.append(currentScore)
        if playerScore.count > 5 {
            playerScore.remove(at: 0)
            playerName.remove(at: 0)
        }
        
        ud.set(playerScore, forKey: scoreKey)
        ud.set(playerName, forKey: nameKey)
        ud.synchronize()
    }
    
    func loadGameResults() {
        guard ud.value(forKey: scoreKey) != nil && ud.value(forKey: nameKey) != nil else { return }
        
        playerScore = ud.array(forKey: scoreKey) as! [Int]
        playerName = ud.stringArray(forKey: nameKey) ?? [""]
    
    }
}
