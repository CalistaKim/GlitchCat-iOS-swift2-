//
//  touchEvents.swift
//  SassCat
//
//  Created by Calista Kim on 2016-07-26.
//  Copyright © 2016 cal_games. All rights reserved.
//

import SpriteKit

extension GameScene {
    func catTapped() {
        // setting up the animations for cat squinting expression
        
        let catTexture = SKTexture(imageNamed: "IMG/cat_base.png")
        let catSquintTexture = SKTexture(imageNamed: "IMG/cat_squint.png")
        let catSquint2Texture = SKTexture(imageNamed: "IMG/cat_squint2.png")
        let expessionSquint = SKAction.animateWithTextures([catTexture, catSquintTexture, catTexture, catSquintTexture], timePerFrame: 0.5)
        let expessionSquint2 = SKAction.animateWithTextures([catTexture, catSquint2Texture, catTexture, catSquint2Texture], timePerFrame: 0.5)
        let catSquint = SKAction.repeatAction(expessionSquint, count: 1)
        let catSquinty = SKAction.repeatAction(expessionSquint2, count: 1)
        
        // randomizing expression, reaction, and points
        var randomInt = Int(arc4random_uniform(5))
        if randomInt == 0{
            catChat.text = "WATCH THE EYES"
            cat.runAction(catSquint)
            points += 1
        }
        else if randomInt == 3 {
            catChat.text = "do you enjoy this"
            cat.runAction(catSquinty)
            points += 3
        }
        else {
            catChat.text = "meOuch"
            cat.runAction(catSquint)
        }
    }
    
    func bgAnim() {
        let bgTexture = SKTexture(imageNamed: "IMG/room_base.png")
        let bgTexture2 = SKTexture(imageNamed: "IMG/room_base2.png")
        let bgTexture3 = SKTexture(imageNamed: "IMG/room_base3.png")
        let bgAnimate = SKAction.animateWithTextures([bgTexture, bgTexture2, bgTexture3, bgTexture2], timePerFrame: 0.2)
        let bgMove = SKAction.repeatActionForever(bgAnimate)
        bg.runAction(bgMove)
    }
    
    func tvDripAnim() {
        let tvTexture = SKTexture(imageNamed:"IMG/tv1.png")
        let tvTexture2 = SKTexture(imageNamed:"IMG/tv2.png")
        let tvTexture3 = SKTexture(imageNamed:"IMG/tv3.png")
        let tvAnimate = SKAction.animateWithTextures([tvTexture, tvTexture2, tvTexture3, tvTexture2], timePerFrame: 0.3)
        let tvDrip = SKAction.repeatActionForever(tvAnimate)
        tv.runAction(tvDrip)
        
    }
    
    func glitchAnim(){
        let tvTexture = SKTexture(imageNamed:"IMG/glitch1.png")
        let tvTexture2 = SKTexture(imageNamed:"IMG/glitch2.png")
        let tvTexture3 = SKTexture(imageNamed:"IMG/glitch3.png")
        let tvTexture4 = SKTexture(imageNamed:"IMG/glitch4.png")
        let tvTexture5 = SKTexture(imageNamed:"IMG/glitch5.png")
        let tvAnimate = SKAction.animateWithTextures([tvTexture, tvTexture2, tvTexture3, tvTexture4, tvTexture2, tvTexture5, tvTexture3 ], timePerFrame: 0.2)
        let bgGlitch = SKAction.repeatActionForever(tvAnimate)
        bg.runAction(bgGlitch)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // detects when a SKSpriteNode has been touched
        let touch = touches.first
        let positionInScene = touch!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(positionInScene)
        
        if let name = touchedNode.name
        {
            if name == "lvlBox" {
                if timesTapped == 0 {
                    self.addChild(lvlOpen)
                    timesTapped += 1
                    print("times tapped:\(timesTapped), points:\(points)")
                }
                else if timesTapped == 1 {
                    self.lvlOpen.removeFromParent()
                    timesTapped = 0
                }
            }
            if name == "window" {
                window.alpha = 1
                catChat.text = "this is marginally nicer"
                UIColorFromRGB(13684944, nodeOne:bgColor, nodeTwo:nil)
                points += 5
            }
            if name == "tv"{
                if tapped == 0 {
                    tv.alpha = 1
                    catChat.text = "is GoT on right now"
                    points += 5
                    tapped += 1
                }
                else if tapped == 1 {
                    glitchAnim()
                    catChat.text = "SWEET JEFF."
                    tapped += 1
                }
                else if tapped == 2 {
                    tvDripAnim()
                    catChat.text = "QUICK hit it again"
                    tapped += 1
                }
                else if tapped == 3 {
                    bgAnim()
                    catChat.text = "phew"
                    points += 2
                    tapped = 0
                }
            }
            if name == "cat" {
                catTapped()
            }
            addBlockToGauge()
        }
    }
}
