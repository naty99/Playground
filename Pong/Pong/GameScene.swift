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
    private var opp: Opponent = Opponent(10.0)
    private var planet: Planet = Planet()
    private var r: CGFloat = 70.0
    
    private var opponentScore: Int = 0
    private var playerScore: Int = 0
    
    private var opponentScoreLabel: SKLabelNode! = SKLabelNode(text: "0")
    private var playerScoreLabel: SKLabelNode! = SKLabelNode(text: "0")
    
    
    override func sceneDidLoad() {
        setLabels()
        
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
        
        // Add planet
        self.addChild(planet)
        
        // Add opponent
        self.opp.setPosition(pos: CGPoint(x: 0, y: self.frame.height / 2 - 100))
        self.addChild(self.opp.getBar())
        
        let pattern : [CGFloat] = [20.0, 10.0]
        let line = SKShapeNode()
        let pathToDraw = CGMutablePath()
        pathToDraw.move(to: CGPoint(x: -self.frame.width / 2, y: 0))
        pathToDraw.addLine(to: CGPoint(x: self.frame.width / 2, y: 0))
        let dashed = pathToDraw.copy(dashingWithPhase: 1, lengths: pattern)
        line.path = dashed
        line.lineWidth = 2
        self.addChild(line)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let node1 = contact.bodyA.node
        let node2 = contact.bodyB.node
        
        let planetHit = (contact.bodyA.node!.isEqual(to: planet) || contact.bodyB.node!.isEqual(to: planet))
        
        let point = contact.contactPoint
        
        let w = self.frame.width / 2 - self.ball.getRadius() - self.r
        let h = self.frame.height / 2 - self.ball.getRadius()
        
        if (planetHit) {
            let center = planet.position
            let ball1 = (node1!.isEqual(to: ball)) ? node1 : node2
            
            let direction = CGVector(dx: (center.x - ball1!.position.x) * 0.1, dy: (center.y - ball1!.position.y) * 0.1)
            let magnitude = hypot(direction.dx, direction.dy)
            let vect = CGVector(dx: direction.dx * magnitude * 0.1, dy: direction.dy * magnitude * 0.1)
            
            let len = hypot(ball1!.physicsBody!.velocity.dx, ball1!.physicsBody!.velocity.dy)
            if (len > 70.0)
            {
                ball1?.physicsBody?.velocity.dx *= 70.0 / len;
                ball1?.physicsBody?.velocity.dy *= 70.0 / len;
            }
            
            let gravity = SKAction.applyForce(vect, duration: 0.05)
            ball1?.run(gravity)
        }
        
        if (!planetHit) {
            if (point.x < -w || point.x > w) {
                physicsWorld.gravity = CGVector(
                    dx: -physicsWorld.gravity.dx,
                    dy: physicsWorld.gravity.dy * CGFloat.random(in: 1...1.5))
            } else {
                if (point.y < -h || point.y > h) {
                    let center = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0)
                    self.ball.run(center)
                    self.ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    physicsWorld.gravity = CGVector(dx: 1, dy: 1)
                } else {
                    let pos = (point.y > 0) ? self.opp.getBar().position : self.bar.position
                     var dy = -physicsWorld.gravity.dy * CGFloat.random(in: 1...1.5)
                     dy = (dy > 0) ? min(dy, 4) : max(dy, -4)
                     let perc = (pos.x - point.x) / 150
                     let diff = perc * 6 + dy * CGFloat.random(in: 0.75...1.5) * (CGFloat.random(in: 0...1) > 0.5 ? 1 : -1)
                    
                     physicsWorld.gravity = CGVector(dx: diff, dy: dy)
                }
            }
        }
        
        if (contact.bodyA.node!.isEqual(ball) || contact.bodyB.node!.isEqual(ball)) {
            if (contact.contactPoint.y < bar.position.y - bar.frame.height) {
                opponentScore += 1
                opponentScoreLabel.text = String(opponentScore)
            } else if (contact.contactPoint.y > opp.getBar().position.y + bar.frame.height) {
                playerScore += 1
                playerScoreLabel.text = String(playerScore)
            }
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let move = SKAction.moveTo(x: t.location(in: self).x, duration: 0.1)
            bar.run(move)
        }
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
        opp.update(ball: self.ball)
        
        self.lastUpdateTime = currentTime
    }
    
    func setLabels() {
        opponentScoreLabel.text = "\(opponentScore)"
        playerScoreLabel.text = "\(playerScore)"
        
        opponentScoreLabel.fontName = "pixelmix.ttf"
        playerScoreLabel.fontName = "pixelmix.ttf"
        
        opponentScoreLabel.fontSize = 50
        playerScoreLabel.fontSize = 50
        
        opponentScoreLabel.position = CGPoint(x: self.frame.minX + 100, y: 20)
        playerScoreLabel.position = CGPoint(x: self.frame.maxX - 100, y: -20 - opponentScoreLabel.frame.height)
        
        addChild(opponentScoreLabel)
        addChild(playerScoreLabel)
    }
}
