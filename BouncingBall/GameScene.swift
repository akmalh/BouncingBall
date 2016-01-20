//
//  GameScene.swift
//  BouncingBall
//
//  Created by Akmal Hossain on 20/01/2016.
//  Copyright (c) 2016 Akmal Hossain. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene {
    
    var motionManager = CMMotionManager()
    override func didMoveToView(view: SKView) {
        
        /* Setup your scene here */
        
        // gravity = 9.8 meters/sec^2
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        let sceneBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        sceneBody.friction = 0
        self.physicsBody = sceneBody
        
        // add a ball in the center of the screen
        var positionOfTouch = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        println("x: \(positionOfTouch.x) y: \(positionOfTouch.y)")
        var ball = SKShapeNode(circleOfRadius: 15)
        
        ball.fillColor = SKColor.redColor()
        ball.position = positionOfTouch
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 15)
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.restitution = 1   // the ball will have a perfect bounce
        ball.physicsBody?.linearDamping = 0 // no air resistance
        self.addChild(ball)
        
        // get sensed data - device motion
        motionManager.deviceMotionUpdateInterval = 0.025
        
        motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.currentQueue(),
            withHandler: { (motion: CMDeviceMotion!, error: NSError!) -> Void
            in
            let gravity: CMAcceleration = motion.gravity
            self.physicsWorld.gravity = CGVectorMake(CGFloat(gravity.x), CGFloat(gravity.y))
            })
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
            /* Called when a touch begins */
            
            for touch: AnyObject in touches {
            var positionOfTouch = touch.locationInNode(self)
            println("x: \(positionOfTouch.x) y: \(positionOfTouch.y)")
            var ball = SKShapeNode(circleOfRadius: 15)
            ball.fillColor = SKColor.redColor()
            ball.position = positionOfTouch
            ball.physicsBody = SKPhysicsBody(circleOfRadius: 15)
            ball.physicsBody?.affectedByGravity = true
            ball.physicsBody?.restitution = 1   // the ball will have a perfect bounce
            ball.physicsBody?.linearDamping = 0 // no air resistance
            self.addChild(ball)
            
            }
    }
    
    override func update(currentTime: CFTimeInterval) {
            /* Called before each frame is rendered */
    }
}

