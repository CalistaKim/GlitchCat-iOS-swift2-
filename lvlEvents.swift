//
//  LvlEvents.swift
//  SassCat
//
//  Created by Calista Kim on 2016-07-26.
//  Copyright © 2016 cal_games. All rights reserved.
//

import Foundation


import SpriteKit

extension GameScene {
    
    func addBlockToGauge(){
        //logic to calculate how many points until next block is added to level gauge
        
        pointsToNextBlock = numBlocks * lvl
        let lvlBlockTexture = SKTexture(imageNamed: "IMG/lvl0_pt.png")
        
        if points >= pointsToNextBlock && numBlocks <= 8 {
            
            // setting blocks into position
            labelLvl.text = "lvl: \(lvl)"
            labelPoints.text = "bytes:\(points)"
            lvlBlock = SKSpriteNode(texture: lvlBlockTexture)
            lvlBlock.zPosition = 3
            lvlBlock.name = "lvlBlock\(numBlocks)"
            lvlBlock.position = CGPoint(x: CGRectGetMinX(self.frame) - 352 + (88 * CGFloat(numBlocks)), y: CGRectGetMinY(self.frame))
            
            // changes color of each block after level gained
            if lvl == 2{
                lvlBlock.color = UIColor.redColor()
                lvlBlock.colorBlendFactor = 0.5
            }
            if lvl == 3{
                lvlBlock.color = UIColor.magentaColor()
                lvlBlock.colorBlendFactor = 0.5
            }
            
            //adding block to gauge
            lvlOpen.addChild(lvlBlock)
            print("added \(lvlBlock.name)")
            numBlocks += 1
            
            if points >= 8 && lvl == 1{
                lvl = 2
                labelLvl.text = "lvl: \(lvl)"
                catChat.text = "well congrats"
                numBlocks = 1
                print("LEVEL 2 REACHED")
                removeBlocks()
                UIColorFromRGB(16711680, nodeOne: lvlOpen, nodeTwo: lvlBox)
                
            }
            if points >= 16 && lvl == 2{
                lvl = 3
                labelLvl.text = "lvl: \(lvl)"
                catChat.text = "wow look at you go"
                numBlocks = 1
                print("LEVEL 3 REACHED")
                removeBlocks()
                UIColorFromRGB(13382655, nodeOne: lvlOpen, nodeTwo: lvlBox)
            }
        }
    }
    
    func removeBlocks() {
        for node in lvlOpen.children {
            node.removeFromParent()
        }
    }
    
    func UIColorFromRGB(rgbValue: UInt, nodeOne:SKSpriteNode?, nodeTwo:SKSpriteNode?) {
        // apply a color change animation to a maxiumum of 2 SKSpriteNodes. Color must be entered as a RGB INT
        let newColor = UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
        let colorize = SKAction.colorizeWithColor(newColor, colorBlendFactor: 0.5, duration: 2)
        nodeOne?.runAction(colorize)
        nodeTwo?.runAction(colorize)
    }
    
    /* OLD UIColorFromRGB FUNCTION
    func colorRed() {
    let colorize = SKAction.colorizeWithColor(.redColor(), colorBlendFactor: 0.5, duration: 2)
    lvlBlock.runAction(colorize)
    lvlOpen.runAction(colorize)
    lvlBox.runAction(colorize)
    }*/
    
    /*
    func getRandomColor(nodeOne: SKSpriteNode?) {
    let red   = Float((arc4random() % 256)) / 255.0
    let green = Float((arc4random() % 256)) / 255.0
    let blue  = Float((arc4random() % 256)) / 255.0
    let alpha = Float(1.0)
    
    UIView.animateWithDuration(1.0, delay: 0.0, options:[UIViewAnimationOptions.Repeat, UIViewAnimationOptions.Autoreverse], animations: {
    self.view.backgroundColor = UIColor(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)
    }, completion:nil)
    
    }*/
    
    
}
