//
//  GameScene.swift
//  Obstacle Pong
//
//  Created by Buka Cakrawala on 7/5/16.
//  Copyright (c) 2016 Buka Cakrawala. All rights reserved.
//

//  Hello, you have been the forked

import SpriteKit
import AVFoundation

struct PhysicsCategory {
    static let None:    UInt32 = 0
    static let Ball:    UInt32 = 0b1
    static let Paddle:  UInt32 = 0b10
    static let Edge:    UInt32 = 0b100
    static let ScoreLine: UInt32 = 0b1000
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var centerLine: SKSpriteNode!
    var ball: SKSpriteNode!
    var paddleOne: SKSpriteNode!
    var paddleTwo: SKSpriteNode!
    var scoreLine: SKSpriteNode!
    var scoreLine2: SKSpriteNode!
    var scoreLabel1: SKLabelNode!
    var scoreLabel2: SKLabelNode!
    var points = 0
    var points2 = 0
    
    
    //Score Label Function: Size, Color and CGPoint
    func makeScoreLabel(x: CGFloat, y: CGFloat, color: UIColor)-> SKLabelNode {
        let label = SKLabelNode(text: "0")
        label.fontColor = color
        label.fontSize = 50
        label.position = CGPoint(x: x,y: y)
        label.fontName = "Geneva"
        label.zPosition = 10
        addChild(label)
        return label
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsBody = SKPhysicsBody(edgeLoopFromRect: view.frame)
        physicsBody?.categoryBitMask = PhysicsCategory.Edge
        physicsBody?.contactTestBitMask = 0 // PhysicsCategory.Ball|PhysicsCategory.ScoreLine
        physicsBody?.collisionBitMask = PhysicsCategory.Ball|PhysicsCategory.Paddle|PhysicsCategory.ScoreLine
        physicsWorld.contactDelegate = self
        
        
        
        
        backgroundColor = UIColor.blackColor()
        
        let centerX = view.frame.width/2
        let centerY = view.frame.height/2
        
        // Center line
        let lineSize = CGSize(width: view.frame.width, height: 2)
        centerLine = SKSpriteNode(color: UIColor.whiteColor(), size: lineSize)
        addChild(centerLine)
        centerLine.position.x = centerX
        centerLine.position.y = centerY
        
        scoreLabel1 = makeScoreLabel(centerX, y: centerY + 55, color: SKColor.greenColor())
        scoreLabel2 = makeScoreLabel(centerX, y: centerY - 55, color: SKColor.yellowColor())
        let rotation = SKAction.rotateByAngle(CGFloat(M_PI), duration: 0)
        scoreLabel1.runAction(rotation)
        
        
        
        //scoreline
        let scoreLineSize = CGSize(width: view.frame.width, height: 10)
        scoreLine = SKSpriteNode(color: UIColor.orangeColor(), size: scoreLineSize)
        scoreLine.physicsBody = SKPhysicsBody(edgeLoopFromRect: scoreLine.frame)
        scoreLine.physicsBody?.categoryBitMask = PhysicsCategory.ScoreLine
        scoreLine.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
        scoreLine.physicsBody?.collisionBitMask = 0
        scoreLine.name = "scoreLine1"
        addChild(scoreLine)
        
        scoreLine.position.x = view.frame.width / 2
        scoreLine.position.y = 0
        
        
        //scoreline2
        let scoreLineSize2 = CGSize(width: view.frame.width, height: 10)
        scoreLine2 = SKSpriteNode(color: UIColor.orangeColor(), size: scoreLineSize2)
        scoreLine2.physicsBody = SKPhysicsBody(edgeLoopFromRect: scoreLine2.frame)
        scoreLine2.physicsBody?.categoryBitMask = PhysicsCategory.ScoreLine
        scoreLine2.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
        scoreLine2.physicsBody?.collisionBitMask = 0
        scoreLine2.name = "scoreLine2"
        addChild(scoreLine2)
        scoreLine2.position.x = view.frame.width / 2
        scoreLine2.position.y = view.frame.height
        
        // Ball
        let ballTexture = SKTexture(imageNamed: "Ball")
        ball = SKSpriteNode(texture: ballTexture)
        ball.name = "ball"
        addChild(ball)
        ball.position.x = view.frame.width / 2
        ball.position.y = view.frame.height / 2
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 15)
        ball.physicsBody?.categoryBitMask = PhysicsCategory.Ball
        ball.physicsBody?.contactTestBitMask = PhysicsCategory.ScoreLine
        ball.physicsBody?.collisionBitMask = PhysicsCategory.Paddle|PhysicsCategory.Edge|PhysicsCategory.ScoreLine
        ball.physicsBody?.restitution = 1.0
        ball.physicsBody?.friction = 0
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.velocity = CGVectorMake(400, 300)
        
        // Paddle 1 
        let paddleOneSize = CGSize(width: 70, height: 20)
        paddleOne = SKSpriteNode(color: UIColor.greenColor(), size: paddleOneSize)
        self.addChild(paddleOne)
        paddleOne.position.x = view.frame.width / 2
        paddleOne.position.y = view.frame.height - 30
        paddleOne.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        paddleOne.physicsBody?.categoryBitMask = PhysicsCategory.Paddle
        //paddleOne.physicsBody?.collisionBitMask = PhysicsCategory.Ball|PhysicsCategory.Edge
        paddleOne.physicsBody?.dynamic = false
        
        
        
        // Paddle 2
        let paddleTwoSize = CGSize(width: 70, height: 20)
        paddleTwo = SKSpriteNode(color: UIColor.blueColor(), size: paddleTwoSize)
        self.addChild(paddleTwo)
        paddleTwo.position.x = view.frame.width / 2
        paddleTwo.position.y = 30
        paddleTwo.physicsBody = SKPhysicsBody(rectangleOfSize: paddleTwoSize)
        paddleTwo.physicsBody?.categoryBitMask = PhysicsCategory.Paddle
        //paddleTwo.physicsBody?.collisionBitMask = PhysicsCategory.Ball|PhysicsCategory.Edge
        paddleTwo.physicsBody?.dynamic = false
        
        scoreLabel1.text = String(points)
        scoreLabel2.text = String(points)
        
    }
    //MARK: touch events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        for touch: AnyObject in touches {
            //ball.physicsBody?.applyImpulse(CGVectorMake(100, 100))
        }
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            let centerY = view!.frame.height / 2
            if location.y < centerY {
                //touch in the bottom half of the screen
                //TODO: move paddle 2
                paddleTwo.position.x = location.x
                paddleTwo.position.y = location.y
            } else {
                //touch in the top half of the screen
                //TODO: move paddle 1
                paddleOne.position.x = location.x
                paddleOne.position.y = location.y
            }
        }
    }
    var contactCount = 0
    func didBeginContact(contact: SKPhysicsContact) {
//        contactCount += 1
//        print("did contact \(contactCount)")
//        print("  \(contact.bodyA.node?.name!) body A")
//        print("  \(contact.bodyB.node?.name!) body B")
        let contactBodyA: SKPhysicsBody = contact.bodyA
        let contactBodyB: SKPhysicsBody = contact.bodyB
//        //get references to the physics body parent nodes
        let nodeA = contactBodyA.node!
        let nodeB = contactBodyB.node!
//        
        if nodeA.name == "scoreLine1" || nodeB.name == "scoreLine1" {
            points += 1
            scoreLabel1.text = String(points)
            return
        } else if nodeA.name == "scoreLine2" || nodeB.name == "scoreLine2"{
            points2 += 1
            scoreLabel2.text = String(points2)
        }
    }
}

