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
    private var opp: Opponent = Opponent(7.0)
    private var planet: Planet = Planet()
    private var r: CGFloat = 70.0
    
    private var opponentScore: Int = 0
    private var playerScore: Int = 0
        
    private var opponentScoreLabel: SKLabelNode! = SKLabelNode()
    private var playerScoreLabel: SKLabelNode! = SKLabelNode()
    
    override func sceneDidLoad() {
        setLabels()
        
        setPhysics()

        self.backgroundColor = SKColor.init(displayP3Red: 0.085, green: 0.085, blue: 0.113, alpha: 1)
                
        // Add bar
        bar.position = CGPoint(x: 0, y: -self.frame.height / 2 + 100)
        self.addChild(bar)
        
        // Add ball
        self.addChild(ball)
        
        // Add planet
//        self.addChild(planet)
        
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
        // Category BitMasks
        // Bar -> 1
        // Ball -> 10
        // Planet -> 100
        
        let cat1 = contact.bodyA.categoryBitMask
        let cat2 = contact.bodyB.categoryBitMask
        
        // Bar vs. Ball
        if (cat1 + cat2 == 11) {
            collisionBar(p: contact.contactPoint)
        }
        
        let planetHit = (contact.bodyA.node!.isEqual(to: planet) || contact.bodyB.node!.isEqual(to: planet))
        
        let w = self.frame.width / 2 - self.ball.getRadius() - self.r
        let h = self.frame.height / 2 - self.ball.getRadius()
        
        if (planetHit) {
            let center = planet.shape!.position
//            let ball1 = (node1!.isEqual(to: ball)) ? node1 : node2
            
            let direction = CGVector(dx: (ball.position.x - center.x), dy: (ball.position.y - center.y))
            let m: CGFloat = 1
            let vect = CGVector(dx: direction.dx * m, dy: direction.dy * m)
            
            let gravity = SKAction.applyForce(vect, duration: 0.1)
            ball.run(gravity)
        }
        
        if (!planetHit) {
            if (contact.contactPoint.x < -w || contact.contactPoint.x > w) { collisionSides() }
            else {
                if (contact.contactPoint.y < -h || contact.contactPoint.y > h) { score() }
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
        
        // Update opponent based on the ball
        opp.update(ball: self.ball)
        planet.update()
        
        self.lastUpdateTime = currentTime
    }
    
    func limit(vec: CGVector, dx: CGFloat, dy: CGFloat) -> CGVector {
        var x: CGFloat = 0.0, y: CGFloat = 0.0
        if (vec.dx > 0) { x = (vec.dx > dx) ? dx : vec.dx }
        if (vec.dx <= 0) { x = (vec.dx < -dx) ? -dx : vec.dx }
        if (vec.dy > 0) { y = (vec.dy > dy) ? dy : vec.dy }
        if (vec.dy <= 0) { y = (vec.dy < -dy) ? -dy : vec.dy }
        return CGVector(dx: x, dy: y)
    }
    
    func collisionSides() {
        self.ball.physicsBody?.velocity =
            limit(vec: (self.ball.physicsBody?.velocity)!, dx: self.frame.width, dy: CGFloat.greatestFiniteMagnitude)
    }
    
    func collisionBar(p: CGPoint) {
        let pos = (p.y > 0) ? self.opp.getBar().position : self.bar.position
        var dy = -physicsWorld.gravity.dy * CGFloat.random(in: 1...1.5)
        dy = (dy > 0) ? min(dy, 6) : max(dy, -6)
//        let perc = (pos.x - p.x) / self.bar.getWidth()
//        let diff = pow(perc * 2, 2) * (perc > 0 ? 1 : -1) * 10 + dy * (perc > 0 ? 1 : -1)
//        let diff = perc * 5 + dy * (CGFloat.random(in: 0...1) > 0.5 ? 1 : -1)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: dy)
    }
    
    func score() {
        let center = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0)
        self.ball.run(center)
        self.ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        physicsWorld.gravity = CGVector(dx: 1, dy: 1)
    }
    
    func setLabels() {
        opponentScoreLabel.text = "\(opponentScore)"
        playerScoreLabel.text = "\(playerScore)"
        
        opponentScoreLabel.fontName = "pixelmix"
        playerScoreLabel.fontName = "pixelmix"
        
        opponentScoreLabel.fontSize = 50
        playerScoreLabel.fontSize = 50
        
        opponentScoreLabel.position = CGPoint(x: self.frame.minX + 100, y: 20)
        playerScoreLabel.position = CGPoint(x: self.frame.maxX - 100, y: -20 - opponentScoreLabel.frame.height)
        
        addChild(opponentScoreLabel)
        addChild(playerScoreLabel)
    }
    
    func setPhysics() {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(
            dx: CGFloat.random(in: 1...2) * ((CGFloat.random(in: 0...1) > 0.5) ? 1 : -1),
            dy: -1)
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(
            x: -self.frame.width / 2 + self.r, y: -self.frame.height / 2,
            width: self.frame.width - 2 * self.r, height: self.frame.height))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.restitution = 1.25
        self.physicsBody?.categoryBitMask = 0b1
        self.physicsBody?.contactTestBitMask = 0b0
    }
}
