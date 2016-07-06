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
    
    struct TouchInfo {
        var location: CGPoint
        var time: NSTimeInterval
    }
    
    var selectedNode: SKSpriteNode?
    var history: [TouchInfo]?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsBody = SKPhysicsBody(edgeLoopFromRect: view.frame)
        
        backgroundColor = UIColor.blackColor()
        
        //sets up gesture recognizer
        let pan = UIPanGestureRecognizer(target: self, action: "panned:")
        view.addGestureRecognizer(pan)
        
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
        let paddleOneSize = CGSize(width: 70, height: 12)
        paddleOne = SKSpriteNode(color: UIColor.greenColor(), size: paddleOneSize)
        self.addChild(paddleOne)
        paddleOne.position.x = view.frame.width / 2
        paddleOne.position.y = view.frame.height - 30
        
        // Paddle 2
        let paddleTwoSize = CGSize(width: 70, height: 12)
        paddleTwo = SKSpriteNode(color: UIColor.blueColor(), size: paddleTwoSize)
        self.addChild(paddleTwo)
        paddleTwo.position.x = view.frame.width / 2
        paddleTwo.position.y = view.frame.height - 700
    }
    
    var previousTranslateX: CGFloat = 0.0
    
    func panned(sender: UIPanGestureRecognizer) {
        //retrieve pan movement along the x axis of the view since the touches began
        let currentTranslateX = sender.translationInView(view!).x
        //calculate translation
        let translateX = currentTranslateX - previousTranslateX
        //move shape within frame boudaries
        let newShapeX = paddleOne.position.x + translateX
        if newShapeX < frame.maxX && newShapeX > frame.minX {
            paddleOne.position = CGPointMake(paddleOne.position.x + translateX, paddleOne.position.y)
        }
        //(re-)set previous measurement
        if sender.state == .Ended {
            previousTranslateX = 0
        } else {
            previousTranslateX = currentTranslateX
        }
    
    }
    }

    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
       
        
    }
    
