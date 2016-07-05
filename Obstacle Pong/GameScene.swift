//
//  GameScene.swift
//  Obstacle Pong
//
//  Created by Buka Cakrawala on 7/5/16.
//  Copyright (c) 2016 Buka Cakrawala. All rights reserved.
//

//  Hello, you have been the forked

import SpriteKit

class GameScene: SKScene {
    
    var centerLine: SKSpriteNode!
    var ball:SKSpriteNode!
    var paddleOne: SKSpriteNode!
    var paddleTwo: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsBody = SKPhysicsBody(edgeLoopFromRect: view.frame)
        
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
        
        // Paddle 1 
        let paddleOneSize = CGSize(width: 65, height: 12)
        paddleOne = SKSpriteNode(color: UIColor.greenColor(), size: paddleOneSize)
        addChild(paddleOne)
        paddleOne.position.x = view.frame.width / 2
        paddleOne.position.y = view.frame.height - 30
        
        // Paddle 2
        let paddleTwoSize = CGSize(width: 65, height: 12)
        paddleTwo = SKSpriteNode(color: UIColor.blueColor(), size: paddleTwoSize)
        addChild(paddleTwo)
        paddleTwo.position.x = view.frame.width / 2
        paddleTwo.position.y = view.frame.height - 630
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
