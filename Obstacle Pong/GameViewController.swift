//
//  GameViewController.swift
//  Obstacle Pong
//
//  Created by Buka Cakrawala on 7/5/16.
//  Copyright (c) 2016 Buka Cakrawala. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel(frame: CGRectMake(0, 0, 200, 21))
        label.center = CGPointMake(160, 300)
        label.textAlignment = NSTextAlignment.Center
        label.text = "0"
        label.textColor = UIColor.blueColor()
        label.font = UIFont(name: "HelveticaNeue", size: CGFloat(30))
        self.view.addSubview(label)
        
        let labelTwo = UILabel(frame: CGRectMake(0, 0, 200, 21))
        labelTwo.center = CGPointMake(160, 268)
        labelTwo.textAlignment = NSTextAlignment.Center
        labelTwo.text = "0"
        labelTwo.textColor = UIColor.greenColor()
        labelTwo.font = UIFont(name: "HelveticaNeue", size: CGFloat(30))
        self.view.addSubview(labelTwo)
        
        let scene = GameScene(size: view.frame.size)
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)

    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
