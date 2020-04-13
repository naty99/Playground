//
//  GameScene.swift
//  Pong
//
//  Created by Natália Struharová on 12/04/2020.
//  Copyright © 2020 Bleach. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var bar: Bar = Bar()
    private var ball: Ball = Ball()
    private var opp: Opponent = Opponent(5.0)
    private var r: CGFloat = 70.0
    
    override func sceneDidLoad() {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(
            dx: CGFloat.random(in: 1...2) * ((CGFloat.random(in: 0...1) > 0.5) ? 1 : -1),
            dy: -1)
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(
            x: -self.frame.width / 2 + self.r, y: -self.frame.height / 2,
            width: self.frame.width - 2 * self.r, height: self.frame.height))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = 0b1
        self.physicsBody?.contactTestBitMask = 0b0

        self.backgroundColor = SKColor.init(displayP3Red: 0.085, green: 0.085, blue: 0.113, alpha: 1)
        
        // Add bar
        bar.position = CGPoint(x: 0, y: -self.frame.height / 2 + 100)
        self.addChild(bar)
        
        // Add ball
        self.addChild(ball)
        
        // Add opponent
        self.opp.setPosition(pos: CGPoint(x: 0, y: self.frame.height / 2 - 100))
        self.addChild(self.opp.getBar())
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let point = contact.contactPoint
        let w = self.frame.width / 2 - self.ball.getR() - self.r
        let h = self.frame.height / 2 - self.ball.getR()
        if (point.x < -w || point.x > w) {
            physicsWorld.gravity = CGVector(
                dx: -physicsWorld.gravity.dx * CGFloat.random(in: 0.5...1.5),
                dy: physicsWorld.gravity.dy * CGFloat.random(in: 0.5...1.5))
        } else {
            if (point.y < -h || point.y > h) {
                print("you lost")
            } else {
                physicsWorld.gravity = CGVector(
                dx: physicsWorld.gravity.dx * CGFloat.random(in: 0.5...1.5),
                dy: -physicsWorld.gravity.dy * CGFloat.random(in: 0.5...1.5))
            }
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        opp.update(ball: self.ball)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchMoved(toPoint: t.location(in: self))
            var x: CGFloat, w = self.bar.getWidth()
            if (t.location(in: self).x < -self.frame.width / 2 + w) { x = -self.frame.width / 2 + w }
            else if (t.location(in: self).x > self.frame.width / 2 - w) { x = self.frame.width / 2 - w }
            else { x = t.location(in: self).x }
            bar.position.x = x
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {                
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
