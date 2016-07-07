//
//  GameScene.swift
//  Obstacle Pong
//
//  Created by Buka Cakrawala on 7/5/16.
//  Copyright (c) 2016 Buka Cakrawala. All rights reserved.
//

//  Hello, you have been the forked

import SpriteKit

struct PhysicsCategory {
    static let None:    UInt32 = 0
    static let Ball:    UInt32 = 0b1
    static let Paddle:  UInt32 = 0b10
    static let Edge:    UInt32 = 0b100
}

class GameScene: SKScene {
    
    var centerLine: SKSpriteNode!
    var ball:SKSpriteNode!
    var paddleOne: SKSpriteNode!
    var paddleTwo: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsBody = SKPhysicsBody(edgeLoopFromRect: view.frame)
        physicsBody?.categoryBitMask = PhysicsCategory.Edge
        physicsBody?.contactTestBitMask = PhysicsCategory.None
        physicsBody?.collisionBitMask = PhysicsCategory.Ball|PhysicsCategory.Paddle
        
        backgroundColor = UIColor.blackColor()
        
        
        
        // Center line
        let lineSize = CGSize(width: view.frame.width, height: 2)
        centerLine = SKSpriteNode(color: UIColor.whiteColor(), size: lineSize)
        addChild(centerLine)
        centerLine.position.x = view.frame.width / 2
        centerLine.position.y = view.frame.height / 2
        
        // Ball
        let ballTexture = SKTexture(imageNamed: "Ball")
        ball = SKSpriteNode(texture: ballTexture)
        addChild(ball)
        ball.position.x = view.frame.width / 2
        ball.position.y = view.frame.height / 2
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 15)
        ball.physicsBody?.categoryBitMask = PhysicsCategory.Ball
        ball.physicsBody?.contactTestBitMask = PhysicsCategory.Paddle
        ball.physicsBody?.collisionBitMask = PhysicsCategory.Paddle|PhysicsCategory.Edge
        ball.physicsBody?.restitution = 1.0
        ball.physicsBody?.friction = 0
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.velocity = CGVectorMake(400, 200)
        
        
        // Paddle 1 
        let paddleOneSize = CGSize(width: 70, height: 20)
        paddleOne = SKSpriteNode(color: UIColor.greenColor(), size: paddleOneSize)
        self.addChild(paddleOne)
        paddleOne.position.x = view.frame.width / 2
        paddleOne.position.y = view.frame.height - 30
        paddleOne.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        paddleOne.physicsBody?.categoryBitMask = PhysicsCategory.Paddle
        paddleOne.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
        paddleOne.physicsBody?.collisionBitMask = PhysicsCategory.Ball|PhysicsCategory.Edge
        paddleOne.physicsBody?.dynamic = false
        
        
        
        // Paddle 2
        let paddleTwoSize = CGSize(width: 70, height: 20)
        paddleTwo = SKSpriteNode(color: UIColor.blueColor(), size: paddleTwoSize)
        self.addChild(paddleTwo)
        paddleTwo.position.x = view.frame.width / 2
        paddleTwo.position.y = 30
        paddleTwo.physicsBody = SKPhysicsBody(rectangleOfSize: paddleTwoSize)
        paddleTwo.physicsBody?.categoryBitMask = PhysicsCategory.Paddle
        paddleTwo.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
        paddleTwo.physicsBody?.collisionBitMask = PhysicsCategory.Ball|PhysicsCategory.Edge
        paddleTwo.physicsBody?.dynamic = false
        
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

    
}