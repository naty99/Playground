//
//  Planet.swift
//  Pong
//
//  Created by Natália Struharová on 13/04/2020.
//  Copyright © 2020 Bleach. All rights reserved.
//

import Foundation
import SpriteKit

class Planet: SKNode {
    
    var outerPhysics: SKPhysicsBody?
    var shape: SKShapeNode?
    var trajectory = (w: 250.0, h: 100.0)
    var off: Double = 0.0
    var fx, fy: (Double) -> Double
    
    override init() {
        super.init()
        self.fx = generateFunction(dt: Double(Int.random(in: 1...3)), c: (Float.random(in: 0...1) > 0.5))
        self.fy = generateFunction(dt: Double(Int.random(in: 1...3)), c: (Float.random(in: 0...1) > 0.5))

        let radius: CGFloat = CGFloat.random(in: 8...12)
        let steps: Int = Int(radius)
        self.shape = SKShapeNode(circleOfRadius: radius)
        shape!.fillColor = UIColor.white
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius + CGFloat(11) * radius / 2)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = 0b100
        self.physicsBody?.collisionBitMask = 0b0
        self.physicsBody?.contactTestBitMask = 0b10
        
        for i in 0...steps {
            let circle = SKShapeNode(circleOfRadius: radius + CGFloat(i + 1) * radius / CGFloat(steps) * 8)
            circle.strokeColor = UIColor(hue: 0, saturation: 0, brightness: 1, alpha: 1 - 1 / CGFloat(steps) * CGFloat(i))
            self.shape!.addChild(circle)
        }
        
        addChild(shape!)
    }
    
    func update() {
        self.position = CGPoint(
            x: self.fx(self.off) * trajectory.w,
            y: self.fy(self.off) * trajectory.h)
        off += 0.02
    }
    
    func generateFunction(dt: Double, c: Bool) -> (Double) -> Double {
        return c ? { (off) -> Double in cos(dt * off) } : { (off) -> Double in sin(dt * off) }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
