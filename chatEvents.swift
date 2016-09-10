//
//  ChatEvents.swift
//  SassCat
//
//  Created by Calista Kim on 2016-07-26.
//  Copyright © 2016 cal_games. All rights reserved.
//

import SpriteKit

extension GameScene{
    
    func autoChat(){
        //automatically updates catChat label every 12 counts with a random string from an array
        let chatArray:NSArray = ["meow", "How Can Mirrors Be Real If Your Eyes Aren't Real", "give me attention", "life is meaningless", "do you wish starvation upon me", "feed me", "help i'm trapped in a game", "SOS", "rub my belly 3 times exactly", "..."]
        
        var wait = SKAction.waitForDuration(1)
        var chatCreate = Int()
        var chatRemove = Int()
        var run = SKAction.runBlock {
            
            chatRemove++
            chatCreate++
            // removes catChat 3 counts after display
            if chatCreate == 12 {
                var randomInt = Int(arc4random_uniform(9))
                self.catChat.text = chatArray[randomInt] as! String
                print("ping")
            }
            else if chatRemove == 15 {
                print("removed")
                self.catChat.text = " "
                chatRemove = 0
                chatCreate = 0
            }
        }
        catChat.runAction(SKAction.repeatActionForever(SKAction.sequence([wait, run])))
        
    }
}
