//
//  Ball.swift
//  Pong
//
//  Created by Thijs Nulle on 12/04/2020.
//  Copyright © 2020 Bleach. All rights reserved.
//

import SpriteKit

class Ball: SKNode {
    
    private var shape: SKShapeNode?
    
    override init() {
        super.init()
        
        let shape = SKShapeNode(circleOfRadius: 10)
        shape.lineWidth = 2
        self.shape = shape
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        self.physicsBody?.categoryBitMask = 0b10
        self.physicsBody?.collisionBitMask = 0b1
        self.physicsBody?.contactTestBitMask = 0b1
        
        self.addChild(shape)
    }
    
    func getRadius() -> CGFloat {
        return (self.shape?.frame.width)! / 2.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
