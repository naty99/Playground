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
    
    override init() {
        super.init()
        
        let radius: CGFloat = CGFloat.random(in: 8...12)
        let steps: Int = Int(radius)
        let shape = SKShapeNode(circleOfRadius: radius)
        shape.fillColor = UIColor.white
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius + CGFloat(11) * radius / 2)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = 0b100
        self.physicsBody?.collisionBitMask = 0b0
        self.physicsBody?.contactTestBitMask = 0b10
        
        for i in 0...steps {
            let circle = SKShapeNode(circleOfRadius: radius + CGFloat(i + 1) * radius / CGFloat(steps) * 8)
            circle.strokeColor = UIColor(hue: 0, saturation: 0, brightness: 1, alpha: 1 - 1 / CGFloat(steps) * CGFloat(i))
            self.addChild(circle)
        }
        
        addChild(shape)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
