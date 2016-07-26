# GlitchCat-iOS-swift2-
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
    
    var timesTapped = 0
    var tapped = 0
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
        
        labelLvl.frame = CGRectMake(0, 0, self.view!.frame.size.width, 120)
        labelLvl.textAlignment = NSTextAlignment.Left
        labelLvl.text = "lvl: \(lvl)"
        labelLvl.font = UIFont(name: "Silom", size: 10)
        labelLvl.backgroundColor = UIColor.clearColor()
        labelLvl.textColor = UIColor.blackColor()
        labelLvl.center = CGPointMake(CGRectGetMidX(lvlBox.frame) + 232 , CGRectGetMidY(lvlBox.frame) + 135 )
        self.view!.addSubview(labelLvl)
        
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
    
    //automatically updates catChat label every 20 seconds
    func autoChat(){
        let chatArray:NSArray = ["meow", "How Can Mirrors Be Real If Your Eyes Aren't Real", "give me attention", "life is meaningless", "do you wish starvation upon me", "feed me", "help i'm trapped in a game", "SOS", "rub my belly 3 times exactly", "..."]
        
        var wait = SKAction.waitForDuration(1)
        var chatCreate = Int()
        var chatRemove = Int()
        var run = SKAction.runBlock {
            
            chatRemove++
            chatCreate++
            
            if chatCreate == 12 {
                var randomInt = Int(arc4random_uniform(9))
                self.catChat.text = chatArray[randomInt] as! String
                print("ping")
                chatCreate = 0
            }
            else if chatRemove == 15 {
                print("removed")
                self.catChat.text = " "
                chatRemove = 0
            }
        }
        catChat.runAction(SKAction.repeatActionForever(SKAction.sequence([wait, run])))
        
    }
    
    func catTapped() {
        let catTexture = SKTexture(imageNamed: "IMG/cat_base.png")
        let catSquintTexture = SKTexture(imageNamed: "IMG/cat_squint.png")
        let catSquint2Texture = SKTexture(imageNamed: "IMG/cat_squint2.png")
        let expessionSquint = SKAction.animateWithTextures([catTexture, catSquintTexture, catTexture, catSquintTexture], timePerFrame: 0.5)
        let expessionSquint2 = SKAction.animateWithTextures([catTexture, catSquint2Texture, catTexture, catSquint2Texture], timePerFrame: 0.5)
        let catSquint = SKAction.repeatAction(expessionSquint, count: 1)
        let catSquinty = SKAction.repeatAction(expessionSquint2, count: 1)
        
        var randomInt = Int(arc4random_uniform(5))
        if randomInt == 0{
            catChat.text = "WATCH THE EYES"
            cat.runAction(catSquint)
            points += 2
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
    
    
    //adds a block to the lvl gauge when x amount of pts reached
    func addBlockToGauge(){
        
        pointsToNextBlock = numBlocks * lvl
        let lvlBlockTexture = SKTexture(imageNamed: "IMG/lvl0_pt.png")
        

        if points >= pointsToNextBlock && numBlocks <= 8 {
            
            //setting blocks to be added to lvl gauge
            labelLvl.text = "lvl: \(lvl)"
            labelPoints.text = "bytes:\(points)"
            lvlBlock = SKSpriteNode(texture: lvlBlockTexture)
            lvlBlock.zPosition = 3
            lvlBlock.name = "lvlBlock\(numBlocks)"
            lvlBlock.position = CGPoint(x: CGRectGetMinX(self.frame) - 352 + (88 * CGFloat(numBlocks)), y: CGRectGetMinY(self.frame))
            
            if lvl == 2{
                lvlBlock.color = UIColor.redColor()
                lvlBlock.colorBlendFactor = 0.5
            }
            if lvl == 3{
                lvlBlock.color = UIColor.magentaColor()
                lvlBlock.colorBlendFactor = 0.5
            }
            
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
                
            } // lvl 2 points end
            if points >= 16 && lvl == 2{
                lvl = 3
                labelLvl.text = "lvl: \(lvl)"
                catChat.text = "wow look at you go"
                numBlocks = 1
                print("LEVEL 3 REACHED")
                removeBlocks()
                UIColorFromRGB(13382655, nodeOne: lvlOpen, nodeTwo: lvlBox)
            }
        } //points to next block end
    }

    func removeBlocks() {
        for node in lvlOpen.children {
            node.removeFromParent()
        }
    }
    
    func UIColorFromRGB(rgbValue: UInt, nodeOne:SKSpriteNode?, nodeTwo:SKSpriteNode?) {
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
    func bgAnim() {
        let bgTexture = SKTexture(imageNamed: "IMG/room_base.png")
        let bgTexture2 = SKTexture(imageNamed: "IMG/room_base2.png")
        let bgTexture3 = SKTexture(imageNamed: "IMG/room_base3.png")
        let bgAnimate = SKAction.animateWithTextures([bgTexture, bgTexture2, bgTexture3, bgTexture2], timePerFrame: 0.2)
        let bgMove = SKAction.repeatActionForever(bgAnimate)
        bg.runAction(bgMove)
    }
    
    func tvDrip() {
        let tvTexture = SKTexture(imageNamed:"IMG/tv1.png")
        let tvTexture2 = SKTexture(imageNamed:"IMG/tv2.png")
        let tvTexture3 = SKTexture(imageNamed:"IMG/tv3.png")
        let tvAnimate = SKAction.animateWithTextures([tvTexture, tvTexture2, tvTexture3, tvTexture2], timePerFrame: 0.3)
        let tvDrip = SKAction.repeatActionForever(tvAnimate)
        tv.runAction(tvDrip)
        
    }
    
    func glitch(){
        let tvTexture = SKTexture(imageNamed:"IMG/glitch1.png")
        let tvTexture2 = SKTexture(imageNamed:"IMG/glitch2.png")
        let tvTexture3 = SKTexture(imageNamed:"IMG/glitch3.png")
        let tvTexture4 = SKTexture(imageNamed:"IMG/glitch4.png")
        let tvTexture5 = SKTexture(imageNamed:"IMG/glitch5.png")
        let tvAnimate = SKAction.animateWithTextures([tvTexture, tvTexture2, tvTexture3, tvTexture4, tvTexture2, tvTexture5, tvTexture3 ], timePerFrame: 0.2)
        let bgGlitch = SKAction.repeatActionForever(tvAnimate)
        bg.runAction(bgGlitch)
    }
    
    /* OLD UIColorFromRGB FUNCTION
    func colorRed() {
    let colorize = SKAction.colorizeWithColor(.redColor(), colorBlendFactor: 0.5, duration: 2)
    lvlBlock.runAction(colorize)
    lvlOpen.runAction(colorize)
    lvlBox.runAction(colorize)
    }*/
    
    // apply a color change animation to a maxiumum of 2 SKSpriteNodes. Color must be entered as a RGB INT
    
    /*
    func getRandomColor() {
        let red   = Float((arc4random() % 256)) / 255.0
        let green = Float((arc4random() % 256)) / 255.0
        let blue  = Float((arc4random() % 256)) / 255.0
        let alpha = Float(1.0)
        
        UIView.animateWithDuration(1.0, delay: 0.0, options:[UIViewAnimationOptions.Repeat, UIViewAnimationOptions.Autoreverse], animations: {
            self.view.backgroundColor = UIColor(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)
            }, completion:nil)
        
    }*/
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       // detects when a SKSpriteNode has been touched
        let touch = touches.first
        let positionInScene = touch!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(positionInScene)
        
        if let name = touchedNode.name
        {
            if name == "lvlBox"
            {
                if timesTapped == 0
                {
                    self.addChild(lvlOpen)
                    timesTapped += 1
                    print("times tapped:\(timesTapped), points:\(points)")
                }
                else if timesTapped == 1
                {
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
                    glitch()
                    catChat.text = "SWEET JEFF."
                    tapped += 1
                }
                else if tapped == 2 {
                    tvDrip()
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
            
            if name == "cat"{
                catTapped()
            }
        }
        addBlockToGauge()
    
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
