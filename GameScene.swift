//
//  GameScene.swift
//  SassCat
//
//  Created by Calista Kim on 2016-07-19.
//  Copyright (c) 2016 cal_games. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var cat = SKSpriteNode()
    var bg = SKSpriteNode()
    var lvlBox = SKSpriteNode()
    var lvlOpen = SKSpriteNode()
    var lvlBlock = SKSpriteNode()
    var window = SKSpriteNode()
    var bgColor = SKSpriteNode()
    var tv = SKSpriteNode()
    
    var numBlocks = 1 // indicates the number of blocks filled in gauge
    var pointsToNextBlock = 0
    var timesTapped = 0 // used in touchesBegan to count lvlBox taps
    var tapped = 0 // used in touchesBegan to count tv taps
    var lvl = 1
    var points = 0
    
    let labelLvl = UILabel()
    let labelPoints = UILabel()
    let catChat = SKLabelNode(fontNamed: "Silom")
    
    override func didMoveToView(view: SKView) {
        //setting background color
        
        bgColor.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        bgColor.size.height = self.frame.height
        bgColor.size.width = self.frame.width
        bgColor.color = UIColor.blackColor()
        bgColor.zPosition = -1
        self.addChild(bgColor)

        //setting background
        let bgTexture = SKTexture(imageNamed: "IMG/room_base.png")
        bg = SKSpriteNode(texture: bgTexture)
        bg.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        bg.size.height = self.frame.height
        bg.size.width = self.frame.width
        bg.zPosition = 0
        self.addChild(bg)
        bgAnim()
        
        //setting window
        let windowTexture = SKTexture(imageNamed:"IMG/window_day.png")
        window = SKSpriteNode(texture: windowTexture)
        window.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) + 200 )
        window.name = "window"
        window.alpha = 0.01
        window.zPosition = 3
        self.addChild(window)
        
        //setting tv
        let tvTexture = SKTexture(imageNamed:"IMG/tv1.png")
        tv = SKSpriteNode(texture: tvTexture)
        tv.position = CGPoint(x: CGRectGetMidX(self.frame) - 250 , y: CGRectGetMidY(self.frame) + 30 )
        tv.name = "tv"
        tv.alpha = 0.01
        tv.zPosition = 3
        self.addChild(tv)
        
        //setting lvl box
        let lvlBoxTexture = SKTexture(imageNamed:"IMG/lvl0.png")
        lvlBox = SKSpriteNode(texture: lvlBoxTexture)
        lvlBox.position = CGPoint(x: CGRectGetMinX(self.frame) + 55, y: CGRectGetMinY(self.frame)+145 )
        lvlBox.zPosition = 2
        lvlBox.userInteractionEnabled = false
        lvlBox.name = "lvlBox"
        self.addChild(lvlBox)
        
        //setting level display
        labelLvl.frame = CGRectMake(0, 0, self.view!.frame.size.width, 120)
        labelLvl.textAlignment = NSTextAlignment.Left
        labelLvl.text = "lvl: \(lvl)"
        labelLvl.font = UIFont(name: "Silom", size: 10)
        labelLvl.backgroundColor = UIColor.clearColor()
        labelLvl.textColor = UIColor.blackColor()
        labelLvl.center = CGPointMake(CGRectGetMidX(lvlBox.frame) + 232 , CGRectGetMidY(lvlBox.frame) + 135 )
        self.view!.addSubview(labelLvl)
        
        //setting points display
        labelPoints.frame = CGRectMake(0, 0, self.view!.frame.size.width, 120)
        labelPoints.textAlignment = NSTextAlignment.Left
        labelPoints.text = "bytes:\(points)"
        labelPoints.font = UIFont(name: "Silom", size: 9)
        labelPoints.backgroundColor = UIColor.clearColor()
        labelPoints.textColor = UIColor.blackColor()
        labelPoints.center = CGPointMake(CGRectGetMidX(lvlBox.frame) + 232 , CGRectGetMidY(lvlBox.frame) + 145 )
        self.view!.addSubview(labelPoints)
        
        //setting lvl gauge
        let lvlOpenTexture = SKTexture(imageNamed:"IMG/lvl0gague.png")
        lvlOpen = SKSpriteNode(texture: lvlOpenTexture)
        lvlOpen.position = CGPoint(x: CGRectGetMinX(self.frame) + 409, y: CGRectGetMinY(self.frame)+145 )
        lvlOpen.zPosition = 1
        
        // setting cat
        let catTexture = SKTexture(imageNamed: "IMG/cat_base.png")
        let catTexture2 = SKTexture(imageNamed: "IMG/cat_blink.png")
        let cathappyTexture = SKTexture(imageNamed: "IMG/cat_happy.png")
        
        //cat animations
        let baseAnimation = SKAction.animateWithTextures([catTexture, catTexture2, catTexture], timePerFrame: 0.5)
        let expessionHappy = SKAction.animateWithTextures([catTexture, cathappyTexture, catTexture, cathappyTexture], timePerFrame: 0.5)
        let catBlink = SKAction.repeatActionForever(baseAnimation)
        cat = SKSpriteNode(texture: catTexture)
        cat.name = "cat"
        cat.anchorPoint = CGPointMake(0, 0)
        cat.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) - 50)
        cat.runAction(catBlink)
        cat.zPosition = 1
        self.addChild(cat)
        
        //setting cat chat label
        catChat.fontSize = 15
        catChat.fontColor = UIColor.blackColor()
        catChat.position = CGPointMake(100, 75)
        catChat.zPosition = 2
        catChat.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        cat.addChild(catChat)
        autoChat()

    }
    

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
